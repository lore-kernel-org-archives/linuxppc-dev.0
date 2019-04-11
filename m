Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A117C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:50:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931932133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931932133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fzqJ3SzKzDqRY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzkw6J8fzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:46:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzkw3xtNz9s70; Thu, 11 Apr 2019 21:46:32 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzkw33DNz9s71; Thu, 11 Apr 2019 21:46:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 00/35] powerpc spectre backports for 4.9
Date: Thu, 11 Apr 2019 21:45:55 +1000
Message-Id: <20190411114630.4042-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Greg,

Please queue up these powerpc patches for 4.9 if you have no objections.

There's one build fix for newer toolchains, and the rest are spectre related.

cheers

Andreas Schwab (1):
  powerpc: Fix invalid use of register expressions

Christophe Leroy (1):
  powerpc/fsl: Fix the flush of branch predictor.

Diana Craciun (16):
  powerpc/64: Disable the speculation barrier from the command line
  powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
  powerpc/64: Make meltdown reporting Book3S 64 specific
  powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E
  powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit
    platforms
  powerpc/fsl: Add infrastructure to fixup branch predictor flush
  powerpc/fsl: Add macro to flush the branch predictor
  powerpc/fsl: Fix spectre_v2 mitigations reporting
  powerpc/fsl: Emulate SPRN_BUCSR register
  powerpc/fsl: Add nospectre_v2 command line argument
  powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)
  powerpc/fsl: Flush the branch predictor at each kernel entry (32 bit)
  powerpc/fsl: Flush branch predictor when entering KVM
  powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used
  powerpc/fsl: Update Spectre v2 reporting
  powerpc/fsl: Fixed warning: orphan section `__btb_flush_fixup'

Michael Ellerman (11):
  powerpc: Use barrier_nospec in copy_from_user()
  powerpc/64: Use barrier_nospec in syscall entry
  powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2
  powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
  powerpc/64: Call setup_barrier_nospec() from setup_arch()
  powerpc/asm: Add a patch_site macro & helpers for patching
    instructions
  powerpc/64s: Add new security feature flags for count cache flush
  powerpc/64s: Add support for software count cache flush
  powerpc/pseries: Query hypervisor for count cache flush settings
  powerpc/powernv: Query firmware for count cache flush settings
  powerpc/security: Fix spectre_v2 reporting

Michael Neuling (1):
  powerpc: Avoid code patching freed init sections

Michal Suchanek (5):
  powerpc/64s: Add barrier_nospec
  powerpc/64s: Add support for ori barrier_nospec patching
  powerpc/64s: Patch barrier_nospec in modules
  powerpc/64s: Enable barrier_nospec based on firmware settings
  powerpc/64s: Enhance the information in cpu_show_spectre_v1()

 arch/powerpc/Kconfig                         |   7 +-
 arch/powerpc/include/asm/asm-prototypes.h    |   6 +
 arch/powerpc/include/asm/barrier.h           |  21 ++
 arch/powerpc/include/asm/code-patching-asm.h |  18 ++
 arch/powerpc/include/asm/code-patching.h     |   2 +
 arch/powerpc/include/asm/feature-fixups.h    |  21 ++
 arch/powerpc/include/asm/hvcall.h            |   2 +
 arch/powerpc/include/asm/ppc_asm.h           |  23 +-
 arch/powerpc/include/asm/security_features.h |   7 +
 arch/powerpc/include/asm/setup.h             |  21 ++
 arch/powerpc/include/asm/uaccess.h           |  11 +-
 arch/powerpc/kernel/Makefile                 |   3 +-
 arch/powerpc/kernel/entry_32.S               |  10 +
 arch/powerpc/kernel/entry_64.S               |  69 ++++++
 arch/powerpc/kernel/exceptions-64e.S         |  27 ++-
 arch/powerpc/kernel/head_booke.h             |  12 ++
 arch/powerpc/kernel/head_fsl_booke.S         |  15 ++
 arch/powerpc/kernel/module.c                 |  10 +-
 arch/powerpc/kernel/security.c               | 216 ++++++++++++++++++-
 arch/powerpc/kernel/setup-common.c           |   3 +
 arch/powerpc/kernel/swsusp_asm64.S           |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S            |  19 +-
 arch/powerpc/kvm/bookehv_interrupts.S        |   4 +
 arch/powerpc/kvm/e500_emulate.c              |   7 +
 arch/powerpc/lib/code-patching.c             |  24 +++
 arch/powerpc/lib/copypage_power7.S           |  14 +-
 arch/powerpc/lib/copyuser_power7.S           |  66 +++---
 arch/powerpc/lib/feature-fixups.c            |  93 ++++++++
 arch/powerpc/lib/memcpy_power7.S             |  66 +++---
 arch/powerpc/lib/string_64.S                 |   2 +-
 arch/powerpc/mm/mem.c                        |   2 +
 arch/powerpc/mm/tlb_low_64e.S                |   7 +
 arch/powerpc/platforms/powernv/setup.c       |   7 +
 arch/powerpc/platforms/pseries/setup.c       |   7 +
 34 files changed, 733 insertions(+), 91 deletions(-)
 create mode 100644 arch/powerpc/include/asm/code-patching-asm.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0a6bb48854e3..fa8f2aa88189 100644
- --- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -128,7 +128,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CMOS_UPDATE
- -	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
 	select GENERIC_TIME_VSYSCALL_OLD
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
@@ -164,6 +164,11 @@ config PPC
 	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_KERNEL_GZIP
 
+config PPC_BARRIER_NOSPEC
+    bool
+    default y
+    depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
+
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
 
diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index e0baba1535e6..f3daa175f86c 100644
- --- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -121,4 +121,10 @@ extern s64 __ashrdi3(s64, int);
 extern int __cmpdi2(s64, s64);
 extern int __ucmpdi2(u64, u64);
 
+/* Patch sites */
+extern s32 patch__call_flush_count_cache;
+extern s32 patch__flush_count_cache_return;
+
+extern long flush_count_cache;
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 798ab37c9930..80024c4f2093 100644
- --- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -77,6 +77,27 @@ do {									\
 
 #define smp_mb__before_spinlock()   smp_mb()
 
+#ifdef CONFIG_PPC_BOOK3S_64
+#define NOSPEC_BARRIER_SLOT   nop
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+#define NOSPEC_BARRIER_SLOT   nop; nop
+#endif
+
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
+/*
+ * Prevent execution of subsequent instructions until preceding branches have
+ * been fully resolved and are no longer executing speculatively.
+ */
+#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; NOSPEC_BARRIER_SLOT
+
+// This also acts as a compiler barrier due to the memory clobber.
+#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
+
+#else /* !CONFIG_PPC_BARRIER_NOSPEC */
+#define barrier_nospec_asm
+#define barrier_nospec()
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_POWERPC_BARRIER_H */
diff --git a/arch/powerpc/include/asm/code-patching-asm.h b/arch/powerpc/include/asm/code-patching-asm.h
new file mode 100644
index 000000000000..ed7b1448493a
- --- /dev/null
+++ b/arch/powerpc/include/asm/code-patching-asm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2018, Michael Ellerman, IBM Corporation.
+ */
+#ifndef _ASM_POWERPC_CODE_PATCHING_ASM_H
+#define _ASM_POWERPC_CODE_PATCHING_ASM_H
+
+/* Define a "site" that can be patched */
+.macro patch_site label name
+	.pushsection ".rodata"
+	.balign 4
+	.global \name
+\name:
+	.4byte	\label - .
+	.popsection
+.endm
+
+#endif /* _ASM_POWERPC_CODE_PATCHING_ASM_H */
diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index b4ab1f497335..ab934f8232bd 100644
- --- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -28,6 +28,8 @@ unsigned int create_cond_branch(const unsigned int *addr,
 				unsigned long target, int flags);
 int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
+int patch_instruction_site(s32 *addr, unsigned int instr);
+int patch_branch_site(s32 *site, unsigned long target, int flags);
 
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_relative_link_branch(unsigned int instr);
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 0bf8202feca6..175128e19025 100644
- --- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -213,6 +213,25 @@ void setup_feature_keys(void);
 	FTR_ENTRY_OFFSET 951b-952b;			\
 	.popsection;
 
+#define NOSPEC_BARRIER_FIXUP_SECTION			\
+953:							\
+	.pushsection __barrier_nospec_fixup,"a";	\
+	.align 2;					\
+954:							\
+	FTR_ENTRY_OFFSET 953b-954b;			\
+	.popsection;
+
+#define START_BTB_FLUSH_SECTION			\
+955:							\
+
+#define END_BTB_FLUSH_SECTION			\
+956:							\
+	.pushsection __btb_flush_fixup,"a";	\
+	.align 2;							\
+957:						\
+	FTR_ENTRY_OFFSET 955b-957b;			\
+	FTR_ENTRY_OFFSET 956b-957b;			\
+	.popsection;
 
 #ifndef __ASSEMBLY__
 
@@ -220,6 +239,8 @@ extern long stf_barrier_fallback;
 extern long __start___stf_entry_barrier_fixup, __stop___stf_entry_barrier_fixup;
 extern long __start___stf_exit_barrier_fixup, __stop___stf_exit_barrier_fixup;
 extern long __start___rfi_flush_fixup, __stop___rfi_flush_fixup;
+extern long __start___barrier_nospec_fixup, __stop___barrier_nospec_fixup;
+extern long __start__btb_flush_fixup, __stop__btb_flush_fixup;
 
 #endif
 
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 9d978102bf0d..9587d301db55 100644
- --- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -316,10 +316,12 @@
 #define H_CPU_CHAR_BRANCH_HINTS_HONORED	(1ull << 58) // IBM bit 5
 #define H_CPU_CHAR_THREAD_RECONFIG_CTRL	(1ull << 57) // IBM bit 6
 #define H_CPU_CHAR_COUNT_CACHE_DISABLED	(1ull << 56) // IBM bit 7
+#define H_CPU_CHAR_BCCTR_FLUSH_ASSIST	(1ull << 54) // IBM bit 9
 
 #define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
 #define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
+#define H_CPU_BEHAV_FLUSH_COUNT_CACHE	(1ull << 58) // IBM bit 5
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index c73750b0d9fa..bbd35ba36a22 100644
- --- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -437,7 +437,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 .machine push ;					\
 .machine "power4" ;				\
        lis     scratch,0x60000000@h;		\
- -       dcbt    r0,scratch,0b01010;		\
+       dcbt    0,scratch,0b01010;		\
 .machine pop
 
 /*
@@ -780,4 +780,25 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	.long 0x2400004c  /* rfid				*/
 #endif /* !CONFIG_PPC_BOOK3E */
 #endif /*  __ASSEMBLY__ */
+
+/*
+ * Helper macro for exception table entries
+ */
+#define EX_TABLE(_fault, _target)		\
+	stringify_in_c(.section __ex_table,"a";)\
+	stringify_in_c(.balign 4;)		\
+	stringify_in_c(.long (_fault) - . ;)	\
+	stringify_in_c(.long (_target) - . ;)	\
+	stringify_in_c(.previous)
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define BTB_FLUSH(reg)			\
+	lis reg,BUCSR_INIT@h;		\
+	ori reg,reg,BUCSR_INIT@l;	\
+	mtspr SPRN_BUCSR,reg;		\
+	isync;
+#else
+#define BTB_FLUSH(reg)
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 #endif /* _ASM_POWERPC_PPC_ASM_H */
diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index 44989b22383c..759597bf0fd8 100644
- --- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -22,6 +22,7 @@ enum stf_barrier_type {
 
 void setup_stf_barrier(void);
 void do_stf_barrier_fixups(enum stf_barrier_type types);
+void setup_count_cache_flush(void);
 
 static inline void security_ftr_set(unsigned long feature)
 {
@@ -59,6 +60,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Indirect branch prediction cache disabled
 #define SEC_FTR_COUNT_CACHE_DISABLED	0x0000000000000020ull
 
+// bcctr 2,0,0 triggers a hardware assisted count cache flush
+#define SEC_FTR_BCCTR_FLUSH_ASSIST	0x0000000000000800ull
+
 
 // Features indicating need for Spectre/Meltdown mitigations
 
@@ -74,6 +78,9 @@ static inline bool security_ftr_enabled(unsigned long feature)
 // Firmware configuration indicates user favours security over performance
 #define SEC_FTR_FAVOUR_SECURITY		0x0000000000000200ull
 
+// Software required to flush count cache on context switch
+#define SEC_FTR_FLUSH_COUNT_CACHE	0x0000000000000400ull
+
 
 // Features enabled by default
 #define SEC_FTR_DEFAULT \
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 3f160cd20107..862ebce3ae54 100644
- --- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -8,6 +8,7 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
+extern bool init_mem_is_free;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
@@ -50,6 +51,26 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
+void setup_barrier_nospec(void);
+#else
+static inline void setup_barrier_nospec(void) { };
+#endif
+void do_barrier_nospec_fixups(bool enable);
+extern bool barrier_nospec_enabled;
+
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
+void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
+#else
+static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
+#endif
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void setup_spectre_v2(void);
+#else
+static inline void setup_spectre_v2(void) {};
+#endif
+void do_btb_flush_fixups(void);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 31913b3ac7ab..da852153c1f8 100644
- --- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -269,6 +269,7 @@ do {								\
 	__chk_user_ptr(ptr);					\
 	if (!is_kernel_addr((unsigned long)__gu_addr))		\
 		might_fault();					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -280,8 +281,10 @@ do {								\
 	unsigned long  __gu_val = 0;					\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	might_fault();							\
- -	if (access_ok(VERIFY_READ, __gu_addr, (size)))			\
+	if (access_ok(VERIFY_READ, __gu_addr, (size))) {		\
+		barrier_nospec();					\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
+	}								\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	__gu_err;							\
 })
@@ -292,6 +295,7 @@ do {								\
 	unsigned long __gu_val;					\
 	__typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
 	__chk_user_ptr(ptr);					\
+	barrier_nospec();					\
 	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 	__gu_err;						\
@@ -348,15 +352,19 @@ static inline unsigned long __copy_from_user_inatomic(void *to,
 
 		switch (n) {
 		case 1:
+			barrier_nospec();
 			__get_user_size(*(u8 *)to, from, 1, ret);
 			break;
 		case 2:
+			barrier_nospec();
 			__get_user_size(*(u16 *)to, from, 2, ret);
 			break;
 		case 4:
+			barrier_nospec();
 			__get_user_size(*(u32 *)to, from, 4, ret);
 			break;
 		case 8:
+			barrier_nospec();
 			__get_user_size(*(u64 *)to, from, 8, ret);
 			break;
 		}
@@ -366,6 +374,7 @@ static inline unsigned long __copy_from_user_inatomic(void *to,
 
 	check_object_size(to, n, false);
 
+	barrier_nospec();
 	return __copy_tofrom_user((__force void __user *)to, from, n);
 }
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 13885786282b..d80fbf0884ff 100644
- --- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -44,9 +44,10 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
- -obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_BARRIER_NOSPEC) += security.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 370645687cc7..bdd88f9d7926 100644
- --- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -34,6 +34,7 @@
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/barrier.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
@@ -347,6 +348,15 @@ _GLOBAL(DoSyscall)
 	ori	r10,r10,sys_call_table@l
 	slwi	r0,r0,2
 	bge-	66f
+
+	barrier_nospec_asm
+	/*
+	 * Prevent the load of the handler below (based on the user-passed
+	 * system call number) being speculatively executed until the test
+	 * against NR_syscalls and branch to .66f above has
+	 * committed.
+	 */
+
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e24ae0fa80ed..390ebf4ef384 100644
- --- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -26,6 +26,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/thread_info.h>
+#include <asm/code-patching-asm.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
@@ -38,6 +39,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -78,6 +80,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
 	beq	2f			/* if from kernel mode */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+START_BTB_FLUSH_SECTION
+	BTB_FLUSH(r10)
+END_BTB_FLUSH_SECTION
+#endif
 	ACCOUNT_CPU_USER_ENTRY(r13, r10, r11)
 2:	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
@@ -180,6 +187,15 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r8,r8,32
 15:
 	slwi	r0,r0,4
+
+	barrier_nospec_asm
+	/*
+	 * Prevent the load of the handler below (based on the user-passed
+	 * system call number) being speculatively executed until the test
+	 * against NR_syscalls and branch to .Lsyscall_enosys above has
+	 * committed.
+	 */
+
 	ldx	r12,r11,r0	/* Fetch system call handler [ptr] */
 	mtctr   r12
 	bctrl			/* Call handler */
@@ -473,6 +489,57 @@ _GLOBAL(ret_from_kernel_thread)
 	li	r3,0
 	b	.Lsyscall_exit
 
+#ifdef CONFIG_PPC_BOOK3S_64
+
+#define FLUSH_COUNT_CACHE	\
+1:	nop;			\
+	patch_site 1b, patch__call_flush_count_cache
+
+
+#define BCCTR_FLUSH	.long 0x4c400420
+
+.macro nops number
+	.rept \number
+	nop
+	.endr
+.endm
+
+.balign 32
+.global flush_count_cache
+flush_count_cache:
+	/* Save LR into r9 */
+	mflr	r9
+
+	.rept 64
+	bl	.+4
+	.endr
+	b	1f
+	nops	6
+
+	.balign 32
+	/* Restore LR */
+1:	mtlr	r9
+	li	r9,0x7fff
+	mtctr	r9
+
+	BCCTR_FLUSH
+
+2:	nop
+	patch_site 2b patch__flush_count_cache_return
+
+	nops	3
+
+	.rept 278
+	.balign 32
+	BCCTR_FLUSH
+	nops	7
+	.endr
+
+	blr
+#else
+#define FLUSH_COUNT_CACHE
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 /*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
@@ -504,6 +571,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	FLUSH_COUNT_CACHE
+
 #ifdef CONFIG_SMP
 	/* We need a sync somewhere here to make sure that if the
 	 * previous task gets rescheduled on another CPU, it sees all
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index ca03eb229a9a..423b5257d3a1 100644
- --- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -295,7 +295,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
 	beq	1f;			/* branch around if supervisor */   \
 	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
- -1:	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
+1:	type##_BTB_FLUSH		\
+	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
 	bge-	cr1,exc_##n##_bad_stack;/* bad stack (TODO: out of line) */ \
 	mfspr	r10,SPRN_##type##_SRR0;	/* read SRR0 before touching stack */
 
@@ -327,6 +328,30 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 #define SPRN_MC_SRR0	SPRN_MCSRR0
 #define SPRN_MC_SRR1	SPRN_MCSRR1
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define GEN_BTB_FLUSH			\
+	START_BTB_FLUSH_SECTION		\
+		beq 1f;			\
+		BTB_FLUSH(r10)			\
+		1:		\
+	END_BTB_FLUSH_SECTION
+
+#define CRIT_BTB_FLUSH			\
+	START_BTB_FLUSH_SECTION		\
+		BTB_FLUSH(r10)		\
+	END_BTB_FLUSH_SECTION
+
+#define DBG_BTB_FLUSH CRIT_BTB_FLUSH
+#define MC_BTB_FLUSH CRIT_BTB_FLUSH
+#define GDBELL_BTB_FLUSH GEN_BTB_FLUSH
+#else
+#define GEN_BTB_FLUSH
+#define CRIT_BTB_FLUSH
+#define DBG_BTB_FLUSH
+#define MC_BTB_FLUSH
+#define GDBELL_BTB_FLUSH
+#endif
+
 #define NORMAL_EXCEPTION_PROLOG(n, intnum, addition)			    \
 	EXCEPTION_PROLOG(n, intnum, GEN, addition##_GEN(n))
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index a620203f7de3..7b98c7351f6c 100644
- --- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -31,6 +31,16 @@
  */
 #define THREAD_NORMSAVE(offset)	(THREAD_NORMSAVES + (offset * 4))
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+#define BOOKE_CLEAR_BTB(reg)									\
+START_BTB_FLUSH_SECTION								\
+	BTB_FLUSH(reg)									\
+END_BTB_FLUSH_SECTION
+#else
+#define BOOKE_CLEAR_BTB(reg)
+#endif
+
+
 #define NORMAL_EXCEPTION_PROLOG(intno)						     \
 	mtspr	SPRN_SPRG_WSCRATCH0, r10;	/* save one register */	     \
 	mfspr	r10, SPRN_SPRG_THREAD;					     \
@@ -42,6 +52,7 @@
 	andi.	r11, r11, MSR_PR;	/* check whether user or kernel    */\
 	mr	r11, r1;						     \
 	beq	1f;							     \
+	BOOKE_CLEAR_BTB(r11)						\
 	/* if from user, start at top of this thread's kernel stack */       \
 	lwz	r11, THREAD_INFO-THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
@@ -127,6 +138,7 @@
 	stw	r9,_CCR(r8);		/* save CR on stack		   */\
 	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
 	DO_KVM	BOOKE_INTERRUPT_##intno exc_level_srr1;		             \
+	BOOKE_CLEAR_BTB(r10)						\
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index bf4c6021515f..60a0aeefc4a7 100644
- --- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -452,6 +452,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	mfcr	r13
 	stw	r13, THREAD_NORMSAVE(3)(r10)
 	DO_KVM	BOOKE_INTERRUPT_DTLB_MISS SPRN_SRR1
+START_BTB_FLUSH_SECTION
+	mfspr r11, SPRN_SRR1
+	andi. r10,r11,MSR_PR
+	beq 1f
+	BTB_FLUSH(r10)
+1:
+END_BTB_FLUSH_SECTION
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -546,6 +553,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	mfcr	r13
 	stw	r13, THREAD_NORMSAVE(3)(r10)
 	DO_KVM	BOOKE_INTERRUPT_ITLB_MISS SPRN_SRR1
+START_BTB_FLUSH_SECTION
+	mfspr r11, SPRN_SRR1
+	andi. r10,r11,MSR_PR
+	beq 1f
+	BTB_FLUSH(r10)
+1:
+END_BTB_FLUSH_SECTION
+
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 30b89d5cbb03..3b1c3bb91025 100644
- --- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,7 +72,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
- -#endif
+#endif /* CONFIG_PPC64 */
+
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
+	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
+	if (sect != NULL)
+		do_barrier_nospec_fixups_range(barrier_nospec_enabled,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
 	if (sect != NULL)
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 2277df84ef6e..30542e833ebe 100644
- --- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -9,11 +9,121 @@
 #include <linux/device.h>
 #include <linux/seq_buf.h>
 
+#include <asm/asm-prototypes.h>
+#include <asm/code-patching.h>
+#include <asm/debug.h>
 #include <asm/security_features.h>
+#include <asm/setup.h>
 
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
+enum count_cache_flush_type {
+	COUNT_CACHE_FLUSH_NONE	= 0x1,
+	COUNT_CACHE_FLUSH_SW	= 0x2,
+	COUNT_CACHE_FLUSH_HW	= 0x4,
+};
+static enum count_cache_flush_type count_cache_flush_type = COUNT_CACHE_FLUSH_NONE;
+
+bool barrier_nospec_enabled;
+static bool no_nospec;
+static bool btb_flush_enabled;
+#ifdef CONFIG_PPC_FSL_BOOK3E
+static bool no_spectrev2;
+#endif
+
+static void enable_barrier_nospec(bool enable)
+{
+	barrier_nospec_enabled = enable;
+	do_barrier_nospec_fixups(enable);
+}
+
+void setup_barrier_nospec(void)
+{
+	bool enable;
+
+	/*
+	 * It would make sense to check SEC_FTR_SPEC_BAR_ORI31 below as well.
+	 * But there's a good reason not to. The two flags we check below are
+	 * both are enabled by default in the kernel, so if the hcall is not
+	 * functional they will be enabled.
+	 * On a system where the host firmware has been updated (so the ori
+	 * functions as a barrier), but on which the hypervisor (KVM/Qemu) has
+	 * not been updated, we would like to enable the barrier. Dropping the
+	 * check for SEC_FTR_SPEC_BAR_ORI31 achieves that. The only downside is
+	 * we potentially enable the barrier on systems where the host firmware
+	 * is not updated, but that's harmless as it's a no-op.
+	 */
+	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
+		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
+
+	if (!no_nospec)
+		enable_barrier_nospec(enable);
+}
+
+static int __init handle_nospectre_v1(char *p)
+{
+	no_nospec = true;
+
+	return 0;
+}
+early_param("nospectre_v1", handle_nospectre_v1);
+
+#ifdef CONFIG_DEBUG_FS
+static int barrier_nospec_set(void *data, u64 val)
+{
+	switch (val) {
+	case 0:
+	case 1:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!!val == !!barrier_nospec_enabled)
+		return 0;
+
+	enable_barrier_nospec(!!val);
+
+	return 0;
+}
+
+static int barrier_nospec_get(void *data, u64 *val)
+{
+	*val = barrier_nospec_enabled ? 1 : 0;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_barrier_nospec,
+			barrier_nospec_get, barrier_nospec_set, "%llu\n");
+
+static __init int barrier_nospec_debugfs_init(void)
+{
+	debugfs_create_file("barrier_nospec", 0600, powerpc_debugfs_root, NULL,
+			    &fops_barrier_nospec);
+	return 0;
+}
+device_initcall(barrier_nospec_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+static int __init handle_nospectre_v2(char *p)
+{
+	no_spectrev2 = true;
+
+	return 0;
+}
+early_param("nospectre_v2", handle_nospectre_v2);
+void setup_spectre_v2(void)
+{
+	if (no_spectrev2)
+		do_btb_flush_fixups();
+	else
+		btb_flush_enabled = true;
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
+#ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
@@ -46,25 +156,39 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
 
 	return sprintf(buf, "Vulnerable\n");
 }
+#endif
 
 ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
 {
- -	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
- -		return sprintf(buf, "Not affected\n");
+	struct seq_buf s;
 
- -	return sprintf(buf, "Vulnerable\n");
+	seq_buf_init(&s, buf, PAGE_SIZE - 1);
+
+	if (security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR)) {
+		if (barrier_nospec_enabled)
+			seq_buf_printf(&s, "Mitigation: __user pointer sanitization");
+		else
+			seq_buf_printf(&s, "Vulnerable");
+
+		if (security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31))
+			seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+
+		seq_buf_printf(&s, "\n");
+	} else
+		seq_buf_printf(&s, "Not affected\n");
+
+	return s.len;
 }
 
 ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, char *buf)
 {
- -	bool bcs, ccd, ori;
 	struct seq_buf s;
+	bool bcs, ccd;
 
 	seq_buf_init(&s, buf, PAGE_SIZE - 1);
 
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
- -	ori = security_ftr_enabled(SEC_FTR_SPEC_BAR_ORI31);
 
 	if (bcs || ccd) {
 		seq_buf_printf(&s, "Mitigation: ");
@@ -77,17 +201,23 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 
 		if (ccd)
 			seq_buf_printf(&s, "Indirect branch cache disabled");
- -	} else
+	} else if (count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
+		seq_buf_printf(&s, "Mitigation: Software count cache flush");
+
+		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
+			seq_buf_printf(&s, " (hardware accelerated)");
+	} else if (btb_flush_enabled) {
+		seq_buf_printf(&s, "Mitigation: Branch predictor state flush");
+	} else {
 		seq_buf_printf(&s, "Vulnerable");
- -
- -	if (ori)
- -		seq_buf_printf(&s, ", ori31 speculation barrier enabled");
+	}
 
 	seq_buf_printf(&s, "\n");
 
 	return s.len;
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * Store-forwarding barrier support.
  */
@@ -235,3 +365,71 @@ static __init int stf_barrier_debugfs_init(void)
 }
 device_initcall(stf_barrier_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
+
+static void toggle_count_cache_flush(bool enable)
+{
+	if (!enable || !security_ftr_enabled(SEC_FTR_FLUSH_COUNT_CACHE)) {
+		patch_instruction_site(&patch__call_flush_count_cache, PPC_INST_NOP);
+		count_cache_flush_type = COUNT_CACHE_FLUSH_NONE;
+		pr_info("count-cache-flush: software flush disabled.\n");
+		return;
+	}
+
+	patch_branch_site(&patch__call_flush_count_cache,
+			  (u64)&flush_count_cache, BRANCH_SET_LINK);
+
+	if (!security_ftr_enabled(SEC_FTR_BCCTR_FLUSH_ASSIST)) {
+		count_cache_flush_type = COUNT_CACHE_FLUSH_SW;
+		pr_info("count-cache-flush: full software flush sequence enabled.\n");
+		return;
+	}
+
+	patch_instruction_site(&patch__flush_count_cache_return, PPC_INST_BLR);
+	count_cache_flush_type = COUNT_CACHE_FLUSH_HW;
+	pr_info("count-cache-flush: hardware assisted flush sequence enabled\n");
+}
+
+void setup_count_cache_flush(void)
+{
+	toggle_count_cache_flush(true);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int count_cache_flush_set(void *data, u64 val)
+{
+	bool enable;
+
+	if (val == 1)
+		enable = true;
+	else if (val == 0)
+		enable = false;
+	else
+		return -EINVAL;
+
+	toggle_count_cache_flush(enable);
+
+	return 0;
+}
+
+static int count_cache_flush_get(void *data, u64 *val)
+{
+	if (count_cache_flush_type == COUNT_CACHE_FLUSH_NONE)
+		*val = 0;
+	else
+		*val = 1;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_count_cache_flush, count_cache_flush_get,
+			count_cache_flush_set, "%llu\n");
+
+static __init int count_cache_flush_debugfs_init(void)
+{
+	debugfs_create_file("count_cache_flush", 0600, powerpc_debugfs_root,
+			    NULL, &fops_count_cache_flush);
+	return 0;
+}
+device_initcall(count_cache_flush_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_PPC_BOOK3S_64 */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bf0f712ac0e0..5e7d70c5d065 100644
- --- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -918,6 +918,9 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
+	setup_barrier_nospec();
+	setup_spectre_v2();
+
 	paging_init();
 
 	/* Initialize the MMU context management stuff. */
diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index 988f38dced0f..82d8aae81c6a 100644
- --- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -179,7 +179,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	sld	r3, r3, r0
 	li	r0, 0
 1:
- -	dcbf	r0,r3
+	dcbf	0,r3
 	addi	r3,r3,0x20
 	bdnz	1b
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c16fddbb6ab8..50d365060855 100644
- --- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -153,8 +153,25 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
- -#endif
+#endif /* CONFIG_PPC64 */
+
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
+	. = ALIGN(8);
+	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
+		__start___barrier_nospec_fixup = .;
+		*(__barrier_nospec_fixup)
+		__stop___barrier_nospec_fixup = .;
+	}
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	. = ALIGN(8);
+	__spec_btb_flush_fixup : AT(ADDR(__spec_btb_flush_fixup) - LOAD_OFFSET) {
+		__start__btb_flush_fixup = .;
+		*(__btb_flush_fixup)
+		__stop__btb_flush_fixup = .;
+	}
+#endif
 	EXCEPTION_TABLE(0)
 
 	NOTES :kernel :notes
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 81bd8a07aa51..612b7f6a887f 100644
- --- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -75,6 +75,10 @@
 	PPC_LL	r1, VCPU_HOST_STACK(r4)
 	PPC_LL	r2, HOST_R2(r1)
 
+START_BTB_FLUSH_SECTION
+	BTB_FLUSH(r10)
+END_BTB_FLUSH_SECTION
+
 	mfspr	r10, SPRN_PID
 	lwz	r8, VCPU_HOST_PID(r4)
 	PPC_LL	r11, VCPU_SHARED(r4)
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 990db69a1d0b..fa88f641ac03 100644
- --- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -277,6 +277,13 @@ int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_va
 		vcpu->arch.pwrmgtcr0 = spr_val;
 		break;
 
+	case SPRN_BUCSR:
+		/*
+		 * If we are here, it means that we have already flushed the
+		 * branch predictor, so just return to guest.
+		 */
+		break;
+
 	/* extra exceptions */
 #ifdef CONFIG_SPE_POSSIBLE
 	case SPRN_IVOR32:
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 753d591f1b52..14535ad4cdd1 100644
- --- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -14,12 +14,20 @@
 #include <asm/page.h>
 #include <asm/code-patching.h>
 #include <asm/uaccess.h>
+#include <asm/setup.h>
+#include <asm/sections.h>
 
 
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
 
+	/* Make sure we aren't patching a freed init section */
+	if (init_mem_is_free && init_section_contains(addr, 4)) {
+		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
+		return 0;
+	}
+
 	__put_user_size(instr, addr, 4, err);
 	if (err)
 		return err;
@@ -32,6 +40,22 @@ int patch_branch(unsigned int *addr, unsigned long target, int flags)
 	return patch_instruction(addr, create_branch(addr, target, flags));
 }
 
+int patch_branch_site(s32 *site, unsigned long target, int flags)
+{
+	unsigned int *addr;
+
+	addr = (unsigned int *)((unsigned long)site + *site);
+	return patch_instruction(addr, create_branch(addr, target, flags));
+}
+
+int patch_instruction_site(s32 *site, unsigned int instr)
+{
+	unsigned int *addr;
+
+	addr = (unsigned int *)((unsigned long)site + *site);
+	return patch_instruction(addr, instr);
+}
+
 unsigned int create_branch(const unsigned int *addr,
 			   unsigned long target, int flags)
 {
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index a84d333ecb09..ca5fc8fa7efc 100644
- --- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -45,13 +45,13 @@ _GLOBAL(copypage_power7)
 .machine push
 .machine "power4"
 	/* setup read stream 0  */
- -	dcbt	r0,r4,0b01000  	/* addr from */
- -	dcbt	r0,r7,0b01010   /* length and depth from */
+	dcbt	0,r4,0b01000  	/* addr from */
+	dcbt	0,r7,0b01010   /* length and depth from */
 	/* setup write stream 1 */
- -	dcbtst	r0,r9,0b01000   /* addr to */
- -	dcbtst	r0,r10,0b01010  /* length and depth to */
+	dcbtst	0,r9,0b01000   /* addr to */
+	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
- -	dcbt	r0,r8,0b01010	/* all streams GO */
+	dcbt	0,r8,0b01010	/* all streams GO */
 .machine pop
 
 #ifdef CONFIG_ALTIVEC
@@ -83,7 +83,7 @@ _GLOBAL(copypage_power7)
 	li	r12,112
 
 	.align	5
- -1:	lvx	v7,r0,r4
+1:	lvx	v7,0,r4
 	lvx	v6,r4,r6
 	lvx	v5,r4,r7
 	lvx	v4,r4,r8
@@ -92,7 +92,7 @@ _GLOBAL(copypage_power7)
 	lvx	v1,r4,r11
 	lvx	v0,r4,r12
 	addi	r4,r4,128
- -	stvx	v7,r0,r3
+	stvx	v7,0,r3
 	stvx	v6,r3,r6
 	stvx	v5,r3,r7
 	stvx	v4,r3,r8
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index da0c568d18c4..391694814691 100644
- --- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -327,13 +327,13 @@ err1;	stb	r0,0(r3)
 .machine push
 .machine "power4"
 	/* setup read stream 0 */
- -	dcbt	r0,r6,0b01000   /* addr from */
- -	dcbt	r0,r7,0b01010   /* length and depth from */
+	dcbt	0,r6,0b01000   /* addr from */
+	dcbt	0,r7,0b01010   /* length and depth from */
 	/* setup write stream 1 */
- -	dcbtst	r0,r9,0b01000   /* addr to */
- -	dcbtst	r0,r10,0b01010  /* length and depth to */
+	dcbtst	0,r9,0b01000   /* addr to */
+	dcbtst	0,r10,0b01010  /* length and depth to */
 	eieio
- -	dcbt	r0,r8,0b01010	/* all streams GO */
+	dcbt	0,r8,0b01010	/* all streams GO */
 .machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
@@ -388,26 +388,26 @@ err3;	std	r0,0(r3)
 	li	r11,48
 
 	bf	cr7*4+3,5f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	addi	r4,r4,16
- -err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
- -err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
- -err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 err3;	lvx	v2,r4,r9
 err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
- -err3;	stvx	v3,r0,r3
+err3;	stvx	v3,0,r3
 err3;	stvx	v2,r3,r9
 err3;	stvx	v1,r3,r10
 err3;	stvx	v0,r3,r11
@@ -433,7 +433,7 @@ err3;	stvx	v0,r3,r11
 	 */
 	.align	5
 8:
- -err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 err4;	lvx	v6,r4,r9
 err4;	lvx	v5,r4,r10
 err4;	lvx	v4,r4,r11
@@ -442,7 +442,7 @@ err4;	lvx	v2,r4,r14
 err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	addi	r4,r4,128
- -err4;	stvx	v7,r0,r3
+err4;	stvx	v7,0,r3
 err4;	stvx	v6,r3,r9
 err4;	stvx	v5,r3,r10
 err4;	stvx	v4,r3,r11
@@ -463,29 +463,29 @@ err4;	stvx	v0,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
- -err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 err3;	lvx	v2,r4,r9
 err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	addi	r4,r4,64
- -err3;	stvx	v3,r0,r3
+err3;	stvx	v3,0,r3
 err3;	stvx	v2,r3,r9
 err3;	stvx	v1,r3,r10
 err3;	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 err3;	lvx	v0,r4,r9
 	addi	r4,r4,32
- -err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 err3;	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	addi	r4,r4,16
- -err3;	stvx	v1,r0,r3
+err3;	stvx	v1,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -565,25 +565,25 @@ err3;	lvx	v0,0,r4
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
- -err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 	addi	r3,r3,16
 	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 err3;	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
- -err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
- -err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 err3;	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -592,7 +592,7 @@ err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
- -err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 err3;	stvx	v10,r3,r10
 err3;	stvx	v11,r3,r11
@@ -618,7 +618,7 @@ err3;	stvx	v11,r3,r11
 	 */
 	.align	5
 8:
- -err4;	lvx	v7,r0,r4
+err4;	lvx	v7,0,r4
 	VPERM(v8,v0,v7,v16)
 err4;	lvx	v6,r4,r9
 	VPERM(v9,v7,v6,v16)
@@ -635,7 +635,7 @@ err4;	lvx	v1,r4,r15
 err4;	lvx	v0,r4,r16
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
- -err4;	stvx	v8,r0,r3
+err4;	stvx	v8,0,r3
 err4;	stvx	v9,r3,r9
 err4;	stvx	v10,r3,r10
 err4;	stvx	v11,r3,r11
@@ -656,7 +656,7 @@ err4;	stvx	v15,r3,r16
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
- -err3;	lvx	v3,r0,r4
+err3;	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 err3;	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -665,27 +665,27 @@ err3;	lvx	v1,r4,r10
 err3;	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
- -err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 err3;	stvx	v10,r3,r10
 err3;	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 err3;	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
- -err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 err3;	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
- -err3;	lvx	v1,r0,r4
+err3;	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
- -err3;	stvx	v8,r0,r3
+err3;	stvx	v8,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index cf1398e3c2e0..e6ed0ec94bc8 100644
- --- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -277,8 +277,101 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
 						: "unknown");
 }
+
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
+{
+	unsigned int instr, *dest;
+	long *start, *end;
+	int i;
+
+	start = fixup_start;
+	end = fixup_end;
+
+	instr = 0x60000000; /* nop */
+
+	if (enable) {
+		pr_info("barrier-nospec: using ORI speculation barrier\n");
+		instr = 0x63ff0000; /* ori 31,31,0 speculation barrier */
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
+void do_barrier_nospec_fixups(bool enable)
+{
+	void *start, *end;
+
+	start = PTRRELOC(&__start___barrier_nospec_fixup),
+	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+
+	do_barrier_nospec_fixups_range(enable, start, end);
+}
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
+{
+	unsigned int instr[2], *dest;
+	long *start, *end;
+	int i;
+
+	start = fixup_start;
+	end = fixup_end;
+
+	instr[0] = PPC_INST_NOP;
+	instr[1] = PPC_INST_NOP;
+
+	if (enable) {
+		pr_info("barrier-nospec: using isync; sync as speculation barrier\n");
+		instr[0] = PPC_INST_ISYNC;
+		instr[1] = PPC_INST_SYNC;
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr[0]);
+		patch_instruction(dest + 1, instr[1]);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+
+static void patch_btb_flush_section(long *curr)
+{
+	unsigned int *start, *end;
+
+	start = (void *)curr + *curr;
+	end = (void *)curr + *(curr + 1);
+	for (; start < end; start++) {
+		pr_devel("patching dest %lx\n", (unsigned long)start);
+		patch_instruction(start, PPC_INST_NOP);
+	}
+}
+
+void do_btb_flush_fixups(void)
+{
+	long *start, *end;
+
+	start = PTRRELOC(&__start__btb_flush_fixup);
+	end = PTRRELOC(&__stop__btb_flush_fixup);
+
+	for (; start < end; start += 2)
+		patch_btb_flush_section(start);
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
 	long *start, *end;
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 786234fd4e91..193909abd18b 100644
- --- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -261,12 +261,12 @@ _GLOBAL(memcpy_power7)
 
 .machine push
 .machine "power4"
- -	dcbt	r0,r6,0b01000
- -	dcbt	r0,r7,0b01010
- -	dcbtst	r0,r9,0b01000
- -	dcbtst	r0,r10,0b01010
+	dcbt	0,r6,0b01000
+	dcbt	0,r7,0b01010
+	dcbtst	0,r9,0b01000
+	dcbtst	0,r10,0b01010
 	eieio
- -	dcbt	r0,r8,0b01010	/* GO */
+	dcbt	0,r8,0b01010	/* GO */
 .machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
@@ -321,26 +321,26 @@ _GLOBAL(memcpy_power7)
 	li	r11,48
 
 	bf	cr7*4+3,5f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	addi	r4,r4,16
- -	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	addi	r3,r3,16
 
 5:	bf	cr7*4+2,6f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	lvx	v0,r4,r9
 	addi	r4,r4,32
- -	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
- -	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	lvx	v2,r4,r9
 	lvx	v1,r4,r10
 	lvx	v0,r4,r11
 	addi	r4,r4,64
- -	stvx	v3,r0,r3
+	stvx	v3,0,r3
 	stvx	v2,r3,r9
 	stvx	v1,r3,r10
 	stvx	v0,r3,r11
@@ -366,7 +366,7 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
- -	lvx	v7,r0,r4
+	lvx	v7,0,r4
 	lvx	v6,r4,r9
 	lvx	v5,r4,r10
 	lvx	v4,r4,r11
@@ -375,7 +375,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v1,r4,r15
 	lvx	v0,r4,r16
 	addi	r4,r4,128
- -	stvx	v7,r0,r3
+	stvx	v7,0,r3
 	stvx	v6,r3,r9
 	stvx	v5,r3,r10
 	stvx	v4,r3,r11
@@ -396,29 +396,29 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
- -	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	lvx	v2,r4,r9
 	lvx	v1,r4,r10
 	lvx	v0,r4,r11
 	addi	r4,r4,64
- -	stvx	v3,r0,r3
+	stvx	v3,0,r3
 	stvx	v2,r3,r9
 	stvx	v1,r3,r10
 	stvx	v0,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	lvx	v0,r4,r9
 	addi	r4,r4,32
- -	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	stvx	v0,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	addi	r4,r4,16
- -	stvx	v1,r0,r3
+	stvx	v1,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
@@ -499,25 +499,25 @@ _GLOBAL(memcpy_power7)
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
- -	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	addi	r3,r3,16
 	vor	v0,v1,v1
 
 5:	bf	cr7*4+2,6f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
- -	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 6:	bf	cr7*4+1,7f
- -	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -526,7 +526,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
- -	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
@@ -552,7 +552,7 @@ _GLOBAL(memcpy_power7)
 	 */
 	.align	5
 8:
- -	lvx	v7,r0,r4
+	lvx	v7,0,r4
 	VPERM(v8,v0,v7,v16)
 	lvx	v6,r4,r9
 	VPERM(v9,v7,v6,v16)
@@ -569,7 +569,7 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r16
 	VPERM(v15,v1,v0,v16)
 	addi	r4,r4,128
- -	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
@@ -590,7 +590,7 @@ _GLOBAL(memcpy_power7)
 	mtocrf	0x01,r6
 
 	bf	cr7*4+1,9f
- -	lvx	v3,r0,r4
+	lvx	v3,0,r4
 	VPERM(v8,v0,v3,v16)
 	lvx	v2,r4,r9
 	VPERM(v9,v3,v2,v16)
@@ -599,27 +599,27 @@ _GLOBAL(memcpy_power7)
 	lvx	v0,r4,r11
 	VPERM(v11,v1,v0,v16)
 	addi	r4,r4,64
- -	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	stvx	v10,r3,r10
 	stvx	v11,r3,r11
 	addi	r3,r3,64
 
 9:	bf	cr7*4+2,10f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	lvx	v0,r4,r9
 	VPERM(v9,v1,v0,v16)
 	addi	r4,r4,32
- -	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	stvx	v9,r3,r9
 	addi	r3,r3,32
 
 10:	bf	cr7*4+3,11f
- -	lvx	v1,r0,r4
+	lvx	v1,0,r4
 	VPERM(v8,v0,v1,v16)
 	addi	r4,r4,16
- -	stvx	v8,r0,r3
+	stvx	v8,0,r3
 	addi	r3,r3,16
 
 	/* Up to 15B to go */
diff --git a/arch/powerpc/lib/string_64.S b/arch/powerpc/lib/string_64.S
index 57ace356c949..11e6372537fd 100644
- --- a/arch/powerpc/lib/string_64.S
+++ b/arch/powerpc/lib/string_64.S
@@ -192,7 +192,7 @@ err1;	std	r0,8(r3)
 	mtctr	r6
 	mr	r8,r3
 14:
- -err1;	dcbz	r0,r3
+err1;	dcbz	0,r3
 	add	r3,r3,r9
 	bdnz	14b
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5f844337de21..1e93dbc88e80 100644
- --- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -62,6 +62,7 @@
 #endif
 
 unsigned long long memory_limit;
+bool init_mem_is_free;
 
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
@@ -396,6 +397,7 @@ void __init mem_init(void)
 void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
+	init_mem_is_free = true;
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index eb82d787d99a..b7e9c09dfe19 100644
- --- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -69,6 +69,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	std	r15,EX_TLB_R15(r12)
 	std	r10,EX_TLB_CR(r12)
 #ifdef CONFIG_PPC_FSL_BOOK3E
+START_BTB_FLUSH_SECTION
+	mfspr r11, SPRN_SRR1
+	andi. r10,r11,MSR_PR
+	beq 1f
+	BTB_FLUSH(r10)
+1:
+END_BTB_FLUSH_SECTION
 	std	r7,EX_TLB_R7(r12)
 #endif
 	TLB_MISS_PROLOG_STATS
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 17203abf38e8..365e2b620201 100644
- --- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -77,6 +77,12 @@ static void init_fw_feat_flags(struct device_node *np)
 	if (fw_feature_is("enabled", "fw-count-cache-disabled", np))
 		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
 
+	if (fw_feature_is("enabled", "fw-count-cache-flush-bcctr2,0,0", np))
+		security_ftr_set(SEC_FTR_BCCTR_FLUSH_ASSIST);
+
+	if (fw_feature_is("enabled", "needs-count-cache-flush-on-context-switch", np))
+		security_ftr_set(SEC_FTR_FLUSH_COUNT_CACHE);
+
 	/*
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
@@ -123,6 +129,7 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
+	setup_count_cache_flush();
 }
 
 static void __init pnv_setup_arch(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 91ade7755823..adb09ab87f7c 100644
- --- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -475,6 +475,12 @@ static void init_cpu_char_feature_flags(struct h_cpu_char_result *result)
 	if (result->character & H_CPU_CHAR_COUNT_CACHE_DISABLED)
 		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
 
+	if (result->character & H_CPU_CHAR_BCCTR_FLUSH_ASSIST)
+		security_ftr_set(SEC_FTR_BCCTR_FLUSH_ASSIST);
+
+	if (result->behaviour & H_CPU_BEHAV_FLUSH_COUNT_CACHE)
+		security_ftr_set(SEC_FTR_FLUSH_COUNT_CACHE);
+
 	/*
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
@@ -525,6 +531,7 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
+	setup_count_cache_flush();
 }
 
 static void __init pSeries_setup_arch(void)
- -- 
2.20.1

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcrfzCAAoJEFHr6jzI4aWAg8kQAJkDz2e9knVmKCHft/WEgrjW
qTmhjw3tsjyHqbvvop4vzsgzquUKQDfV7623smnGtNTIdQX8ODgAA/KRDuaaqEra
Y8q9kSXxbJYDwYqN6kmp7ufrxRRt4TWESc07xuC8JBy4DG7RrOBSC4dF3LE8Mq8c
CS6OyL0/T+9jegBgCJwG8AacqzV4yvhhDhgseAdwwxRxo2np68N09huZzIIl2jR7
dEjOUiCtl+RegO/WIj/qRH0CGH/tMzju7zjPhk5qCbEhcCk8byjowfl1DJvGHpx2
xan70CMDtkP6hO6dHL2+ydgWi9ahyJwGQeKTI/w/9r6E8SGyEUxgoJN6arMrdUTd
zXJwGzFBnhB4ZLRuWkpTjOeGE7GJ+VU7xis9pv6FFBN3FOUJYbFuVgaXOl0u/oWQ
75OZ6Gum53/GblAiUiZ7GpUPzsWOBvQZreLetuZAgDIK0VArSy4n0PxlC5c/IILx
jxoDaY+ll2cTtR7Phy0918IVZy8+52JpDWgLeCzRNBS9Wz6Fw65h1IOy0J7EtYeo
6NYwzNOOOrV+n2dtoljgY3HGlVA8/+2kTDbT3ljMkFgjsv9ZZCra8eRPPY/hvn2p
K3zzY2izMKbKY5Sp20SoDyouxAit/BcqAPzxYdaz1PazR38GZOBtFuf4pMMeSXOJ
RkQPFO+MHH8ukNtf/Tnd
=+Bgj
-----END PGP SIGNATURE-----
