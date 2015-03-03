Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8DA31A0541
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 11:25:03 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH 2/5] mm: expose arch_mmap_rnd when available
Date: Mon,  2 Mar 2015 16:19:45 -0800
Message-Id: <1425341988-1599-3-git-send-email-keescook@chromium.org>
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When an architecture fully supports randomizing the ELF load location, a
per-arch mmap_rnd() function is used to finding a randomized
mmap base. In preparation for randomizing the location of ET_DYN binaries
separately from mmap, this renames and exports these functions as
arch_mmap_rnd(). Additionally introduces CONFIG_ARCH_HAS_ELF_RANDOMIZE
for describing this feature on architectures that support it (which is a
superset of ARCH_BINFMT_ELF_RANDOMIZE_PIE, since s390 already does this
witout the ARCH_BINFMT_ELF_RANDOMIZE_PIE logic).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig                  |  7 +++++++
 arch/arm/Kconfig              |  1 +
 arch/arm/mm/mmap.c            |  4 ++--
 arch/arm64/Kconfig            |  1 +
 arch/arm64/mm/mmap.c          |  4 ++--
 arch/mips/Kconfig             |  1 +
 arch/mips/mm/mmap.c           |  9 ++++++---
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/mm/mmap.c        |  4 ++--
 arch/s390/Kconfig             |  1 +
 arch/s390/mm/mmap.c           |  8 ++++----
 arch/x86/Kconfig              |  1 +
 arch/x86/mm/mmap.c            |  6 +++---
 fs/binfmt_elf.c               |  1 +
 include/linux/elf-randomize.h | 10 ++++++++++
 15 files changed, 43 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/elf-randomize.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a458d5..e315cc79ebe7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -484,6 +484,13 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	  This spares a stack switch and improves cache usage on softirq
 	  processing.
 
+config ARCH_HAS_ELF_RANDOMIZE
+	bool
+	help
+	  An architecture supports choosing randomized locations for
+	  stack, mmap, brk, and ET_DYN. Defined functions:
+	  - arch_mmap_rnd(), must respect (current->flags & PF_RANDOMIZE)
+
 #
 # ABI hall of shame
 #
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a2bc9b..248d99cabaa8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	default y
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 0f8bc158f2c6..3c1fedb034bb 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -169,7 +169,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0UL;
 
@@ -183,7 +183,7 @@ static unsigned long mmap_rnd(void)
 
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
-	unsigned long random_factor = mmap_rnd();
+	unsigned long random_factor = arch_mmap_rnd();
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e97331ffb..5f469095e0e2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 54922d1275b8..b7117cb4bc07 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -47,7 +47,7 @@ static int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0;
 
@@ -66,7 +66,7 @@ static unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(STACK_TOP - gap - mmap_rnd());
+	return PAGE_ALIGN(STACK_TOP - gap - arch_mmap_rnd());
 }
 
 /*
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c7a16904cd03..72ce5cece768 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -24,6 +24,7 @@ config MIPS
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select RTC_LIB if !MACH_LOONGSON
 	select GENERIC_ATOMIC64 if !64BIT
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index f1baadd56e82..d32490d99671 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -164,9 +164,12 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	}
 }
 
-static inline unsigned long brk_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
-	unsigned long rnd = get_random_int();
+	unsigned long rnd = 0;
+
+	if (current->flags & PF_RANDOMIZE)
+		rnd = get_random_int();
 
 	rnd = rnd << PAGE_SHIFT;
 	/* 8MB for 32bit, 256MB for 64bit */
@@ -183,7 +186,7 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	unsigned long base = mm->brk;
 	unsigned long ret;
 
-	ret = PAGE_ALIGN(base + brk_rnd());
+	ret = PAGE_ALIGN(base + arch_mmap_rnd());
 
 	if (ret < mm->brk)
 		return mm->brk;
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 22b0940494bb..14fe1c411489 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -89,6 +89,7 @@ config PPC
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index cb8bdbe4972f..d1111b49f03d 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -53,7 +53,7 @@ static inline int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0;
 
@@ -76,7 +76,7 @@ static inline unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - mmap_rnd());
+	return PAGE_ALIGN(TASK_SIZE - gap - arch_mmap_rnd());
 }
 
 /*
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 373cd5badf1c..4d707bb3e8dd 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -65,6 +65,7 @@ config S390
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
+	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 179a2c20b01f..77759e35671b 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -60,7 +60,7 @@ static inline int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	if (!(current->flags & PF_RANDOMIZE))
 		return 0;
@@ -72,7 +72,7 @@ static unsigned long mmap_rnd(void)
 
 static unsigned long mmap_base_legacy(void)
 {
-	return TASK_UNMAPPED_BASE + mmap_rnd();
+	return TASK_UNMAPPED_BASE + arch_mmap_rnd();
 }
 
 static inline unsigned long mmap_base(void)
@@ -84,7 +84,7 @@ static inline unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 	gap &= PAGE_MASK;
-	return STACK_TOP - stack_maxrandom_size() - mmap_rnd() - gap;
+	return STACK_TOP - stack_maxrandom_size() - arch_mmap_rnd() - gap;
 }
 
 unsigned long
@@ -187,7 +187,7 @@ unsigned long randomize_et_dyn(void)
 	if (!is_32bit_task())
 		/* Align to 4GB */
 		base &= ~((1UL << 32) - 1);
-	return base + mmap_rnd();
+	return base + arch_mmap_rnd();
 }
 
 #ifndef CONFIG_64BIT
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c2fb8a87dccb..9aa91727fbf8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -88,6 +88,7 @@ config X86
 	select HAVE_ARCH_KASAN if X86_64 && SPARSEMEM_VMEMMAP
 	select HAVE_USER_RETURN_NOTIFIER
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
+	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select SPARSE_IRQ
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index df4552bd239e..a65e2b3154da 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -65,7 +65,7 @@ static int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd = 0;
 
@@ -91,7 +91,7 @@ static unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return PAGE_ALIGN(TASK_SIZE - gap - mmap_rnd());
+	return PAGE_ALIGN(TASK_SIZE - gap - arch_mmap_rnd());
 }
 
 /*
@@ -103,7 +103,7 @@ static unsigned long mmap_legacy_base(void)
 	if (mmap_is_ia32())
 		return TASK_UNMAPPED_BASE;
 	else
-		return TASK_UNMAPPED_BASE + mmap_rnd();
+		return TASK_UNMAPPED_BASE + arch_mmap_rnd();
 }
 
 /*
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 995986b8e36b..b1c5ef5d9322 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -31,6 +31,7 @@
 #include <linux/security.h>
 #include <linux/random.h>
 #include <linux/elf.h>
+#include <linux/elf-randomize.h>
 #include <linux/utsname.h>
 #include <linux/coredump.h>
 #include <linux/sched.h>
diff --git a/include/linux/elf-randomize.h b/include/linux/elf-randomize.h
new file mode 100644
index 000000000000..7a4eda02d2b1
--- /dev/null
+++ b/include/linux/elf-randomize.h
@@ -0,0 +1,10 @@
+#ifndef _ELF_RANDOMIZE_H
+#define _ELF_RANDOMIZE_H
+
+#ifndef CONFIG_ARCH_HAS_ELF_RANDOMIZE
+static inline unsigned long arch_mmap_rnd(void) { return 0; }
+#else
+extern unsigned long arch_mmap_rnd(void);
+#endif
+
+#endif
-- 
1.9.1
