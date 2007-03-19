Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0BB7BDDFFC
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 06:58:18 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JJwDuG030570
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:58:13 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JJw8t9260454
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:58:08 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JJw8fB012465
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 15:58:08 -0400
Date: Mon, 19 Mar 2007 14:58:07 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/11] ppc64: EEH: wait for slot status
Message-ID: <20070319195807.GH11532@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319194349.GT5151@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Modify routine that returns PCI slot status to wait for slot status
to become available. This is needed, as slots that are in some remote 
card cage may go offline for extended periods of time. New users for 
this routine in following patches.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |  110 ++++++++++++++++++-----------------
 include/asm-powerpc/ppc-pci.h        |    3 
 2 files changed, 61 insertions(+), 52 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:43.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:46.000000000 -0500
@@ -76,6 +76,9 @@
  */
 #define EEH_MAX_FAILS	2100000
 
+/* Time to wait for a PCI slot to retport status, in milliseconds */
+#define PCI_BUS_RESET_WAIT_MSEC (60*1000)
+
 /* RTAS tokens */
 static int ibm_set_eeh_option;
 static int ibm_set_slot_reset;
@@ -169,6 +172,55 @@ static int read_slot_reset_state(struct 
 }
 
 /**
+ * eeh_wait_for_slot_status - returns error status of slot
+ * @pdn pci device node
+ * @max_wait_msecs maximum number to millisecs to wait
+ *
+ * Return negative value if a permanent error, else return 
+ * Partition Endpoint (PE) status value.
+ *
+ * If @max_wait_msecs is positive, then this routine will 
+ * sleep until a valid status can be obtained, or until
+ * the max allowed wait time is exceeded, in which case
+ * a -2 is returned.
+ */
+int
+eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs)
+{
+	int rc;
+	int rets[3];
+	int mwait;
+
+	while (1) {
+		rc = read_slot_reset_state(pdn, rets);
+		if (rc) return rc;
+		if (rets[1] == 0) return -1;  /* EEH is not supported */
+
+		if (rets[0] != 5) return rets[0]; /* return actual status */
+
+		if (rets[2] == 0) return -1; /* permanently unavailable */
+			
+		if (max_wait_msecs <= 0) return -1;
+		
+		mwait = rets[2];
+		if (mwait <= 0) {
+			printk (KERN_WARNING
+			        "EEH: Firmware returned bad wait value=%d\n", mwait);
+			mwait = 1000;
+		} else if (mwait > 300*1000) {
+			printk (KERN_WARNING
+			        "EEH: Firmware is taking too long, time=%d\n", mwait);
+			mwait = 300*1000;
+		}
+		max_wait_msecs -= mwait;
+		msleep (mwait);
+	}
+
+	printk(KERN_WARNING "EEH: Timed out waiting for slot status\n");
+	return -2;
+}
+
+/**
  * eeh_token_to_phys - convert EEH address token to phys address
  * @token i/o token, should be address in the form 0xA....
  */
@@ -459,38 +511,6 @@ EXPORT_SYMBOL(eeh_check_failure);
 /* The code below deals with error recovery */
 
 /**
- * eeh_slot_availability - returns error status of slot
- * @pdn pci device node
- *
- * Return negative value if a permanent error, else return
- * a number of milliseconds to wait until the PCI slot is
- * ready to be used.
- */
-static int
-eeh_slot_availability(struct pci_dn *pdn)
-{
-	int rc;
-	int rets[3];
-
-	rc = read_slot_reset_state(pdn, rets);
-
-	if (rc) return rc;
-
-	if (rets[1] == 0) return -1;  /* EEH is not supported */
-	if (rets[0] == 0) return 0;   /* Oll Korrect */
-	if (rets[0] == 5) {
-		if (rets[2] == 0) return -1; /* permanently unavailable */
-		return rets[2]; /* number of millisecs to wait */
-	}
-	if (rets[0] == 1)
-		return 250;
-
-	printk (KERN_ERR "EEH: Slot unavailable: rc=%d, rets=%d %d %d\n",
-		rc, rets[0], rets[1], rets[2]);
-	return -2;
-}
-
-/**
  * rtas_pci_enable - enable MMIO or DMA transfers for this slot
  * @pdn pci device node
  */
@@ -596,36 +616,24 @@ int rtas_set_slot_reset(struct pci_dn *p
 {
 	int i, rc;
 
-	__rtas_set_slot_reset(pdn);
+	/* Take three shots at resetting the bus */
+	for (i=0; i<3; i++) {
+		__rtas_set_slot_reset(pdn);
 
-	/* Now double check with the firmware to make sure the device is
-	 * ready to be used; if not, wait for recovery. */
-	for (i=0; i<10; i++) {
-		rc = eeh_slot_availability (pdn);
+		rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
 		if (rc == 0)
 			return 0;
 
-		if (rc == -2) {
-			printk (KERN_ERR "EEH: failed (%d) to reset slot %s\n",
-			        i, pdn->node->full_name);
-			__rtas_set_slot_reset(pdn);
-			continue;
-		}
-
 		if (rc < 0) {
 			printk (KERN_ERR "EEH: unrecoverable slot failure %s\n",
 			        pdn->node->full_name);
 			return -1;
 		}
-
-		msleep (rc+100);
+		printk (KERN_ERR "EEH: bus reset %d failed on slot %s\n", 
+		        i+1, pdn->node->full_name);
 	}
 
-	rc = eeh_slot_availability (pdn);
-	if (rc)
-		printk (KERN_ERR "EEH: timeout resetting slot %s\n", pdn->node->full_name);
-
-	return rc;
+	return -1;
 }
 
 /* ------------------------------------------------------- */
Index: linux-2.6.21-rc4-git4/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.21-rc4-git4.orig/include/asm-powerpc/ppc-pci.h	2007-02-04 12:44:54.000000000 -0600
+++ linux-2.6.21-rc4-git4/include/asm-powerpc/ppc-pci.h	2007-03-19 13:21:46.000000000 -0500
@@ -68,7 +68,7 @@ struct pci_dev *pci_get_device_by_addr(u
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 
 /**
- * rtas_pci_enableo - enable IO transfers for this slot
+ * rtas_pci_enable - enable IO transfers for this slot
  * @pdn:       pci device node
  * @function:  either EEH_THAW_MMIO or EEH_THAW_DMA 
  *
@@ -89,6 +89,7 @@ int rtas_pci_enable(struct pci_dn *pdn, 
  * Returns a non-zero value if the reset failed.
  */
 int rtas_set_slot_reset (struct pci_dn *);
+int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs);
 
 /** 
  * eeh_restore_bars - Restore device configuration info.
