Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 801D1DDDE7
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 11:51:23 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1H0q0jY008619
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 19:52:00 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1H0pIpe302010
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 19:51:18 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1H0pI0o031901
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 19:51:18 -0500
Date: Fri, 16 Feb 2007 18:51:17 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc64: wait for pci error state to settle down
Message-ID: <20070217005117.GO923@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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



Paul,
Please apply to your ppc64 tree.
--linas


PCI devices may be attached via a "far away" pci bus which 
might be in the process of being reset. Wait for the
pci bus to come back online before trying to reset the 
pci device.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |    5 ++---
 arch/powerpc/platforms/pseries/eeh_driver.c |   25 ++++++++++++++++++++++---
 include/asm-powerpc/eeh.h                   |    2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

Index: linux-2.6.20-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.20-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-02-16 17:35:01.000000000 -0600
+++ linux-2.6.20-git4/arch/powerpc/platforms/pseries/eeh.c	2007-02-16 18:26:27.000000000 -0600
@@ -409,7 +409,7 @@ int eeh_dn_check_failure(struct device_n
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
 	 * out what happened.  So print that out. */
-	if (rets[0] != 5) dump_stack();
+	dump_stack();
 	return 1;
 
 dn_unlock:
@@ -465,8 +465,7 @@ EXPORT_SYMBOL(eeh_check_failure);
  * a number of milliseconds to wait until the PCI slot is
  * ready to be used.
  */
-static int
-eeh_slot_availability(struct pci_dn *pdn)
+int eeh_slot_availability(struct pci_dn *pdn)
 {
 	int rc;
 	int rets[3];
Index: linux-2.6.20-git4/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.20-git4.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-02-09 11:41:09.000000000 -0600
+++ linux-2.6.20-git4/arch/powerpc/platforms/pseries/eeh_driver.c	2007-02-16 18:05:22.000000000 -0600
@@ -299,7 +299,7 @@ static int eeh_reset_device (struct pci_
 /* The longest amount of time to wait for a pci device
  * to come back on line, in seconds.
  */
-#define MAX_WAIT_FOR_RECOVERY 15
+#define MAX_WAIT_FOR_RECOVERY 150
 
 struct pci_dn * handle_eeh_events (struct eeh_event *event)
 {
@@ -362,8 +362,8 @@ struct pci_dn * handle_eeh_events (struc
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto excess_failures;
 
-	/* If the reset state is a '5' and the time to reset is 0 (infinity)
-	 * or is more then 15 seconds, then mark this as a permanent failure.
+	/* If the reset state is a '5' and the recovery time is 0 (infinity),
+	 * or is more then 2.5 minutes, then mark this as a permanent failure.
 	 */
 	if ((event->state == pci_channel_io_perm_failure) &&
 	    ((event->time_unavail <= 0) ||
@@ -384,6 +384,25 @@ struct pci_dn * handle_eeh_events (struc
 	 */
 	pci_walk_bus(frozen_bus, eeh_report_error, &result);
 
+	/* If the reset state is a '5' and the recovery time is
+	 * finite, then wait until the bus is in a recovered state
+	 * before doing anything more.
+	 */
+	if (event->state == pci_channel_io_perm_failure) {
+		int unavail_wait = 0;
+		while (unavail_wait < MAX_WAIT_FOR_RECOVERY*1000) {
+			rc = eeh_slot_availability(frozen_pdn);
+			if (rc < 0)
+				goto hard_fail;
+			if (rc == 0)
+				break;
+			unavail_wait += rc+100;
+			msleep (rc+100);
+		}
+		if (rc != 0)
+			goto hard_fail;
+	}
+
 	/* If all device drivers were EEH-unaware, then shut
 	 * down all of the device drivers, and hope they
 	 * go down willingly, without panicing the system.
Index: linux-2.6.20-git4/include/asm-powerpc/eeh.h
===================================================================
--- linux-2.6.20-git4.orig/include/asm-powerpc/eeh.h	2007-02-04 12:44:54.000000000 -0600
+++ linux-2.6.20-git4/include/asm-powerpc/eeh.h	2007-02-16 18:18:12.000000000 -0600
@@ -31,6 +31,7 @@ struct device_node;
 
 #ifdef CONFIG_EEH
 
+struct pci_dn;
 extern int eeh_subsystem_enabled;
 
 /* Values for eeh_mode bits in device_node */
@@ -49,6 +50,7 @@ unsigned long eeh_check_failure(const vo
 				unsigned long val);
 int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev);
 void __init pci_addr_cache_build(void);
+int eeh_slot_availability(struct pci_dn *pdn);
 
 /**
  * eeh_add_device_early
