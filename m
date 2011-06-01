Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FE11B773B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 05:47:51 +1000 (EST)
Message-Id: <20110601180610.984881988@duck.linux-mips.net>
Date: Wed, 01 Jun 2011 19:05:09 +0100
From: ralf@linux-mips.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [patch 13/14] PCSPKR: Cleanup Kconfig dependencies
References: <20110601180456.801265664@duck.linux-mips.net>
Cc: linux-mips@linux-mips.org, linux-alpha@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	"H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>,
	Matt Turner <mattst88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lenghty lists of the kind "depends on ARCH1 || ARCH2 ... || ARCH123" are
usually either wrong or too coarse grained.  Or plain an ugly sin.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org

 arch/alpha/Kconfig                     |    1 +
 arch/mips/Kconfig                      |    1 +
 arch/powerpc/platforms/chrp/Kconfig    |    1 +
 arch/powerpc/platforms/prep/Kconfig    |    1 +
 arch/powerpc/platforms/pseries/Kconfig |    1 +
 arch/x86/Kconfig                       |    1 +
 init/Kconfig                           |    5 ++++-
 7 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-mips/arch/alpha/Kconfig
===================================================================
--- linux-mips.orig/arch/alpha/Kconfig
+++ linux-mips/arch/alpha/Kconfig
@@ -6,6 +6,7 @@ config ALPHA
 	select HAVE_OPROFILE
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_IRQ_WORK
+	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_DMA_ATTRS
 	select HAVE_GENERIC_HARDIRQS
Index: linux-mips/arch/mips/Kconfig
===================================================================
--- linux-mips.orig/arch/mips/Kconfig
+++ linux-mips/arch/mips/Kconfig
@@ -5,6 +5,7 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_IRQ_WORK
+	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_ARCH_KGDB
Index: linux-mips/arch/powerpc/platforms/chrp/Kconfig
===================================================================
--- linux-mips.orig/arch/powerpc/platforms/chrp/Kconfig
+++ linux-mips/arch/powerpc/platforms/chrp/Kconfig
@@ -1,6 +1,7 @@
 config PPC_CHRP
 	bool "Common Hardware Reference Platform (CHRP) based machines"
 	depends on 6xx
+	select HAVE_PCSPKR_PLATFORM
 	select MPIC
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
Index: linux-mips/arch/powerpc/platforms/prep/Kconfig
===================================================================
--- linux-mips.orig/arch/powerpc/platforms/prep/Kconfig
+++ linux-mips/arch/powerpc/platforms/prep/Kconfig
@@ -1,6 +1,7 @@
 config PPC_PREP
 	bool "PowerPC Reference Platform (PReP) based machines"
 	depends on 6xx && BROKEN
+	select HAVE_PCSPKR_PLATFORM
 	select MPIC
 	select PPC_I8259
 	select PPC_INDIRECT_PCI
Index: linux-mips/arch/powerpc/platforms/pseries/Kconfig
===================================================================
--- linux-mips.orig/arch/powerpc/platforms/pseries/Kconfig
+++ linux-mips/arch/powerpc/platforms/pseries/Kconfig
@@ -1,6 +1,7 @@
 config PPC_PSERIES
 	depends on PPC64 && PPC_BOOK3S
 	bool "IBM pSeries & new (POWER5-based) iSeries"
+	select HAVE_PCSPKR_PLATFORM
 	select MPIC
 	select PCI_MSI
 	select PPC_XICS
Index: linux-mips/arch/x86/Kconfig
===================================================================
--- linux-mips.orig/arch/x86/Kconfig
+++ linux-mips/arch/x86/Kconfig
@@ -20,6 +20,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_IDE
 	select HAVE_OPROFILE
+	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_IRQ_WORK
 	select HAVE_IOREMAP_PROT
Index: linux-mips/init/Kconfig
===================================================================
--- linux-mips.orig/init/Kconfig
+++ linux-mips/init/Kconfig
@@ -1001,12 +1001,15 @@ config ELF_CORE
 
 config PCSPKR_PLATFORM
 	bool "Enable PC-Speaker support" if EXPERT
-	depends on ALPHA || X86 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES
+	depends on HAVE_PCSPKR_PLATFORM
 	default y
 	help
           This option allows to disable the internal PC-Speaker
           support, saving some memory.
 
+config HAVE_PCSPKR_PLATFORM
+	bool
+
 config BASE_FULL
 	default y
 	bool "Enable full-sized data structures for core" if EXPERT
