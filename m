Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBTMb1R0SzDrFb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 15:32:59 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id o88so1414933pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 22:32:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/64s: Fix hypercall entry clobbering r12 input
Date: Tue, 18 Jul 2017 15:32:44 +1000
Message-Id: <20170718053244.7665-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A previous optimisation incorrectly assumed the PAPR hcall does
not use r12, and clobbers it upon entry. In fact it is used as
an input. This can result in KVM guests crashing (observed with
PR KVM).

Instead of using r12 to save r13, tihs patch saves r13 in ctr.
This is more costly, but not as slow as using the SPRG.

Fixes: acd7d8cef0153 ("powerpc/64s: Optimize hypercall/syscall entry")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
One brown paper bag please.

 arch/powerpc/kernel/exceptions-64s.S | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d8b4ceed7a74..c174e7db7594 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -824,7 +824,7 @@ EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
  * r3 volatile parameter and return value for status
  * r4-r10 volatile input and output value
  * r11 volatile hypercall number and output value
- * r12 volatile
+ * r12 volatile input and output value
  * r13-r31 nonvolatile
  * LR nonvolatile
  * CTR volatile
@@ -834,25 +834,26 @@ EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
  * Other registers nonvolatile
  *
  * The intersection of volatile registers that don't contain possible
- * inputs is: r12, cr0, xer, ctr. We may use these as scratch regs
- * upon entry without saving.
+ * inputs is: cr0, xer, ctr. We may use these as scratch regs upon entry
+ * without saving, though xer is not a good idea to use, as hardware may
+ * interpret some bits so it may be costly to change them.
  */
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	/*
 	 * There is a little bit of juggling to get syscall and hcall
-	 * working well. Save r10 in ctr to be restored in case it is a
-	 * hcall.
+	 * working well. Save r13 in ctr to avoid using SPRG scratch
+	 * register.
 	 *
 	 * Userspace syscalls have already saved the PPR, hcalls must save
 	 * it before setting HMT_MEDIUM.
 	 */
 #define SYSCALL_KVMTEST							\
-	mr	r12,r13;						\
+	mtctr	r13;							\
 	GET_PACA(r13);							\
-	mtctr	r10;							\
+	std	r10,PACA_EXGEN+EX_R10(r13);				\
 	KVMTEST_PR(0xc00); /* uses r10, branch to do_kvm_0xc00_system_call */ \
 	HMT_MEDIUM;							\
-	mr	r9,r12;							\
+	mfctr	r9;
 
 #else
 #define SYSCALL_KVMTEST							\
@@ -935,8 +936,8 @@ EXC_VIRT_END(system_call, 0x4c00, 0x100)
 	 * This is a hcall, so register convention is as above, with these
 	 * differences:
 	 * r13 = PACA
-	 * r12 = orig r13
-	 * ctr = orig r10
+	 * ctr = orig r13
+	 * orig r10 saved in PACA
 	 */
 TRAMP_KVM_BEGIN(do_kvm_0xc00)
 	 /*
@@ -944,14 +945,13 @@ TRAMP_KVM_BEGIN(do_kvm_0xc00)
 	  * HMT_MEDIUM. That allows the KVM code to save that value into the
 	  * guest state (it is the guest's PPR value).
 	  */
-	OPT_GET_SPR(r0, SPRN_PPR, CPU_FTR_HAS_PPR)
+	OPT_GET_SPR(r10, SPRN_PPR, CPU_FTR_HAS_PPR)
 	HMT_MEDIUM
-	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r0, CPU_FTR_HAS_PPR)
+	OPT_SAVE_REG_TO_PACA(PACA_EXGEN+EX_PPR, r10, CPU_FTR_HAS_PPR)
 	mfctr	r10
-	SET_SCRATCH0(r12)
+	SET_SCRATCH0(r10)
 	std	r9,PACA_EXGEN+EX_R9(r13)
 	mfcr	r9
-	std	r10,PACA_EXGEN+EX_R10(r13)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
 #endif
 
-- 
2.11.0
