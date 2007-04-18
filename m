Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 8/10] Early serial debug support for PPC44x
In-Reply-To: <20070418063517.GB29312@localhost.localdomain>
Message-Id: <20070418063626.B0FB2DDE3C@ozlabs.org>
Date: Wed, 18 Apr 2007 16:36:26 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for early serial debugging via the built in
port on IBM/AMCC PowerPC 44x CPUs.  It uses a bolted TLB entry in
address space 1 for the UART's mapping, allowing robust debugging both
before and after the initialization of the MMU.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 arch/powerpc/Kconfig.debug            |   22 ++++++++++++++++++----
 arch/powerpc/kernel/head_44x.S        |   34 +++++++++++++---------------------
 arch/powerpc/kernel/of_platform.c     |    1 -
 arch/powerpc/kernel/udbg.c            |    3 +++
 arch/powerpc/kernel/udbg_16550.c      |   23 +++++++++++++++++++++++
 arch/powerpc/platforms/4xx/44x.h      |    2 ++
 arch/powerpc/platforms/4xx/misc_44x.S |   31 +++++++++++++++++++++++++++++++
 include/asm-powerpc/mmu-44x/mmu.h     |    7 ++++++-
 include/asm-powerpc/udbg.h            |    1 +
 9 files changed, 97 insertions(+), 27 deletions(-)

Index: working-2.6/arch/powerpc/Kconfig.debug
===================================================================
--- working-2.6.orig/arch/powerpc/Kconfig.debug	2007-04-18 14:24:58.000000000 +1000
+++ working-2.6/arch/powerpc/Kconfig.debug	2007-04-18 14:25:13.000000000 +1000
@@ -130,10 +130,6 @@ config BOOTX_TEXT
 	  Say Y here to see progress messages from the boot firmware in text
 	  mode. Requires either BootX or Open Firmware.
 
-config SERIAL_TEXT_DEBUG
-	bool "Support for early boot texts over serial port"
-	depends on 4xx
-
 config PPC_EARLY_DEBUG
 	bool "Early debugging (dangerous)"
 
@@ -198,6 +194,24 @@ config PPC_EARLY_DEBUG_BEAT
 	help
 	  Select this to enable early debugging for Celleb with Beat.
 
+config PPC_EARLY_DEBUG_44x
+	bool "Early serial debugging for IBM/AMCC 44x CPUs"
+	depends on 44x
+	select PPC_UDBG_16550
+	help
+	  Select this to enable early debugging for IBM 44x chips via the
+	  inbuilt serial port.
+
 endchoice
 
+config PPC_EARLY_DEBUG_44x_PHYSLOW
+	hex "Low 32 bits of early debug UART physical address"
+	depends PPC_EARLY_DEBUG_44x
+	default "0x40000200"
+
+config PPC_EARLY_DEBUG_44x_PHYSHIGH
+	hex "EPRN of early debug UART physical address"
+	depends PPC_EARLY_DEBUG_44x
+	default "0x1"
+
 endmenu
Index: working-2.6/arch/powerpc/kernel/head_44x.S
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/head_44x.S	2007-04-18 14:24:59.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/head_44x.S	2007-04-18 14:25:03.000000000 +1000
@@ -172,36 +172,28 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	isync
 
 4:
-#ifdef CONFIG_SERIAL_TEXT_DEBUG
-	/*
-	 * Add temporary UART mapping for early debug.
-	 * We can map UART registers wherever we want as long as they don't
-	 * interfere with other system mappings (e.g. with pinned entries).
-	 * For an example of how we handle this - see ocotea.h.       --ebs
-	 */
+#ifdef CONFIG_PPC_EARLY_DEBUG_44x
+	/* Add UART mapping for early debug. */
+
  	/* pageid fields */
-	lis	r3,UART0_IO_BASE@h
-	ori	r3,r3,PPC44x_TLB_VALID | PPC44x_TLB_4K
+	lis	r3,PPC44x_EARLY_DEBUG_VIRTADDR@h
+	ori	r3,r3,PPC44x_TLB_VALID|PPC44x_TLB_TS|PPC44x_TLB_64K
 
 	/* xlat fields */
-	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
-#ifndef CONFIG_440EP
-	ori	r4,r4,0x0001		/* ERPN is 1 for second 4GB page */
-#endif
+	lis	r4,CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW@h
+	ori	r4,r4,CONFIG_PPC_EARLY_DEBUG_44x_PHYSHIGH
 
 	/* attrib fields */
-	li	r5,0
-	ori	r5,r5,(PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_I | PPC44x_TLB_G)
-
-        li      r0,0                    /* TLB slot 0 */
+	li	r5,(PPC44x_TLB_SW|PPC44x_TLB_SR|PPC44x_TLB_I|PPC44x_TLB_G)
+        li      r0,62                    /* TLB slot 0 */
 
-	tlbwe	r3,r0,PPC44x_TLB_PAGEID	/* Load the pageid fields */
-	tlbwe	r4,r0,PPC44x_TLB_XLAT	/* Load the translation fields */
-	tlbwe	r5,r0,PPC44x_TLB_ATTRIB	/* Load the attrib/access fields */
+	tlbwe	r3,r0,PPC44x_TLB_PAGEID
+	tlbwe	r4,r0,PPC44x_TLB_XLAT
+	tlbwe	r5,r0,PPC44x_TLB_ATTRIB
 
 	/* Force context change */
 	isync
