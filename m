Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsxZZ5gl7zF1cm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:45:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander.Levin@microsoft.com
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	npiggin@gmail.com
Subject: [PATCH v4.1 backport 03/15] powerpc/64s: Simple RFI macro conversions
Date: Fri,  2 Mar 2018 15:45:37 +1100
Message-Id: <20180302044549.14930-4-mpe@ellerman.id.au>
In-Reply-To: <20180302044549.14930-1-mpe@ellerman.id.au>
References: <20180302044549.14930-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

commit 222f20f140623ef6033491d0103ee0875fe87d35 upstream.

This commit does simple conversions of rfi/rfid to the new macros that
include the expected destination context. By simple we mean cases
where there is a single well known destination context, and it's
simply a matter of substituting the instruction for the appropriate
macro.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[Balbir fixed issues with backporting to stable]
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/exception-64s.h |  2 +-
 arch/powerpc/kernel/entry_64.S           | 11 ++++++++---
 arch/powerpc/kernel/exceptions-64s.S     | 18 +++++++++---------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  7 +++----
 arch/powerpc/kvm/book3s_rmhandlers.S     |  7 +++++--
 arch/powerpc/kvm/book3s_segment.S        |  4 ++--
 6 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index c8c8a81e3976..6dfb6e928f81 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -220,7 +220,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtspr	SPRN_##h##SRR0,r12;					\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	mtspr	SPRN_##h##SRR1,r10;					\
-	h##rfid;							\
+	h##RFI_TO_KERNEL;						\
 	b	.	/* prevent speculative execution */
 #define EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	__EXCEPTION_PROLOG_PSERIES_1(label, h)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index de276553cc79..e3bb07c78cee 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -34,6 +34,11 @@
 #include <asm/ftrace.h>
 #include <asm/hw_irq.h>
 #include <asm/context_tracking.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/exception-64s.h>
+#else
+#include <asm/exception-64e.h>
+#endif
 
 /*
  * System calls.
@@ -1030,7 +1035,7 @@ _GLOBAL(enter_rtas)
 	
 	mtspr	SPRN_SRR0,r5
 	mtspr	SPRN_SRR1,r6
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 rtas_return_loc:
@@ -1055,7 +1060,7 @@ rtas_return_loc:
 
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
 	.align	3
@@ -1126,7 +1131,7 @@ _GLOBAL(enter_prom)
 	LOAD_REG_IMMEDIATE(r12, MSR_SF | MSR_ISF | MSR_LE)
 	andc	r11,r11,r12
 	mtsrr1	r11
-	rfid
+	RFI_TO_KERNEL
 #endif /* CONFIG_PPC_BOOK3E */
 
 1:	/* Return from OF */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7662bfae0493..591efc03f80d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -46,7 +46,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
 	mtspr	SPRN_SRR1,r10 ; 				\
-	rfid ; 							\
+	RFI_TO_KERNEL ; 							\
 	b	. ;	/* prevent speculative execution */
 
 #define SYSCALL_PSERIES_3					\
@@ -54,7 +54,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 1:	mfspr	r12,SPRN_SRR1 ;					\
 	xori	r12,r12,MSR_LE ;				\
 	mtspr	SPRN_SRR1,r12 ;					\
-	rfid ;		/* return to userspace */		\
+	RFI_TO_USER ;		/* return to userspace */		\
 	b	. ;	/* prevent speculative execution */
 
 #if defined(CONFIG_RELOCATABLE)
