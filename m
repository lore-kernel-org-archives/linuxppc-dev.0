Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C33384750F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:14:39 +1100 (EST)
Subject: [PATCH 3/4] hvc_console: free_irq only if request_irq was successful
From: Milton Miller <miltonm@bga.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Benjiman Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <hvc-console-29-3-3@bga.com>
In-Reply-To: : <hvc-console-29-3@bga.com>
Date: Thu, 08 Jan 2009 06:14:21 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Joe Peterson <joe@skyrush.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Only call free_irq if we marked the request_irq has having succeeded
instead of whenever the the sub-driver identified the interrupt to use.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Appears to be a bugfix but might use a bit of time in -next.
This code was created in 2.6.28 to allow s390 to build without adding ifdefs.
Many hvc-console sub-drivers have a single channel and are not modules.

Index: work.git/drivers/char/hvc_irq.c
===================================================================
--- work.git.orig/drivers/char/hvc_irq.c	2009-01-08 04:07:28.000000000 -0600
+++ work.git/drivers/char/hvc_irq.c	2009-01-08 04:07:47.000000000 -0600
@@ -37,7 +37,7 @@ int notifier_add_irq(struct hvc_struct *
 
 void notifier_del_irq(struct hvc_struct *hp, int irq)
 {
-	if (!irq)
+	if (!hp->irq_requested)
 		return;
 	free_irq(irq, hp);
 	hp->irq_requested = 0;
