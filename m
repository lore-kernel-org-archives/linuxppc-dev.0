Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58A0AB6FBB
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:36 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 09:30:57 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9X16e3297364
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:33:01 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cLO0006912
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:21 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/21] Cleanup on comments of EEH core
Date: Fri, 24 Feb 2012 17:37:58 +0800
Message-Id: <1330076298-7006-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: kernel.crashing.org@shangw, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EEH has been implemented on pSeries platform. The original
code looks a little bit nasty. The patch does cleanup on the
current EEH implementation so that it looks more clean.

	* Duplicated comments have been removed from the corresponding
	  header files.
	* Comments have been reorganized so that it looks more clean.
	* The leading comments of functions are adjusted for a little
	  bit so that the result of "make pdfdocs" would be more
	  unified.
	* Function definitions and calls have unified format as "xxx()".
	  That means the format "xxx ()" has been replaced by "xxx()".
	* There're multiple functions implemented for resetting PE. The
	  position of those functions have been move around so that they
	  are adjacent to each other to reflect their relationship.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h       |   26 +--
 arch/powerpc/include/asm/ppc-pci.h   |   71 +------
 arch/powerpc/platforms/pseries/eeh.c |  400 +++++++++++++++++++++++-----------
 3 files changed, 276 insertions(+), 221 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 66ea9b8..2328877 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -1,6 +1,6 @@
 /*
- * eeh.h
  * Copyright (C) 2001  Dave Engebretsen & Todd Inglett IBM Corporation.
+ * Copyright 2001-2012 IBM Corporation.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -40,8 +40,10 @@ extern int eeh_subsystem_enabled;
 #define EEH_MODE_RECOVERING    (1<<3)
 #define EEH_MODE_IRQ_DISABLED  (1<<4)
 
-/* Max number of EEH freezes allowed before we consider the device
- * to be permanently disabled. */
+/*
+ * Max number of EEH freezes allowed before we consider the device
+ * to be permanently disabled.
+ */
 #define EEH_MAX_ALLOWED_FREEZES 5
 
 void __init eeh_init(void);
@@ -49,26 +51,8 @@ unsigned long eeh_check_failure(const volatile void __iomem *token,
 				unsigned long val);
 int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev);
 void __init pci_addr_cache_build(void);
-
-/**
- * eeh_add_device_early
- * eeh_add_device_late
- *
- * Perform eeh initialization for devices added after boot.
- * Call eeh_add_device_early before doing any i/o to the
- * device (including config space i/o).  Call eeh_add_device_late
- * to finish the eeh setup for this device.
- */
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
-
-/**
- * eeh_remove_device_recursive - undo EEH for device & children.
- * @dev: pci device to be removed
- *
- * As above, this removes the device; it also removes child
- * pci devices as well.
- */
 void eeh_remove_bus_device(struct pci_dev *);
 
 /**
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 6d42297..221d82f 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -47,92 +47,27 @@ extern int rtas_setup_phb(struct pci_controller *phb);
 
 extern unsigned long pci_probe_only;
 
-/* ---- EEH internal-use-only related routines ---- */
 #ifdef CONFIG_EEH
 
 void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
 void pci_addr_cache_build(void);
 struct pci_dev *pci_get_device_by_addr(unsigned long addr);
-
-/**
- * eeh_slot_error_detail -- record and EEH error condition to the log
- * @pdn:      pci device node
- * @severity: EEH_LOG_TEMP_FAILURE or EEH_LOG_PERM_FAILURE
- *
- * Obtains the EEH error details from the RTAS subsystem,
- * and then logs these details with the RTAS error log system.
- */
 #define EEH_LOG_TEMP_FAILURE 1
 #define EEH_LOG_PERM_FAILURE 2
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
-
-/**
- * rtas_pci_enable - enable IO transfers for this slot
- * @pdn:       pci device node
- * @function:  either EEH_THAW_MMIO or EEH_THAW_DMA 
- *
- * Enable I/O transfers to this slot 
- */
 #define EEH_THAW_MMIO 2
 #define EEH_THAW_DMA  3
 int rtas_pci_enable(struct pci_dn *pdn, int function);
-
-/**
- * rtas_set_slot_reset -- unfreeze a frozen slot
- * @pdn:       pci device node
- *
- * Clear the EEH-frozen condition on a slot.  This routine
- * does this by asserting the PCI #RST line for 1/8th of
- * a second; this routine will sleep while the adapter is
- * being reset.
- *
- * Returns a non-zero value if the reset failed.
- */
 int rtas_set_slot_reset (struct pci_dn *);
 int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs);
