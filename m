Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id E96D568206
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Sep 2005 01:13:03 +1000 (EST)
Date: Thu, 8 Sep 2005 08:13:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20050908151302.GI3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.13] ppc32: Correct an instruction in the boot code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In the flush and invalidate bootcode on PPC4xx we were accidentally
using the wrong instruction.  Use cmplw, which reads from a register
like we want.

From: Frank van Maarseveen <frankvm@frankvm.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Index: linux-2.6/arch/ppc/boot/common/util.S
===================================================================
--- linux-2.6.orig/arch/ppc/boot/common/util.S
+++ linux-2.6/arch/ppc/boot/common/util.S
@@ -252,7 +252,7 @@ _GLOBAL(flush_instruction_cache)
 1:	dcbf	r0,r3			# Flush the data cache
 	icbi	r0,r3			# Invalidate the instruction cache
 	addi	r3,r3,0x10		# Increment by one cache line
-	cmplwi	cr0,r3,r4		# Are we at the end yet?
+	cmplw	cr0,r3,r4		# Are we at the end yet?
 	blt	1b			# No, keep flushing and invalidating
 #else
 	/* Enable, invalidate and then disable the L1 icache/dcache. */

-- 
Tom Rini
http://gate.crashing.org/~trini/
