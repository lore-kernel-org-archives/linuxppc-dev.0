Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D7C51A1748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:49:23 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Sep 2014 15:49:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1B80E2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:49:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8J5oYpx25035000
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:50:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8J5mlEq017923
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 15:48:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/eeh: Fix improper condition in eeh_pci_enable()
Date: Fri, 19 Sep 2014 15:48:19 +1000
Message-Id: <1411105703-30149-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function eeh_pci_enable() is called to apply various requests
to one particular PE: Enabling EEH, Disabling EEH, Enabling IO,
Enabling DMA, Freezing PE. When enabling IO or DMA on one specific
PE, we need check that IO or DMA isn't enabled previously. But
the condition used to do the check isn't completely correct because
one PE would be in DMA frozen state with workable IO path, or vice
versa.

The patch fixes the improper condition.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 58 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index e436d5e..09bcf95 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -579,25 +579,51 @@ EXPORT_SYMBOL(eeh_check_failure);
  */
 int eeh_pci_enable(struct eeh_pe *pe, int function)
 {
-	int rc, flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
+	int active_flag, rc;
 
 	/*
 	 * pHyp doesn't allow to enable IO or DMA on unfrozen PE.
 	 * Also, it's pointless to enable them on unfrozen PE. So
-	 * we have the check here.
+	 * we have to check before enabling IO or DMA.
 	 */
-	if (function == EEH_OPT_THAW_MMIO ||
-	    function == EEH_OPT_THAW_DMA) {
+	switch (function) {
+	case EEH_OPT_THAW_MMIO:
+		active_flag = EEH_STATE_MMIO_ACTIVE;
+		break;
+	case EEH_OPT_THAW_DMA:
+		active_flag = EEH_STATE_DMA_ACTIVE;
+		break;
+	case EEH_OPT_DISABLE:
+	case EEH_OPT_ENABLE:
+	case EEH_OPT_FREEZE_PE:
+		active_flag = 0;
+		break;
+	default:
+		pr_warn("%s: Invalid function %d\n",
+			__func__, function);
+		return -EINVAL;
+	}
+
+	/*
+	 * Check if IO or DMA has been enabled before
+	 * enabling them.
+	 */
+	if (active_flag) {
 		rc = eeh_ops->get_state(pe, NULL);
 		if (rc < 0)
 			return rc;
 
-		/* Needn't to enable or already enabled */
-		if ((rc == EEH_STATE_NOT_SUPPORT) ||
-		    ((rc & flags) == flags))
+		/* Needn't enable it at all */
+		if (rc == EEH_STATE_NOT_SUPPORT)
+			return 0;
+
+		/* It's already enabled */
+		if (rc & active_flag)
 			return 0;
 	}
 
+
+	/* Issue the request */
 	rc = eeh_ops->set_option(pe, function);
 	if (rc)
 		pr_warn("%s: Unexpected state change %d on "
@@ -605,17 +631,17 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 			__func__, function, pe->phb->global_number,
 			pe->addr, rc);
 
-	rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-	if (rc <= 0)
-		return rc;
+	/* Check if the request is finished successfully */
+	if (active_flag) {
+		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
+		if (rc <= 0)
+			return rc;
 
-	if ((function == EEH_OPT_THAW_MMIO) &&
-	    (rc & EEH_STATE_MMIO_ENABLED))
-		return 0;
+		if (rc & active_flag)
+			return 0;
 
-	if ((function == EEH_OPT_THAW_DMA) &&
-	    (rc & EEH_STATE_DMA_ENABLED))
-		return 0;
+		return -EIO;
+	}
 
 	return rc;
 }
-- 
1.8.3.2
