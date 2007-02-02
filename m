Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E50E4DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:16 +1100 (EST)
Message-Id: <20070202045507.851600000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:50 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [2/9] pasemi: UART udbg support
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Early debug output for PA Semi UART. Uses the 2.05 CI real mode ops.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/kernel/udbg_16550.c
===================================================================
--- merge.orig/arch/powerpc/kernel/udbg_16550.c
+++ merge/arch/powerpc/kernel/udbg_16550.c
@@ -14,6 +14,8 @@
 
 extern u8 real_readb(volatile u8 __iomem  *addr);
 extern void real_writeb(u8 data, volatile u8 __iomem *addr);
+extern u8 real_205_readb(volatile u8 __iomem  *addr);
+extern void real_205_writeb(u8 data, volatile u8 __iomem *addr);
 
 struct NS16550 {
 	/* this struct must be packed */
@@ -167,3 +169,25 @@ void __init udbg_init_maple_realmode(voi
 	udbg_getc_poll = NULL;
 }
 #endif /* CONFIG_PPC_MAPLE */
+
+#ifdef CONFIG_PPC_PASEMI
+void udbg_pas_real_putc(char c)
+{
+	if (udbg_comport) {
+		while ((real_205_readb(&udbg_comport->lsr) & LSR_THRE) == 0)
+			/* wait for idle */;
+		real_205_writeb(c, &udbg_comport->thr); eieio();
+		if (c == '\n')
+			udbg_pas_real_putc('\r');
+	}
+}
+
+void udbg_init_pas_realmode(void)
+{
+	udbg_comport = (volatile struct NS16550 __iomem *)0xfcff03f8;
+
+	udbg_putc = udbg_pas_real_putc;
+	udbg_getc = NULL;
+	udbg_getc_poll = NULL;
+}
+#endif /* CONFIG_PPC_MAPLE */
Index: merge/arch/powerpc/Kconfig.debug
===================================================================
--- merge.orig/arch/powerpc/Kconfig.debug
+++ merge/arch/powerpc/Kconfig.debug
@@ -185,6 +185,13 @@ config PPC_EARLY_DEBUG_ISERIES
 	  Select this to enable early debugging for legacy iSeries. You need
 	  to hit "Ctrl-x Ctrl-x" to see the messages on the console.
 
+config PPC_EARLY_DEBUG_PAS_REALMODE
+	bool "PA Semi real mode"
+	depends on PPC_PASEMI
+	help
+	  Select this to enable early debugging for PA Semi.
+	  Output will be on UART0.
+
 endchoice
 
 endmenu
Index: merge/arch/powerpc/kernel/udbg.c
===================================================================
--- merge.orig/arch/powerpc/kernel/udbg.c
+++ merge/arch/powerpc/kernel/udbg.c
@@ -45,6 +45,8 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
 	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
 	udbg_init_iseries();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE)
+	udbg_init_pas_realmode();
 #endif
 }
 
Index: merge/arch/powerpc/kernel/misc_64.S
===================================================================
--- merge.orig/arch/powerpc/kernel/misc_64.S
+++ merge/arch/powerpc/kernel/misc_64.S
@@ -311,6 +311,46 @@ _GLOBAL(real_writeb)
 	blr
 #endif /* defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE) */
 
+#ifdef CONFIG_PPC_PASEMI
+
+/* No support in all binutils for these yet, so use defines */
+#define LBZCIX(RT,RA,RB)  .long (0x7c0006aa|(RT<<21)|(RA<<16)|(RB << 11))
+#define STBCIX(RS,RA,RB)  .long (0x7c0007aa|(RS<<21)|(RA<<16)|(RB << 11))
+
+
+_GLOBAL(real_205_readb)
+	mfmsr	r7
+	ori	r0,r7,MSR_DR
+	xori	r0,r0,MSR_DR
+	sync
+	mtmsrd	r0
+	sync
+	isync
+	LBZCIX(r3,0,r3)
+	isync
+	mtmsrd	r7
+	sync
+	isync
+	blr
+
+_GLOBAL(real_205_writeb)
+	mfmsr	r7
+	ori	r0,r7,MSR_DR
+	xori	r0,r0,MSR_DR
+	sync
+	mtmsrd	r0
+	sync
+	isync
+	STBCIX(r3,0,r4)
+	isync
+	mtmsrd	r7
+	sync
+	isync
+	blr
+
+#endif /* CONFIG_PPC_PASEMI */
+
+
 #ifdef CONFIG_CPU_FREQ_PMAC64
 /*
  * SCOM access functions for 970 (FX only for now)
Index: merge/include/asm-powerpc/udbg.h
===================================================================
--- merge.orig/include/asm-powerpc/udbg.h
+++ merge/include/asm-powerpc/udbg.h
@@ -41,6 +41,7 @@ extern void __init udbg_early_init(void)
 extern void __init udbg_init_debug_lpar(void);
 extern void __init udbg_init_pmac_realmode(void);
 extern void __init udbg_init_maple_realmode(void);
+extern void __init udbg_init_pas_realmode(void);
 extern void __init udbg_init_iseries(void);
 extern void __init udbg_init_rtas_panel(void);
 extern void __init udbg_init_rtas_console(void);

--
