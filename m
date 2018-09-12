Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vr4TSlzF3FZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:52 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1Ib8c034848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:50 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2meq7h3rrg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:50 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:48 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1Nc8c28311762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0C8BAE045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:22:53 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 285A4AE04D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:22:53 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:22:53 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BCB70A03B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/14] powerpc/eeh: Cleanup eeh_ops.wait_state()
Date: Wed, 12 Sep 2018 11:23:32 +1000
In-Reply-To: <cover.1536715396.git.sbobroff@linux.ibm.com>
References: <cover.1536715396.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <a23b55c5b3bf8efd9ef9a5ceed67bfb98e57279b.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The wait_state member of eeh_ops does not need to be platform
dependent; it's just logic around eeh_ops.get_state(). Therefore,
merge the two (slightly different!) platform versions into a new
function, eeh_wait_state() and remove the eeh_ops member.

While doing this, also correct:
* The wait logic, so that it never waits longer than max_wait.
* The wait logic, so that it never waits less than
  EEH_STATE_MIN_WAIT_TIME.
* One call site where the result is treated like a bit field before
  it's checked for negative error values.
* In pseries_eeh_get_state(), rename the "state" parameter to "delay"
  because that's what it is.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  4 +-
 arch/powerpc/kernel/eeh.c                    |  9 ++-
 arch/powerpc/kernel/eeh_driver.c             |  2 +-
 arch/powerpc/kernel/eeh_pe.c                 | 51 +++++++++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c | 38 -----------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 66 ++------------------
 6 files changed, 62 insertions(+), 108 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 247f09ce44de..8b596d096ebe 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -205,9 +205,8 @@ struct eeh_ops {
 	void* (*probe)(struct pci_dn *pdn, void *data);
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_pe_addr)(struct eeh_pe *pe);
-	int (*get_state)(struct eeh_pe *pe, int *state);
+	int (*get_state)(struct eeh_pe *pe, int *delay);
 	int (*reset)(struct eeh_pe *pe, int option);
