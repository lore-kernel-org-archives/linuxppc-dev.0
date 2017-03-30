Return-Path: <srs0=dd8m=3h=linux-powerpc.org=kda@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv60l0qtKzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 01:08:07 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vv60l0H5Wz8swH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 01:08:07 +1100 (AEDT)
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vv60k0qMMz9s1y
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2017 01:08:05 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id r36so4752427lfi.0
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 07:08:05 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: gregkh@linuxfoundation.org,
	jslaby@suse.com
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH] tty/hvc_console: fix console lock ordering with spinlock
Date: Thu, 30 Mar 2017 10:06:19 -0400
Message-Id: <1490882779-16066-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hvc_remove() takes a spin lock first then acquires the console
semaphore. This situation can easily lead to a deadlock scenario
where we call scheduler with spin lock held.

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 drivers/tty/hvc/hvc_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index b19ae36..a8d3991 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -920,17 +920,17 @@ int hvc_remove(struct hvc_struct *hp)
 
 	tty = tty_port_tty_get(&hp->port);
 
+	console_lock();
 	spin_lock_irqsave(&hp->lock, flags);
 	if (hp->index < MAX_NR_HVC_CONSOLES) {
-		console_lock();
 		vtermnos[hp->index] = -1;
 		cons_ops[hp->index] = NULL;
-		console_unlock();
 	}
 
 	/* Don't whack hp->irq because tty_hangup() will need to free the irq. */
 
 	spin_unlock_irqrestore(&hp->lock, flags);
+	console_unlock();
 
 	/*
 	 * We 'put' the instance that was grabbed when the kref instance
-- 
1.8.3.1
