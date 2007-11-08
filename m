Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AF23FDDF8F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 01:36:15 +1100 (EST)
Subject: [RFC] PMU: don't lock_kernel()
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 08 Nov 2007 13:01:23 +0100
Message-Id: <1194523283.6294.9.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I see nothing that this lock_kernel() actually protects against
so remove it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/via-pmu.c |    3 ---
 1 file changed, 3 deletions(-)

--- everything.orig/drivers/macintosh/via-pmu.c	2007-11-08 11:48:37.192845813 +0100
+++ everything/drivers/macintosh/via-pmu.c	2007-11-08 11:48:48.292846681 +0100
@@ -33,7 +33,6 @@
 #include <linux/adb.h>
 #include <linux/pmu.h>
 #include <linux/cuda.h>
-#include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
@@ -2436,7 +2435,6 @@ pmu_release(struct inode *inode, struct 
 	struct pmu_private *pp = file->private_data;
 	unsigned long flags;
 
-	lock_kernel();
 	if (pp != 0) {
 		file->private_data = NULL;
 		spin_lock_irqsave(&all_pvt_lock, flags);
@@ -2450,7 +2448,6 @@ pmu_release(struct inode *inode, struct 
 
 		kfree(pp);
 	}
-	unlock_kernel();
 	return 0;
 }
 
