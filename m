Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 866D4B6FD7
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:31 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 11:34:26 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S64MMm4341762
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:22 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64Lma005508
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:21 +0530
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/21] pSeries platform EEH wait PE state
Date: Tue, 28 Feb 2012 14:03:58 +0800
Message-Id: <1330409051-8941-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On pSeries platform, the PE state might be temporarily unavailable.
In that case, the firmware will return the corresponding wait time.
That means the kernel has to wait for appropriate time in order to
get the PE state.

The patch does the implementation for that. Besides, the function
has been abstracted through struct eeh_ops::wait_state so that EEH core
components could support multiple platforms in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h           |    1 -
 arch/powerpc/platforms/pseries/eeh.c         |   46 +------------------------
 arch/powerpc/platforms/pseries/eeh_driver.c  |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   47 +++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 6150349..1cfb2b0 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -58,7 +58,6 @@ struct pci_dev *pci_get_device_by_addr(unsigned long addr);
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 int eeh_pci_enable(struct pci_dn *pdn, int function);
 int eeh_reset_pe(struct pci_dn *);
-int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs);
 void eeh_restore_bars(struct pci_dn *);
 void eeh_configure_bridge(struct pci_dn *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 8d11f1f..b5b03d4 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -287,48 +287,6 @@ void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 }
 
 /**
- * eeh_wait_for_slot_status - Returns error status of slot
- * @pdn: pci device node
- * @max_wait_msecs: maximum number to millisecs to wait
- *
- * Return negative value if a permanent error, else return
- * Partition Endpoint (PE) status value.
- *
- * If @max_wait_msecs is positive, then this routine will
- * sleep until a valid status can be obtained, or until
- * the max allowed wait time is exceeded, in which case
- * a -2 is returned.
- */
-int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs)
-{
-	int rc;
-	int mwait;
-
-	while (1) {
-		rc = eeh_ops->get_state(pdn->node, &mwait);
-		if (rc != EEH_STATE_UNAVAILABLE)
-			return rc;
-
-		if (max_wait_msecs <= 0) break;
-
-		if (mwait <= 0) {
-			printk(KERN_WARNING "EEH: Firmware returned bad wait value=%d\n",
-				mwait);
-			mwait = 1000;
-		} else if (mwait > 300*1000) {
-			printk(KERN_WARNING "EEH: Firmware is taking too long, time=%d\n",
-				mwait);
-			mwait = 300*1000;
-		}
-		max_wait_msecs -= mwait;
-		msleep(mwait);
-	}
-
-	printk(KERN_WARNING "EEH: Timed out waiting for slot status\n");
-	return -2;
-}
-
-/**
  * eeh_token_to_phys - Convert EEH address token to phys address
  * @token: I/O token, should be address in the form 0xA....
  *
@@ -640,7 +598,7 @@ int eeh_pci_enable(struct pci_dn *pdn, int function)
 		printk(KERN_WARNING "EEH: Unexpected state change %d, err=%d dn=%s\n",
 		        function, rc, pdn->node->full_name);
 
-	rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
+	rc = eeh_ops->wait_state(pdn->node, PCI_BUS_RESET_WAIT_MSEC);
 	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
 	   (function == EEH_OPT_THAW_MMIO))
 		return 0;
@@ -838,7 +796,7 @@ int eeh_reset_pe(struct pci_dn *pdn)
 	for (i=0; i<3; i++) {
 		eeh_reset_pe_once(pdn);
 
-		rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
+		rc = eeh_ops->wait_state(pdn->node, PCI_BUS_RESET_WAIT_MSEC);
 		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
 			return 0;
 
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 4c6e0c1c..584defe 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -396,7 +396,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 3 seconds for certain systems. */
-	rc = eeh_wait_for_slot_status (frozen_pdn, MAX_WAIT_FOR_RECOVERY*1000);
+	rc = eeh_ops->wait_state(frozen_pdn->node, MAX_WAIT_FOR_RECOVERY*1000);
 	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
 		printk(KERN_WARNING "EEH: Permanent failure\n");
 		goto hard_fail;
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 39567b2..7b60131 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -331,7 +331,52 @@ static int pseries_eeh_reset(struct device_node *dn, int option)
  */
 static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
 {
-	return 0;
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
+		ret = pseries_eeh_get_state(dn, &mwait);
+
+		/*
+		 * If the PE's state is temporarily unavailable,
+		 * we have to wait for the specified time. Otherwise,
+		 * the PE's state will be returned immediately.
+		 */
+		if (ret != EEH_STATE_UNAVAILABLE)
+			return ret;
+
+		if (max_wait <= 0) {
+			pr_warning("%s: Timeout when getting PE's state (%d)\n",
+				__func__, max_wait);
+			return EEH_STATE_NOT_SUPPORT;
+		}
+
+		if (mwait <= 0) {
+			pr_warning("%s: Firmware returned bad wait value %d\n",
+				__func__, mwait);
+			mwait = EEH_STATE_MIN_WAIT_TIME;
+		} else if (mwait > EEH_STATE_MAX_WAIT_TIME) {
+			pr_warning("%s: Firmware returned too long wait value %d\n",
+				__func__, mwait);
+			mwait = EEH_STATE_MAX_WAIT_TIME;
+		}
+
+		max_wait -= mwait;
+		msleep(mwait);
+	}
+
+	return EEH_STATE_NOT_SUPPORT;
 }
 
 /**
-- 
1.7.5.4
