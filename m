Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405771A090D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 09:14:24 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH v4 09/10] mm: split ET_DYN ASLR from mmap ASLR
Date: Wed,  4 Mar 2015 13:10:53 -0800
Message-Id: <1425503454-7531-10-git-send-email-keescook@chromium.org>
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, Ingo Molnar <mingo@redhat.com>,
 "David A. Long" <dave.long@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Borislav Petkov <bp@suse.de>,
 Ben Hutchings <ben@decadent.org.uk>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, Oleg Nesterov <oleg@redhat.com>,
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

This fixes the "offset2lib" weakness in ASLR for arm, arm64, mips,
powerpc, and x86. The problem is that if there is a leak of ASLR from
the executable (ET_DYN), it means a leak of shared library offset as
well (mmap), and vice versa. Further details and a PoC of this attack
is available here:
http://cybersecurity.upv.es/attacks/offset2lib/offset2lib.html

With this patch, a PIE linked executable (ET_DYN) has its own ASLR region
(e.g. 0x5... instead of 0x7f... on x86_64):

$ ./show_mmaps_pie
54859ccd6000-54859ccd7000 r-xp  ...  /tmp/show_mmaps_pie
54859ced6000-54859ced7000 r--p  ...  /tmp/show_mmaps_pie
54859ced7000-54859ced8000 rw-p  ...  /tmp/show_mmaps_pie
7f75be764000-7f75be91f000 r-xp  ...  /lib/x86_64-linux-gnu/libc.so.6
7f75be91f000-7f75beb1f000 ---p  ...  /lib/x86_64-linux-gnu/libc.so.6
7f75beb1f000-7f75beb23000 r--p  ...  /lib/x86_64-linux-gnu/libc.so.6
7f75beb23000-7f75beb25000 rw-p  ...  /lib/x86_64-linux-gnu/libc.so.6
7f75beb25000-7f75beb2a000 rw-p  ...
7f75beb2a000-7f75beb4d000 r-xp  ...  /lib64/ld-linux-x86-64.so.2
7f75bed45000-7f75bed46000 rw-p  ...
7f75bed46000-7f75bed47000 r-xp  ...
7f75bed47000-7f75bed4c000 rw-p  ...
7f75bed4c000-7f75bed4d000 r--p  ...  /lib64/ld-linux-x86-64.so.2
7f75bed4d000-7f75bed4e000 rw-p  ...  /lib64/ld-linux-x86-64.so.2
7f75bed4e000-7f75bed4f000 rw-p  ...
7fffb3741000-7fffb3762000 rw-p  ...  [stack]
7fffb377b000-7fffb377d000 r--p  ...  [vvar]
7fffb377d000-7fffb377f000 r-xp  ...  [vdso]

The change is to add a call the newly created arch_mmap_rnd() into the
ELF loader for handling ET_DYN ASLR in a separate region from mmap ASLR,
as was already done on s390. Removes CONFIG_BINFMT_ELF_RANDOMIZE_PIE,
which is no longer needed.

Reported-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Kconfig            |  1 -
 arch/arm64/Kconfig          |  1 -
 arch/mips/Kconfig           |  1 -
 arch/powerpc/Kconfig        |  1 -
 arch/s390/include/asm/elf.h |  5 ++---
 arch/s390/mm/mmap.c         |  8 --------
 arch/x86/Kconfig            |  1 -
 fs/Kconfig.binfmt           |  3 ---
 fs/binfmt_elf.c             | 18 ++++--------------
 9 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 248d99cabaa8..e2f0ef9c6ee3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1,7 +1,6 @@
 config ARM
 	bool
 	default y
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5f469095e0e2..07e0fc7adc88 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,6 +1,5 @@
 config ARM64
 	def_bool y
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 72ce5cece768..557c5f1772c1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -23,7 +23,6 @@ config MIPS
 	select HAVE_KRETPROBES
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_SYSCALL_TRACEPOINTS
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
 	select RTC_LIB if !MACH_LOONGSON
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 14fe1c411489..910fa4f9ad1e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -88,7 +88,6 @@ config PPC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 2e63de8aac7c..d0db9d944b6d 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -163,10 +163,9 @@ extern unsigned int vdso_enabled;
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk. 64-bit
    tasks are aligned to 4GB. */
-extern unsigned long randomize_et_dyn(void);
-#define ELF_ET_DYN_BASE (randomize_et_dyn() + (is_32bit_task() ? \
+#define ELF_ET_DYN_BASE (is_32bit_task() ? \
 				(STACK_TOP / 3 * 2) : \
-				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)))
+				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1))
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 8c11536f972d..bb3367c5cb0b 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -177,14 +177,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-unsigned long randomize_et_dyn(void)
-{
-	if (current->flags & PF_RANDOMIZE)
-		return arch_mmap_rnd();
-
-	return 0UL;
-}
-
 #ifndef CONFIG_64BIT
 
 /*
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9aa91727fbf8..328be0fab910 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -87,7 +87,6 @@ config X86
 	select HAVE_ARCH_KMEMCHECK
 	select HAVE_ARCH_KASAN if X86_64 && SPARSEMEM_VMEMMAP
 	select HAVE_USER_RETURN_NOTIFIER
-	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select HAVE_ARCH_JUMP_LABEL
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 270c48148f79..2d0cbbd14cfc 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -27,9 +27,6 @@ config COMPAT_BINFMT_ELF
 	bool
 	depends on COMPAT && BINFMT_ELF
 
-config ARCH_BINFMT_ELF_RANDOMIZE_PIE
-	bool
-
 config ARCH_BINFMT_ELF_STATE
 	bool
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 995986b8e36b..6f08f5fa99dc 100644
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
@@ -909,21 +910,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * default mmap base, as well as whatever program they
 			 * might try to exec.  This is because the brk will
 			 * follow the loader, and is not movable.  */
-#ifdef CONFIG_ARCH_BINFMT_ELF_RANDOMIZE_PIE
-			/* Memory randomization might have been switched off
-			 * in runtime via sysctl or explicit setting of
-			 * personality flags.
-			 * If that is the case, retain the original non-zero
-			 * load_bias value in order to establish proper
-			 * non-randomized mappings.
-			 */
+			load_bias = ELF_ET_DYN_BASE - vaddr;
 			if (current->flags & PF_RANDOMIZE)
-				load_bias = 0;
-			else
-				load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-#else
-			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
-#endif
+				load_bias += arch_mmap_rnd();
+			load_bias = ELF_PAGESTART(load_bias);
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
-- 
1.9.1
