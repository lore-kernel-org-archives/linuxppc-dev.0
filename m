Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id C4977B70B3
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 05:13:14 +1100 (EST)
Date: Thu, 10 Dec 2009 13:13:11 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Floating point in the kernel
Message-ID: <20091210131311.78cab78c@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One of our drivers has code that was originally running on a DSP. The
code makes heavy use of floating point. We have isolated all the
floating point to one kthread in the driver. Using enable_kernel_fp()
this has worked well.

But under a specific heavy RTP load, we started getting kernel panics.
To make a long story short, the scheduler disables FP when you are
context switched out. When you come back and access a FP instruction,
you trap and call load_up_fpu() and everything is fine..... unless you
are in the kernel. If you are in the kernel, like our kthread is, you
get a "kernel FP unavailable exception".

Basically we got away with it for two years because the thread is at
high priority (-20) and tries very hard to finish within 1ms. But the
RTP high load causes us to context switch out and crash. The following
patch fixes this:

diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 50504ae..3476de9 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -383,7 +383,7 @@ label:
 #define FP_UNAVAILABLE_EXCEPTION                                             \
        START_EXCEPTION(FloatingPointUnavailable)                             \
        NORMAL_EXCEPTION_PROLOG;                                              \
-       beq     1f;                                                           \
+       /* SAM beq      1f; */                                          \
        bl      load_up_fpu;            /* if from user, just load it up */   \
        b       fast_exception_return;                                        \
 1:     addi    r3,r1,STACK_FRAME_OVERHEAD;                                   \

With the patch we run fine, at the expense that we lose the ability to
catch real FP unavailable exceptions in the kernel. It is because of
this loss that I have not submitted this patch.

We also hit another problem under high RTP load... and this is the
patch that fixes it:

diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index fc8f5b1..051a02c 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -83,6 +83,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
        stfd    fr0,THREAD_FPSCR(r4)
        PPC_LL  r5,PT_REGS(r4)
        toreal(r5)
+
+       /* Under heavy RTP load the hsp thread can have a NULL pt_regs. */
+       PPC_LCMPI       0,r5,0
+       beq     1f
+
        PPC_LL  r4,_MSR-STACK_FRAME_OVERHEAD(r5)
        li      r10,MSR_FP|MSR_FE0|MSR_FE1
        andc    r4,r4,r10               /* disable FP for previous task */

So, if you are still reading this far, I am just looking for any
suggestions. Are there better ways of handling this? Have I
missed something? Anybody know why pt_regs might be NULL?

Cheers,
   Sean
