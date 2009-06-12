Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 327E2B71BC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 16:51:12 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87A98DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 16:51:10 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n5C6p5CQ010042
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 01:51:06 -0500
Subject: [PATCH] powerpc: Fix bug in move of altivec code to vector.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 16:51:04 +1000
Message-Id: <1244789464.7172.63.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch that moved to vector.S and made common between 32 and 64-bit the
altivec code had a nasty bug on 32-bit (did I really test that ?) which
causes the kernel to blr back into userspace ... oops :-)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'm going to stick that in my -next branch along with updating it to
Linus latest tonight. Things still blow in various places because
of the mem init change, see the patch I posted to lkml (I forgot to
CC it here, I'll do that now).

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 6437f90..4846946 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -733,9 +733,11 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 AltiVecUnavailable:
 	EXCEPTION_PROLOG
 #ifdef CONFIG_ALTIVEC
-	bne	load_up_altivec		/* if from user, just load it up */
+	beq	1f
+	bl	load_up_altivec		/* if from user, just load it up */
+	b	fast_exception_return
 #endif /* CONFIG_ALTIVEC */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
+1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
 
 PerformanceMonitor:
-- 
1.6.1.2.14.gf26b5