-
-/** 
- * eeh_restore_bars - Restore device configuration info.
- * @pdn:       pci device node
- *
- * A reset of a PCI device will clear out its config space.
- * This routines will restore the config space for this
- * device, and is children, to values previously obtained
- * from the firmware.
- */
 void eeh_restore_bars(struct pci_dn *);
-
-/**
- * rtas_configure_bridge -- firmware initialization of pci bridge
- * @pdn:       pci device node
- *
- * Ask the firmware to configure all PCI bridges devices
- * located behind the indicated node. Required after a
- * pci device reset. Does essentially the same hing as
- * eeh_restore_bars, but for brdges, and lets firmware 
- * do the work.
- */
 void rtas_configure_bridge(struct pci_dn *);
-
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
-
-/**
- * eeh_mark_slot -- set mode flags for pertition endpoint
- * @pdn:       pci device node
- *
- * mark and clear slots: find "partition endpoint" PE and set or 
- * clear the flags for each subnode of the PE.
- */
-void eeh_mark_slot (struct device_node *dn, int mode_flag);
-void eeh_clear_slot (struct device_node *dn, int mode_flag);
-
-/**
- * find_device_pe -- Find the associated "Partiationable Endpoint" PE
- * @pdn:       pci device node
- */
-struct device_node * find_device_pe(struct device_node *dn);
+void eeh_mark_slot(struct device_node *dn, int mode_flag);
+void eeh_clear_slot(struct device_node *dn, int mode_flag);
+struct device_node *find_device_pe(struct device_node *dn);
 
 void eeh_sysfs_add_device(struct pci_dev *pdev);
 void eeh_sysfs_remove_device(struct pci_dev *pdev);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index c0b40af..5f6d37b 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -1,8 +1,8 @@
 /*
- * eeh.c
  * Copyright IBM Corporation 2001, 2005, 2006
  * Copyright Dave Engebretsen & Todd Inglett 2001
  * Copyright Linas Vepstas 2005, 2006
+ * Copyright 2001-2012 IBM Corporation.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -22,7 +22,7 @@
  */
 
 #include <linux/delay.h>
-#include <linux/sched.h>	/* for init_mm */
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/pci.h>
@@ -129,9 +129,16 @@ static unsigned long slot_resets;
 
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
 
