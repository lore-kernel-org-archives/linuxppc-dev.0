Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31C9FDDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 13:24:17 +1000 (EST)
Date: Wed, 23 Apr 2008 22:20:16 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] cleanup misc_64.S
Message-ID: <Pine.LNX.4.64.0804232220020.32732@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Removed get_msr(), get_srr0(), and get_srr1() - not used anywhere
* Use STACK_FRAME_OVERHEAD instead of magic number

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/misc_64.S |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index a3c491e..942951e 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -27,23 +27,11 @@

 	.text

-_GLOBAL(get_msr)
-	mfmsr	r3
-	blr
-
-_GLOBAL(get_srr0)
-	mfsrr0  r3
-	blr
-
-_GLOBAL(get_srr1)
-	mfsrr1  r3
-	blr
-
 #ifdef CONFIG_IRQSTACKS
 _GLOBAL(call_do_softirq)
 	mflr	r0
 	std	r0,16(r1)
-	stdu	r1,THREAD_SIZE-112(r3)
+	stdu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
 	mr	r1,r3
 	bl	.__do_softirq
 	ld	r1,0(r1)
@@ -56,7 +44,7 @@ _GLOBAL(call_handle_irq)
 	mflr	r0
 	std	r0,16(r1)
 	mtctr	r8
-	stdu	r1,THREAD_SIZE-112(r5)
+	stdu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r5)
 	mr	r1,r5
 	bctrl
 	ld	r1,0(r1)
@@ -599,7 +587,7 @@ _GLOBAL(kexec_sequence)
 	std	r0,16(r1)

 	/* switch stacks to newstack -- &kexec_stack.stack */
-	stdu	r1,THREAD_SIZE-112(r3)
+	stdu	r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r3)
 	mr	r1,r3

 	li	r0,0
@@ -616,7 +604,7 @@ _GLOBAL(kexec_sequence)
 	std	r26,-48(r1)
 	std	r25,-56(r1)

-	stdu	r1,-112-64(r1)
+	stdu	r1,-STACK_FRAME_OVERHEAD-64(r1)

 	/* save args into preserved regs */
 	mr	r31,r3			/* newstack (both) */
-- 
1.5.4.1
