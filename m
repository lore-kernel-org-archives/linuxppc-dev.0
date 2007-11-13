Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BBD54DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 23:42:40 +1100 (EST)
Subject: [PATCH] PMU: don't lock_kernel()
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Nov 2007 20:07:56 +0100
Message-Id: <1194980876.6695.4.camel@johannes.berg>
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
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Please queue to whatever branch you feel appropriate.

 drivers/macintosh/via-pmu.c |    3 ---
 1 file changed, 3 deletions(-)

--- everything.orig/drivers/macintosh/via-pmu.c	2007-11-13 19:32:01.728726509 +0100
+++ everything/drivers/macintosh/via-pmu.c	2007-11-13 19:32:03.058713543 +0100
@@ -33,7 +33,6 @@
 #include <linux/adb.h>
 #include <linux/pmu.h>
 #include <linux/cuda.h>
-#include <linux/smp_lock.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
@@ -2547,7 +2546,6 @@ pmu_release(struct inode *inode, struct 
 	struct pmu_private *pp = file->private_data;
 	unsigned long flags;
 
-	lock_kernel();
 	if (pp != 0) {
 		file->private_data = NULL;
 		spin_lock_irqsave(&all_pvt_lock, flags);
@@ -2561,7 +2559,6 @@ pmu_release(struct inode *inode, struct 
 
 		kfree(pp);
 	}
-	unlock_kernel();
 	return 0;
 }
 