-/* --------------------------------------------------------------- */
-/* Below lies the EEH event infrastructure */
-
+/**
+ * rtas_slot_error_detail - Retrieve error log through RTAS call
+ * @pdn: device node
+ * @severity: temporary or permanent error log
+ * @driver_log: driver log to be combined with the retrieved error log
+ * @loglen: length of driver log
+ *
+ * This routine should be called to retrieve error log through the dedicated
+ * RTAS call.
+ */
 static void rtas_slot_error_detail(struct pci_dn *pdn, int severity,
                                    char *driver_log, size_t loglen)
 {
@@ -163,7 +170,7 @@ static void rtas_slot_error_detail(struct pci_dn *pdn, int severity,
 }
 
 /**
- * gather_pci_data - copy assorted PCI config space registers to buff
+ * gather_pci_data - Copy assorted PCI config space registers to buff
  * @pdn: device to report data for
  * @buf: point to buffer in which to log
  * @len: amount of room in buffer
@@ -258,6 +265,16 @@ static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 	return n;
 }
 
+/**
+ * eeh_slot_error_detail - Generate combined log including driver log and error log
+ * @pdn: device node
+ * @severity: temporary or permanent error log
+ *
+ * This routine should be called to generate the combined log, which
+ * is comprised of driver log and error log. The driver log is figured
+ * out from the config space of the corresponding PCI device, while
+ * the error log is fetched through platform dependent function call.
+ */
 void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 {
 	size_t loglen = 0;
@@ -275,6 +292,9 @@ void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
  * read_slot_reset_state - Read the reset state of a device node's slot
  * @dn: device node to read
  * @rets: array to return results in
+ *
+ * Read the reset state of a device node's slot through platform dependent
+ * function call.
  */
 static int read_slot_reset_state(struct pci_dn *pdn, int rets[])
 {
@@ -300,9 +320,9 @@ static int read_slot_reset_state(struct pci_dn *pdn, int rets[])
 }
 
 /**
- * eeh_wait_for_slot_status - returns error status of slot
- * @pdn pci device node
- * @max_wait_msecs maximum number to millisecs to wait
+ * eeh_wait_for_slot_status - Returns error status of slot
+ * @pdn: pci device node
+ * @max_wait_msecs: maximum number to millisecs to wait
  *
  * Return negative value if a permanent error, else return
  * Partition Endpoint (PE) status value.
@@ -332,16 +352,16 @@ eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs)
 
 		mwait = rets[2];
 		if (mwait <= 0) {
-			printk (KERN_WARNING
-			        "EEH: Firmware returned bad wait value=%d\n", mwait);
+			printk(KERN_WARNING "EEH: Firmware returned bad wait value=%d\n",
+				mwait);
 			mwait = 1000;
 		} else if (mwait > 300*1000) {
-			printk (KERN_WARNING
-			        "EEH: Firmware is taking too long, time=%d\n", mwait);
+			printk(KERN_WARNING "EEH: Firmware is taking too long, time=%d\n",
+				mwait);
 			mwait = 300*1000;
 		}
 		max_wait_msecs -= mwait;
-		msleep (mwait);
+		msleep(mwait);
 	}
 
 	printk(KERN_WARNING "EEH: Timed out waiting for slot status\n");
@@ -349,8 +369,11 @@ eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs)
 }
 
 /**
- * eeh_token_to_phys - convert EEH address token to phys address
- * @token i/o token, should be address in the form 0xA....
+ * eeh_token_to_phys - Convert EEH address token to phys address
+ * @token: I/O token, should be address in the form 0xA....
+ *
+ * This routine should be called to convert virtual I/O address
+ * to physical one.
  */
 static inline unsigned long eeh_token_to_phys(unsigned long token)
 {
@@ -365,8 +388,11 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	return pa | (token & (PAGE_SIZE-1));
 }
 
-/** 
- * Return the "partitionable endpoint" (pe) under which this device lies
+/**
+ * find_device_pe - Retrieve the PE for the given device
+ * @dn: device node
+ *
+ * Return the PE under which this device lies
  */
 struct device_node * find_device_pe(struct device_node *dn)
 {
@@ -377,14 +403,18 @@ struct device_node * find_device_pe(struct device_node *dn)
 	return dn;
 }
 
-/** Mark all devices that are children of this device as failed.
- *  Mark the device driver too, so that it can see the failure
- *  immediately; this is critical, since some drivers poll
- *  status registers in interrupts ... If a driver is polling,
- *  and the slot is frozen, then the driver can deadlock in
- *  an interrupt context, which is bad.
+/**
+ * __eeh_mark_slot - Mark all child devices as failed
+ * @parent: parent device
+ * @mode_flag: failure flag
+ *
+ * Mark all devices that are children of this device as failed.
+ * Mark the device driver too, so that it can see the failure
+ * immediately; this is critical, since some drivers poll
+ * status registers in interrupts ... If a driver is polling,
+ * and the slot is frozen, then the driver can deadlock in
+ * an interrupt context, which is bad.
  */
-
 static void __eeh_mark_slot(struct device_node *parent, int mode_flag)
 {
 	struct device_node *dn;
@@ -404,10 +434,18 @@ static void __eeh_mark_slot(struct device_node *parent, int mode_flag)
 	}
 }
 
-void eeh_mark_slot (struct device_node *dn, int mode_flag)
+/**
+ * eeh_mark_slot - Mark the indicated device and its children as failed
+ * @dn: parent device
+ * @mode_flag: failure flag
+ *
+ * Mark the indicated device and its child devices as failed.
+ * The device drivers are marked as failed as well.
+ */
+void eeh_mark_slot(struct device_node *dn, int mode_flag)
 {
 	struct pci_dev *dev;
-	dn = find_device_pe (dn);
+	dn = find_device_pe(dn);
 
 	/* Back up one, since config addrs might be shared */
 	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
@@ -423,6 +461,13 @@ void eeh_mark_slot (struct device_node *dn, int mode_flag)
 	__eeh_mark_slot(dn, mode_flag);
 }
 
+/**
+ * __eeh_clear_slot - Clear failure flag for the child devices
+ * @parent: parent device
+ * @mode_flag: flag to be cleared
+ *
+ * Clear failure flag for the child devices.
+ */
 static void __eeh_clear_slot(struct device_node *parent, int mode_flag)
 {
 	struct device_node *dn;
@@ -436,12 +481,19 @@ static void __eeh_clear_slot(struct device_node *parent, int mode_flag)
 	}
 }
 
