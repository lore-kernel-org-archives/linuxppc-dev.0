Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkJS61GzTzDqYx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 17:27:49 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id m5so4877048pgk.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 23:27:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] powerpc/64s: optimize hypercall/syscall
Date: Thu, 16 Mar 2017 16:27:36 +1000
Message-Id: <20170316062736.22681-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After bc3551257a ("powerpc/64: Allow for relocation-on interrupts from
guest to host"), a getppid() system call goes from 307 cycles to 358
cycles (+17%). This is due significantly to the scratch SPR used by the
hypercall.

It turns out there are a some volatile registers common to both system
call and hypercall (in particular, r12, cr0, ctr), which can be used to
avoid the SPR and some other overheads for the system call case. This
brings getppid to 320 cycles (+4%).

Testing hcall entry performance by running "sc 1" in guest userspace
before this patch is 854 cycles, afterwards is 826. Also a small win
there.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Hi,

Since last posted, I tidied this up a bit, added some more comments,
and got some host kernel hcall entry numbers from within guest.

Thanks,
Nick


 arch/powerpc/kernel/exceptions-64s.S | 134 +++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 857bf7c5b946..0f54b4844399 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -830,46 +830,80 @@ EXC_VIRT(trap_0b, 0x4b00, 0x100, 0xb00)
 TRAMP_KVM(PACA_EXGEN, 0xb00)
 EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 
+/*
+ * system call / hypercall (0xc00, 0x4c00)
+ *
+ * The system call exception is invoked with "sc 0" and does not alter HV bit.
+ * There is support for kernel code to invoke system calls but there are no
+ * in-tree users.
+ *
+ * The hypercall is invoked with "sc 1" and sets HV=1.
+ *
+ * In HPT, sc 1 always goes to 0xc00 real mode. In RADIX, sc 1 can go to
+ * 0x4c00 virtual mode.
+ *
+ * Call convention:
+ *
+ * syscall register convention is in Documentation/powerpc/syscall64-abi.txt
+ *
+ * For hypercalls, the register convention is as follows:
+ * r0 volatile
+ * r1-2 nonvolatile
+ * r3 volatile parameter and return value for status
+ * r4-r10 volatile input and output value
+ * r11 volatile hypercall number and output value
+ * r12 volatile
+ * r13-r31 nonvolatile
+ * LR nonvolatile
+ * CTR volatile
+ * XER volatile
+ * CR0-1 CR5-7 volatile
+ * CR2-4 nonvolatile
+ * Other registers nonvolatile
+ *
+ * The intersection of volatile registers that don't contain possible
+ * inputs is: r12, cr0, xer, ctr. We may use these as scratch regs
+ * upon entry without saving.
+ */
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
-	 /*
-	  * If CONFIG_KVM_BOOK3S_64_HANDLER is set, save the PPR (on systems
-	  * that support it) before changing to HMT_MEDIUM. That allows the KVM
-	  * code to save that value into the guest state (it is the guest's PPR
-	  * value). Otherwise just change to HMT_MEDIUM as userspace has
-	  * already saved the PPR.
-	  */
+	/*
+	 * There is a little bit of juggling to get syscall and hcall
+	 * working well. Save r10 in ctr to be restored in case it is a
+	 * hcall.
+	 *
+	 * Userspace syscalls have already saved the PPR, hcalls must save
+	 * it before setting HMT_MEDIUM.
+	 */
 #define SYSCALL_KVMTEST							\
-	SET_SCRATCH0(r13);						\
+	mr	r12,r13;						\
 	GET_PACA(r13);							\
-	std	r9,PACA_EXGEN+EX_R9(r13);				\
-	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);			\
+	mtctr	r10;							\
+	KVMTEST_PR(0xc00); /* uses r10, branch to do_kvm_0xc00_system_call */ \
 	HMT_MEDIUM;							\
-	std	r10,PACA_EXGEN+EX_R10(r13);				\
-	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r9, CPU_FTR_HAS_PPR);	\
-	mfcr	r9;							\
-	KVMTEST_PR(0xc00);						\
-	GET_SCRATCH0(r13)
+	mr	r9,r12;							\
 
 #else
 #define SYSCALL_KVMTEST							\
-	HMT_MEDIUM
+	HMT_MEDIUM;							\
+	mr	r9,r13;							\
+	GET_PACA(r13);
 #endif
 	
 #define LOAD_SYSCALL_HANDLER(reg)					\
 	__LOAD_HANDLER(reg, system_call_common)
 
-/* Syscall routine is used twice, in reloc-off and reloc-on paths */
-#define SYSCALL_PSERIES_1 					\
+#define SYSCALL_FASTENDIAN_TEST					\
 BEGIN_FTR_SECTION						\
 	cmpdi	r0,0x1ebe ; 					\
 	beq-	1f ;						\
 END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
