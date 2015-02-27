Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 372D71A08B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 14:16:03 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH 5/5] mm: fold arch_randomize_brk into ARCH_HAS_ELF_RANDOMIZE
Date: Thu, 26 Feb 2015 19:07:14 -0800
Message-Id: <1425006434-3106-6-git-send-email-keescook@chromium.org>
In-Reply-To: <1425006434-3106-1-git-send-email-keescook@chromium.org>
References: <1425006434-3106-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>,
 Behan Webster <behanw@converseincode.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Ben Hutchings <ben@decadent.org.uk>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Alex Smith <alex@alex-smith.me.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, Oleg Nesterov <oleg@redhat.com>,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On architectures that define CONFIG_ARCH_HAS_ELF_RANDOMIZE, collapse the
function declarations while continuing to handle CONFIG_COMPAT_BRK.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig                   |  1 +
 arch/arm/include/asm/elf.h     |  4 ----
 arch/arm64/include/asm/elf.h   |  4 ----
 arch/mips/include/asm/elf.h    |  4 ----
 arch/powerpc/include/asm/elf.h |  4 ----
 arch/s390/include/asm/elf.h    |  3 ---
 arch/x86/include/asm/elf.h     |  3 ---
 fs/binfmt_elf.c                |  4 +---
 include/linux/elf-randomize.h  | 12 ++++++++++++
 9 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e315cc79ebe7..1c7e98f137db 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -490,6 +490,7 @@ config ARCH_HAS_ELF_RANDOMIZE
 	  An architecture supports choosing randomized locations for
 	  stack, mmap, brk, and ET_DYN. Defined functions:
 	  - arch_mmap_rnd(), must respect (current->flags & PF_RANDOMIZE)
+	  - arch_randomize_brk()
 
 #
 # ABI hall of shame
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index afb9cafd3786..c1ff8ab12914 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -125,10 +125,6 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 #ifdef CONFIG_MMU
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index f724db00b235..faad6df49e5b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -156,10 +156,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #define STACK_RND_MASK			(0x3ffff >> (PAGE_SHIFT - 12))
 #endif
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 #ifdef CONFIG_COMPAT
 
 #ifdef __AARCH64EB__
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 535f196ffe02..31d747d46a23 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -410,10 +410,6 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 struct arch_elf_state {
 	int fp_abi;
 	int interp_fp_abi;
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 57d289acb803..ee46ffef608e 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -128,10 +128,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 	(0x7ff >> (PAGE_SHIFT - 12)) : \
 	(0x3ffff >> (PAGE_SHIFT - 12)))
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
-
 #ifdef CONFIG_SPU_BASE
 /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
 #define NT_SPU		1
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 617f7fabdb0a..7cc271003ff6 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -226,9 +226,6 @@ struct linux_binprm;
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 int arch_setup_additional_pages(struct linux_binprm *, int);
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 void *fill_cpu_elf_notes(void *ptr, struct save_area *sa, __vector128 *vxrs);
 
 #endif
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index ca3347a9dab5..bbdace22daf8 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -338,9 +338,6 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
 
-extern unsigned long arch_randomize_brk(struct mm_struct *mm);
-#define arch_randomize_brk arch_randomize_brk
-
 /*
  * True on X86_32 or when emulating IA32 on X86_64
  */
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 203c2e6f9a25..96459c18d1eb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1041,15 +1041,13 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-#ifdef arch_randomize_brk
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
 		current->mm->brk = current->mm->start_brk =
 			arch_randomize_brk(current->mm);
-#ifdef CONFIG_COMPAT_BRK
+#ifdef compat_brk_randomized
 		current->brk_randomized = 1;
 #endif
 	}
-#endif
 
 	if (current->personality & MMAP_PAGE_ZERO) {
 		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
diff --git a/include/linux/elf-randomize.h b/include/linux/elf-randomize.h
index 7a4eda02d2b1..b5f0bda9472e 100644
--- a/include/linux/elf-randomize.h
+++ b/include/linux/elf-randomize.h
@@ -1,10 +1,22 @@
 #ifndef _ELF_RANDOMIZE_H
 #define _ELF_RANDOMIZE_H
 
+struct mm_struct;
+
 #ifndef CONFIG_ARCH_HAS_ELF_RANDOMIZE
 static inline unsigned long arch_mmap_rnd(void) { return 0; }
+# if defined(arch_randomize_brk) && defined(CONFIG_COMPAT_BRK)
+#  define compat_brk_randomized
+# endif
+# ifndef arch_randomize_brk
+#  define arch_randomize_brk(mm)	(mm->brk)
+# endif
 #else
 extern unsigned long arch_mmap_rnd(void);
+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
+# ifdef CONFIG_COMPAT_BRK
+#  define compat_brk_randomized
+# endif
 #endif
 
 #endif
-- 
1.9.1
