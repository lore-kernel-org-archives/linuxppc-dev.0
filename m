Return-Path: <gang.chen.5i5j@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0AB81A01A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 02:55:23 +1000 (EST)
Received: by mail-pd0-f173.google.com with SMTP id w10so1876791pde.18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 09:55:21 -0700 (PDT)
Message-ID: <53ECE9DD.80004@gmail.com>
Date: Fri, 15 Aug 2014 00:54:53 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
 rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 vgupta@synopsys.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jean Delvare <jdelvare@suse.de>,
 linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com,
 hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
 msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com,
 jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org,
 tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org,
 james.hogan@imgtec.com, Michal Simek <monstr@monstr.eu>,
 ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com,
 jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 paulus@samba.org, mpe@ellerman.id.au,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 heiko.carstens@de.ibm.com, Liqin Chen <liqin.linux@gmail.com>,
 Lennox Wu <lennox.wu@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, cmetcalf@tilera.com,
 jdike@addtoit.com, Richard Weinberger <richard@nod.at>,
 gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com
Subject: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux@lists.openrisc.net,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-am33-list@redhat.com, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, x86@kernel.org, linux-xtensa@linux-xtensa.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
 user-mode-linux-user@lists.sourceforge.net, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org,
 linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Normal architectures:

 - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc

 - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
                  score, unicore32, x86

 - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh

Special architectures:

 - Deside by compiler: microblaze, tile, xtensa.

 - Deside by building host: um

 - Next, need improve Kbuild to probe endian to deside whether need mark
   __BUILDING_TIME_BIG_ENDIAN__ before real config.

Another improvements:

 - score: use '\t' instead of ' '.

 - s390: sort the select value in alpha order.

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/alpha/Kconfig      |  1 +
 arch/arc/Kconfig        |  1 +
 arch/arm/Kconfig        |  1 +
 arch/arm64/Kconfig      |  1 +
 arch/avr32/Kconfig      |  1 +
 arch/blackfin/Kconfig   |  1 +
 arch/c6x/Kconfig        |  1 +
 arch/cris/Kconfig       |  1 +
 arch/frv/Kconfig        |  1 +
 arch/hexagon/Kconfig    |  1 +
 arch/ia64/Kconfig       |  1 +
 arch/m32r/Kconfig       |  1 +
 arch/m68k/Kconfig       |  1 +
 arch/metag/Kconfig      |  1 +
 arch/microblaze/Kconfig |  2 ++
 arch/mips/Kconfig       |  1 +
 arch/mn10300/Kconfig    |  1 +
 arch/openrisc/Kconfig   |  1 +
 arch/parisc/Kconfig     |  1 +
 arch/powerpc/Kconfig    |  1 +
 arch/s390/Kconfig       |  3 ++-
 arch/score/Kconfig      | 21 +++++++++++----------
 arch/sparc/Kconfig      |  1 +
 arch/tile/Kconfig       |  2 ++
 arch/um/Kconfig.common  |  2 ++
 arch/unicore32/Kconfig  |  1 +
 arch/x86/Kconfig        |  1 +
 arch/xtensa/Kconfig     |  2 ++
 init/Kconfig            |  6 ++++++
 29 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b7ff9a3..1cb7426 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -27,6 +27,7 @@ config ALPHA
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
+	select CPU_LITTLE_ENDIAN
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 9596b0a..e939abd 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -35,6 +35,7 @@ config ARC
 	select OF_EARLY_FLATTREE
 	select PERF_USE_VMALLOC
 	select HAVE_DEBUG_STACKOVERFLOW
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 32cbbd5..3a806b3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -12,6 +12,7 @@ config ARM
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT if MMU
 	select CLONE_BACKWARDS
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select GENERIC_ATOMIC64 if (CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI)
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 62b4ae1..c5a91de 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -17,6 +17,7 @@ config ARM64
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index b6878eb..fab44ee 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -17,6 +17,7 @@ config AVR32
 	select GENERIC_CLOCKEVENTS
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
+	select CPU_BIG_ENDIAN
 	help
 	  AVR32 is a high-performance 32-bit RISC microprocessor core,
 	  designed for cost-sensitive embedded applications, with particular
diff --git a/arch/blackfin/Kconfig b/arch/blackfin/Kconfig
index ed30699..348f16d 100644
--- a/arch/blackfin/Kconfig
+++ b/arch/blackfin/Kconfig
@@ -40,6 +40,7 @@ config BLACKFIN
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
+	select CPU_LITTLE_ENDIAN
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index 77ea09b..7e74d14 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -17,6 +17,7 @@ config C6X
 	select OF_EARLY_FLATTREE
 	select GENERIC_CLOCKEVENTS
 	select MODULES_USE_ELF_RELA
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
 config MMU
 	def_bool n
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 52731e2..405a097 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -52,6 +52,7 @@ config CRIS
 	select CLONE_BACKWARDS2
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
+	select CPU_LITTLE_ENDIAN
 
 config HZ
 	int
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 34aa193..aa21ccc 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -14,6 +14,7 @@ config FRV
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select HAVE_DEBUG_STACKOVERFLOW
+	select CPU_BIG_ENDIAN
 
 config ZONE_DMA
 	bool
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 4dc89d1..ee91285 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,7 @@ config HEXAGON
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
 	select HAVE_DMA_ATTRS
