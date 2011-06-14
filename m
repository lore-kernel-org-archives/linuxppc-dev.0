Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net
	(f.4.b.c.8.c.7.3.d.4.3.3.f.3.9.3.0.0.0.0.a.e.3.0.0.b.8.0.1.0.0.2.ip6.arpa
	[IPv6:2001:8b0:3ea:0:393f:334d:37c8:cb4f])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B45C0B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 05:23:23 +1000 (EST)
Date: Tue, 14 Jun 2011 20:08:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-arch@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Chen Liqin <liqin.chen@sunplusct.com>,
	Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>,
	"David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Helge Deller <deller@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Kyle McMartin <kyle@mcmartin.ca>, Lennox Wu <lennox.wu@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>,
	Mikael Starvik <starvik@axis.com>, Paul Mackerras <paulus@samba.org>,
	Paul Mundt <lethal@linux-sh.org>, Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@twiddle.net>,
	Russell King <linux@arm.linux.org.uk>, sparclinux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
	x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC,PATCH] Cleanup PC parallel port Kconfig
Message-ID: <20110614190850.GA13526@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-sh@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PC parallel port Kconfig as acquired one of those messy terms to
describe it's architecture dependencies:

       depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
               (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN

This isn't just ugly - it also almost certainly describes the dependencies
too coarse grainedly.  This is an attempt at cleaing the mess up.

I tried to faithfully aproximate the old behaviour but the existing
behaviour seems inacurate if not wrong for some architectures or platforms.
To improve on this I rely on comments from other arch and platforms
maintainers.  Any system that can take PCI multi-IO card or has a PC-style
parallel port on the mainboard should probably should now do a
select HAVE_PC_PARPORT.  And some arch Kconfig files should further
restrict the use of HAVE_PC_PARPORT to only those platforms that actually
need it.

Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/alpha/Kconfig      |    1 +
 arch/arm/Kconfig        |    1 +
 arch/cris/Kconfig       |    1 +
 arch/h8300/Kconfig      |    1 +
 arch/ia64/Kconfig       |    1 +
 arch/m68k/Kconfig.mmu   |    1 +
 arch/microblaze/Kconfig |    1 +
 arch/mips/Kconfig       |   16 ++++++++++++++++
 arch/parisc/Kconfig     |    1 +
 arch/powerpc/Kconfig    |    1 +
 arch/score/Kconfig      |    7 ++++---
 arch/sh/Kconfig         |    1 +
 arch/sparc/Kconfig      |    1 +
 arch/tile/Kconfig       |    1 +
 arch/unicore32/Kconfig  |    1 +
 arch/x86/Kconfig        |    1 +
 arch/xtensa/Kconfig     |    1 +
 drivers/parport/Kconfig |    6 ++++--
 18 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 60219bf..2ba8dd7 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -9,6 +9,7 @@ config ALPHA
 	select HAVE_PERF_EVENTS
 	select HAVE_DMA_ATTRS
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_PROBE
 	select AUTO_IRQ_AFFINITY if SMP
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..2968751f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -21,6 +21,7 @@ config ARM
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
 	select HAVE_IRQ_WORK
+	select HAVE_PC_PARPORT
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/cris/Kconfig b/arch/cris/Kconfig
index 17addac..2eda6cf 100644
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -51,6 +51,7 @@ config CRIS
 	default y
 	select HAVE_IDE
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_SHOW
 
 config HZ
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 091ed61..da08646 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -3,6 +3,7 @@ config H8300
 	default y
 	select HAVE_IDE
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_SHOW
 
 config SYMBOL_PREFIX
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 38280ef..849805a 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -23,6 +23,7 @@ config IA64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DMA_API_DEBUG
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select IRQ_PER_CPU
diff --git a/arch/m68k/Kconfig.mmu b/arch/m68k/Kconfig.mmu
index 16539b1..6db5a3e 100644
--- a/arch/m68k/Kconfig.mmu
+++ b/arch/m68k/Kconfig.mmu
@@ -399,6 +399,7 @@ config ISA
 	bool
 	depends on Q40 || AMIGA_PCMCIA
 	default y
+	select PARPORT_PC
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index e446bab..ceac9b5 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -15,6 +15,7 @@ config MICROBLAZE
 	select OF
 	select OF_EARLY_FLATTREE
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 653da62..51170ba 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -39,6 +39,7 @@ config MIPS_ALCHEMY
 	select 64BIT_PHYS_ADDR
 	select CEVT_R4K_LIB
 	select CSRC_R4K_LIB
+	select HAVE_PC_PARPORT
 	select IRQ_CPU
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -127,6 +128,7 @@ config MIPS_COBALT
 	select CSRC_R4K
 	select CEVT_GT641XX
 	select DMA_NONCOHERENT
+	select HAVE_PC_PARPORT
 	select HW_HAS_PCI
 	select I8253
 	select I8259
@@ -185,6 +187,7 @@ config MACH_JAZZ
 	select CSRC_R4K
 	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select GENERIC_ISA_DMA
+	select HAVE_PC_PARPORT
 	select IRQ_CPU
 	select I8253
 	select I8259
@@ -266,6 +269,7 @@ config MIPS_MALTA
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
+	select HAVE_PC_PARPORT
 	select IRQ_CPU
 	select IRQ_GIC
 	select HW_HAS_PCI
@@ -421,6 +425,7 @@ config SGI_IP22
 	select CSRC_R4K
 	select DEFAULT_SGI_PARTITION
 	select DMA_NONCOHERENT
+	select HAVE_PC_PARPORT
 	select HW_HAS_EISA
 	select I8253
 	select I8259
@@ -483,6 +488,7 @@ config SGI_IP28
 	select DEFAULT_SGI_PARTITION
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select HAVE_PC_PARPORT
 	select IRQ_CPU
 	select HW_HAS_EISA
 	select I8253
@@ -517,6 +523,7 @@ config SGI_IP32
 	select CEVT_R4K
 	select CSRC_R4K
 	select DMA_NONCOHERENT
+	select HAVE_PC_PARPORT
 	select HW_HAS_PCI
 	select IRQ_CPU
 	select R5000_CPU_SCACHE
@@ -535,6 +542,7 @@ config SIBYTE_CRHINE
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PC_PARPORT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -546,6 +554,7 @@ config SIBYTE_CARMEL
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PC_PARPORT
 	select SIBYTE_BCM1120
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -557,6 +566,7 @@ config SIBYTE_CRHONE
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PC_PARPORT
 	select SIBYTE_BCM1125
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -569,6 +579,7 @@ config SIBYTE_RHONE
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PC_PARPORT
 	select SIBYTE_BCM1125H
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_SB1
@@ -580,6 +591,7 @@ config SIBYTE_SWARM
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
+	select HAVE_PC_PARPORT
 	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -595,6 +607,7 @@ config SIBYTE_LITTLESUR
 	select BOOT_ELF32
 	select DMA_COHERENT
 	select HAVE_PATA_PLATFORM
+	select HAVE_PC_PARPORT
 	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -608,6 +621,7 @@ config SIBYTE_SENTOSA
 	depends on EXPERIMENTAL
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PC_PARPORT
 	select NR_CPUS_DEFAULT_2
 	select SIBYTE_SB1250
 	select SWAP_IO_SPACE
@@ -619,6 +633,7 @@ config SIBYTE_BIGSUR
 	bool "Sibyte BCM91480B-BigSur"
 	select BOOT_ELF32
 	select DMA_COHERENT
+	select HAVE_PC_PARPORT
 	select NR_CPUS_DEFAULT_4
 	select SIBYTE_BCM1x80
 	select SWAP_IO_SPACE
@@ -640,6 +655,7 @@ config SNI_RM
 	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
+	select HAVE_PC_PARPORT
 	select HW_HAS_EISA
 	select HW_HAS_PCI
 	select IRQ_CPU
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 65adc86..1be72d9 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -13,6 +13,7 @@ config PARISC
 	select HAVE_PERF_EVENTS
 	select GENERIC_ATOMIC64 if !64BIT
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_PROBE
 	select IRQ_PER_CPU
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2729c66..b8328df 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -128,6 +128,7 @@ config PPC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select HAVE_SPARSE_IRQ
 	select IRQ_PER_CPU
 	select GENERIC_IRQ_SHOW
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 288add8..ba078d0 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -1,9 +1,10 @@
 menu "Machine selection"
 
 config SCORE
-       def_bool y
-       select HAVE_GENERIC_HARDIRQS
-       select GENERIC_IRQ_SHOW
+	def_bool y
+	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
+	select GENERIC_IRQ_SHOW
 
 choice
 	prompt "System type"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f03338c..daa65f3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -20,6 +20,7 @@ config SUPERH
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select HAVE_SPARSE_IRQ
 	select IRQ_FORCED_THREADING
 	select RTC_LIB
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 253986b..3679d7c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -520,6 +520,7 @@ config PCI
 	  CONFIG_PCI is needed for all JavaStation's (including MrCoffee),
 	  CP-1200, JavaEngine-1, Corona, Red October, and Serengeti SGSC.
 	  All of these platforms are extremely obscure, so say N if unsure.
+	select HAVE_PC_PARPORT if SPARC64
 
 config PCI_DOMAINS
 	def_bool PCI if SPARC64
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 0249b8b..3e96eff 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -8,6 +8,7 @@ config TILE
 	select USE_GENERIC_SMP_HELPERS
 	select CC_OPTIMIZE_FOR_SIZE
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_IRQ_SHOW
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index e57dcce..3832e7e 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -8,6 +8,7 @@ config UNICORE32
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
+	select HAVE_PC_PARPORT
 	select GENERIC_FIND_FIRST_BIT
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index da34972..750f584 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -70,6 +70,7 @@ config X86
 	select IRQ_FORCED_THREADING
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_BPF_JIT if (X86_64 && NET)
+	select HAVE_PC_PARPORT
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS)
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 5d43c1f..d4c3040 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -8,6 +8,7 @@ config XTENSA
 	def_bool y
 	select HAVE_IDE
 	select HAVE_GENERIC_HARDIRQS
+	select HAVE_PC_PARPORT
 	select GENERIC_IRQ_SHOW
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index d92185a..095a8c7 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -35,8 +35,7 @@ if PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
-		(!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
+	depends on HAVE_PC_PARPORT
 	---help---
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
@@ -48,6 +47,9 @@ config PARPORT_PC
 
 	  If unsure, say Y.
 
+config HAVE_PC_PARPORT
+	bool
+
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
 	depends on SERIAL_8250_PCI && PARPORT_PC && PCI
