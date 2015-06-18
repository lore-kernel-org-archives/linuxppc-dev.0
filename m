Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F02B1A0F52
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 18:08:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 18 Jun 2015 18:08:05 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2F8DD3578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 18:08:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5I87qDd57344092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 18:08:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5I87T7f003601
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 18:07:29 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V8 06/10] powerpc/eeh: Create PE for VFs
Date: Thu, 18 Jun 2015 16:06:41 +0800
Message-Id: <1434614805-19002-7-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1434614805-19002-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1434614805-19002-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current EEH recovery code works with the assumption: the PE has primary
bus. Unfortunately, that's not true for VF PEs, which generally contains
one or multiple VFs (for VF group case).

The patch introduces a weak function pcibios_bus_add_device() which is
called by pci_bus_add_device(). In this function, we creates PEs for VFs.
Those PEs for VFs are identified with newly introduced flag EEH_PE_VF so
that we handle them differently during EEH recovery.

[gwshan: changelog and code refactoring]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/kernel/eeh_pe.c                 |   10 ++++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c |   16 ++++++++++++++++
 drivers/pci/bus.c                            |    2 ++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 1b3614d..c1fde48 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -70,6 +70,7 @@ struct pci_dn;
 #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
 #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
 #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
+#define EEH_PE_VF	(1 << 4)	/* VF PE     */
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 35f0b62..260a701 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
 	 * EEH device already having associated PE, but
 	 * the direct parent EEH device doesn't have yet.
 	 */
-	pdn = pdn ? pdn->parent : NULL;
+	if (edev->physfn)
+		pdn = pci_get_pdn(edev->physfn);
+	else
+		pdn = pdn ? pdn->parent : NULL;
 	while (pdn) {
 		/* We're poking out of PCI territory */
 		parent = pdn_to_eeh_dev(pdn);
@@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	}
 
 	/* Create a new EEH PE */
-	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
+	if (edev->physfn)
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
+	else
+		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
 	if (!pe) {
 		pr_err("%s: out of memory!\n", __func__);
 		return -ENOMEM;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ce738ab..4ec1d2e 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1520,6 +1520,22 @@ static struct eeh_ops pnv_eeh_ops = {
 	.restore_config		= pnv_eeh_restore_config
 };
 
+void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
+	if (!pdev->is_virtfn)
+		return;
+
+	/*
+	 * The following operations will fail if VF's sysfs files
+	 * aren't created or its resources aren't finalized.
+	 */
+	eeh_add_device_early(pdn);
+	eeh_add_device_late(pdev);
+	eeh_sysfs_add_device(pdev);
+}
+
 /**
  * eeh_powernv_init - Register platform dependent EEH operations
  *
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 90fa3a7..960577f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -267,6 +267,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
+void __weak pcibios_bus_add_device(struct pci_dev *dev) { }
 /**
  * pci_bus_add_device - start driver for a single device
  * @dev: device to add
@@ -277,6 +278,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	int retval;
 
+	pcibios_bus_add_device(dev);
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
-- 
1.7.9.5