+	select CPU_LITTLE_ENDIAN
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index c84c88b..54f32c7 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -49,6 +49,7 @@ config IA64
 	select MODULES_USE_ELF_RELA
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_AUDITSYSCALL
+	select CPU_LITTLE_ENDIAN
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 9e44bbd..1932483 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -16,6 +16,7 @@ config M32R
 	select ARCH_USES_GETTIMEOFFSET
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
+	select CPU_BIG_ENDIAN if !CPU_LITTLE_ENDIAN
 
 config SBUS
 	bool
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 87b7c75..7a7fe25 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -23,6 +23,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select CPU_BIG_ENDIAN
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index 0b389a8..e57c6a0 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -29,6 +29,7 @@ config METAG
 	select OF
 	select OF_EARLY_FLATTREE
 	select SPARSE_IRQ
+	select CPU_LITTLE_ENDIAN
 
 config STACKTRACE_SUPPORT
 	def_bool y
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 40e1c1d..d80ae78 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -7,6 +7,8 @@ config MICROBLAZE
 	select CLKSRC_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
+	select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 900c7e5..671d822 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -52,6 +52,7 @@ config MIPS
 	select HAVE_CC_STACKPROTECTOR
 	select CPU_PM if CPU_IDLE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
 menu "Machine selection"
 
diff --git a/arch/mn10300/Kconfig b/arch/mn10300/Kconfig
index a648de1..60fb249 100644
--- a/arch/mn10300/Kconfig
+++ b/arch/mn10300/Kconfig
@@ -13,6 +13,7 @@ config MN10300
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select HAVE_DEBUG_STACKOVERFLOW
+	select CPU_LITTLE_ENDIAN
 
 config AM33_2
 	def_bool n
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 88e8336..4757b7d 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -23,6 +23,7 @@ config OPENRISC
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
+	select CPU_BIG_ENDIAN
 
 config MMU
 	def_bool y
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 6e75e20..dc82137 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -29,6 +29,7 @@ config PARISC
 	select TTY # Needed for pdc_cons.c
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_ARCH_AUDITSYSCALL
+	select CPU_BIG_ENDIAN
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4bc7b62..644c6d4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -147,6 +147,7 @@ config PPC
 	select ARCH_USE_CMPXCHG_LOCKREF if PPC64
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 05c78bb..8691c6f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -62,6 +62,7 @@ config S390
 	def_bool y
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
+	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
 	select ARCH_INLINE_READ_LOCK_BH
@@ -97,6 +98,7 @@ config S390
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS2
+	select CPU_BIG_ENDIAN
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES if !SMP
 	select GENERIC_FIND_FIRST_BIT
@@ -145,7 +147,6 @@ config S390
 	select TTY
 	select VIRT_CPU_ACCOUNTING
 	select VIRT_TO_BUS
-	select ARCH_HAS_SG_CHAIN
 
 config SCHED_OMIT_FRAME_POINTER
 	def_bool y
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 4ac8cae..713b290 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -1,19 +1,20 @@
 menu "Machine selection"
 
 config SCORE
-       def_bool y
-       select GENERIC_IRQ_SHOW
-       select GENERIC_IOMAP
-       select GENERIC_ATOMIC64
-       select HAVE_MEMBLOCK
-       select HAVE_MEMBLOCK_NODE_MAP
-       select ARCH_DISCARD_MEMBLOCK
-       select GENERIC_CPU_DEVICES
-       select GENERIC_CLOCKEVENTS
-       select HAVE_MOD_ARCH_SPECIFIC
+	def_bool y
+	select GENERIC_IRQ_SHOW
+	select GENERIC_IOMAP
+	select GENERIC_ATOMIC64
+	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
+	select ARCH_DISCARD_MEMBLOCK
+	select GENERIC_CPU_DEVICES
+	select GENERIC_CLOCKEVENTS
+	select HAVE_MOD_ARCH_SPECIFIC
 	select VIRT_TO_BUS
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
+	select CPU_LITTLE_ENDIAN
 
 choice
 	prompt "System type"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a537816..9de09e6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,6 +43,7 @@ config SPARC
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select ARCH_HAS_SG_CHAIN
+	select CPU_BIG_ENDIAN
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 7fcd492..e042479 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -27,6 +27,8 @@ config TILE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_DEBUG_STACKOVERFLOW
 	select ARCH_WANT_FRAME_POINTERS
+	select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
 # FIXME: investigate whether we need/want these options.
 #	select HAVE_IOREMAP_PROT
diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 6915d28..f696ec2 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -8,6 +8,8 @@ config UML
 	select GENERIC_IO
 	select GENERIC_CLOCKEVENTS
 	select TTY # Needed for line.c
+	select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 
 config MMU
 	bool
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 928237a..02be244 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -18,6 +18,7 @@ config UNICORE32
 	select ARCH_WANT_FRAME_POINTERS
 	select GENERIC_IOMAP
 	select MODULES_USE_ELF_REL
+	select CPU_LITTLE_ENDIAN
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1164b7d..9b83e33 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -136,6 +136,7 @@ config X86
 	select HAVE_ACPI_APEI if ACPI
 	select HAVE_ACPI_APEI_NMI if ACPI
 	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
+	select CPU_LITTLE_ENDIAN
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 3a617af..a3e8f7e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -22,6 +22,8 @@ config XTENSA
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_PERF_EVENTS
 	select COMMON_CLK
+	select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
+	select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
diff --git a/init/Kconfig b/init/Kconfig
index 9565224..6dd3b20 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -23,6 +23,12 @@ config CONSTRUCTORS
 config IRQ_WORK
 	bool
 
+config CPU_LITTLE_ENDIAN
+	bool
+
+config CPU_BIG_ENDIAN
+	bool
+
 config BUILDTIME_EXTABLE_SORT
 	bool
 
-- 
1.7.11.7
