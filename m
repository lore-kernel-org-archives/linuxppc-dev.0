Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57BACDDE49
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:09:16 +1100 (EST)
Message-Id: <20070205185836.099816000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Date: Mon, 05 Feb 2007 19:30:30 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/10] powerpc: fix comment in kernel/irq.c
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
numbers. Replace by NO_IRQ and NO_IRQ_IGNORE.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>

--- mb-wireless.orig/arch/powerpc/kernel/irq.c	2007-02-05 14:24:06.694526864 +0100
+++ mb-wireless/arch/powerpc/kernel/irq.c	2007-02-05 14:24:37.084526864 +0100
@@ -281,10 +281,10 @@ void do_IRQ(struct pt_regs *regs)
 
 	/*
 	 * Every platform is required to implement ppc_md.get_irq.
-	 * This function will either return an irq number or -1 to
+	 * This function will either return an irq number or NO_IRQ to
 	 * indicate there are no more pending.
-	 * The value -2 is for buggy hardware and means that this IRQ
-	 * has already been handled. -- Tom
+	 * The value NO_IRQ_IGNORE is for buggy hardware and means that this
+	 * IRQ has already been handled. -- Tom
 	 */
 	irq = ppc_md.get_irq();
 

--
