Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A05C10F0B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 07:04:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8FB217D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 07:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8FB217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l98g4Xr4zDqRY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 17:04:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l8sM49v7zDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 16:51:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44l8sM3NHHz9sBV; Thu, 18 Apr 2019 16:51:35 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44l8sM1pk2z9s9G; Thu, 18 Apr 2019 16:51:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 09/10] powerpc/64s: Implement KUAP for Radix MMU
Date: Thu, 18 Apr 2019 16:51:24 +1000
Message-Id: <20190418065125.2687-9-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418065125.2687-1-mpe@ellerman.id.au>
References: <20190418065125.2687-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kernel Userspace Access Prevention utilises a feature of the Radix MMU
which disallows read and write access to userspace addresses. By
utilising this, the kernel is prevented from accessing user data from
outside of trusted paths that perform proper safety checks, such as
copy_{to/from}_user() and friends.

Userspace access is disabled from early boot and is only enabled when
performing an operation like copy_{to/from}_user(). The register that
controls this (AMR) does not prevent userspace from accessing itself,
so there is no need to save and restore when entering and exiting
userspace.

When entering the kernel from the kernel we save AMR and if it is not
blocking user access (because eg. we faulted doing a user access) we
reblock user access for the duration of the exception (ie. the page
fault) and then restore the AMR when returning back to the kernel.

This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=y)
and performing the following:

  # (echo ACCESS_USERSPACE) > [debugfs]/provoke-crash/DIRECT

If enabled, this should send SIGSEGV to the thread.

We also add paranoid checking of AMR in switch and syscall return
under CONFIG_PPC_KUAP_DEBUG.

Co-authored-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

v6:
 - Add an isync() in setup_kuap() as noticed by Christophe.
 - Fixup the arguments to kuap_check_amr.
 - Check for NULL to/from in allow_user_access() and choose the right
   access permissions.
 - setup_kuap() can't be __init.
 - Minor whitespace fixups.

v5:
 - On kernel entry check if the AMR is already blocking user access
   and if so don't do the mtspr again, because it's slow (pointed out
   by Nick) (in kuap_save_amr_and_lock).
 - Rework the constants to make the asm a bit cleaner and avoid any
   hard coded shifts.
 - Selectively disable read or write, we don't support separately
   nesting read/write access (use allow_user_access() instead) and
   shouldn't need to (famous last words).
 - Add isync() before & after setting AMR in set_kuap() as per the
   ISA. We'll investigate whether they are both really needed in
   future.
 - Don't touch the AMR in hmi_exception_early() it never goes to
   virtual mode.
 - Check the full value in kuap_check_amr

v4:
 - Drop the unused paca flags.
 - Zero the UAMOR to be safe.
 - Save the AMR when we enter the kernel from the kernel and then lock
   it again.
 - Restore on the way back to the kernel.
 - That means we handle nesting of interrupts properly, ie. we are
   protected inside the page fault handler caused by a user access.
 - Add paranoid checking of AMR in switch and syscall return.
 - Add an isync() to prevent_user_access()
---
 .../powerpc/include/asm/book3s/64/kup-radix.h | 102 ++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h      |   2 +
 arch/powerpc/include/asm/feature-fixups.h     |   3 +
 arch/powerpc/include/asm/kup.h                |   4 +
 arch/powerpc/include/asm/mmu.h                |  10 +-
 arch/powerpc/kernel/entry_64.S                |  27 ++++-
 arch/powerpc/kernel/exceptions-64s.S          |   3 +
 arch/powerpc/mm/pgtable-radix.c               |  19 ++++
 arch/powerpc/mm/pkeys.c                       |   1 +
 arch/powerpc/platforms/Kconfig.cputype        |   8 ++
 10 files changed, 176 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h

diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
new file mode 100644
index 000000000000..6d6628424134
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
+#define _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
+
+#include <linux/const.h>
+
+#define AMR_KUAP_BLOCK_READ	UL(0x4000000000000000)
+#define AMR_KUAP_BLOCK_WRITE	UL(0x8000000000000000)
+#define AMR_KUAP_BLOCKED	(AMR_KUAP_BLOCK_READ | AMR_KUAP_BLOCK_WRITE)
+#define AMR_KUAP_SHIFT		62
+
+#ifdef __ASSEMBLY__
+
+.macro kuap_restore_amr	gpr
+#ifdef CONFIG_PPC_KUAP
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	ld	\gpr, STACK_REGS_KUAP(r1)
+	mtspr	SPRN_AMR, \gpr
+	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
+#endif
+.endm
+
+.macro kuap_check_amr gpr1, gpr2
+#ifdef CONFIG_PPC_KUAP_DEBUG
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	mfspr	\gpr1, SPRN_AMR
+	li	\gpr2, (AMR_KUAP_BLOCKED >> AMR_KUAP_SHIFT)
+	sldi	\gpr2, \gpr2, AMR_KUAP_SHIFT
+999:	tdne	\gpr1, \gpr2
+	EMIT_BUG_ENTRY 999b, __FILE__, __LINE__, (BUGFLAG_WARNING | BUGFLAG_ONCE)
+	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
+#endif
+.endm
+
+.macro kuap_save_amr_and_lock gpr1, gpr2, use_cr, msr_pr_cr
+#ifdef CONFIG_PPC_KUAP
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	.ifnb \msr_pr_cr
+	bne	\msr_pr_cr, 99f
+	.endif
+	mfspr	\gpr1, SPRN_AMR
+	std	\gpr1, STACK_REGS_KUAP(r1)
+	li	\gpr2, (AMR_KUAP_BLOCKED >> AMR_KUAP_SHIFT)
+	sldi	\gpr2, \gpr2, AMR_KUAP_SHIFT
+	cmpd	\use_cr, \gpr1, \gpr2
+	beq	\use_cr, 99f
+	// We don't isync here because we very recently entered via rfid
+	mtspr	SPRN_AMR, \gpr2
+	isync
+99:
+	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
+#endif
+.endm
+
+#else /* !__ASSEMBLY__ */
+
+#ifdef CONFIG_PPC_KUAP
+
+#include <asm/reg.h>
+
+/*
+ * We support individually allowing read or write, but we don't support nesting
+ * because that would require an expensive read/modify write of the AMR.
+ */
+
+static inline void set_kuap(unsigned long value)
+{
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return;
+
+	/*
+	 * ISA v3.0B says we need a CSI (Context Synchronising Instruction) both
+	 * before and after the move to AMR. See table 6 on page 1134.
+	 */
+	isync();
+	mtspr(SPRN_AMR, value);
+	isync();
+}
+
+static inline void allow_user_access(void __user *to, const void __user *from,
+				     unsigned long size)
+{
+	// This is written so we can resolve to a single case at build time
+	if (__builtin_constant_p(to) && to == NULL)
+		set_kuap(AMR_KUAP_BLOCK_WRITE);
+	else if (__builtin_constant_p(from) && from == NULL)
+		set_kuap(AMR_KUAP_BLOCK_READ);
+	else
+		set_kuap(0);
+}
+
+static inline void prevent_user_access(void __user *to, const void __user *from,
+				       unsigned long size)
+{
+	set_kuap(AMR_KUAP_BLOCKED);
+}
+
+#endif /* CONFIG_PPC_KUAP */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H */
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 937bb630093f..bef4e05a6823 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -497,6 +497,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	RESTORE_CTR(r1, area);						   \
 	b	bad_stack;						   \
 3:	EXCEPTION_PROLOG_COMMON_1();					   \
+	kuap_save_amr_and_lock r9, r10, cr1, cr0;			   \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
 	SAVE_PPR(area, r9);						   \
@@ -691,6 +692,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
  */
 #define EXCEPTION_COMMON_NORET_STACK(area, trap, label, hdlr, additions) \
 	EXCEPTION_PROLOG_COMMON_1();				\
+	kuap_save_amr_and_lock r9, r10, cr1;			\
 	EXCEPTION_PROLOG_COMMON_2(area);			\
 	EXCEPTION_PROLOG_COMMON_3(trap);			\
 	/* Volatile regs are potentially clobbered here */	\
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 40a6c9261a6b..f6fc31f8baff 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -100,6 +100,9 @@ label##5:							\
 #define END_MMU_FTR_SECTION(msk, val)		\
 	END_MMU_FTR_SECTION_NESTED(msk, val, 97)
 
+#define END_MMU_FTR_SECTION_NESTED_IFSET(msk, label)	\
+	END_MMU_FTR_SECTION_NESTED((msk), (msk), label)
+
 #define END_MMU_FTR_SECTION_IFSET(msk)	END_MMU_FTR_SECTION((msk), (msk))
 #define END_MMU_FTR_SECTION_IFCLR(msk)	END_MMU_FTR_SECTION((msk), 0)
 
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 4d78b9d8c99c..d7312defbe1c 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_POWERPC_KUP_H_
 #define _ASM_POWERPC_KUP_H_
 
+#ifdef CONFIG_PPC64
+#include <asm/book3s/64/kup-radix.h>
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <asm/pgtable.h>
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 598cdcdd1355..a57f27487196 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -107,6 +107,11 @@
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
 