@@ -508,7 +508,7 @@ BEGIN_FTR_SECTION
 	LOAD_HANDLER(r12, machine_check_handle_early)
 1:	mtspr	SPRN_SRR0,r12
 	mtspr	SPRN_SRR1,r11
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 2:
 	/* Stack overflow. Stay on emergency stack and panic.
@@ -602,7 +602,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r12,PACA_EXGEN+EX_R12(r13)
 	ld	r13,PACA_EXGEN+EX_R13(r13)
-	HRFID
+	HRFI_TO_UNKNOWN
 	b	.
 #endif
 
@@ -667,7 +667,7 @@ masked_##_H##interrupt:					\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
 	ld	r11,PACA_EXGEN+EX_R11(r13);		\
 	GET_SCRATCH0(r13);				\
-	##_H##rfid;					\
+	##_H##RFI_TO_KERNEL;				\
 	b	.
 	
 	MASKED_INTERRUPT()
@@ -757,7 +757,7 @@ kvmppc_skip_interrupt:
 	addi	r13, r13, 4
 	mtspr	SPRN_SRR0, r13
 	GET_SCRATCH0(r13)
-	rfid
+	RFI_TO_KERNEL
 	b	.
 
 kvmppc_skip_Hinterrupt:
@@ -769,7 +769,7 @@ kvmppc_skip_Hinterrupt:
 	addi	r13, r13, 4
 	mtspr	SPRN_HSRR0, r13
 	GET_SCRATCH0(r13)
-	hrfid
+	HRFI_TO_KERNEL
 	b	.
 #endif
 
@@ -1447,7 +1447,7 @@ machine_check_handle_early:
 	li	r3,MSR_ME
 	andc	r10,r10,r3		/* Turn off MSR_ME */
 	mtspr	SPRN_SRR1,r10
-	rfid
+	RFI_TO_KERNEL
 	b	.
 2:
 	/*
@@ -1465,7 +1465,7 @@ machine_check_handle_early:
 	 */
 	bl	machine_check_queue_event
 	MACHINE_CHECK_HANDLER_WINDUP
-	rfid
+	RFI_TO_USER_OR_KERNEL
 9:
 	/* Deliver the machine check to host kernel in V mode. */
 	MACHINE_CHECK_HANDLER_WINDUP
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index a3018f109cd3..a7bd4100f158 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -64,7 +64,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
 	mtmsrd	r0,1		/* clear RI in MSR */
 	mtsrr0	r5
 	mtsrr1	r6
-	RFI
+	RFI_TO_KERNEL
 
 kvmppc_call_hv_entry:
 	ld	r4, HSTATE_KVM_VCPU(r13)
@@ -164,7 +164,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	mtsrr0	r8
 	mtsrr1	r7
 	beq	cr1, 13f		/* machine check */
-	RFI
+	RFI_TO_KERNEL
 
 	/* On POWER7, we have external interrupts set to use HSRR0/1 */
 11:	mtspr	SPRN_HSRR0, r8
@@ -877,8 +877,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r0, VCPU_GPR(R0)(r4)
 	ld	r4, VCPU_GPR(R4)(r4)
-
-	hrfid
+	HRFI_TO_GUEST
 	b	.
 
 secondary_too_late:
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 16c4d88ba27d..a328f99a887c 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -46,6 +46,9 @@
 
 #define FUNC(name)		name
 
+#define RFI_TO_KERNEL	RFI
+#define RFI_TO_GUEST	RFI
+
 .macro INTERRUPT_TRAMPOLINE intno
 
 .global kvmppc_trampoline_\intno
@@ -141,7 +144,7 @@ kvmppc_handler_skip_ins:
 	GET_SCRATCH0(r13)
 
 	/* And get back into the code */
-	RFI
+	RFI_TO_KERNEL
 #endif
 
 /*
@@ -164,6 +167,6 @@ _GLOBAL_TOC(kvmppc_entry_trampoline)
 	ori	r5, r5, MSR_EE
 	mtsrr0	r7
 	mtsrr1	r6
-	RFI
+	RFI_TO_KERNEL
 
 #include "book3s_segment.S"
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index acee37cde840..af3a91c00b46 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -156,7 +156,7 @@ no_dcbz32_on:
 	PPC_LL	r9, SVCPU_R9(r3)
 	PPC_LL	r3, (SVCPU_R3)(r3)
 
-	RFI
+	RFI_TO_GUEST
 kvmppc_handler_trampoline_enter_end:
 
 
@@ -389,5 +389,5 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	cmpwi	r12, BOOK3S_INTERRUPT_DOORBELL
 	beqa	BOOK3S_INTERRUPT_DOORBELL
 
-	RFI
+	RFI_TO_KERNEL
 kvmppc_handler_trampoline_exit_end:
-- 
2.14.1
