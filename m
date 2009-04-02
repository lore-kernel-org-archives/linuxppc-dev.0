Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C66EDDE23
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 15:02:43 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: change giveup_fpu/altivec to disable VSX for current
Date: Thu, 02 Apr 2009 15:02:42 +1100
Message-ID: <2074.1238644962@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When we call giveup_fpu, we need to need to turn off VSX in current.
If we don't, on return to current it may execute a VSX instruction
(before the next FP), and not have it's register state refreshed
correctly from the thread_struct.  Ditto for altivec.

This caused a bug where an unaligned lfs or stfs (which calls
giveup_fpu so it can use the FPRs) to return to userspace with FP off
but VSX on.  Then if a VSX instruction is executed, before another FP
instruction, it will proceed without another exception and hence have
the incorrect register state for VSX registers 0-31.

   lfs unaligned   <- alignment exception turns FP off but leaves VSX on

   VSX instruction <- no exception since VSX on, hence we get the
                      wrong VSX register values for VSX registers 0-31
                      (overlapping the FPRs)

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/fpu.S     |    5 +++++
 arch/powerpc/kernel/misc_64.S |    8 ++++++++
 2 files changed, 13 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/fpu.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
@@ -145,6 +145,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	beq	1f
 	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	li	r3,MSR_FP|MSR_FE0|MSR_FE1
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	oris	r3,r3,MSR_VSX@h
+END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
 	andc	r4,r4,r3		/* disable FP for previous task */
 	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc_64.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc_64.S
@@ -495,7 +495,15 @@ _GLOBAL(giveup_altivec)
 	stvx	vr0,r4,r3
 	beq	1f
 	ld	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	lis	r3,(MSR_VEC|MSR_VSX)@h
+FTR_SECTION_ELSE
+	lis	r3,MSR_VEC@h
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_VSX)
+#else
 	lis	r3,MSR_VEC@h
+#endif
 	andc	r4,r4,r3		/* disable FP for previous task */
 	std	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
