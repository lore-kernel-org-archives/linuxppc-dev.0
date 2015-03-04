Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E1831A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 13:12:23 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH v3 07/10] mm: expose arch_mmap_rnd when available
Date: Tue,  3 Mar 2015 18:10:22 -0800
Message-Id: <1425435025-30284-8-git-send-email-keescook@chromium.org>
In-Reply-To: <1425435025-30284-1-git-send-email-keescook@chromium.org>
References: <1425435025-30284-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>,
 Behan Webster <behanw@converseincode.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Ben Hutchings <ben@decadent.org.uk>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dan McGee <dpmcgee@gmail.com>,
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

When an architecture fully supports randomizing the ELF load location,
a per-arch mmap_rnd() function is used to find a randomized mmap base.
In preparation for randomizing the location of ET_DYN binaries
separately from mmap, this renames and exports these functions as
arch_mmap_rnd(). Additionally introduces CONFIG_ARCH_HAS_ELF_RANDOMIZE
for describing this feature on architectures that support it
(which is a superset of ARCH_BINFMT_ELF_RANDOMIZE_PIE, since s390
already supports a separated ET_DYN ASLR from mmap ASLR without the
ARCH_BINFMT_ELF_RANDOMIZE_PIE logic).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/Kconfig                  |  7 +++++++
 arch/arm/Kconfig              |  1 +
 arch/arm/mm/mmap.c            |  4 ++--
 arch/arm64/Kconfig            |  1 +
 arch/arm64/mm/mmap.c          |  4 ++--
 arch/mips/Kconfig             |  1 +
 arch/mips/mm/mmap.c           |  4 ++--
 arch/powerpc/Kconfig          |  1 +
 arch/powerpc/mm/mmap.c        |  4 ++--
 arch/s390/Kconfig             |  1 +
 arch/s390/mm/mmap.c           |  8 ++++----
 arch/x86/Kconfig              |  1 +
 arch/x86/mm/mmap.c            |  4 ++--
 include/linux/elf-randomize.h | 10 ++++++++++
 14 files changed, 37 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/elf-randomize.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a458d5..9ff5aa8fa2c1 100644
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
+	  - arch_mmap_rnd()
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
index 15a8160096b3..407dc786583a 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -169,7 +169,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
@@ -184,7 +184,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	unsigned long random_factor = 0UL;
 
 	if (current->flags & PF_RANDOMIZE)
-		random_factor = mmap_rnd();
+		random_factor = arch_mmap_rnd();
 
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
index 837626d0e142..c25f8ed6d7b6 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -47,7 +47,7 @@ static int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
@@ -77,7 +77,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	unsigned long random_factor = 0UL;
 
 	if (current->flags & PF_RANDOMIZE)
-		random_factor = mmap_rnd();
+		random_factor = arch_mmap_rnd();
 
 	/*
 	 * Fall back to the standard layout if the personality bit is set, or
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
index 673a5cfe082f..ce54fff57c93 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -142,7 +142,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
 			addr0, len, pgoff, flags, DOWN);
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
@@ -161,7 +161,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	unsigned long random_factor = 0UL;
 
 	if (current->flags & PF_RANDOMIZE)
-		random_factor = mmap_rnd();
+		random_factor = arch_mmap_rnd();
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
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
index 3d7088bfe93c..ed54d5296c7a 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -53,7 +53,7 @@ static inline int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
@@ -87,7 +87,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	unsigned long random_factor = 0UL;
 
 	if (current->flags & PF_RANDOMIZE)
-		random_factor = mmap_rnd();
+		random_factor = arch_mmap_rnd();
 
 	/*
 	 * Fall back to the standard layout if the personality
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
index db57078075c5..a94504d99c47 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -60,7 +60,7 @@ static inline int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	if (is_32bit_task())
 		return (get_random_int() & 0x7ff) << PAGE_SHIFT;
@@ -187,7 +187,7 @@ unsigned long randomize_et_dyn(void)
 		base &= ~((1UL << 32) - 1);
 
 	if (current->flags & PF_RANDOMIZE)
-		base += mmap_rnd();
+		base += arch_mmap_rnd();
 
 	return base;
 }
@@ -203,7 +203,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	unsigned long random_factor = 0UL;
 
 	if (current->flags & PF_RANDOMIZE)
-		random_factor = mmap_rnd();
+		random_factor = arch_mmap_rnd();
 
 	/*
 	 * Fall back to the standard layout if the personality
@@ -283,7 +283,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	unsigned long random_factor = 0UL;
 
 	if (current->flags & PF_RANDOMIZE)
-		random_factor = mmap_rnd();
+		random_factor = arch_mmap_rnd();
 
 	/*
 	 * Fall back to the standard layout if the personality
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
index ebfa52030d5c..9d518d693b4b 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -65,7 +65,7 @@ static int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-static unsigned long mmap_rnd(void)
+unsigned long arch_mmap_rnd(void)
 {
 	unsigned long rnd;
 
@@ -114,7 +114,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	unsigned long random_factor = 0UL;
 
 	if (current->flags & PF_RANDOMIZE)
-		random_factor = mmap_rnd();
+		random_factor = arch_mmap_rnd();
 
 	mm->mmap_legacy_base = mmap_legacy_base(random_factor);
 
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
