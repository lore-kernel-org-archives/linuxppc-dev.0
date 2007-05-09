Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 28097DDEFF
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:38:34 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l49GcVVe029541
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 12:38:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49GcVTh138544
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 10:38:31 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49GcV50029484
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 10:38:31 -0600
Date: Wed, 9 May 2007 11:38:11 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: PowerPC: Assorted janitorial EEH cleanups.
Message-ID: <20070509163811.GV4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Assorted minor cleanups to EEH code; -- use literals, use
kerneldoc format.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |   13 ++++++++++---
 arch/powerpc/platforms/pseries/eeh_driver.c |    7 ++++---
 include/asm-powerpc/ppc-pci.h               |   18 +++++++++++++++---
 3 files changed, 29 insertions(+), 9 deletions(-)

Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-08 17:56:55.000000000 -0500
+++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh_driver.c	2007-05-09 11:19:11.000000000 -0500
@@ -378,8 +378,9 @@ struct pci_dn * handle_eeh_events (struc
 
 	/* Since rtas may enable MMIO when posting the error log,
 	 * don't post the error log until after all dev drivers
-	 * have been informed. */
-	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
+	 * have been informed.
+	 */
+	eeh_slot_error_detail(frozen_pdn, EEH_LOG_TEMP_FAILURE);
 
 	/* If all device drivers were EEH-unaware, then shut
 	 * down all of the device drivers, and hope they
@@ -470,7 +471,7 @@ hard_fail:
 		location, drv_str, pci_str);
 
 perm_error:
-	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
+	eeh_slot_error_detail(frozen_pdn, EEH_LOG_PERM_FAILURE);
 
 	/* Notify all devices that they're about to go down. */
 	pci_walk_bus(frozen_bus, eeh_report_failure, NULL);
Index: linux-2.6.21-rc7-mm2/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.21-rc7-mm2.orig/include/asm-powerpc/ppc-pci.h	2007-04-26 15:37:56.000000000 -0500
+++ linux-2.6.21-rc7-mm2/include/asm-powerpc/ppc-pci.h	2007-05-09 11:19:30.000000000 -0500
@@ -62,11 +62,14 @@ struct pci_dev *pci_get_device_by_addr(u
 
 /**
  * eeh_slot_error_detail -- record and EEH error condition to the log
- * @severity: 1 if temporary, 2 if permanent failure.
+ * @pdn:      pci device node
+ * @severity: EEH_LOG_TEMP_FAILURE or EEH_LOG_PERM_FAILURE
  *
  * Obtains the the EEH error details from the RTAS subsystem,
  * and then logs these details with the RTAS error log system.
  */
+#define EEH_LOG_TEMP_FAILURE 1
+#define EEH_LOG_PERM_FAILURE 2
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 
 /**
@@ -82,6 +85,7 @@ int rtas_pci_enable(struct pci_dn *pdn, 
 
 /**
  * rtas_set_slot_reset -- unfreeze a frozen slot
+ * @pdn:       pci device node
  *
  * Clear the EEH-frozen condition on a slot.  This routine
  * does this by asserting the PCI #RST line for 1/8th of
@@ -95,6 +99,7 @@ int eeh_wait_for_slot_status(struct pci_
 
 /** 
  * eeh_restore_bars - Restore device configuration info.
+ * @pdn:       pci device node
  *
  * A reset of a PCI device will clear out its config space.
  * This routines will restore the config space for this
@@ -105,6 +110,7 @@ void eeh_restore_bars(struct pci_dn *);
 
 /**
  * rtas_configure_bridge -- firmware initialization of pci bridge
+ * @pdn:       pci device node
  *
  * Ask the firmware to configure all PCI bridges devices
  * located behind the indicated node. Required after a
@@ -118,16 +124,22 @@ int rtas_write_config(struct pci_dn *, i
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 
 /**
+ * eeh_mark_slot -- set mode flags for pertition endpoint
+ * @pdn:       pci device node
+ *
  * mark and clear slots: find "partition endpoint" PE and set or 
  * clear the flags for each subnode of the PE.
  */
 void eeh_mark_slot (struct device_node *dn, int mode_flag);
 void eeh_clear_slot (struct device_node *dn, int mode_flag);
 
-/* Find the associated "Partiationable Endpoint" PE */
+/**
+ * find_device_pe -- Find the associated "Partiationable Endpoint" PE
+ * @pdn:       pci device node
+ */
 struct device_node * find_device_pe(struct device_node *dn);
 
-#endif
+#endif /* CONFIG_EEH */
 
 #else /* CONFIG_PCI */
 static inline void find_and_init_phbs(void) { }
Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/eeh.c	2007-05-08 17:56:55.000000000 -0500
+++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/eeh.c	2007-05-09 11:26:01.000000000 -0500
@@ -76,7 +76,7 @@
  */
 #define EEH_MAX_FAILS	2100000
 
-/* Time to wait for a PCI slot to retport status, in milliseconds */
+/* Time to wait for a PCI slot to report status, in milliseconds */
 #define PCI_BUS_RESET_WAIT_MSEC (60*1000)
 
 /* RTAS tokens */
@@ -95,11 +95,18 @@ EXPORT_SYMBOL(eeh_subsystem_enabled);
 /* Lock to avoid races due to multiple reports of an error */
 static DEFINE_SPINLOCK(confirm_error_lock);
 
-/* Buffer for reporting slot-error-detail rtas calls */
+/* Buffer for reporting slot-error-detail rtas calls. Its here
+ * in BSS, and not dynamically alloced, so that it ends up in
+ * RMO where RTAS can access it.
+ */
 static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
 static DEFINE_SPINLOCK(slot_errbuf_lock);
 static int eeh_error_buf_size;
 
+/* Buffer for reporting pci register dumps. Its here in BSS, and
+ * not dynamically alloced, so that it ends up in RMO where RTAS
+ * can access it.
+ */
 #define EEH_PCI_REGS_LOG_LEN 4096
 static unsigned char pci_regs_buf[EEH_PCI_REGS_LOG_LEN];
 
@@ -218,7 +225,7 @@ static size_t gather_pci_data(struct pci
 void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 {
 	size_t loglen = 0;
-	memset(pci_regs_buf, 0, EEH_PCI_REGS_LOG_LEN);
+	pci_regs_buf[0] = 0;
 
 	rtas_pci_enable(pdn, EEH_THAW_MMIO);
 	loglen = gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