-#endif /* CONFIG_SERIAL_TEXT_DEBUG */
+#endif /* CONFIG_PPC_EARLY_DEBUG_44x */
 
 	/* Establish the interrupt vector offsets */
 	SET_IVOR(0,  CriticalInput);
Index: working-2.6/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/udbg_16550.c	2007-04-16 10:04:20.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/udbg_16550.c	2007-04-18 14:25:03.000000000 +1000
@@ -191,3 +191,26 @@ void udbg_init_pas_realmode(void)
 	udbg_getc_poll = NULL;
 }
 #endif /* CONFIG_PPC_MAPLE */
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_44x
+#include <platforms/4xx/44x.h>
+
+static void udbg_44x_as1_putc(char c)
+{
+	if (udbg_comport) {
+		while ((as1_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
+			/* wait for idle */;
+		as1_writeb(c, &udbg_comport->thr); eieio();
+		if (c == '\n')
+			udbg_44x_as1_putc('\r');
+	}
+}
+
+void __init udbg_init_44x_as1(void)
+{
+	udbg_comport =
+		(volatile struct NS16550 __iomem *)PPC44x_EARLY_DEBUG_VIRTADDR;
+
+	udbg_putc = udbg_44x_as1_putc;
+}
+#endif /* CONFIG_PPC_EARLY_DEBUG_44x */
Index: working-2.6/include/asm-powerpc/mmu-44x/mmu.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu-44x/mmu.h	2007-04-18 14:24:59.000000000 +1000
+++ working-2.6/include/asm-powerpc/mmu-44x/mmu.h	2007-04-18 14:25:03.000000000 +1000
@@ -69,7 +69,12 @@ typedef struct {
 #define PPC44x_PIN_SHIFT	28
 #define PPC_PIN_SIZE		(1 << PPC44x_PIN_SHIFT)
 
+#ifndef CONFIG_PPC_EARLY_DEBUG_44x
 #define PPC44x_EARLY_TLBS	1
+#else
+#define PPC44x_EARLY_TLBS	2
+#define PPC44x_EARLY_DEBUG_VIRTADDR	(ASM_CONST(0xf0000000) \
+	| (ASM_CONST(CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW) & 0xffff))
+#endif
 
 #endif /* _ASM_POWERPC_MMU_44X_MMU_H_ */
-
Index: working-2.6/arch/powerpc/kernel/udbg.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/udbg.c	2007-02-15 10:05:18.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/udbg.c	2007-04-18 14:25:03.000000000 +1000
@@ -51,6 +51,9 @@ void __init udbg_early_init(void)
 	udbg_init_pas_realmode();
 #elif defined(CONFIG_BOOTX_TEXT)
 	udbg_init_btext();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_44x)
+	/* PPC44x debug */
+	udbg_init_44x_as1();
 #endif
 }
 
Index: working-2.6/include/asm-powerpc/udbg.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/udbg.h	2007-02-15 10:05:19.000000000 +1100
+++ working-2.6/include/asm-powerpc/udbg.h	2007-04-18 14:25:03.000000000 +1000
@@ -47,6 +47,7 @@ extern void __init udbg_init_rtas_panel(
 extern void __init udbg_init_rtas_console(void);
 extern void __init udbg_init_debug_beat(void);
 extern void __init udbg_init_btext(void);
+extern void __init udbg_init_44x_as1(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
Index: working-2.6/arch/powerpc/kernel/of_platform.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/of_platform.c	2007-04-18 14:24:58.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/of_platform.c	2007-04-18 14:25:03.000000000 +1000
@@ -29,7 +29,6 @@
 #include <asm/ppc-pci.h>
 #include <asm/atomic.h>
 
-
 /*
  * The list of OF IDs below is used for matching bus types in the
  * system whose devices are to be exposed as of_platform_devices.
Index: working-2.6/arch/powerpc/platforms/4xx/misc_44x.S
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/misc_44x.S	2007-04-18 14:24:59.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/4xx/misc_44x.S	2007-04-18 14:25:03.000000000 +1000
@@ -15,6 +15,37 @@
 	.text
 
 /*
+ * Do an IO access in AS1
+ */
+_GLOBAL(as1_readb)
+	mfmsr	r7
+	ori	r0,r7,MSR_DS
+	sync
+	mtmsr	r0
+	sync
+	isync
+	lbz	r3,0(r3)
+	sync
+	mtmsr	r7
+	sync
+	isync
+	blr
+
+_GLOBAL(as1_writeb)
+	mfmsr	r7
+	ori	r0,r7,MSR_DS
+	sync
+	mtmsr	r0
+	sync
+	isync
+	stb	r3,0(r4)
+	sync
+	mtmsr	r7
+	sync
+	isync
+	blr
+
+/*
  * void ppc44x_reset_system(char *cmd)
  *
  * At present, this routine just applies a system reset.
Index: working-2.6/arch/powerpc/platforms/4xx/44x.h
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/4xx/44x.h	2007-04-18 14:24:59.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/4xx/44x.h	2007-04-18 14:25:03.000000000 +1000
@@ -1,6 +1,8 @@
 #ifndef __POWERPC_PLATFORMS_4XX_44X_H
 #define __POWERPC_PLATFORMS_4XX_44X_H
 
+extern u8 as1_readb(volatile u8 __iomem  *addr);
+extern void as1_writeb(u8 data, volatile u8 __iomem *addr);
 extern void ppc44x_reset_system(char *cmd);
 
 #endif /* __POWERPC_PLATFORMS_4XX_44X_H */
