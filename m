Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C2B2A140171
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:32 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:30 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3274B3578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dObg7143884
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80Rxj004111
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 08/25] powerpc/eeh: Avoid I/O access during PE reset
Date: Thu, 24 Apr 2014 18:00:14 +1000
Message-Id: <1398326431-24305-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have suffered recrusive frozen PE a lot, which was caused
by IO accesses during the PE reset. Ben came up with the good
idea to keep frozen PE until recovery (BAR restore) gets done.
With that, IO accesses during PE reset are dropped by hardware
and wouldn't incur the recrusive frozen PE any more.

The patch implements the idea. We don't clear the frozen state
until PE reset is done completely. During the period, the EEH
core expects unfrozen state from backend to keep going. So we
have to reuse EEH_PE_RESET flag, which has been set during PE
reset, to return normal state from backend. The side effect is
we have to clear frozen state for towice (PE reset and clear it
explicitly), but that's harmless.

We have some limitations on pHyp. pHyp doesn't allow to enable
IO or DMA for unfrozen PE. So we don't enable them on unfrozen PE
in eeh_pci_enable(). We have to enable IO before grabbing logs on
pHyp. Otherwise, 0xFF's is always returned from PCI config space.
Also, we had wrong return value from eeh_pci_enable() for
EEH_OPT_THAW_DMA case. The patch fixes it too.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 | 50 ++++++++++++++----
 arch/powerpc/kernel/eeh_driver.c          | 35 +++++++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c | 84 +++++++++----------------------
 3 files changed, 99 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index cc728e8..25f3753 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -238,9 +238,13 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int severity)
 	 * the data from PCI config space because it should return
 	 * 0xFF's. For ER, we still retrieve the data from the PCI
 	 * config space.
