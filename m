Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BCAD67B7A
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 16:42:49 +1000 (EST)
Subject: [POWERPC] Make OF interrupt tree parsing more strict
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 16:42:33 +1000
Message-Id: <1152513753.1576.64.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a bit of boundchecking in the new Open Firmware
interrupt tree parsing code. It's important that it fails when things
aren't correct in order to trigger fallback mecanisms that are necessary
to make some machines work properly.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/prom_parse.c	2006-07-10 12:39:08.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/prom_parse.c	2006-07-10 12:43:51.000000000 +1000
@@ -881,7 +881,7 @@
 	intsize = *tmp;
 
 	/* Check index */
-	if (index * intsize >= intlen)
+	if ((index + 1) * intsize > intlen)
 		return -EINVAL;
 
 	/* Get new specifier and map it */
