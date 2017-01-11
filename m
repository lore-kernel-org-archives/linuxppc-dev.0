Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyr0D4pHnzDqG4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:20 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B0hl0t132748
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:17 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27w7m669a7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 19:50:17 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 10:50:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5A0293578057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:12 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0B0oC7K51576898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:12 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0B0oBcI010836
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 11:50:12 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, hankmax0000@gmail.com, williel@supermicro.com.tw,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, stable@vger.kernel.org,
 #v4.9+@gwshan.ozlabs.ibm.com
Subject: [PATCH 1/3] drivers/pci/hotplug: Handle presence detection change
 properly
Date: Wed, 11 Jan 2017 11:50:06 +1100
In-Reply-To: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1484095808-24777-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <1484095808-24777-2-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The surprise hotplug is driven by interrupt in PowerNV PCI hotplug
driver. In the interrupt handler, pnv_php_interrupt(), we bail when
pnv_pci_get_presence_state() returns zero wrongly. It causes the
presence change event is always ignored incorrectly.

This fixes the issue by bailing on error (non-zero value) returned
from pnv_pci_get_presence_state().

Fixes: 360aebd85a4 ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
Cc: stable@vger.kernel.org #v4.9+
Reported-by: Hank Chang <hankmax0000@gmail.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Tested-by: Willie Liauw <williel@supermicro.com.tw>
---
 drivers/pci/hotplug/pnv_php.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 56efaf7..306728c 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -707,8 +707,12 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
 	} else if (sts & PCI_EXP_SLTSTA_PDC) {
 		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
-		if (!ret)
+		if (ret) {
+			dev_warn(&pdev->dev, "PCI slot [%s] error %d getting presence (0x%04x), to retry the operation.\n",
+				 php_slot->name, ret, sts);
 			return IRQ_HANDLED;
+		}
+
 		added = !!(presence == OPAL_PCI_SLOT_PRESENT);
 	} else {
 		return IRQ_NONE;
-- 
2.7.4