-	mr	r9,r13 ;					\
-	GET_PACA(r13) ;						\
-	mfspr	r11,SPRN_SRR0 ;					\
-0:
 
-#define SYSCALL_PSERIES_2_RFID 					\
+/*
+ * After SYSCALL_KVMTEST, we reach here with PACA in r13, r13 in r9,
+ * and HMT_MEDIUM.
+ */
+#define SYSCALL_REAL	 					\
+	mfspr	r11,SPRN_SRR0 ;					\
 	mfspr	r12,SPRN_SRR1 ;					\
 	LOAD_SYSCALL_HANDLER(r10) ; 				\
 	mtspr	SPRN_SRR0,r10 ; 				\
@@ -878,11 +912,12 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	rfid ; 							\
 	b	. ;	/* prevent speculative execution */
 
-#define SYSCALL_PSERIES_3					\
+#define SYSCALL_FASTENDIAN					\
 	/* Fast LE/BE switch system call */			\
 1:	mfspr	r12,SPRN_SRR1 ;					\
 	xori	r12,r12,MSR_LE ;				\
 	mtspr	SPRN_SRR1,r12 ;					\
+	mr	r13,r9 ;					\
 	rfid ;		/* return to userspace */		\
 	b	. ;	/* prevent speculative execution */
 
@@ -891,16 +926,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	 * We can't branch directly so we do it via the CTR which
 	 * is volatile across system calls.
 	 */
-#define SYSCALL_PSERIES_2_DIRECT				\
-	LOAD_SYSCALL_HANDLER(r12) ;				\
-	mtctr	r12 ;						\
+#define SYSCALL_VIRT						\
+	LOAD_SYSCALL_HANDLER(r10) ;				\
+	mtctr	r10 ;						\
+	mfspr	r11,SPRN_SRR0 ;					\
 	mfspr	r12,SPRN_SRR1 ;					\
 	li	r10,MSR_RI ;					\
 	mtmsrd 	r10,1 ;						\
 	bctr ;
 #else
 	/* We can branch directly */
-#define SYSCALL_PSERIES_2_DIRECT				\
+#define SYSCALL_VIRT						\
+	mfspr	r11,SPRN_SRR0 ;					\
 	mfspr	r12,SPRN_SRR1 ;					\
 	li	r10,MSR_RI ;					\
 	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
@@ -908,20 +945,43 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 #endif
 
 EXC_REAL_BEGIN(system_call, 0xc00, 0x100)
-	SYSCALL_KVMTEST
-	SYSCALL_PSERIES_1
-	SYSCALL_PSERIES_2_RFID
-	SYSCALL_PSERIES_3
+	SYSCALL_KVMTEST /* loads PACA into r13, and saves r13 to r9 */
+	SYSCALL_FASTENDIAN_TEST
+	SYSCALL_REAL
+	SYSCALL_FASTENDIAN
 EXC_REAL_END(system_call, 0xc00, 0x100)
 
 EXC_VIRT_BEGIN(system_call, 0x4c00, 0x100)
-	SYSCALL_KVMTEST
-	SYSCALL_PSERIES_1
-	SYSCALL_PSERIES_2_DIRECT
-	SYSCALL_PSERIES_3
+	SYSCALL_KVMTEST /* loads PACA into r13, and saves r13 to r9 */
+	SYSCALL_FASTENDIAN_TEST
+	SYSCALL_VIRT
+	SYSCALL_FASTENDIAN
 EXC_VIRT_END(system_call, 0x4c00, 0x100)
 
-TRAMP_KVM(PACA_EXGEN, 0xc00)
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	/*
+	 * This is a hcall, so register convention is as above, with these
+	 * differences:
+	 * r13 = PACA
+	 * r12 = orig r13
+	 * ctr = orig r10
+	 */
+TRAMP_KVM_BEGIN(do_kvm_0xc00)
+	 /*
+	  * Save the PPR (on systems that support it) before changing to
+	  * HMT_MEDIUM. That allows the KVM code to save that value into the
+	  * guest state (it is the guest's PPR value).
+	  */
+	OPT_GET_SPR(r0, SPRN_PPR, CPU_FTR_HAS_PPR)
+	HMT_MEDIUM
+	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r0, CPU_FTR_HAS_PPR)
+	mfctr	r10
+	SET_SCRATCH0(r12)
+	std	r9,PACA_EXGEN+EX_R9(r13)
+	mfcr	r9
+	std	r10,PACA_EXGEN+EX_R10(r13)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
+#endif
 
 
 EXC_REAL(single_step, 0xd00, 0x100)
-- 
2.11.0
