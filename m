Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z665D0nB8zDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 19:50:55 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id v21so25509354wrc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Dec 2017 00:50:55 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ralf Baechle <ralf@linux-mips.org>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Petr Mladek <pmladek@suse.com>,
 Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: [PATCH v6 1/8] arch: enable relative relocations for arm64, power, x86,
 s390 and x86
Date: Wed, 27 Dec 2017 08:50:26 +0000
Message-Id: <20171227085033.22389-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before updating certain subsystems to use place relative 32-bit
relocations in special sections, to save space  and reduce the
number of absolute relocations that need to be processed at runtime
by relocatable kernels, introduce the Kconfig symbol and define it
for some architectures that should be able to support and benefit
from it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/Kconfig                    | 10 ++++++++++
 arch/arm64/Kconfig              |  1 +
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 arch/powerpc/Kconfig            |  1 +
 arch/s390/Kconfig               |  1 +
 arch/x86/Kconfig                |  1 +
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 400b9e1b2f27..dbc036a7bd1b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -959,4 +959,14 @@ config REFCOUNT_FULL
 	  against various use-after-free conditions that can be used in
 	  security flaw exploits.
 
+config HAVE_ARCH_PREL32_RELOCATIONS
+	bool
+	help
+	  May be selected by an architecture if it supports place-relative
+	  32-bit relocations, both in the toolchain and in the module loader,
+	  in which case relative references can be used in special sections
+	  for PCI fixup, initcalls etc which are only half the size on 64 bit
+	  architectures, and don't require runtime relocation on relocatable
+	  kernels.
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a7e9e1414f..66c7b9ab2a3d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,6 +89,7 @@ config ARM64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7da3e5c366a0..49ae5b43fe2b 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -156,7 +156,7 @@ SECTIONS
 		CON_INITCALL
 		SECURITY_INITCALL
 		INIT_RAM_FS
-		*(.init.rodata.* .init.bss)	/* from the EFI stub */
+		*(.init.rodata.* .init.bss .init.discard.*)	/* EFI stub */
 	}
 	.exit.data : {
 		ARM_EXIT_KEEP(EXIT_DATA)
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c51e6ce42e7a..e172478e2ae7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -177,6 +177,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 829c67986db7..ed29d1ebecd9 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -129,6 +129,7 @@ config S390
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d4fc98c50378..9f2bb853aedb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -115,6 +115,7 @@ config X86
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if MMU && COMPAT
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
+	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
-- 
2.11.0
