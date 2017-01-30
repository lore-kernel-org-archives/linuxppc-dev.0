Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnC0MQlzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:07 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 07/20] powerpc/64: Allow for relocation-on interrupts from
 guest to host
Date: Mon, 30 Jan 2017 21:21:40 +1100
Message-Id: <1485771713-24801-8-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With host and guest both using radix translation, it is feasible
for the host to take interrupts that come from the guest with
relocation on, and that is in fact what the POWER9 hardware will
do when LPCR[AIL] = 3.  All such interrupts use HSRR0/1 not SRR0/1
except for system call with LEV=1 (hcall).

Therefore this adds the KVM tests to the _HV variants of the
relocation-on interrupt handlers, and adds the KVM test to the
relocation-on system call entry point.

We also instantiate the relocation-on versions of the hypervisor
data storage and instruction interrupt handlers, since these can
occur with relocation on in radix guests.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/exception-64s.h | 10 +++---
 arch/powerpc/kernel/exceptions-64s.S     | 53 +++++++++++++++++---------------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9a3eee6..109414f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -393,12 +393,12 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
-	/* No guest interrupts come through here */	\
 	SET_SCRATCH0(r13);	/* save r13 */		\
-	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label, EXC_HV, NOTEST, vec);
+	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label,	\
+				       EXC_HV, KVMTEST_HV, vec);
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
 
 /* This associate vector numbers with bits in paca->irq_happened */
@@ -475,10 +475,10 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label)			\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_HV, SOFTEN_NOTEST_HV)
+					  EXC_HV, SOFTEN_TEST_HV)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);		\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d39d611..9425e0e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -832,6 +832,31 @@ EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
 TRAMP_KVM(PACA_EXGEN, 0xb00)
 EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	 /*
+	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
+	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
+	  * code to save that value into the guest state (it is the guest's PPR
+	  * value). Otherwise just change to HMT_MEDIUM as userspace has
+	  * already saved the PPR.
+	  */
+#define SYSCALL_KVMTEST							\
+	SET_SCRATCH0(r13);						\
+	GET_PACA(r13);							\
+	std	r9,PACA_EXGEN+EX_R9(r13);				\
+	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);			\
+	HMT_MEDIUM;							\
+	std	r10,PACA_EXGEN+EX_R10(r13);				\
+	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);	\
+	mfcr	r9;							\
+	KVMTEST_PR(0xc00);						\
+	GET_SCRATCH0(r13)
+
+#else
+#define SYSCALL_KVMTEST							\
+	HMT_MEDIUM
+#endif
+	
 #define LOAD_SYSCALL_HANDLER(reg)					\
 	__LOAD_HANDLER(reg, system_call_common)
 
@@ -885,34 +910,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 #endif
 
 EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
-	 /*
-	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
-	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
-	  * code to save that value into the guest state (it is the guest's PPR
-	  * value). Otherwise just change to HMT_MEDIUM as userspace has
-	  * already saved the PPR.
-	  */
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-	SET_SCRATCH0(r13)
-	GET_PACA(r13)
-	std	r9,PACA_EXGEN+EX_R9(r13)
-	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);
-	HMT_MEDIUM;
-	std	r10,PACA_EXGEN+EX_R10(r13)
-	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);
-	mfcr	r9
-	KVMTEST_PR(0xc00)
-	GET_SCRATCH0(r13)
-#else
-	HMT_MEDIUM;
-#endif
+	SYSCALL_KVMTEST
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_RFID
 	SYSCALL_PSERIES_3
 EXC_REAL_END(system_call, 0xc00, 0xd00)
 
 EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
-	HMT_MEDIUM
+	SYSCALL_KVMTEST
 	SYSCALL_PSERIES_1
 	SYSCALL_PSERIES_2_DIRECT
 	SYSCALL_PSERIES_3
@@ -927,7 +932,7 @@ TRAMP_KVM(PACA_EXGEN, 0xd00)
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 
 EXC_REAL_OOL_HV(h_data_storage, 0xe00, 0xe20)
-EXC_VIRT_NONE(0x4e00, 0x4e20)
+EXC_VIRT_OOL_HV(h_data_storage, 0x4e00, 0x4e20, 0xe00)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
 EXC_COMMON_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
@@ -943,7 +948,7 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 
 
 EXC_REAL_OOL_HV(h_instr_storage, 0xe20, 0xe40)
-EXC_VIRT_NONE(0x4e20, 0x4e40)
+EXC_VIRT_OOL_HV(h_instr_storage, 0x4e20, 0x4e40, 0xe20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe20)
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
-- 
2.7.4
