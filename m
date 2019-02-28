Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C48C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 15:04:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5C02184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 15:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5C02184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449G6p1p5CzDqNW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 02:04:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449FnS14YVzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 01:49:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 449FnR4lk1z9sN4; Fri,  1 Mar 2019 01:49:31 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 449FnR2tY6z9sMr; Fri,  1 Mar 2019 01:49:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 9/9] powerpc/64s: Implement KUAP for Radix MMU
Date: Fri,  1 Mar 2019 01:49:17 +1100
Message-Id: <20190228144917.16876-9-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228144917.16876-1-mpe@ellerman.id.au>
References: <20190228144917.16876-1-mpe@ellerman.id.au>
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
Cc: akshay.adiga@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Russell Currey <ruscur@russell.cc>

Kernel Userspace Access Prevention utilises a feature of the Radix MMU
which disallows read and write access to userspace addresses. By
utilising this, the kernel is prevented from accessing user data from
outside of trusted paths that perform proper safety checks, such as
copy_{to/from}_user() and friends.

Userspace access is disabled from early boot and is only enabled when
performing an operation like copy_{to/from}_user().  The register that
controls this (AMR) does not prevent userspace from accessing itself,
so there is no need to save and restore when entering and exiting
userspace.

This feature has a slight performance impact which I roughly measured
to be 3% slower in the worst case (performing 1GB of 1 byte
read()/write() syscalls), and is gated behind the CONFIG_PPC_KUAP
option for performance-critical builds.

This feature can be tested by using the lkdtm driver (CONFIG_LKDTM=y)
and performing the following:

  # (echo ACCESS_USERSPACE) > [debugfs]/provoke-crash/DIRECT

If enabled, this should send SIGSEGV to the thread.

mpe: Drop the unused paca flags. Zero the UAMOR to be safe. Save the
AMR when we enter the kernel from the kernel and then lock it again.
Restore on the way back to the kernel. This means we handle nesting of
interrupts properly, ie. we are protected inside the page fault
handler caused by a user access. Add paranoid checking of AMR in
switch and syscall return. Add an isync() to prevent_user_access()

Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../powerpc/include/asm/book3s/64/kup-radix.h | 79 +++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h      |  2 +
 arch/powerpc/include/asm/feature-fixups.h     |  3 +
 arch/powerpc/include/asm/kup.h                |  4 +
 arch/powerpc/include/asm/mmu.h                | 10 ++-
 arch/powerpc/include/asm/reg.h                |  1 +
 arch/powerpc/kernel/entry_64.S                | 22 +++++-
 arch/powerpc/kernel/exceptions-64s.S          |  3 +
 arch/powerpc/mm/pgtable-radix.c               | 19 +++++
 arch/powerpc/mm/pkeys.c                       |  1 +
 arch/powerpc/platforms/Kconfig.cputype        |  8 ++
 11 files changed, 149 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h

v4: mpe: Drop the unused paca flags. Zero the UAMOR to be safe. Save the
AMR when we enter the kernel from the kernel and then lock it again.
Restore on the way back to the kernel. This means we handle nesting of
interrupts properly, ie. we are protected inside the page fault
handler caused by a user access. Add paranoid checking of AMR in
switch and syscall return. Add an isync() to prevent_user_access()

diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
new file mode 100644
index 000000000000..87f2af26764c
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
+#define _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H
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
+.macro kuap_check_amr gpr
+#ifdef CONFIG_PPC_KUAP_DEBUG
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	mfspr	\gpr, SPRN_AMR
+	sradi	\gpr, \gpr, 48
+999:	tdnei	\gpr, RADIX_AMR_LOCKED@highest
+	EMIT_BUG_ENTRY 999b,__FILE__,__LINE__, \
+		(BUGFLAG_WARNING|BUGFLAG_ONCE)
+	END_MMU_FTR_SECTION_NESTED_IFSET(MMU_FTR_RADIX_KUAP, 67)
+#endif
+.endm
+
+.macro kuap_save_amr_and_lock gpr, msr_pr_cr
+#ifdef CONFIG_PPC_KUAP
+	BEGIN_MMU_FTR_SECTION_NESTED(67)
+	.ifnb \msr_pr_cr
+	bne	\msr_pr_cr, 99f
+	.endif
+	mfspr	\gpr, SPRN_AMR
+	std	\gpr, STACK_REGS_KUAP(r1)
+	li	\gpr, (RADIX_AMR_LOCKED)@highest
+	sldi	\gpr, \gpr, 48
+	mtspr	SPRN_AMR,\gpr
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
+/*
+ * We do have the ability to individually lock/unlock reads and writes rather
+ * than both at once, however it's a significant performance hit due to needing
+ * to do a read-modify-write, which adds a mfspr, which is slow.  As a result,
+ * locking/unlocking both at once is preferred.
+ */
+static inline void allow_user_access(void __user *to, const void __user *from,
+				     unsigned long size)
+{
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return;
+
+	mtspr(SPRN_AMR, 0);
+	isync();
+}
+
+static inline void prevent_user_access(void __user *to, const void __user *from,
+				       unsigned long size)
+{
+	if (!mmu_has_feature(MMU_FTR_RADIX_KUAP))
+		return;
+
+	mtspr(SPRN_AMR, RADIX_AMR_LOCKED);
+	isync();
+}
+
+#endif /* CONFIG_PPC_KUAP */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_POWERPC_BOOK3S_64_KUP_RADIX_H */
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 937bb630093f..df7cbfc45952 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -497,6 +497,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	RESTORE_CTR(r1, area);						   \
 	b	bad_stack;						   \
 3:	EXCEPTION_PROLOG_COMMON_1();					   \
