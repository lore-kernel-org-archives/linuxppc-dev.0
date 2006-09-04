Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A489567BC1
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Sep 2006 10:36:32 +1000 (EST)
Subject: [PATCH] powerpc: Fix typo in powermac platform functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 10:36:15 +1000
Message-Id: <1157330175.32334.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

New sparse caught that typo which could have caused erratic hardware
behaviour on some machines if the platform functions are used by the
firmware to change bits in some FCR registers.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/platforms/powermac/pfunc_base.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pfunc_base.c	2006-07-04 09:37:03.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/pfunc_base.c	2006-09-04 10:34:02.000000000 +1000
@@ -256,7 +256,7 @@
 	.write_reg32		= macio_do_write_reg32,
 	.read_reg32		= macio_do_read_reg32,
 	.write_reg8		= macio_do_write_reg8,
-	.read_reg32		= macio_do_read_reg8,
+	.read_reg8		= macio_do_read_reg8,
 	.read_reg32_msrx	= macio_do_read_reg32_msrx,
 	.read_reg8_msrx		= macio_do_read_reg8_msrx,
 	.write_reg32_slm	= macio_do_write_reg32_slm,