-void eeh_clear_slot (struct device_node *dn, int mode_flag)
+/**
+ * eeh_clear_slot - Clear failure flag for the indicated device and its children
+ * @dn: parent device
+ * @mode_flag: flag to be cleared
+ *
+ * Clear failure flag for the indicated device and its children.
+ */
+void eeh_clear_slot(struct device_node *dn, int mode_flag)
 {
 	unsigned long flags;
 	raw_spin_lock_irqsave(&confirm_error_lock, flags);
 	
-	dn = find_device_pe (dn);
+	dn = find_device_pe(dn);
 	
 	/* Back up one, since config addrs might be shared */
 	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
@@ -453,43 +505,10 @@ void eeh_clear_slot (struct device_node *dn, int mode_flag)
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
-void __eeh_set_pe_freset(struct device_node *parent, unsigned int *freset)
-{
-	struct device_node *dn;
-
-	for_each_child_of_node(parent, dn) {
-		if (PCI_DN(dn)) {
-
-			struct pci_dev *dev = PCI_DN(dn)->pcidev;
-
-			if (dev && dev->driver)
-				*freset |= dev->needs_freset;
-
-			__eeh_set_pe_freset(dn, freset);
-		}
-	}
-}
-
-void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
-{
-	struct pci_dev *dev;
-	dn = find_device_pe(dn);
-
-	/* Back up one, since config addrs might be shared */
-	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
-		dn = dn->parent;
-
-	dev = PCI_DN(dn)->pcidev;
-	if (dev)
-		*freset |= dev->needs_freset;
-
-	__eeh_set_pe_freset(dn, freset);
-}
-
 /**
- * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
- * @dn device node
- * @dev pci device, if known
+ * eeh_dn_check_failure - Check if all 1's data is due to EEH slot freeze
+ * @dn: device node
+ * @dev: pci device, if known
  *
  * Check for an EEH failure for the given device node.  Call this
  * routine if the result of a read was all 0xff's and you want to
@@ -548,11 +567,11 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 		pdn->eeh_check_count ++;
 		if (pdn->eeh_check_count % EEH_MAX_FAILS == 0) {
 			location = of_get_property(dn, "ibm,loc-code", NULL);
-			printk (KERN_ERR "EEH: %d reads ignored for recovering device at "
+			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
 				"location=%s driver=%s pci addr=%s\n",
 				pdn->eeh_check_count, location,
 				eeh_driver_name(dev), eeh_pci_name(dev));
-			printk (KERN_ERR "EEH: Might be infinite loop in %s driver\n",
+			printk(KERN_ERR "EEH: Might be infinite loop in %s driver\n",
 				eeh_driver_name(dev));
 			dump_stack();
 		}
@@ -579,7 +598,8 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	}
 
 	/* Note that config-io to empty slots may fail;
-	 * they are empty when they don't have children. */
+	 * they are empty when they don't have children.
+	 */
 	if ((rets[0] == 5) && (rets[2] == 0) && (dn->child == NULL)) {
 		false_positives++;
 		pdn->eeh_false_positives ++;
@@ -609,15 +629,17 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
  
 	/* Avoid repeated reports of this failure, including problems
 	 * with other functions on this device, and functions under
-	 * bridges. */
-	eeh_mark_slot (dn, EEH_MODE_ISOLATED);
+	 * bridges.
+	 */
+	eeh_mark_slot(dn, EEH_MODE_ISOLATED);
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	eeh_send_failure_event (dn, dev);
+	eeh_send_failure_event(dn, dev);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
-	 * out what happened.  So print that out. */
+	 * out what happened.  So print that out.
+	 */
 	dump_stack();
 	return 1;
 
@@ -629,9 +651,9 @@ dn_unlock:
 EXPORT_SYMBOL_GPL(eeh_dn_check_failure);
 
 /**
- * eeh_check_failure - check if all 1's data is due to EEH slot freeze
- * @token i/o token, should be address in the form 0xA....
- * @val value, should be all 1's (XXX why do we need this arg??)
+ * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
+ * @token: I/O token, should be address in the form 0xA....
+ * @val: value, should be all 1's (XXX why do we need this arg??)
  *
  * Check for an EEH failure at the given token address.  Call this
  * routine if the result of a read was all 0xff's and you want to
@@ -655,7 +677,7 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 	}
 
 	dn = pci_device_to_OF_node(dev);
-	eeh_dn_check_failure (dn, dev);
+	eeh_dn_check_failure(dn, dev);
 
 	pci_dev_put(dev);
 	return val;
@@ -663,14 +685,15 @@ unsigned long eeh_check_failure(const volatile void __iomem *token, unsigned lon
 
 EXPORT_SYMBOL(eeh_check_failure);
 
-/* ------------------------------------------------------------- */
-/* The code below deals with error recovery */
 
 /**
- * rtas_pci_enable - enable MMIO or DMA transfers for this slot
+ * rtas_pci_enable - Enable MMIO or DMA transfers for this slot
  * @pdn pci device node
+ *
+ * This routine should be called to reenable frozen MMIO or DMA
+ * so that it would work correctly again. It's useful while doing
+ * recovery or log collection on the indicated device.
  */
-
 int
 rtas_pci_enable(struct pci_dn *pdn, int function)
 {
@@ -692,7 +715,7 @@ rtas_pci_enable(struct pci_dn *pdn, int function)
 		printk(KERN_WARNING "EEH: Unexpected state change %d, err=%d dn=%s\n",
 		        function, rc, pdn->node->full_name);
 
-	rc = eeh_wait_for_slot_status (pdn, PCI_BUS_RESET_WAIT_MSEC);
+	rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
 	if ((rc == 4) && (function == EEH_THAW_MMIO))
 		return 0;
 
@@ -700,27 +723,25 @@ rtas_pci_enable(struct pci_dn *pdn, int function)
 }
 
 /**
- * rtas_pci_slot_reset - raises/lowers the pci #RST line
- * @pdn pci device node
+ * rtas_pci_slot_reset - Raises/Lowers the pci #RST line
+ * @pdn: pci device node
  * @state: 1/0 to raise/lower the #RST
  *
  * Clear the EEH-frozen condition on a slot.  This routine
  * asserts the PCI #RST line if the 'state' argument is '1',
  * and drops the #RST line if 'state is '0'.  This routine is
  * safe to call in an interrupt context.
- *
  */
-
 static void
 rtas_pci_slot_reset(struct pci_dn *pdn, int state)
 {
 	int config_addr;
 	int rc;
 
-	BUG_ON (pdn==NULL); 
+	BUG_ON(pdn==NULL);
 
 	if (!pdn->phb) {
-		printk (KERN_WARNING "EEH: in slot reset, device node %s has no phb\n",
+		printk(KERN_WARNING "EEH: in slot reset, device node %s has no phb\n",
 		        pdn->node->full_name);
 		return;
 	}
@@ -752,12 +773,12 @@ rtas_pci_slot_reset(struct pci_dn *pdn, int state)
 
 /**
  * pcibios_set_pcie_slot_reset - Set PCI-E reset state
- * @dev:	pci device struct
- * @state:	reset state to enter
+ * @dev: pci device struct
+ * @state: reset state to enter
  *
  * Return value:
  * 	0 if success
- **/
+ */
 int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
@@ -781,10 +802,62 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 }
 
 /**
- * rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
- * @pdn: pci device node to be reset.
+ * __eeh_set_pe_freset - Check the required reset for child devices
+ * @parent: parent device
+ * @freset: return value
+ *
+ * Each device might have its preferred reset type: fundamental or
+ * hot reset. The routine is used to collect the information from
+ * the child devices so that they could be reset accordingly.
  */
+void __eeh_set_pe_freset(struct device_node *parent, unsigned int *freset)
+{
+	struct device_node *dn;
+
+	for_each_child_of_node(parent, dn) {
+		if (PCI_DN(dn)) {
+			struct pci_dev *dev = PCI_DN(dn)->pcidev;
+
+			if (dev && dev->driver)
+				*freset |= dev->needs_freset;
+
+			__eeh_set_pe_freset(dn, freset);
+		}
+	}
+}
+
+/**
+ * eeh_set_pe_freset - Check the required reset for the indicated device and its children
+ * @dn: parent device
+ * @freset: return value
+ *
+ * Each device might have its preferred reset type: fundamental or
+ * hot reset. The routine is used to collected the information for
+ * the indicated device and its children so that the bunch of the
+ * devices could be reset properly.
+ */
+void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
+{
+	struct pci_dev *dev;
+	dn = find_device_pe(dn);
+
+	/* Back up one, since config addrs might be shared */
+	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
+		dn = dn->parent;
 
+	dev = PCI_DN(dn)->pcidev;
+	if (dev)
+		*freset |= dev->needs_freset;
+
+	__eeh_set_pe_freset(dn, freset);
+}
+
+/**
+ * __rtas_set_slot_reset - Assert the pci #RST line for 1/4 second
+ * @pdn: pci device node to be reset.
+ *
+ * Assert the PCI #RST line for 1/4 second.
+ */
 static void __rtas_set_slot_reset(struct pci_dn *pdn)
 {
 	unsigned int freset = 0;
@@ -803,25 +876,35 @@ static void __rtas_set_slot_reset(struct pci_dn *pdn)
 		rtas_pci_slot_reset(pdn, 1);
 
 	/* The PCI bus requires that the reset be held high for at least
-	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
-
+	 * a 100 milliseconds. We wait a bit longer 'just in case'.
+	 */
 #define PCI_BUS_RST_HOLD_TIME_MSEC 250
-	msleep (PCI_BUS_RST_HOLD_TIME_MSEC);
+	msleep(PCI_BUS_RST_HOLD_TIME_MSEC);
 	
 	/* We might get hit with another EEH freeze as soon as the 
 	 * pci slot reset line is dropped. Make sure we don't miss
-	 * these, and clear the flag now. */
-	eeh_clear_slot (pdn->node, EEH_MODE_ISOLATED);
+	 * these, and clear the flag now.
+	 */
+	eeh_clear_slot(pdn->node, EEH_MODE_ISOLATED);
 
-	rtas_pci_slot_reset (pdn, 0);
+	rtas_pci_slot_reset(pdn, 0);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
 	 * a 1.5 second idle time for the bus to stabilize, before starting
-	 * up traffic. */
+	 * up traffic.
+	 */
 #define PCI_BUS_SETTLE_TIME_MSEC 1800
-	msleep (PCI_BUS_SETTLE_TIME_MSEC);
+	msleep(PCI_BUS_SETTLE_TIME_MSEC);
 }
 
+/**
+ * rtas_set_slot_reset - Reset the indicated PE
+ * @pdn: PCI device node
+ *
+ * This routine should be called to reset indicated device, including
+ * PE. A PE might include multiple PCI devices and sometimes PCI bridges
+ * might be involved as well.
+ */
 int rtas_set_slot_reset(struct pci_dn *pdn)
 {
 	int i, rc;
@@ -846,7 +929,6 @@ int rtas_set_slot_reset(struct pci_dn *pdn)
 	return -1;
 }
 
-/* ------------------------------------------------------- */
 /** Save and restore of PCI BARs
  *
  * Although firmware will set up BARs during boot, it doesn't
@@ -863,7 +945,7 @@ int rtas_set_slot_reset(struct pci_dn *pdn)
  * the expansion ROM base address, the latency timer, and etc.
  * from the saved values in the device node.
  */
-static inline void __restore_bars (struct pci_dn *pdn)
+static inline void __restore_bars(struct pci_dn *pdn)
 {
 	int i;
 	u32 cmd;
@@ -879,17 +961,18 @@ static inline void __restore_bars (struct pci_dn *pdn)
 #define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
 #define SAVED_BYTE(OFF) (((u8 *)(pdn->config_space))[BYTE_SWAP(OFF)])
 
-	rtas_write_config (pdn, PCI_CACHE_LINE_SIZE, 1,
+	rtas_write_config(pdn, PCI_CACHE_LINE_SIZE, 1,
 	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
 
-	rtas_write_config (pdn, PCI_LATENCY_TIMER, 1,
+	rtas_write_config(pdn, PCI_LATENCY_TIMER, 1,
 	            SAVED_BYTE(PCI_LATENCY_TIMER));
 
 	/* max latency, min grant, interrupt pin and line */
 	rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
 
 	/* Restore PERR & SERR bits, some devices require it,
-	   don't touch the other command bits */
+	 * don't touch the other command bits
+	 */
 	rtas_read_config(pdn, PCI_COMMAND, 4, &cmd);
 	if (pdn->config_space[1] & PCI_COMMAND_PARITY)
 		cmd |= PCI_COMMAND_PARITY;
@@ -903,7 +986,8 @@ static inline void __restore_bars (struct pci_dn *pdn)
 }
 
 /**
- * eeh_restore_bars - restore the PCI config space info
+ * eeh_restore_bars - Restore the PCI config space info
+ * @pdn: PCI device node
  *
  * This routine performs a recursive walk to the children
  * of this device as well.
@@ -915,14 +999,15 @@ void eeh_restore_bars(struct pci_dn *pdn)
 		return;
 	
 	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_code))
-		__restore_bars (pdn);
+		__restore_bars(pdn);
 
 	for_each_child_of_node(pdn->node, dn)
-		eeh_restore_bars (PCI_DN(dn));
+		eeh_restore_bars(PCI_DN(dn));
 }
 
 /**
- * eeh_save_bars - save device bars
+ * eeh_save_bars - Save device bars
+ * @pdn: PCI device node
  *
  * Save the values of the device bars. Unlike the restore
  * routine, this routine is *not* recursive. This is because
@@ -940,6 +1025,14 @@ static void eeh_save_bars(struct pci_dn *pdn)
 		rtas_read_config(pdn, i * 4, 4, &pdn->config_space[i]);
 }
 
+/**
+ * rtas_configure_bridge - Configure PCI bridges for the indicated PE
+ * @pdn: PCI device node
+ *
+ * PCI bridges might be included in PE. In order to make the PE work
+ * again. The included PCI bridges should be recovered after the PE
+ * encounters frozen state.
+ */
 void
 rtas_configure_bridge(struct pci_dn *pdn)
 {
@@ -963,17 +1056,11 @@ rtas_configure_bridge(struct pci_dn *pdn)
 	               BUID_HI(pdn->phb->buid),
 	               BUID_LO(pdn->phb->buid));
 	if (rc) {
-		printk (KERN_WARNING "EEH: Unable to configure device bridge (%d) for %s\n",
+		printk(KERN_WARNING "EEH: Unable to configure device bridge (%d) for %s\n",
 		        rc, pdn->node->full_name);
 	}
 }
 
-/* ------------------------------------------------------------- */
-/* The code below deals with enabling EEH for devices during  the
- * early boot sequence.  EEH must be enabled before any PCI probing
- * can be done.
- */
-
 #define EEH_ENABLE 1
 
 struct eeh_early_enable_info {
@@ -981,7 +1068,18 @@ struct eeh_early_enable_info {
 	unsigned int buid_lo;
 };
 
-static int get_pe_addr (int config_addr,
+/**
+ * get_pe_addr - Retrieve PE address with given BDF address
+ * @config_addr: BDF address
+ * @info: BUID of the associated PHB
+ *
+ * There're 2 kinds of addresses existing in EEH core components:
+ * BDF address and PE address. Besides, there has dedicated platform
+ * dependent function call to retrieve the PE address according to
+ * the given BDF address. Further more, we prefer PE address on BDF
+ * address in EEH core components.
+ */
+static int get_pe_addr(int config_addr,
                         struct eeh_early_enable_info *info)
 {
 	unsigned int rets[3];
@@ -990,12 +1088,12 @@ static int get_pe_addr (int config_addr,
 	/* Use latest config-addr token on power6 */
 	if (ibm_get_config_addr_info2 != RTAS_UNKNOWN_SERVICE) {
 		/* Make sure we have a PE in hand */
-		ret = rtas_call (ibm_get_config_addr_info2, 4, 2, rets,
+		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
 			config_addr, info->buid_hi, info->buid_lo, 1);
 		if (ret || (rets[0]==0))
 			return 0;
 
-		ret = rtas_call (ibm_get_config_addr_info2, 4, 2, rets,
+		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
 			config_addr, info->buid_hi, info->buid_lo, 0);
 		if (ret)
 			return 0;
@@ -1004,7 +1102,7 @@ static int get_pe_addr (int config_addr,
 
 	/* Use older config-addr token on power5 */
 	if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
-		ret = rtas_call (ibm_get_config_addr_info, 4, 2, rets,
+		ret = rtas_call(ibm_get_config_addr_info, 4, 2, rets,
 			config_addr, info->buid_hi, info->buid_lo, 0);
 		if (ret)
 			return 0;
@@ -1013,7 +1111,15 @@ static int get_pe_addr (int config_addr,
 	return 0;
 }
 
-/* Enable eeh for the given device node. */
+/**
+ * early_enable_eeh - Early enable EEH on the indicated device
+ * @dn: device node
+ * @data: BUID
+ *
+ * Enable EEH functionality on the specified PCI device. The function
+ * is expected to be called before real PCI probing is done. However,
+ * the PHBs have been initialized at this point.
+ */
 static void *early_enable_eeh(struct device_node *dn, void *data)
 {
 	unsigned int rets[3];
@@ -1047,7 +1153,8 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 	pdn->class_code = *class_code;
 
 	/* Ok... see if this device supports EEH.  Some do, some don't,
-	 * and the only way to find out is to check each and every one. */
+	 * and the only way to find out is to check each and every one.
+	 */
 	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
@@ -1061,13 +1168,15 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 			pdn->eeh_config_addr = regs[0];
 
 			/* If the newer, better, ibm,get-config-addr-info is supported, 
-			 * then use that instead. */
+			 * then use that instead.
+			 */
 			pdn->eeh_pe_config_addr = get_pe_addr(pdn->eeh_config_addr, info);
 
 			/* Some older systems (Power4) allow the
 			 * ibm,set-eeh-option call to succeed even on nodes
 			 * where EEH is not supported. Verify support
-			 * explicitly. */
+			 * explicitly.
+			 */
 			ret = read_slot_reset_state(pdn, rets);
 			if ((ret == 0) && (rets[1] == 1))
 				enable = 1;
@@ -1083,7 +1192,8 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 		} else {
 
 			/* This device doesn't support EEH, but it may have an
-			 * EEH parent, in which case we mark it as supported. */
+			 * EEH parent, in which case we mark it as supported.
+			 */
 			if (dn->parent && PCI_DN(dn->parent)
 			    && (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
 				/* Parent supports EEH. */
@@ -1101,7 +1211,9 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 	return NULL;
 }
 
-/*
+/**
+ * eeh_init - EEH initialization
+ *
  * Initialize EEH by trying to enable it for all of the adapters in the system.
  * As a side effect we can determine here if eeh is supported at all.
  * Note that we leave EEH on so failed config cycles won't cause a machine
@@ -1133,7 +1245,7 @@ void __init eeh_init(void)
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
 	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
 	ibm_get_config_addr_info2 = rtas_token("ibm,get-config-addr-info2");
-	ibm_configure_bridge = rtas_token ("ibm,configure-bridge");
+	ibm_configure_bridge = rtas_token("ibm,configure-bridge");
 	ibm_configure_pe = rtas_token("ibm,configure-pe");
 
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
@@ -1170,7 +1282,7 @@ void __init eeh_init(void)
 }
 
 /**
- * eeh_add_device_early - enable EEH for the indicated device_node
+ * eeh_add_device_early - Enable EEH for the indicated device_node
  * @dn: device node for which to set up EEH
  *
  * This routine must be used to perform EEH initialization for PCI
@@ -1199,6 +1311,14 @@ static void eeh_add_device_early(struct device_node *dn)
 	early_enable_eeh(dn, &info);
 }
 
+/**
+ * eeh_add_device_tree_early - Enable EEH for the indicated device
+ * @dn: device node
+ *
+ * This routine must be used to perform EEH initialization for the
+ * indicated PCI device that was added after system boot (e.g.
+ * hotplug, dlpar).
+ */
 void eeh_add_device_tree_early(struct device_node *dn)
 {
 	struct device_node *sib;
@@ -1210,7 +1330,7 @@ void eeh_add_device_tree_early(struct device_node *dn)
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
 
 /**
- * eeh_add_device_late - perform EEH initialization for the indicated pci device
+ * eeh_add_device_late - Perform EEH initialization for the indicated pci device
  * @dev: pci device for which to set up EEH
  *
  * This routine must be used to complete EEH initialization for PCI
@@ -1234,13 +1354,21 @@ static void eeh_add_device_late(struct pci_dev *dev)
 	}
 	WARN_ON(pdn->pcidev);
 
-	pci_dev_get (dev);
+	pci_dev_get(dev);
 	pdn->pcidev = dev;
 
 	pci_addr_cache_insert_device(dev);
 	eeh_sysfs_add_device(dev);
 }
 
+/**
+ * eeh_add_device_tree_late - Perform EEH initialization for the indicated PCI bus
+ * @bus: PCI bus
+ *
+ * This routine must be used to perform EEH initialization for PCI
+ * devices which are attached to the indicated PCI bus. The PCI bus
+ * is added after system boot through hotplug or dlpar.
+ */
 void eeh_add_device_tree_late(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -1257,7 +1385,7 @@ void eeh_add_device_tree_late(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
 
 /**
- * eeh_remove_device - undo EEH setup for the indicated pci device
+ * eeh_remove_device - Undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  *
  * This routine should be called when a device is removed from
@@ -1281,12 +1409,20 @@ static void eeh_remove_device(struct pci_dev *dev)
 		return;
 	}
 	PCI_DN(dn)->pcidev = NULL;
-	pci_dev_put (dev);
+	pci_dev_put(dev);
 
 	pci_addr_cache_remove_device(dev);
 	eeh_sysfs_remove_device(dev);
 }
 
+/**
+ * eeh_remove_bus_device - Undo EEH setup for the indicated PCI device
+ * @dev: PCI device
+ *
+ * This routine must be called when a device is removed from the
+ * running system through hotplug or dlpar. The corresponding
+ * PCI address cache will be removed.
+ */
 void eeh_remove_bus_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->subordinate;
-- 
1.7.5.4