+/*
+ * Supports KUAP (key 0 controlling userspace addresses) on radix
+ */
+#define MMU_FTR_RADIX_KUAP		ASM_CONST(0x80000000)
+
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
@@ -164,7 +169,10 @@ enum {
 #endif
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_TYPE_RADIX |
-#endif
+#ifdef CONFIG_PPC_KUAP
+		MMU_FTR_RADIX_KUAP |
+#endif /* CONFIG_PPC_KUAP */
+#endif /* CONFIG_PPC_RADIX_MMU */
 		0,
 };
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 15c67d2c0534..7cc25389c6bd 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -46,6 +46,7 @@
 #include <asm/exception-64e.h>
 #endif
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 /*
  * System calls.
@@ -120,6 +121,9 @@ END_BTB_FLUSH_SECTION
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
+
+	kuap_check_amr r10, r11
+
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) && defined(CONFIG_PPC_SPLPAR)
 BEGIN_FW_FTR_SECTION
 	beq	33f
@@ -275,6 +279,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 
+	kuap_check_amr r10, r11
+
 #ifdef CONFIG_PPC_BOOK3S
 	/*
 	 * Clear MSR_RI, MSR_EE is already and remains disabled. We could do
@@ -296,6 +302,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	std	r8, PACATMSCRATCH(r13)
 #endif
 
+	/*
+	 * We don't need to restore AMR on the way back to userspace for KUAP.
+	 * The value of AMR only matters while we're in the kernel.
+	 */
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
@@ -306,8 +316,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	RFI_TO_USER
 	b	.	/* prevent speculative execution */
 
-	/* exit to kernel */
-1:	ld	r2,GPR2(r1)
+1:	/* exit to kernel */
+	kuap_restore_amr r2
+
+	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
 	mtcr	r5
@@ -594,6 +606,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	kuap_check_amr r9, r10
+
 	FLUSH_COUNT_CACHE
 
 	/*
@@ -942,6 +956,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	ld	r4,_XER(r1)
 	mtspr	SPRN_XER,r4
 
+	kuap_check_amr r5, r6
+
 	REST_8GPRS(5, r1)
 
 	andi.	r0,r3,MSR_RI
@@ -974,6 +990,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
 
+	/*
+	 * We don't need to restore AMR on the way back to userspace for KUAP.
+	 * The value of AMR only matters while we're in the kernel.
+	 */
 	mtspr	SPRN_SRR1,r3
 
 	ld	r2,_CCR(r1)
@@ -1006,6 +1026,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r0,GPR0(r1)
 	ld	r2,GPR2(r1)
 	ld	r3,GPR3(r1)
+
+	kuap_restore_amr r4
+
 	ld	r4,GPR4(r1)
 	ld	r1,GPR1(r1)
 	RFI_TO_KERNEL
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a5b8fbae56a0..99b1bc4e190b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,6 +19,7 @@
 #include <asm/cpuidle.h>
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 /*
  * There are a few constraints to be concerned with.
@@ -309,6 +310,7 @@ TRAMP_REAL_BEGIN(machine_check_common_early)
 	mfspr	r11,SPRN_DSISR		/* Save DSISR */
 	std	r11,_DSISR(r1)
 	std	r9,_CCR(r1)		/* Save CR in stackframe */
+	kuap_save_amr_and_lock r9, r10, cr1
 	/* Save r9 through r13 from EXMC save area to stack frame. */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
 	mfmsr	r11			/* get MSR value */
@@ -1097,6 +1099,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
 	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
 	EXCEPTION_PROLOG_COMMON_1()
+	/* We don't touch AMR here, we never go to virtual mode */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 8616b291bcec..45869fd698a0 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -29,6 +29,7 @@
 #include <asm/powernv.h>
 #include <asm/sections.h>
 #include <asm/trace.h>
+#include <asm/uaccess.h>
 
 #include <trace/events/thp.h>
 
@@ -549,6 +550,24 @@ void setup_kuep(bool disabled)
 }
 #endif
 
+#ifdef CONFIG_PPC_KUAP
+void setup_kuap(bool disabled)
+{
+	if (disabled || !early_radix_enabled())
+		return;
+
+	if (smp_processor_id() == boot_cpuid) {
+		pr_info("Activating Kernel Userspace Access Prevention\n");
+		cur_cpu_spec->mmu_features |= MMU_FTR_RADIX_KUAP;
+	}
+
+	/* Make sure userspace can't change the AMR */
+	mtspr(SPRN_UAMOR, 0);
+	mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
+	isync();
+}
+#endif
+
 void __init radix__early_init_mmu(void)
 {
 	unsigned long lpcr;
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 587807763737..ae7fca40e5b3 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -7,6 +7,7 @@
 
 #include <asm/mman.h>
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 #include <asm/setup.h>
 #include <linux/pkeys.h>
 #include <linux/of_device.h>
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 60371784c9f1..5e53b9fd62aa 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -327,6 +327,7 @@ config PPC_RADIX_MMU
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select PPC_HAVE_KUEP
+	select PPC_HAVE_KUAP
 	default y
 	help
 	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
@@ -370,6 +371,13 @@ config PPC_KUAP
 
 	  If you're unsure, say Y.
 
+config PPC_KUAP_DEBUG
+	bool "Extra debugging for Kernel Userspace Access Protection"
+	depends on PPC_HAVE_KUAP && PPC_RADIX_MMU
+	help
+	  Add extra debugging for Kernel Userspace Access Protection (KUAP)
+	  If you're unsure, say N.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	def_bool y
 	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
-- 
2.20.1

