Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEFD51A15E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:19 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:18 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 74F30357804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:15 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2F0Pj45023378
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:15:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dEVG007830
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/21] powerpc/eeh: Unfreeze PE on enabling EEH functionality
Date: Tue, 30 Sep 2014 12:39:01 +1000
Message-Id: <1412044750-24460-12-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When passing through PE to guest, that's possibly in frozen
state. The driver for the pass-through devices on guest side
can't be loaded successfully as reported. We already had one
gate in eeh_dev_open() to clear PE frozen state accordingly,
but that's not enough because the function is only called at
QEMU startup for once.

The patch adds another gate in eeh_pe_set_option() so that the
PE frozen state can be cleared at QEMU restart time.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |  1 +
 arch/powerpc/kernel/eeh.c      | 60 ++++++++++++++++++++++--------------------
 2 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ae8c441..5e6e548 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -281,6 +281,7 @@ void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
 void eeh_remove_device(struct pci_dev *);
+int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state);
 int eeh_dev_open(struct pci_dev *pdev);
 void eeh_dev_release(struct pci_dev *pdev);
 struct eeh_pe *eeh_iommu_group_to_pe(struct iommu_group *group);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 09bcf95..9678e16 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1164,6 +1164,31 @@ void eeh_remove_device(struct pci_dev *dev)
 	edev->mode &= ~EEH_DEV_SYSFS;
 }
 
+int eeh_unfreeze_pe(struct eeh_pe *pe, bool sw_state)
+{
+	int ret;
+
+	ret = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+	if (ret) {
+		pr_warn("%s: Failure %d enabling IO on PHB#%x-PE#%x\n",
+			__func__, ret, pe->phb->global_number, pe->addr);
+		return ret;
+	}
+
+	ret = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
+	if (ret) {
+		pr_warn("%s: Failure %d enabling DMA on PHB#%x-PE#%x\n",
+			__func__, ret, pe->phb->global_number, pe->addr);
+		return ret;
+	}
+
+	/* Clear software isolated state */
+	if (sw_state && (pe->state & EEH_PE_ISOLATED))
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+
+	return ret;
+}
+
 /**
  * eeh_dev_open - Increase count of pass through devices for PE
  * @pdev: PCI device
@@ -1176,7 +1201,6 @@ void eeh_remove_device(struct pci_dev *dev)
 int eeh_dev_open(struct pci_dev *pdev)
 {
 	struct eeh_dev *edev;
-	int flag = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 	int ret = -ENODEV;
 
 	mutex_lock(&eeh_dev_mutex);
@@ -1196,31 +1220,9 @@ int eeh_dev_open(struct pci_dev *pdev)
 	 * in frozen PE won't work properly. Clear the frozen state
 	 * in advance.
 	 */
-	ret = eeh_ops->get_state(edev->pe, NULL);
-	if (ret > 0 && ret != EEH_STATE_NOT_SUPPORT &&
-	    (ret & flag) != flag) {
-		ret = eeh_ops->set_option(edev->pe, EEH_OPT_THAW_MMIO);
-		if (ret) {
-			pr_warn("%s: Failure %d enabling MMIO "
-				"for PHB#%x-PE#%x\n",
-				__func__, ret, edev->phb->global_number,
-				edev->pe->addr);
-			goto out;
-		}
-
-		ret = eeh_ops->set_option(edev->pe, EEH_OPT_THAW_DMA);
-		if (ret) {
-			pr_warn("%s: Failure %d enabling DMA "
-				"for PHB#%x-PE#%x\n",
-				__func__, ret, edev->phb->global_number,
-				edev->pe->addr);
-			goto out;
-		}
-	}
-
-	/* Clear software isolated state */
-	if (edev->pe->state & EEH_PE_ISOLATED)
-		eeh_pe_state_clear(edev->pe, EEH_PE_ISOLATED);
+	ret = eeh_unfreeze_pe(edev->pe, true);
+	if (ret)
+		goto out;
 
 	/* Increase PE's pass through count */
 	atomic_inc(&edev->pe->pass_dev_cnt);
@@ -1338,8 +1340,10 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option)
 	 */
 	switch (option) {
 	case EEH_OPT_ENABLE:
-		if (eeh_enabled())
+		if (eeh_enabled()) {
+			ret = eeh_unfreeze_pe(pe, true);
 			break;
+		}
 		ret = -EIO;
 		break;
 	case EEH_OPT_DISABLE:
@@ -1351,7 +1355,7 @@ int eeh_pe_set_option(struct eeh_pe *pe, int option)
 			break;
 		}
 
-		ret = eeh_ops->set_option(pe, option);
+		ret = eeh_pci_enable(pe, option);
 		break;
 	default:
 		pr_debug("%s: Option %d out of range (%d, %d)\n",
-- 
1.8.3.2
