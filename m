Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2B9C1A032F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 14:25:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc/kernel: Combine vec/loc for STD_EXCEPTION_PSERIES
Date: Wed, 25 Nov 2015 14:25:19 +1100
Message-Id: <1448421919-30426-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1448421919-30426-1-git-send-email-mpe@ellerman.id.au>
References: <1448421919-30426-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The STD_EXCEPTION_PSERIES macro takes both a vector number, and a
location (memory address). However both are always identical, so combine
them to save repeating ourselves.

This does mean an exception handler must always exist at the location in
memory that matches its vector number. But that's OK because this is the
"STD" macro (standard), which does exactly that. We have other macros
for the other cases, eg. STD_EXCEPTION_PSERIES_OOL (out of line).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h |  4 ++--
 arch/powerpc/kernel/exceptions-64s.S     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9b91879b7876..1609448e2583 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -344,8 +344,8 @@ do_kvm_##n:								\
 /*
  * Exception vectors.
  */
-#define STD_EXCEPTION_PSERIES(loc, vec, label)		\
-	. = loc;					\
+#define STD_EXCEPTION_PSERIES(vec, label)		\
+	. = vec;					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
 	SET_SCRATCH0(r13);		/* save r13 */		\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9035bda220f5..7ee72d47f926 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -230,7 +230,7 @@ data_access_slb_pSeries:
 	bctr
 #endif
 
-	STD_EXCEPTION_PSERIES(0x400, 0x400, instruction_access)
+	STD_EXCEPTION_PSERIES(0x400, instruction_access)
 
 	. = 0x480
 	.globl instruction_access_slb_pSeries
@@ -274,13 +274,13 @@ hardware_interrupt_hv:
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
-	STD_EXCEPTION_PSERIES(0x600, 0x600, alignment)
+	STD_EXCEPTION_PSERIES(0x600, alignment)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x600)
 
-	STD_EXCEPTION_PSERIES(0x700, 0x700, program_check)
+	STD_EXCEPTION_PSERIES(0x700, program_check)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x700)
 
-	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
+	STD_EXCEPTION_PSERIES(0x800, fp_unavailable)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
 
 	. = 0x900
@@ -293,7 +293,7 @@ decrementer_pSeries:
 	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xa00)
 
-	STD_EXCEPTION_PSERIES(0xb00, 0xb00, trap_0b)
+	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xb00)
 
 	. = 0xc00
@@ -325,7 +325,7 @@ system_call_pSeries:
 	SYSCALL_PSERIES_3
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
 
-	STD_EXCEPTION_PSERIES(0xd00, 0xd00, single_step)
+	STD_EXCEPTION_PSERIES(0xd00, single_step)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xd00)
 
 	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
@@ -401,7 +401,7 @@ hv_facility_unavailable_trampoline:
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
 #endif /* CONFIG_CBE_RAS */
 
-	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
+	STD_EXCEPTION_PSERIES(0x1300, instruction_breakpoint)
 	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
 
 	. = 0x1500
@@ -428,7 +428,7 @@ denorm_exception_hv:
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1602)
 #endif /* CONFIG_CBE_RAS */
 
-	STD_EXCEPTION_PSERIES(0x1700, 0x1700, altivec_assist)
+	STD_EXCEPTION_PSERIES(0x1700, altivec_assist)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x1700)
 
 #ifdef CONFIG_CBE_RAS
-- 
2.5.0
