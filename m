Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyr0F6FnpzDqH2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:21 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B0hiQG022126
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:19 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27w2xkt48t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:19 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 10:50:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F0D612CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:13 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0B0oDZj51249210
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:13 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0B0oD4n023408
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:13 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, hankmax0000@gmail.com, williel@supermicro.com.tw,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/3] drivers/pci/hotplug: Mask PDC interrupt if required
Date: Wed, 11 Jan 2017 11:50:08 +1100
In-Reply-To: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1484095808-24777-4-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We're supporting surprise hotplug on PCI slots behind root port
or PCIe switch downstream ports, which don't claim the capability
in hardware register (offset: PCIe cap + PCI_EXP_SLTCAP). PEX8718
is one of the examples. For those PCI slots, the PDC (Presence
Detection Change) event isn't reliable and the underly (skiboot)
firmware has best judgement.

This masks the PDC event when skiboot requests by "ibm,slot-broken-pdc"
property in PCI slot's device-tree node.

Reported-by: Hank Chang <hankmax0000@gmail.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Willie Liauw <williel@supermicro.com.tw>
---
 arch/powerpc/include/asm/pnv-pci.h |  2 ++
 drivers/pci/hotplug/pnv_php.c      | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 696438f..de96810 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -57,6 +57,8 @@ struct pnv_php_slot {
 	uint64_t			id;
 	char				*name;
 	int				slot_no;
+	unsigned int			flags;
+#define PNV_PHP_FLAG_BROKEN_PDC		0x1
 	struct kref			kref;
 #define PNV_PHP_STATE_INITIALIZED	0
 #define PNV_PHP_STATE_REGISTERED	1
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 41304b3..63cd9f3 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -717,7 +717,8 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 	if (sts & PCI_EXP_SLTSTA_DLLSC) {
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lsts);
 		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
-	} else if (sts & PCI_EXP_SLTSTA_PDC) {
+	} else if (!(php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) &&
+		   (sts & PCI_EXP_SLTSTA_PDC)) {
 		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 		if (ret) {
 			dev_warn(&pdev->dev, "PCI slot [%s] error %d getting presence (0x%04x), to retry the operation.\n",
@@ -768,6 +769,7 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 {
 	struct pci_dev *pdev = php_slot->pdev;
+	u32 broken_pdc = 0;
 	u16 sts, ctrl;
 	int ret;
 
@@ -779,9 +781,18 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 		return;
 	}
 
+	/* Check PDC (Presence Detection Change) is broken or not */
+	ret = of_property_read_u32(php_slot->dn, "ibm,slot-broken-pdc",
+				   &broken_pdc);
+	if (!ret && broken_pdc)
+		php_slot->flags |= PNV_PHP_FLAG_BROKEN_PDC;
+
 	/* Clear pending interrupts */
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &sts);
-	sts |= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC)
+		sts |= PCI_EXP_SLTSTA_DLLSC;
+	else
+		sts |= (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, sts);
 
 	/* Request the interrupt */
@@ -795,9 +806,15 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 
 	/* Enable the interrupts */
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
-	ctrl |= (PCI_EXP_SLTCTL_HPIE |
-		 PCI_EXP_SLTCTL_PDCE |
-		 PCI_EXP_SLTCTL_DLLSCE);
+	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) {
+		ctrl &= ~PCI_EXP_SLTCTL_PDCE;
+		ctrl |= (PCI_EXP_SLTCTL_HPIE |
+			 PCI_EXP_SLTCTL_DLLSCE);
+	} else {
+		ctrl |= (PCI_EXP_SLTCTL_HPIE |
+			 PCI_EXP_SLTCTL_PDCE |
+			 PCI_EXP_SLTCTL_DLLSCE);
+	}
 	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
 
 	/* The interrupt is initialized successfully when @irq is valid */
-- 
2.7.4