+	 *
+	 * For pHyp, we have to enable IO for log retrieval. Otherwise,
+	 * 0xFF's is always returned from PCI config space.
 	 */
 	if (!(pe->type & EEH_PE_PHB)) {
-		eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+		if (eeh_probe_mode_devtree())
+			eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
 		eeh_ops->configure_bridge(pe);
 		eeh_pe_restore_bars(pe);
 
@@ -509,16 +513,42 @@ EXPORT_SYMBOL(eeh_check_failure);
  */
 int eeh_pci_enable(struct eeh_pe *pe, int function)
 {
-	int rc;
+	int rc, flags = (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
+
+	/*
+	 * pHyp doesn't allow to enable IO or DMA on unfrozen PE.
+	 * Also, it's pointless to enable them on unfrozen PE. So
+	 * we have the check here.
+	 */
+	if (function == EEH_OPT_THAW_MMIO ||
+	    function == EEH_OPT_THAW_DMA) {
+		rc = eeh_ops->get_state(pe, NULL);
+		if (rc < 0)
+			return rc;
+
+		/* Needn't to enable or already enabled */
+		if ((rc == EEH_STATE_NOT_SUPPORT) ||
+		    ((rc & flags) == flags))
+			return 0;
+	}
 
 	rc = eeh_ops->set_option(pe, function);
 	if (rc)
-		pr_warning("%s: Unexpected state change %d on PHB#%d-PE#%x, err=%d\n",
-			__func__, function, pe->phb->global_number, pe->addr, rc);
+		pr_warn("%s: Unexpected state change %d on "
+			"PHB#%d-PE#%x, err=%d\n",
+			__func__, function, pe->phb->global_number,
+			pe->addr, rc);
 
 	rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
-	   (function == EEH_OPT_THAW_MMIO))
+	if (rc <= 0)
+		return rc;
+
+	if ((function == EEH_OPT_THAW_MMIO) &&
+	    (rc & EEH_STATE_MMIO_ENABLED))
+		return 0;
+
+	if ((function == EEH_OPT_THAW_DMA) &&
+	    (rc & EEH_STATE_DMA_ENABLED))
 		return 0;
 
 	return rc;
@@ -639,11 +669,13 @@ int eeh_reset_pe(struct eeh_pe *pe)
 	for (i=0; i<3; i++) {
 		eeh_reset_pe_once(pe);
 
+		/*
+		 * EEH_PE_ISOLATED is expected to be removed after
+		 * BAR restore.
+		 */
 		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if ((rc & flags) == flags) {
-			eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+		if ((rc & flags) == flags)
 			return 0;
-		}
 
 		if (rc < 0) {
 			pr_err("%s: Unrecoverable slot failure on PHB#%d-PE#%x",
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 6d91b51..1f1e2cc 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -417,6 +417,36 @@ static void *eeh_pe_detach_dev(void *data, void *userdata)
 	return NULL;
 }
 
+/*
+ * Explicitly clear PE's frozen state for PowerNV where
+ * we have frozen PE until BAR restore is completed. It's
+ * harmless to clear it for pSeries. To be consistent with
+ * PE reset (for 3 times), we try to clear the frozen state
+ * for 3 times as well.
+ */
+static int eeh_clear_pe_frozen_state(struct eeh_pe *pe)
+{
+	int i, rc;
+
+	for (i = 0; i < 3; i++) {
+		rc = eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
+		if (rc)
+			continue;
+		rc = eeh_pci_enable(pe, EEH_OPT_THAW_DMA);
+		if (!rc)
+			break;
+	}
+
+	/* The PE has been isolated, clear it */
+	if (rc)
+		pr_warn("%s: Can't clear frozen PHB#%x-PE#%x (%d)\n",
+			__func__, pe->phb->global_number, pe->addr, rc);
+	else
+		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
+
+	return rc;
+}
+
 /**
  * eeh_reset_device - Perform actual reset of a pci slot
  * @pe: EEH PE
@@ -474,6 +504,11 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 	eeh_pe_restore_bars(pe);
 	eeh_pe_state_clear(pe, EEH_PE_RESET);
 
+	/* Clear frozen state */
+	rc = eeh_clear_pe_frozen_state(pe);
+	if (rc)
+		return rc;
+
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
 	 * this is a hack, but if we don't do this, and try to bring
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index ed6c686..6bdae8d 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -268,6 +268,21 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 		return EEH_STATE_NOT_SUPPORT;
 	}
 
+	/*
+	 * If we're in middle of PE reset, return normal
+	 * state to keep EEH core going. For PHB reset, we
+	 * still expect to have fenced PHB cleared with
+	 * PHB reset.
+	 */
+	if (!(pe->type & EEH_PE_PHB) &&
+	    (pe->state & EEH_PE_RESET)) {
+		result = (EEH_STATE_MMIO_ACTIVE |
+			  EEH_STATE_DMA_ACTIVE |
+			  EEH_STATE_MMIO_ENABLED |
+			  EEH_STATE_DMA_ENABLED);
+		return result;
+	}
+
 	/* Retrieve PE status through OPAL */
 	pe_no = pe->addr;
 	ret = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
@@ -347,52 +362,6 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 	return result;
 }
 
-static int ioda_eeh_pe_clear(struct eeh_pe *pe)
-{
-	struct pci_controller *hose;
-	struct pnv_phb *phb;
-	u32 pe_no;
-	u8 fstate;
-	u16 pcierr;
-	s64 ret;
-
-	pe_no = pe->addr;
-	hose = pe->phb;
-	phb = pe->phb->private_data;
-
-	/* Clear the EEH error on the PE */
-	ret = opal_pci_eeh_freeze_clear(phb->opal_id,
-			pe_no, OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
-	if (ret) {
-		pr_err("%s: Failed to clear EEH error for "
-		       "PHB#%x-PE#%x, err=%lld\n",
-		       __func__, hose->global_number, pe_no, ret);
-		return -EIO;
-	}
-
-	/*
-	 * Read the PE state back and verify that the frozen
-	 * state has been removed.
-	 */
-	ret = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
-			&fstate, &pcierr, NULL);
-	if (ret) {
-		pr_err("%s: Failed to get EEH status on "
-		       "PHB#%x-PE#%x\n, err=%lld\n",
-		       __func__, hose->global_number, pe_no, ret);
-		return -EIO;
-	}
-
-	if (fstate != OPAL_EEH_STOPPED_NOT_FROZEN) {
-		pr_err("%s: Frozen state not cleared on "
-		       "PHB#%x-PE#%x, sts=%x\n",
-		       __func__, hose->global_number, pe_no, fstate);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
 {
 	s64 rc = OPAL_HARDWARE;
@@ -524,27 +493,20 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	int ret;
 
 	/*
-	 * Anyway, we have to clear the problematic state for the
-	 * corresponding PE. However, we needn't do it if the PE
-	 * is PHB associated. That means the PHB is having fatal
-	 * errors and it needs reset. Further more, the AIB interface
-	 * isn't reliable any more.
-	 */
-	if (!(pe->type & EEH_PE_PHB) &&
-	    (option == EEH_RESET_HOT ||
-	    option == EEH_RESET_FUNDAMENTAL)) {
-		ret = ioda_eeh_pe_clear(pe);
-		if (ret)
-			return -EIO;
-	}
-
-	/*
 	 * The rules applied to reset, either fundamental or hot reset:
 	 *
 	 * We always reset the direct upstream bridge of the PE. If the
 	 * direct upstream bridge isn't root bridge, we always take hot
 	 * reset no matter what option (fundamental or hot) is. Otherwise,
 	 * we should do the reset according to the required option.
+	 *
+	 * Here, we have different design to pHyp, which always clear the
+	 * frozen state during PE reset. However, the good idea here from
+	 * benh is to keep frozen state before we get PE reset done completely
+	 * (until BAR restore). With the frozen state, HW drops illegal IO
+	 * or MMIO access, which can incur recrusive frozen PE during PE
+	 * reset. The side effect is that EEH core has to clear the frozen
+	 * state explicitly after BAR restore.
 	 */
 	if (pe->type & EEH_PE_PHB) {
 		ret = ioda_eeh_phb_reset(hose, option);
-- 
1.8.3.2
