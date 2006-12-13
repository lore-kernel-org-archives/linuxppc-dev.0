Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F26FB67D7C
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 00:01:28 +1100 (EST)
Message-Id: <20061213123945.859071000@sipsolutions.net>>
References: <20061213123819.403286000@sipsolutions.net>>
Date: Wed, 13 Dec 2006 13:38:22 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc: fix comment in kernel/irq.c
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
numbers, but this is actually dependent on configuration options now.
Replace by NO_IRQ and NO_IRQ_ENABLED.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6-git.orig/arch/powerpc/kernel/irq.c	2006-12-13 12:03:44.406144791 +0100
+++ linux-2.6-git/arch/powerpc/kernel/irq.c	2006-12-13 12:04:05.727144791 +0100
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
