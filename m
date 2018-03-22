Return-Path: <srs0=gy/r=gm=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406RkV4PJJzDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:06:10 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 406RkT561Tz8sxT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:06:09 +1100 (AEDT)
Received: from mail-pl0-x22a.google.com (mail-pl0-x22a.google.com
 [IPv6:2607:f8b0:400e:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 406RkR6tMDz9s21
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2018 00:06:07 +1100 (AEDT)
Received: by mail-pl0-x22a.google.com with SMTP id k22-v6so5222427pls.6
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2018 06:06:07 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (115-64-218-172.tpgi.com.au.
 [115.64.218.172])
 by smtp.gmail.com with ESMTPSA id p23sm11285952pgv.11.2018.03.22.06.06.02
 for <linuxppc-dev@ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 22 Mar 2018 06:06:03 -0700 (PDT)
Date: Thu, 22 Mar 2018 23:05:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] powerpc/64s: rewriting interrupt entry code
Message-ID: <20180322230549.4eebf80e@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Long long post ahead...

I've been playing with rewriting interrupt entry code, this is really
rough patch so far, but it boots mambo. I'll just post it now to get
opinions on the approach.

This implements a new set of exception macros, converts the decrementer
to use them (it's maskable so it covers more cases).

Overall two main points to this work. First is to make the code easier
to understand and hack on, second is to improve performance of the end
result.

For the former case, gas macros are used rather than cpp macros as the
main building block. IMO this really turns out a lot nicer for a few
reasons -- we can conditionally include code by testing args rather
than passing in other macros that define our conditional bits, and we
can use cpp conditional compilation easily inside the gas macros. These
two properties means we don't have bits of asm code scattered through
various macros which call each other and are passed into other macros
etc. The everything is pretty linear and flat. Not having to use big
split line makes things nicer to rejig too.

I tried to make the syntax to do conditional asm a bit nicer, but
couldn't find a great way. It's not *horrible*:

#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
    .ifgt \kvm
    lbz    r25,HSTATE_IN_GUEST(r13)
    cmpwi  r25,0
    bne    1f
    .endif
#endif

We could improve it a bit maybe. You could put a cpp wrapper over it:
#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
    IF(kvm)
    lbz    r25,HSTATE_IN_GUEST(r13)
    cmpwi  r25,0
    bne    1f
    ENDIF
#endif

Also if anyone actually read the code, the macro invocations are
bare:
	INT_ENTRY	decrementer,0x80,0,1,PACA_EXGEN,1,0,1,1,1

Again this could be wrapped:
        INT_ENTRY(decrementer, 0x80, INT_SRR, INT_REAL, INT_KVMTEST,
                  INT_NO_CFAR, INT_PPR, INT_TB)

I think this approach will allow the amount of open coded and randomly
used macros to be reduced too. I'd like to really standardize entry a
lot even if it means e.g., some less performance critical interrupts
like MCE and HMI and up saving slightly more regs than they needed to.

Second thing is performance. The biggest concern in entry code is SPR
accesses, then probably loads and stores (assuming we've minimised
branches already). SPR reads should all be done first before any SPR
writes, to avoid scoreboard stalls. SPR writes should be minimised and
so should serialising reads (CFAR, PPR, TB).

So my thinking is:

- Avoid some of these SPR reads if possible. We can avoid saving and
  setting PPR if we don't go to general C code (e.g. SLB miss). We
  could avoid CFAR for some async interrupts, if we could rely on 0x100
  for debug IPIs then important external and doorbell interrupts could
  avoid CFAR.
  
- Start with a bunch of stores to free up GPRs, then do the serializing
  SPR reads as soon as possible before the pipeline fills (these reads
  have to wait for all previous OPs to complete before they can begin).

- Don't store these SPR reads immediately into the PACA, but keep them
  in the GPRs we've just freed. This should make it simpler to keep all
  stores close in cache, and importantly it avoids involveing the LSU in
  this dependency. Stores interact with barriers, and store queue
  resources can be allocated while the store waits for this dependency.

- In some cases (e.g., SLB miss) the CFAR may never be used. If we avoid
  storing the value anywhere, the data doesn't end up in a critical
  execution path (though it still pushes completion out).

- SPRs can be passed via GPRs through to C interrupt handlers. In this
  case we read TB right up front and pass it into timer_interrupt to
  avoid a mftb there.

- A number of HSRR interrupts do not clear MSR[RI], so setting it
  should be avoided for those. But might as well go one further and
  avoid setting MSR[RI]=1 until we're ready to set MSR[EE]=1 so they
  can be done at once. It does increase RI=0 window a bit, but we
  don't take SLB misses on the kernel stack, and we already deal with
  IR=DR=1 && RI=0 case for virt interrupts so we're already exposed
  to machine check in translation there.

- Use non-volatile GPRs for scratch registers. This means we can save
  non-volatiles before calling a C function just by storing them
  immediately to the stack (rather than loading from paca first). It
  allows us to call C functions without blowing our scratch registers.

- Load the stack early from the paca so register saving stores to stack
  get their dependency as soon as possible.

- Not in this patch and not entirely depending on it, but I would like
  to convert kvm interrupt entry over to using this same convention of
  PACA_EX save areas and register layout. Existing KVM calls are slower
  than they could be because they switch to using HSTATE_SCRATCH etc
  and this gets even worse now with more registers saved before the
  KVM test. Other benefit is that KVM entry at the moment is not
  reentrant-safe (e.g., machine check interrupting a hypervisor doorbell
  while KVM is in guest will corrupt scratch space despite MSR[RI]=1).
  Using the different paca save areas would solve that.

That's about all I can think of at the moment.

Thanks,
Nick

diff --git a/arch/powerpc/include/asm/exception-64s-new.h b/arch/powerpc/include/asm/exception-64s-new.h
new file mode 100644
index 000000000000..f5fdc49d14c5
--- /dev/null
+++ b/arch/powerpc/include/asm/exception-64s-new.h
@@ -0,0 +1,291 @@
+#ifndef _ASM_POWERPC_EXCEPTION_NEW_H
+#define _ASM_POWERPC_EXCEPTION_NEW_H
+/*
+ * The following macros define the code that appears as
+ * the prologue to each of the exception handlers.  They
+ * are split into two parts to allow a single kernel binary
+ * to be used for pSeries and iSeries.
+ *
+ * We make as much of the exception code common between native
+ * exception handlers (including pSeries LPAR) and iSeries LPAR
+ * implementations as possible.
+ */
+#include <asm/head-64.h>
+#include <asm/exception-64s.h>
+
+#define EX_R16		0x00
+#define EX_R17		0x08
+#define EX_R18		0x10
+#define EX_R19		0x18
+#define EX_R20		0x20
+#define EX_R21		0x28
+#define EX_R22		0x30
+#define EX_R23		0x38
+#define EX_R24		0x40
+#define EX_R25		0x48
+#define EX_R26		0x50
+#define EX_R1		0x58
+
+.macro	INT_ENTRY name size hsrr virt area kvm cfar ppr tb stack
+	SET_SCRATCH0(r13)		/* save r13 */
+	GET_PACA(r13)
+	.ifgt \cfar
+	std	r16,\area+EX_R16(r13)
+	.endif
+	.ifgt \ppr
+	std	r17,\area+EX_R17(r13)
+	.endif
+	.ifgt \tb
+	std	r18,\area+EX_R18(r13)
+	.endif
+	.ifgt \stack
+	std	r19,\area+EX_R19(r13)
+	.endif
+	.ifgt \cfar
+	OPT_GET_SPR(r16, SPRN_CFAR, CPU_FTR_CFAR)
+	.endif
+	.if (\size == 0x20)
+	b	\name\()_tramp
+	.ifgt \virt
+		.pushsection "virt_trampolines"
+	.else
+		.pushsection "real_trampolines"
+	.endif
+\name\()_tramp:
+	.endif
+
+	.ifgt \ppr
+	OPT_GET_SPR(r17, SPRN_PPR, CPU_FTR_HAS_PPR)
+	.endif
+	.ifgt \tb
+	mftb	r18
+	.endif
+	.ifgt \stack
+	ld	r19,PACAKSAVE(r13)	/* kernel stack to use		*/
+	.endif
+	std	r20,\area+EX_R20(r13)
+	std	r21,\area+EX_R21(r13)
+	std	r22,\area+EX_R22(r13)
+	std	r23,\area+EX_R23(r13)
+	.ifgt \hsrr
+	mfspr	r20,SPRN_HSRR0
+	mfspr	r21,SPRN_HSRR1
+	.else
+	mfspr	r20,SPRN_SRR0
+	mfspr	r21,SPRN_SRR1
+	.endif
+	mfcr	r22
+	mfctr	r23
+	std	r24,\area+EX_R24(r13)
+	std	r25,\area+EX_R25(r13)
+	.ifgt \stack
+	mr	r24,r1
+	.endif
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	.ifgt \kvm
+	lbz	r25,HSTATE_IN_GUEST(r13)
+	cmpwi	r25,0
+	bne	1f
+	.endif
+#endif
+#ifdef CONFIG_RELOCATABLE
+	.ifgt \virt
+	LOAD_HANDLER(r25,\name\()_virt)
+	.else
+	LOAD_HANDLER(r25,\name\()_real)
+	.endif
+	mtctr	r25
+	bctr
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	.ifgt \kvm
+1:	LOAD_HANDLER(r25,\name\()_kvm)
+	mtctr	r25
+	bctr
+	.endif
+#endif
+#else /* CONFIG_RELOCATABLE */
+	.ifgt \virt
+	b	\name\()_virt
+	.else
+	b	\name\()_real
+	.endif
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	.ifgt \kvm
+1:	b	\name\()_kvm
+	.endif
+#endif
+#endif /* CONFIG_RELOCATABLE */
+	.if (\size == 0x20)
+	.popsection
+	.endif
+.endm
+
+.macro INT_ENTRY_RESTORE area cfar ppr tb
+	mtcr	r22
+	mtctr	r23
+	mr	r1,r24
+	.ifgt \cfar
+	ld	r16,\area+EX_R16(r13)
+	.endif
+	.ifgt \ppr
+	ld	r17,\area+EX_R17(r13)
+	.endif
+	.ifgt \tb
+	ld	r18,\area+EX_R18(r13)
+	.endif
+	ld	r19,\area+EX_R19(r13)
+	ld	r20,\area+EX_R20(r13)
+	ld	r21,\area+EX_R21(r13)
+	ld	r22,\area+EX_R22(r13)
+	ld	r23,\area+EX_R23(r13)
+	ld	r24,\area+EX_R24(r13)
+	ld	r25,\area+EX_R25(r13)
+.endm
+
+/*
+ * After INT_ENTRY, with r1 set to a valid stack pointer, this macro sets up
+ * the stack frame, saves state into it, restores the NVGPR registers, and
+ * loads the TOC into r2.
+ */
+.macro INT_SETUP_C_CALL area cfar ppr tb
+	std	r24,0(r1)		/* make stack chain pointer	*/
+	std	r0,GPR0(r1)		/* save r0 in stackframe	*/
+	std	r24,GPR1(r1)		/* save r1 in stackframe	*/
+	std	r2,GPR2(r1)		/* save r2 in stackframe	*/
+	ld	r2,PACATOC(r13)		/* get kernel TOC into r2	*/
+	GET_SCRATCH0(r0)
+	SAVE_4GPRS(3, r1)		/* save r3 - r6 in stackframe  */
+	mflr	r3
+	mfspr	r4,SPRN_XER
+	ld	r5,PACACURRENT(r13)
+	ld	r6,exception_marker@toc(r2)
+	SAVE_4GPRS(7, r1)		/* save r7 - r10 in stackframe  */
+	SAVE_2GPRS(11, r1)		/* save r11 - r12 in stackframe  */
+	std	r0,GPR13(r1)
+	std	r20,_NIP(r1)		/* save SRR0 in stackframe	*/
+	std	r21,_MSR(r1)		/* save SRR1 in stackframe	*/
+	std	r22,_CCR(r1)		/* save CR in stackframe	*/
+	std	r23,_CTR(r1)		/* save CTR in stackframe	*/
+	std	r3,_LINK(r1)
+	std	r4,_XER(r1)
+	std	r25,_TRAP(r1)		/* set trap number		*/
+	li	r3,0
+	std	r3,RESULT(r1)		/* clear regs->result		*/
+	std	r19,SOFTE(r1)
+	std	r6,STACK_FRAME_OVERHEAD-16(r1) /* mark the frame	*/
+
+	HMT_MEDIUM /* XXX: where to put this? It is NTC SPR write, should go after all SPR reads, late but before NTC SPR read stores?? (cfar, tb, ppr) */
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+	andi.	r0,r19,IRQS_DISABLED
+	bne	1f
+	TRACE_DISABLE_INTS /* clobbers volatile registers */
+1:
+#endif
+
+	/* XXX: async calls */
+	FINISH_NAP
+	RUNLATCH_ON
+
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	.ifgt \cfar
+	std	r16,ORIG_GPR3(r1)
+	ld	r16,\area+EX_R16(r13)
+	.endif
+	.ifgt \ppr
+	std	r17,TASKTHREADPPR(r5)
+	ld	r17,\area+EX_R17(r13)
+	.endif
+	.ifgt \tb
+	mr	r4,r18
+	ld	r18,\area+EX_R18(r13)
+	.endif
+	ld	r19,\area+EX_R19(r13)
+	ld	r20,\area+EX_R20(r13)
+	ld	r21,\area+EX_R21(r13)
+	ld	r22,\area+EX_R22(r13)
+	ld	r23,\area+EX_R23(r13)
+	ld	r24,\area+EX_R24(r13)
+	ld	r25,\area+EX_R25(r13)
+.endm
+
+.macro INT_COMMON name vec area mask cfar ppr tb
+\name\()_real:
+	ld	r25,PACAKMSR(r13)	/* MSR value for kernel */
+	xori	r25,r25,MSR_RI		/* clear MSR_RI */
+	mtmsrd	r25,0
+	nop				/* Quadword align the virt entry */
+\name\()_virt:
+	andi.	r25,r21,MSR_PR
+	mr	r1,r19
+	li	r19,IRQS_ENABLED
+	li	r25,PACA_IRQ_HARD_DIS
+	bne	1f
+	subi	r1,r24,INT_FRAME_SIZE
+	.ifgt \mask
+	lbz	r19,PACAIRQSOFTMASK(r13)
+	andi.	r25,r19,\mask
+	lbz	r25,PACAIRQHAPPENED(r13)
+	bne-	\name\()_masked_interrupt
+	.else
+	lbz	r25,PACAIRQHAPPENED(r13)
+	.endif
+	ori	r25,r25,PACA_IRQ_HARD_DIS
+1:
+	stb	r25,PACAIRQHAPPENED(r13)
+	li	r25,IRQS_ALL_DISABLED
+	stb	r25,PACAIRQSOFTMASK(r13)
+	li	r25,\vec + 1
+	cmpdi	r1,-INT_FRAME_SIZE	/* check if r1 is in userspace	*/
+	bge-	bad_stack_common	/* abort if it is		*/
+	INT_SETUP_C_CALL \area \cfar \ppr \tb
+.endm
+
+.macro INT_KVM name hsrr vec area skip cfar ppr tb
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	.ifgt \skip
+	cmpwi	r25,KVM_GUEST_MODE_SKIP
+	beq	1f
+	HMT_MEDIUM /* XXX: where to put this? (see above) */
+	.endif
+	.ifgt \cfar
+	mr	r25,r16			/* No CFAR, set it to 0 */
+	.else
+	li	r25,0
+	.endif
+	std	r25,HSTATE_CFAR(r13)
+	.ifgt \ppr			/* No PPR */
+	mr	r25,r17
+	.else
+	li	r25,0
+	.endif
+	std	r25,HSTATE_PPR(r13)
+	INT_ENTRY_RESTORE \area \cfar \ppr \tb
+	std	r12,HSTATE_SCRATCH0(r13)
+	mfcr	r12
+	sldi	r12,r12,32
+	.ifgt \hsrr
+	ori	r12,r12,\vec + 0x2
+	.else
+	ori	r12,r12,\vec
+	.endif
+	b	kvmppc_interrupt
+
+	.ifgt \skip
+1:	addi	r20,r20,4
+	.ifgt \hsrr
+	mtspr	SPRN_HSRR0,r20
+	INT_ENTRY_RESTORE \area \cfar \ppr \tb
+	GET_SCRATCH0(r13)
+	HRFI_TO_KERNEL
+	.else
+	mtspr	SPRN_SRR0,r20
+	INT_ENTRY_RESTORE \area \cfar \ppr \tb
+	GET_SCRATCH0(r13)
+	RFI_TO_KERNEL
+	.endif
+	.endif
+#endif
+.endm
+
+#endif	/* _ASM_POWERPC_EXCEPTION_NEW_H */
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 471b2274fbeb..a4d501947097 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -49,11 +49,12 @@
 #define EX_PPR		64
 #if defined(CONFIG_RELOCATABLE)
 #define EX_CTR		72
-#define EX_SIZE		10	/* size in u64 units */
 #else
-#define EX_SIZE		9	/* size in u64 units */
 #endif
 
+/* exception-64s-new.h uses 10 */
+#define EX_SIZE		10	/* size in u64 units */
+
 /*
  * maximum recursive depth of MCE exceptions
  */
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 855e17d158b1..49fb156aa93a 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -54,7 +54,8 @@
 extern void replay_system_reset(void);
 extern void __replay_interrupt(unsigned int vector);
 
-extern void timer_interrupt(struct pt_regs *);
+extern void timer_interrupt(struct pt_regs *regs);
+extern void timer_interrupt_new(struct pt_regs *regs, u64 tb);
 extern void performance_monitor_exception(struct pt_regs *regs);
 extern void WatchdogException(struct pt_regs *regs);
 extern void unknown_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cb5109a7ea3..db934d29069c 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -995,7 +995,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 1:	cmpwi	cr0,r3,0x900
 	bne	1f
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
-	bl	timer_interrupt
+	mftb	r4
+	bl	timer_interrupt_new
 	b	ret_from_except
 #ifdef CONFIG_PPC_DOORBELL
 1:
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b6d1baecfbff..c700a9d7e17a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -820,11 +820,42 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
 
-EXC_REAL_MASKABLE(decrementer, 0x900, 0x80, IRQS_DISABLED)
-EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x80, 0x900, IRQS_DISABLED)
-TRAMP_KVM(PACA_EXGEN, 0x900)
-EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
+#include <asm/exception-64s-new.h>
+
+EXC_REAL_BEGIN(decrementer, 0x900, 0x80)
+	/*
+	 * decrementer handler:
+	 * SRR[01], real, exgen, kvm, !cfar, ppr, tb, stack
+	 */
+	INT_ENTRY	decrementer,0x80,0,1,PACA_EXGEN,1,0,1,1,1
+EXC_REAL_END(decrementer, 0x900, 0x80)
+
+EXC_VIRT_BEGIN(decrementer, 0x4900, 0x80)
+	/*
+	 * decrementer handler:
+	 * SRR[01], virt, exgen, kvm, !cfar, ppr, tb, stack
+	 */
+	INT_ENTRY	decrementer,0x80,0,1,PACA_EXGEN,1,0,1,1,1
+EXC_VIRT_END(decrementer, 0x4900, 0x80)
+
+EXC_COMMON_BEGIN(decrementer_kvm)
+	INT_KVM		decrementer,0,0x900,PACA_EXGEN,0,0,1,1
+
+EXC_COMMON_BEGIN(decrementer)
+	INT_COMMON	decrementer,0x900,PACA_EXGEN,IRQS_DISABLED,0,1,1
+	bl	timer_interrupt_new
+	b	ret_from_except_lite
+
+decrementer_masked_interrupt:
+	ori	r25,r25,SOFTEN_VALUE_0x900
+	stb	r25,PACAIRQHAPPENED(r13)
+	lis	r25,0x7fff
+	ori	r25,r25,0xffff
+	mtspr	SPRN_DEC,r25
+	INT_ENTRY_RESTORE PACA_EXGEN,0,1,1
+	RFI_TO_KERNEL
 
+EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
 
 EXC_REAL_HV(hdecrementer, 0x980, 0x80)
 EXC_VIRT_HV(hdecrementer, 0x4980, 0x80, 0x980)
@@ -842,6 +873,7 @@ EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 #endif
 
 
+
 EXC_REAL(trap_0b, 0xb00, 0x100)
 EXC_VIRT(trap_0b, 0x4b00, 0x100, 0xb00)
 TRAMP_KVM(PACA_EXGEN, 0xb00)
@@ -1767,6 +1799,26 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	b	1b
 _ASM_NOKPROBE_SYMBOL(bad_stack);
 
+/*
+ * Here we have detected that the kernel stack pointer is bad.
+ * R9 contains the saved CR, r13 points to the paca,
+ * r10 contains the (bad) kernel stack pointer,
+ * r11 and r12 contain the saved SRR0 and SRR1.
+ * We switch to using an emergency stack, save the registers there,
+ * and call kernel_bad_stack(), which panics.
+ */
+bad_stack_common:
+	ld	r1,PACAEMERGSP(r13)
+	subi	r1,r1,64+INT_FRAME_SIZE
+	/*
+	 * This clobbers r16-r18 for interrupts that use them, but we
+	 * never return to userspace.
+	 */
+	INT_SETUP_C_CALL PACA_EXGEN,0,0,0
+	bl	kernel_bad_stack
+	b	.
+_ASM_NOKPROBE_SYMBOL(bad_stack_common);
+
 /*
  * When doorbell is triggered from system reset wakeup, the message is
  * not cleared, so it would fire again when EE is enabled.
@@ -1786,6 +1838,29 @@ doorbell_super_common_msgclr:
 	PPC_MSGCLRP(3)
 	b 	doorbell_super_common
 
+replay_decrementer:
+	/* XXX: crashes */
+	subi	r1,r1,INT_FRAME_SIZE
+	std	r1,INT_FRAME_SIZE(r1)
+	std	r1,GPR1(r1)
+	std	r2,GPR2(r1)
+	ld	r5,PACACURRENT(r13)
+	ld	r6,exception_marker@toc(r2)
+	std	r11,_NIP(r1)
+	std	r12,_MSR(r1)
+	std	r9,_CCR(r1)
+	std	r3,_TRAP(r1)
+	li	r3,0
+	std	r3,RESULT(r1)
+	lbz	r3,PACAIRQSOFTMASK(r13)
+	std	r3,SOFTE(r1)
+	std	r6,STACK_FRAME_OVERHEAD-16(r1)
+	/* XXX: ppr? */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mftb	r4
+	bl	timer_interrupt_new
+	b	ret_from_except_lite
+
 /*
  * Called from arch_local_irq_enable when an interrupt needs
  * to be resent. r3 contains 0x500, 0x900, 0xa00 or 0xe80 to indicate
@@ -1811,6 +1886,7 @@ _GLOBAL(__replay_interrupt)
 	ori	r12,r12,MSR_EE
 	cmpwi	r3,0x900
 	beq	decrementer_common
+//	beq	replay_decrementer
 	cmpwi	r3,0x500
 BEGIN_FTR_SECTION
 	beq	h_virt_irq_common
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index a32823dcd9a4..72b38917fd77 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -100,7 +100,7 @@ static struct clocksource clocksource_timebase = {
 };
 
 #define DECREMENTER_DEFAULT_MAX 0x7FFFFFFF
-u64 decrementer_max = DECREMENTER_DEFAULT_MAX;
+u64 decrementer_max __read_mostly = DECREMENTER_DEFAULT_MAX;
 
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev);
@@ -535,12 +535,11 @@ void arch_irq_work_raise(void)
 
 #endif /* CONFIG_IRQ_WORK */
 
-static void __timer_interrupt(void)
+static void __timer_interrupt(u64 now)
 {
 	struct pt_regs *regs = get_irq_regs();
 	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
 	struct clock_event_device *evt = this_cpu_ptr(&decrementers);
-	u64 now;
 
 	trace_timer_interrupt_entry(regs);
 
@@ -549,7 +548,10 @@ static void __timer_interrupt(void)
 		irq_work_run();
 	}
 
+#ifndef CONFIG_PPC_BOOK3S_64
 	now = get_tb_or_rtc();
+#endif
+
 	if (now >= *next_tb) {
 		*next_tb = ~(u64)0;
 		if (evt->event_handler)
@@ -557,8 +559,9 @@ static void __timer_interrupt(void)
 		__this_cpu_inc(irq_stat.timer_irqs_event);
 	} else {
 		now = *next_tb - now;
-		if (now <= decrementer_max)
-			set_dec(now);
+		if (now > decrementer_max)
+			now = decrementer_max;
+		set_dec(now);
 		/* We may have raced with new irq work */
 		if (test_irq_work_pending())
 			set_dec(1);
@@ -576,19 +579,18 @@ static void __timer_interrupt(void)
 	trace_timer_interrupt_exit(regs);
 }
 
+void timer_interrupt(struct pt_regs * regs)
+{
+	timer_interrupt_new(regs, get_tb_or_rtc());
+}
+
 /*
  * timer_interrupt - gets called when the decrementer overflows,
  * with interrupts disabled.
  */
-void timer_interrupt(struct pt_regs * regs)
+void timer_interrupt_new(struct pt_regs * regs, u64 tb)
 {
 	struct pt_regs *old_regs;
-	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
-
-	/* Ensure a positive value is written to the decrementer, or else
-	 * some CPUs will continue to take decrementer exceptions.
-	 */
-	set_dec(decrementer_max);
 
 	/* Some implementations of hotplug will get timer interrupts while
 	 * offline, just ignore these and we also need to set
@@ -596,15 +598,21 @@ void timer_interrupt(struct pt_regs * regs)
 	 * don't replay timer interrupt when return, otherwise we'll trap
 	 * here infinitely :(
 	 */
-	if (!cpu_online(smp_processor_id())) {
+	if (unlikely(!cpu_online(smp_processor_id()))) {
+		u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
 		*next_tb = ~(u64)0;
+		set_dec(decrementer_max);
 		return;
 	}
 
 	/* Conditionally hard-enable interrupts now that the DEC has been
 	 * bumped to its maximum value
 	 */
-	may_hard_irq_enable();
+	if (may_hard_irq_enable()) {
+		set_dec(decrementer_max);
+		get_paca()->irq_happened &= ~PACA_IRQ_HARD_DIS;
+		__hard_irq_enable();
+	}
 
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
@@ -615,7 +623,7 @@ void timer_interrupt(struct pt_regs * regs)
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
-	__timer_interrupt();
+	__timer_interrupt(tb);
 	irq_exit();
 	set_irq_regs(old_regs);
 }
@@ -971,10 +979,11 @@ static int decrementer_shutdown(struct clock_event_device *dev)
 /* Interrupt handler for the timer broadcast IPI */
 void tick_broadcast_ipi_handler(void)
 {
+	u64 now = get_tb_or_rtc();
 	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
 
-	*next_tb = get_tb_or_rtc();
-	__timer_interrupt();
+	*next_tb = now;
+	__timer_interrupt(now);
 }
 
 static void register_decrementer_clockevent(int cpu)
