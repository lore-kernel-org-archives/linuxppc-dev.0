Return-Path: <mmlnx@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F09DDDF32
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 02:40:48 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6LGZ0iH005523
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 12:35:00 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6LGeb5K108442
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 10:40:40 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6LGeaXZ030595
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 10:40:37 -0600
Message-ID: <4884BBF1.2060708@us.ibm.com>
Date: Mon, 21 Jul 2008 09:40:17 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: paulus@samba.org, benh@kernel.crashing.org, linasvepstas@gmail.com,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
References: <488383D4.9000602@us.ibm.com>
In-Reply-To: <488383D4.9000602@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a repost of the patch with the suggested changes.

This patch changes the EEH_MAX_FAILS action from panic to printing an 
error message.  Panicking under under this condition is too harsh.  
Although performance will be affected and the device may not recover, 
the system is still running, which at the very least should allow for a 
more graceful shutdown. The patch also removes the msleep() within a 
spinlock, which can lead to a deadlock and is not recommended.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
Acked-by: Linas Vepstas <linasvepstas@gmail.com>

--- powerpc.git/arch/powerpc/platforms/pseries/eeh.c	2008-07-18 08:51:42.000000000 -0700
+++ powerpc.git-new/arch/powerpc/platforms/pseries/eeh.c	2008-07-21 03:25:43.000000000 -0700
@@ -75,9 +75,9 @@
  */
 
 /* If a device driver keeps reading an MMIO register in an interrupt
- * handler after a slot isolation event has occurred, we assume it
- * is broken and panic.  This sets the threshold for how many read
- * attempts we allow before panicking.
+ * handler after a slot isolation event, it might be broken.
+ * This sets the threshold for how many read attempts we allow
+ * before printing an error message.
  */
 #define EEH_MAX_FAILS	2100000
 
@@ -470,6 +470,7 @@ int eeh_dn_check_failure(struct device_n
 	unsigned long flags;
 	struct pci_dn *pdn;
 	int rc = 0;
+	const char *location;
 
 	total_mmio_ffs++;
 
@@ -509,18 +510,15 @@ int eeh_dn_check_failure(struct device_n
 	rc = 1;
 	if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
 		pdn->eeh_check_count ++;
-		if (pdn->eeh_check_count >= EEH_MAX_FAILS) {
-			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
-			        pdn->eeh_check_count);
+		if (pdn->eeh_check_count % EEH_MAX_FAILS == 0) {
+			location = of_get_property(dn, "ibm,loc-code", NULL);
+			printk (KERN_ERR "EEH: %d reads ignored for recovering device at "
+				"location=%s driver=%s pci addr=%s\n",
+				pdn->eeh_check_count, location,
+				dev->driver->name, pci_name(dev));
+			printk (KERN_ERR "EEH: Might be infinite loop in %s driver\n",
+				dev->driver->name);
 			dump_stack();
-			msleep(5000);
-			
-			/* re-read the slot reset state */
-			if (read_slot_reset_state(pdn, rets) != 0)
-				rets[0] = -1;	/* reset state unknown */
-
-			/* If we are here, then we hit an infinite loop. Stop. */
-			panic("EEH: MMIO halt (%d) on device:%s\n", rets[0], pci_name(dev));
 		}
 		goto dn_unlock;
 	}
