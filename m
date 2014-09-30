Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB01F1A05E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:18 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 12:39:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 702932CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:15 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8U2f5aT32309382
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:41:05 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8U2dECC007840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 12:39:15 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/21] powerpc/eeh: Use eeh_unfreeze_pe()
Date: Tue, 30 Sep 2014 12:39:02 +1000
Message-Id: <1412044750-24460-13-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch uses eeh_unfreeze_pe() to replace the logic clearing
frozen IO and DMA, in order to simplify the code.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c        | 19 +------------------
 arch/powerpc/kernel/eeh_driver.c | 18 ++++++------------
 arch/powerpc/kernel/eeh_sysfs.c  | 21 +--------------------
 3 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9678e16..7004673 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1433,24 +1433,7 @@ static int eeh_pe_reenable_devices(struct eeh_pe *pe)
 	}
 
 	/* The PE is still in frozen state */
-	ret = eeh_ops->set_option(pe, EEH_OPT_THAW_MMIO);
-	if (ret) {
-		pr_warn("%s: Failure %d enabling MMIO for PHB#%x-PE#%x\n",
-			__func__, ret, pe->phb->global_number, pe->addr);
-		return ret;
-	}
-
-	ret = eeh_ops->set_option(pe, EEH_OPT_THAW_DMA);
-	if (ret) {
-		pr_warn("%s: Failure %d enabling DMA for PHB#%x-PE#%x\n",
-			__func__, ret, pe->phb->global_number, pe->addr);
-		return ret;
-	}
-
-	/* Clear software isolated state */
-	eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
-
-	return ret;
+	return eeh_unfreeze_pe(pe, true);
 }
 
 /**
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 6a0dcee..948e6f9 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -450,21 +450,15 @@ static void *eeh_pe_detach_dev(void *data, void *userdata)
 static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
 {
 	struct eeh_pe *pe = (struct eeh_pe *)data;
-	int i, rc;
+	int i, rc = 1;
 
-	for (i = 0; i < 3; i++) {
-		rc = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
-		if (rc)
-			continue;
-		rc = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
-		if (!rc)
-			break;
-	}
+	for (i = 0; rc && i < 3; i++)
+		rc = eeh_unfreeze_pe(pe, false);
 
-	/* The PE has been isolated, clear it */
+	/* Stop immediately on any errors */
 	if (rc) {
-		pr_warn("%s: Can't clear frozen PHB#%x-PE#%x (%d)\n",
-			__func__, pe->phb->global_number, pe->addr, rc);
+		pr_warn("%s: Failure %d unfreezing PHB#%x-PE#%x\n",
+			__func__, rc, pe->phb->global_number, pe->addr);
 		return (void *)pe;
 	}
 
diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
index eb15be4..9a44010 100644
--- a/arch/powerpc/kernel/eeh_sysfs.c
+++ b/arch/powerpc/kernel/eeh_sysfs.c
@@ -75,7 +75,6 @@ static ssize_t eeh_pe_state_store(struct device *dev,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
-	int ret;
 
 	if (!edev || !edev->pe)
 		return -ENODEV;
@@ -84,26 +83,8 @@ static ssize_t eeh_pe_state_store(struct device *dev,
 	if (!(edev->pe->state & EEH_PE_ISOLATED))
 		return count;
 
-	/* Enable MMIO */
-	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_MMIO);
-	if (ret) {
-		pr_warn("%s: Failure %d enabling MMIO for PHB#%d-PE#%d\n",
-			__func__, ret, edev->pe->phb->global_number,
-			edev->pe->addr);
+	if (eeh_unfreeze_pe(edev->pe, true))
 		return -EIO;
-	}
-
-	/* Enable DMA */
-	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_DMA);
-	if (ret) {
-		pr_warn("%s: Failure %d enabling DMA for PHB#%d-PE#%d\n",
-			__func__, ret, edev->pe->phb->global_number,
-			edev->pe->addr);
-		return -EIO;
-	}
-
-	/* Clear software state */
-	eeh_pe_state_clear(edev->pe, EEH_PE_ISOLATED);
 
 	return count;
 }
-- 
1.8.3.2