+	kuap_save_amr_and_lock r9, cr0;					   \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
 	SAVE_PPR(area, r9);						   \
@@ -691,6 +692,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
  */
 #define EXCEPTION_COMMON_NORET_STACK(area, trap, label, hdlr, additions) \
 	EXCEPTION_PROLOG_COMMON_1();				\
+	kuap_save_amr_and_lock r9;				\
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
index 4d78b9d8c99c..082f50ad41a7 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_POWERPC_KUP_H_
 #define _ASM_POWERPC_KUP_H_
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#include <asm/book3s/64/kup-radix.h>
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <asm/pgtable.h>
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index d34ad1657d7b..59acb4418164 100644
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
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c5b2aff0ce8e..6350873af4bc 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -246,6 +246,7 @@
 #define SPRN_DSCR	0x11
 #define SPRN_CFAR	0x1c	/* Come From Address Register */
 #define SPRN_AMR	0x1d	/* Authority Mask Register */
+#define   RADIX_AMR_LOCKED	0xC000000000000000UL /* Read & Write disabled */
 #define SPRN_UAMOR	0x9d	/* User Authority Mask Override Register */
 #define SPRN_AMOR	0x15d	/* Authority Mask Override Register */
 #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 15c67d2c0534..612cfa4bffd7 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -46,6 +46,7 @@
 #include <asm/exception-64e.h>
 #endif
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 /*
  * System calls.
@@ -275,6 +276,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 
+	kuap_check_amr r11
+
 #ifdef CONFIG_PPC_BOOK3S
 	/*
 	 * Clear MSR_RI, MSR_EE is already and remains disabled. We could do
@@ -296,6 +299,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	std	r8, PACATMSCRATCH(r13)
 #endif
 
+	/*
+	 * We don't need to restore AMR on the way back to userspace for KUAP.
+	 * The value of AMR only matters while we're in the kernel.
+	 */
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
 	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
@@ -306,8 +313,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
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
@@ -594,6 +603,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	kuap_check_amr r6
+
 	FLUSH_COUNT_CACHE
 
 	/*
@@ -974,6 +985,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
 
+	/*
+	 * We don't need to restore AMR on the way back to userspace for KUAP.
+	 * The value of AMR only matters while we're in the kernel.
+	 */
 	mtspr	SPRN_SRR1,r3
 
 	ld	r2,_CCR(r1)
@@ -1006,6 +1021,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
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
index b179b8b5d3f0..e25cea13b928 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,6 +19,7 @@
 #include <asm/cpuidle.h>
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
+#include <asm/kup.h>
 
 /*
  * There are a few constraints to be concerned with.
@@ -301,6 +302,7 @@ TRAMP_REAL_BEGIN(machine_check_common_early)
 	mfspr	r11,SPRN_DSISR		/* Save DSISR */
 	std	r11,_DSISR(r1)
 	std	r9,_CCR(r1)		/* Save CR in stackframe */
+	kuap_save_amr_and_lock r9
 	/* Save r9 through r13 from EXMC save area to stack frame. */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
 	mfmsr	r11			/* get MSR value */
@@ -1037,6 +1039,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
 	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
 	EXCEPTION_PROLOG_COMMON_1()
+	kuap_save_amr_and_lock r9
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 224bcd4be5ae..aa7d9de3ba3f 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -29,6 +29,7 @@
 #include <asm/powernv.h>
 #include <asm/sections.h>
 #include <asm/trace.h>
+#include <asm/uaccess.h>
 
 #include <trace/events/thp.h>
 
@@ -553,6 +554,24 @@ void __init setup_kuep(bool disabled)
 }
 #endif
 
+#ifdef CONFIG_PPC_KUAP
+void __init setup_kuap(bool disabled)
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
+
+	mtspr(SPRN_AMR, RADIX_AMR_LOCKED);
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