-	int (*wait_state)(struct eeh_pe *pe, int max_wait);
 	int (*get_log)(struct eeh_pe *pe, int severity, char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*err_inject)(struct eeh_pe *pe, int type, int func,
@@ -264,6 +263,7 @@ typedef void *(*eeh_edev_traverse_func)(struct eeh_dev *edev, void *flag);
 typedef void *(*eeh_pe_traverse_func)(struct eeh_pe *pe, void *flag);
 void eeh_set_pe_aux_size(int size);
 int eeh_phb_pe_create(struct pci_controller *phb);
+int eeh_wait_state(struct eeh_pe *pe, int max_wait);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
 struct eeh_pe *eeh_pe_next(struct eeh_pe *pe, struct eeh_pe *root);
 struct eeh_pe *eeh_pe_get(struct pci_controller *phb,
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 90e718f58676..c1c6ae18cfed 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -681,7 +681,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 
 	/* Check if the request is finished successfully */
 	if (active_flag) {
-		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
+		rc = eeh_wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
 		if (rc < 0)
 			return rc;
 
@@ -920,16 +920,15 @@ int eeh_pe_reset_full(struct eeh_pe *pe)
 			break;
 
 		/* Wait until the PE is in a functioning state */
-		state = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
-		if (eeh_state_active(state))
-			break;
-
+		state = eeh_wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
 		if (state < 0) {
 			pr_warn("%s: Unrecoverable slot failure on PHB#%x-PE#%x",
 				__func__, pe->phb->global_number, pe->addr);
 			ret = -ENOTRECOVERABLE;
 			break;
 		}
+		if (eeh_state_active(state))
+			break;
 
 		/* Set error in case this is our last attempt */
 		ret = -EIO;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index c827617613c1..e7f757cd839b 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -836,7 +836,7 @@ void eeh_handle_normal_event(struct eeh_pe *pe)
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 300 seconds for certain systems.
 	 */
-	rc = eeh_ops->wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
+	rc = eeh_wait_state(pe, MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
 		pr_warn("EEH: Permanent failure\n");
 		goto hard_fail;
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index e43dcefbe73f..6fa2032e0594 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -108,6 +108,57 @@ int eeh_phb_pe_create(struct pci_controller *phb)
 	return 0;
 }
 
+/**
+ * eeh_wait_state - Wait for PE state
+ * @pe: EEH PE
+ * @max_wait: maximal period in millisecond
+ *
+ * Wait for the state of associated PE. It might take some time
+ * to retrieve the PE's state.
+ */
+int eeh_wait_state(struct eeh_pe *pe, int max_wait)
+{
+	int ret;
+	int mwait;
+
+	/*
+	 * According to PAPR, the state of PE might be temporarily
+	 * unavailable. Under the circumstance, we have to wait
+	 * for indicated time determined by firmware. The maximal
+	 * wait time is 5 minutes, which is acquired from the original
+	 * EEH implementation. Also, the original implementation
+	 * also defined the minimal wait time as 1 second.
+	 */
+#define EEH_STATE_MIN_WAIT_TIME	(1000)
+#define EEH_STATE_MAX_WAIT_TIME	(300 * 1000)
+
+	while (1) {
+		ret = eeh_ops->get_state(pe, &mwait);
+
+		if (ret != EEH_STATE_UNAVAILABLE)
+			return ret;
+
+		if (max_wait <= 0) {
+			pr_warn("%s: Timeout when getting PE's state (%d)\n",
+				__func__, max_wait);
+			return EEH_STATE_NOT_SUPPORT;
+		}
+
+		if (mwait < EEH_STATE_MIN_WAIT_TIME) {
+			pr_warn("%s: Firmware returned bad wait value %d\n",
+				__func__, mwait);
+			mwait = EEH_STATE_MIN_WAIT_TIME;
+		} else if (mwait > EEH_STATE_MAX_WAIT_TIME) {
+			pr_warn("%s: Firmware returned too long wait value %d\n",
+				__func__, mwait);
+			mwait = EEH_STATE_MAX_WAIT_TIME;
+		}
+
+		msleep(min(mwait, max_wait));
+		max_wait -= mwait;
+	}
+}
+
 /**
  * eeh_phb_pe_get - Retrieve PHB PE based on the given PHB
  * @phb: PCI controller
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index fd1db9f286f1..abc0be7507c8 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1133,43 +1133,6 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 	return pnv_eeh_bridge_reset(bus->self, option);
 }
 
-/**
- * pnv_eeh_wait_state - Wait for PE state
- * @pe: EEH PE
- * @max_wait: maximal period in millisecond
- *
- * Wait for the state of associated PE. It might take some time
- * to retrieve the PE's state.
- */
-static int pnv_eeh_wait_state(struct eeh_pe *pe, int max_wait)
-{
-	int ret;
-	int mwait;
-
-	while (1) {
-		ret = pnv_eeh_get_state(pe, &mwait);
-
-		/*
-		 * If the PE's state is temporarily unavailable,
-		 * we have to wait for the specified time. Otherwise,
-		 * the PE's state will be returned immediately.
-		 */
-		if (ret != EEH_STATE_UNAVAILABLE)
-			return ret;
-
-		if (max_wait <= 0) {
-			pr_warn("%s: Timeout getting PE#%x's state (%d)\n",
-				__func__, pe->addr, max_wait);
-			return EEH_STATE_NOT_SUPPORT;
-		}
-
-		max_wait -= mwait;
-		msleep(mwait);
-	}
-
-	return EEH_STATE_NOT_SUPPORT;
-}
-
 /**
  * pnv_eeh_get_log - Retrieve error log
  * @pe: EEH PE
@@ -1688,7 +1651,6 @@ static struct eeh_ops pnv_eeh_ops = {
 	.get_pe_addr            = pnv_eeh_get_pe_addr,
 	.get_state              = pnv_eeh_get_state,
 	.reset                  = pnv_eeh_reset,
-	.wait_state             = pnv_eeh_wait_state,
 	.get_log                = pnv_eeh_get_log,
 	.configure_bridge       = pnv_eeh_configure_bridge,
 	.err_inject		= pnv_eeh_err_inject,
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 823cb27efa8b..c9e5ca4afb26 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -438,7 +438,7 @@ static int pseries_eeh_get_pe_addr(struct eeh_pe *pe)
 /**
  * pseries_eeh_get_state - Retrieve PE state
  * @pe: EEH PE
- * @state: return value
+ * @delay: suggested time to wait if state is unavailable
  *
  * Retrieve the state of the specified PE. On RTAS compliant
  * pseries platform, there already has one dedicated RTAS function
@@ -448,7 +448,7 @@ static int pseries_eeh_get_pe_addr(struct eeh_pe *pe)
  * RTAS calls for the purpose, we need to try the new one and back
  * to the old one if the new one couldn't work properly.
  */
-static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
+static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
 {
 	int config_addr;
 	int ret;
@@ -499,7 +499,8 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
 		break;
 	case 5:
 		if (rets[2]) {
-			if (state) *state = rets[2];
+			if (delay)
+				*delay = rets[2];
 			result = EEH_STATE_UNAVAILABLE;
 		} else {
 			result = EEH_STATE_NOT_SUPPORT;
@@ -553,64 +554,6 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 	return ret;
 }
 
-/**
- * pseries_eeh_wait_state - Wait for PE state
- * @pe: EEH PE
- * @max_wait: maximal period in millisecond
- *
- * Wait for the state of associated PE. It might take some time
- * to retrieve the PE's state.
- */
-static int pseries_eeh_wait_state(struct eeh_pe *pe, int max_wait)
-{
-	int ret;
-	int mwait;
-
-	/*
-	 * According to PAPR, the state of PE might be temporarily
-	 * unavailable. Under the circumstance, we have to wait
-	 * for indicated time determined by firmware. The maximal
-	 * wait time is 5 minutes, which is acquired from the original
-	 * EEH implementation. Also, the original implementation
-	 * also defined the minimal wait time as 1 second.
-	 */
-#define EEH_STATE_MIN_WAIT_TIME	(1000)
-#define EEH_STATE_MAX_WAIT_TIME	(300 * 1000)
-
-	while (1) {
-		ret = pseries_eeh_get_state(pe, &mwait);
-
-		/*
-		 * If the PE's state is temporarily unavailable,
-		 * we have to wait for the specified time. Otherwise,
-		 * the PE's state will be returned immediately.
-		 */
-		if (ret != EEH_STATE_UNAVAILABLE)
-			return ret;
-
-		if (max_wait <= 0) {
-			pr_warn("%s: Timeout when getting PE's state (%d)\n",
-				__func__, max_wait);
-			return EEH_STATE_NOT_SUPPORT;
-		}
-
-		if (mwait <= 0) {
-			pr_warn("%s: Firmware returned bad wait value %d\n",
-				__func__, mwait);
-			mwait = EEH_STATE_MIN_WAIT_TIME;
-		} else if (mwait > EEH_STATE_MAX_WAIT_TIME) {
-			pr_warn("%s: Firmware returned too long wait value %d\n",
-				__func__, mwait);
-			mwait = EEH_STATE_MAX_WAIT_TIME;
-		}
-
-		max_wait -= mwait;
-		msleep(mwait);
-	}
-
-	return EEH_STATE_NOT_SUPPORT;
-}
-
 /**
  * pseries_eeh_get_log - Retrieve error log
  * @pe: EEH PE
@@ -849,7 +792,6 @@ static struct eeh_ops pseries_eeh_ops = {
 	.get_pe_addr		= pseries_eeh_get_pe_addr,
 	.get_state		= pseries_eeh_get_state,
 	.reset			= pseries_eeh_reset,
-	.wait_state		= pseries_eeh_wait_state,
 	.get_log		= pseries_eeh_get_log,
 	.configure_bridge       = pseries_eeh_configure_bridge,
 	.err_inject		= NULL,
-- 
2.19.0.2.gcad72f5712
