Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADF0CDDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 01:26:07 +1100 (EST)
Message-Id: <20071211142405.777374000@sipsolutions.net>
References: <20071211142122.966506000@sipsolutions.net>
Date: Tue, 11 Dec 2007 15:21:23 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2.6.25 1/5] PMU: dont lock_kernel()
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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
 drivers/macintosh/via-pmu.c |    3 ---
 1 file changed, 3 deletions(-)

--- everything.orig/drivers/macintosh/via-pmu.c	2007-12-04 19:51:41.356950738 +0100
+++ everything/drivers/macintosh/via-pmu.c	2007-12-04 19:54:37.936951768 +0100
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
 

-- 
