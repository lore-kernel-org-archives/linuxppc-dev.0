Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id CAB12DDE30
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 03:29:05 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 6 Jun 2007 10:29:01 -0700
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
Message-ID: <20070606172900.GA29951@xyzzy.farnsworth.org>
References: <20070523220518.GA2312@xyzzy.farnsworth.org>
	<18022.20173.857845.49576@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18022.20173.857845.49576@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2007 at 04:06:05PM +1000, Paul Mackerras wrote:
> Dale Farnsworth writes:
> 
> > Paul, this patch is unchanged from the one I posted 10 days ago.
> > At that time, I saw no discussion, other than Mark's ACK.  I'd 
> > argue that this is a bugfix, and hope that it could go into 2.6.22.
> 
> Um, it seems rather large, and in particular adds a fair bit of
> completely new code.  Is there a simpler way of getting to an
> acceptable point - e.g. just not use the udbg console on these boards?

Yeah, that was the first approach I took.  Unfortunately, currently the
udbg console is included unconditionally on arch/powerpc.  I created the
patch below to conditionalize the use of udbg console.  I thought it a
bit risky for 2.6.22, but I think it's the right approach long term.

> If we don't have udbg support for them then the udbg console would
> seem a bit pointless, no?

There is value in that with the udbg console we do see console output
much earlier.  While there's some new code (I didn't think it was all
that much), the impact is limited to the single platform now using the
mv64x60 console port, the prpmc2800.

-Dale

---------------- begin patch ------------------------
[POWERPC] Make the use of the udbg console conditional

Create a new config variable: PPC_UDBG and make the inclusion
of the udbg console dependent on it.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/Kconfig                    |    4 ++++
 arch/powerpc/Kconfig.debug              |    1 +
 arch/powerpc/kernel/Makefile            |    3 ++-
 arch/powerpc/platforms/Kconfig          |    2 ++
 arch/powerpc/platforms/iseries/Kconfig  |    1 +
 arch/powerpc/platforms/powermac/Kconfig |    1 +
 include/asm-powerpc/udbg.h              |    9 +++++++++
 7 files changed, 20 insertions(+), 1 deletion(-)

Index: linux-2.6-powerpc-df/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/Kconfig
@@ -99,9 +99,13 @@ config ARCH_MAY_HAVE_PC_FDC
 config PPC_OF
 	def_bool y
 
+config PPC_UDBG
+	bool
+
 config PPC_UDBG_16550
 	bool
+	select PPC_UDBG
 	default n
 
 config GENERIC_TBSYNC
 	bool
Index: linux-2.6-powerpc-df/arch/powerpc/Kconfig.debug
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/Kconfig.debug
+++ linux-2.6-powerpc-df/arch/powerpc/Kconfig.debug
@@ -135,6 +135,7 @@ config BDI_SWITCH
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
 	depends PPC_OF
+	select PPC_UDBG
 	help
 	  Say Y here to see progress messages from the boot firmware in text
 	  mode. Requires either BootX or Open Firmware.
Index: linux-2.6-powerpc-df/arch/powerpc/kernel/Makefile
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/kernel/Makefile
+++ linux-2.6-powerpc-df/arch/powerpc/kernel/Makefile
@@ -52,7 +52,8 @@ extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
 obj-y				+= time.o prom.o traps.o setup-common.o \
-				   udbg.o misc.o io.o
+				   misc.o io.o
+obj-$(CONFIG_PPC_UDBG)		+= udbg.o
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/Kconfig
@@ -61,6 +61,7 @@ config UDBG_RTAS_CONSOLE
 config PPC_UDBG_BEAT
 	bool "BEAT based debug console"
 	depends on PPC_CELLEB
+	select PPC_UDBG
 	default n
 
 config XICS
@@ -87,6 +88,7 @@ config U3_DART
 
 config PPC_RTAS
 	bool
+	select PPC_UDBG
 	default n
 
 config RTAS_ERROR_LOGGING
Index: linux-2.6-powerpc-df/include/asm-powerpc/udbg.h
===================================================================
--- linux-2.6-powerpc-df.orig/include/asm-powerpc/udbg.h
+++ linux-2.6-powerpc-df/include/asm-powerpc/udbg.h
@@ -11,6 +11,8 @@
 #define _ASM_POWERPC_UDBG_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_PPC_UDBG
+
 #include <linux/compiler.h>
 #include <linux/init.h>
 
@@ -49,5 +51,12 @@ extern void __init udbg_init_debug_beat(
 extern void __init udbg_init_btext(void);
 extern void __init udbg_init_44x_as1(void);
 
+#else
+
+#define udbg_early_init()
+#define register_early_udbg_console()
+
+#endif /* CONFIG_PPC_UDBG */
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/iseries/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/iseries/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/iseries/Kconfig
@@ -2,6 +2,7 @@ config PPC_ISERIES
 	bool "IBM Legacy iSeries"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_INDIRECT_IO
+	select PPC_UDBG
 
 menu "iSeries device drivers"
 	depends on PPC_ISERIES
Index: linux-2.6-powerpc-df/arch/powerpc/platforms/powermac/Kconfig
===================================================================
--- linux-2.6-powerpc-df.orig/arch/powerpc/platforms/powermac/Kconfig
+++ linux-2.6-powerpc-df/arch/powerpc/platforms/powermac/Kconfig
@@ -5,6 +5,7 @@ config PPC_PMAC
 	select PPC_INDIRECT_PCI if PPC32
 	select PPC_MPC106 if PPC32
 	select PPC_NATIVE
+	select PPC_UDBG
 	default y
 
 config PPC_PMAC64
