Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Dec 2007 18:38:35 +1100
Subject: [PATCH 7/20] [POWERPC] Add early udbg support for 40x processors
Message-Id: <20071213073841.156B8DDFC5@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds some basic real mode based early udbg support for 40x
in order to debug things more easily

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/Kconfig.debug             |   13 +++++++++++
 arch/powerpc/kernel/misc_32.S          |   39 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/udbg.c             |    3 ++
 arch/powerpc/kernel/udbg_16550.c       |   33 +++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |    1 
 include/asm-powerpc/udbg.h             |    1 
 6 files changed, 90 insertions(+)

--- linux-merge.orig/arch/powerpc/Kconfig.debug	2007-12-11 16:30:53.000000000 +1100
+++ linux-merge/arch/powerpc/Kconfig.debug	2007-12-11 16:33:16.000000000 +1100
@@ -227,6 +227,14 @@ config PPC_EARLY_DEBUG_44x
 	  Select this to enable early debugging for IBM 44x chips via the
 	  inbuilt serial port.
 
+config PPC_EARLY_DEBUG_40x
+	bool "Early serial debugging for IBM/AMCC 40x CPUs"
+	depends on 40x
+	help
+	  Select this to enable early debugging for IBM 40x chips via the
+	  inbuilt serial port. This works on chips with a 16550 compatible
+	  UART. Xilinx chips with uartlite cannot use this option.
+
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
 	depends on SERIAL_CPM
@@ -248,6 +256,11 @@ config PPC_EARLY_DEBUG_44x_PHYSHIGH
 	depends on PPC_EARLY_DEBUG_44x
 	default "0x1"
 
+config PPC_EARLY_DEBUG_40x_PHYSADDR
+	hex "Early debug UART physical address"
+	depends on PPC_EARLY_DEBUG_40x
+	default "0xef600300"
+
 config PPC_EARLY_DEBUG_CPM_ADDR
 	hex "CPM UART early debug transmit descriptor address"
 	depends on PPC_EARLY_DEBUG_CPM
Index: linux-merge/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/misc_32.S	2007-12-11 15:07:22.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/misc_32.S	2007-12-11 16:33:16.000000000 +1100
@@ -206,6 +206,45 @@ _GLOBAL(_nmask_and_or_msr)
 	isync
 	blr			/* Done */
 
+#ifdef CONFIG_40x
+
+/*
+ * Do an IO access in real mode
+ */
+_GLOBAL(real_readb)
+	mfmsr	r7
+	ori	r0,r7,MSR_DR
+	xori	r0,r0,MSR_DR
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
+	/*
+ * Do an IO access in real mode
+ */
+_GLOBAL(real_writeb)
+	mfmsr	r7
+	ori	r0,r7,MSR_DR
+	xori	r0,r0,MSR_DR
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
+#endif /* CONFIG_40x */
 
 /*
  * Flush MMU TLB
Index: linux-merge/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/udbg.c	2007-12-11 16:30:53.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/udbg.c	2007-12-11 16:33:16.000000000 +1100
@@ -54,6 +54,9 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_44x)
 	/* PPC44x debug */
 	udbg_init_44x_as1();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_40x)
+	/* PPC40x debug */
+	udbg_init_40x_realmode();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_CPM)
 	udbg_init_cpm();
 #endif
Index: linux-merge/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/udbg_16550.c	2007-12-11 16:30:53.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/udbg_16550.c	2007-12-11 16:33:16.000000000 +1100
@@ -225,3 +225,36 @@ void __init udbg_init_44x_as1(void)
 	udbg_getc = udbg_44x_as1_getc;
 }
 #endif /* CONFIG_PPC_EARLY_DEBUG_44x */
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_40x
+static void udbg_40x_real_putc(char c)
+{
+	if (udbg_comport) {
+		while ((real_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
+			/* wait for idle */;
+		real_writeb(c, &udbg_comport->thr); eieio();
+		if (c == '\n')
+			udbg_40x_real_putc('\r');
+	}
+}
+
+static int udbg_40x_real_getc(void)
+{
+	if (udbg_comport) {
+		while ((real_readb(&udbg_comport->lsr) & LSR_DR) == 0)
+			; /* wait for char */
+		return real_readb(&udbg_comport->rbr);
+	}
+	return -1;
+}
+
+void __init udbg_init_40x_realmode(void)
+{
+	udbg_comport = (struct NS16550 __iomem *)
+		CONFIG_PPC_EARLY_DEBUG_40x_PHYSADDR;
+
+	udbg_putc = udbg_40x_real_putc;
+	udbg_getc = udbg_40x_real_getc;
+	udbg_getc_poll = NULL;
+}
+#endif /* CONFIG_PPC_EARLY_DEBUG_40x */
Index: linux-merge/include/asm-powerpc/udbg.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/udbg.h	2007-10-15 11:19:39.000000000 +1000
+++ linux-merge/include/asm-powerpc/udbg.h	2007-12-11 16:33:16.000000000 +1100
@@ -48,6 +48,7 @@ extern void __init udbg_init_rtas_consol
 extern void __init udbg_init_debug_beat(void);
 extern void __init udbg_init_btext(void);
 extern void __init udbg_init_44x_as1(void);
+extern void __init udbg_init_40x_realmode(void);
 extern void __init udbg_init_cpm(void);
 
 #endif /* __KERNEL__ */
Index: linux-merge/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/Kconfig.cputype	2007-10-25 13:15:47.000000000 +1000
+++ linux-merge/arch/powerpc/platforms/Kconfig.cputype	2007-12-11 16:33:16.000000000 +1100
@@ -43,6 +43,7 @@ config 40x
 	bool "AMCC 40x"
 	select PPC_DCR_NATIVE
 	select WANT_DEVICE_TREE
+	select PPC_UDBG_16550
 
 config 44x
 	bool "AMCC 44x"
