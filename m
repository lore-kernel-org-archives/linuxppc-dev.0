Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:16 +1000
Subject: [PATCH 6/8] Add udbg support for RTAS console
Message-Id: <20060623082018.D9E8067A79@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add udbg hooks for the RTAS console, based on the RTAS put-term-char
and get-term-char calls. Along with my previous patches, this should
enable debugging as soon as early_init_dt_scan_rtas() is called.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig       |    4 ++
 arch/powerpc/Kconfig.debug |    9 +++++
 arch/powerpc/kernel/rtas.c |   72 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/udbg.c |    7 +++-
 include/asm-powerpc/udbg.h |    3 +
 5 files changed, 90 insertions(+), 5 deletions(-)

Index: to-merge/arch/powerpc/Kconfig
===================================================================
--- to-merge.orig/arch/powerpc/Kconfig
+++ to-merge/arch/powerpc/Kconfig
@@ -420,6 +420,10 @@ config PPC_IBM_CELL_BLADE
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 
+config UDBG_RTAS_CONSOLE
+	bool
+	default n
+
 config XICS
 	depends on PPC_PSERIES
 	bool
Index: to-merge/arch/powerpc/Kconfig.debug
===================================================================
--- to-merge.orig/arch/powerpc/Kconfig.debug
+++ to-merge/arch/powerpc/Kconfig.debug
@@ -134,12 +134,19 @@ config PPC_EARLY_DEBUG_G5
 	help
 	  Select this to enable early debugging for Apple G5 machines.
 
-config PPC_EARLY_DEBUG_RTAS
+config PPC_EARLY_DEBUG_RTAS_PANEL
 	bool "RTAS Panel"
 	depends on PPC_RTAS
 	help
 	  Select this to enable early debugging via the RTAS panel.
 
+config PPC_EARLY_DEBUG_RTAS_CONSOLE
+	bool "RTAS Console"
+	depends on PPC_RTAS
+	select UDBG_RTAS_CONSOLE
+	help
+	  Select this to enable early debugging via the RTAS console.
+
 config PPC_EARLY_DEBUG_MAPLE
 	bool "Maple real mode"
 	depends on PPC_MAPLE
Index: to-merge/arch/powerpc/kernel/rtas.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/rtas.c
+++ to-merge/arch/powerpc/kernel/rtas.c
@@ -109,11 +109,71 @@ static void call_rtas_display_status_del
 	}
 }
 
-void __init udbg_init_rtas(void)
+void __init udbg_init_rtas_panel(void)
 {
 	udbg_putc = call_rtas_display_status_delay;
 }
 
+#ifdef CONFIG_UDBG_RTAS_CONSOLE
+
+/* If you think you're dying before early_init_dt_scan_rtas() does its
+ * work, you can hard code the token values for your firmware here and
+ * hardcode rtas.base/entry etc.
+ */
+static unsigned int rtas_putchar_token = RTAS_UNKNOWN_SERVICE;
+static unsigned int rtas_getchar_token = RTAS_UNKNOWN_SERVICE;
+
+static void udbg_rtascon_putc(char c)
+{
+	int tries;
+
+	if (!rtas.base)
+		return;
+
+	/* Add CRs before LFs */
+	if (c == '\n')
+		udbg_rtascon_putc('\r');
+
+	/* if there is more than one character to be displayed, wait a bit */
+	for (tries = 0; tries < 16; tries++) {
+		if (rtas_call(rtas_putchar_token, 1, 1, NULL, c) == 0)
+			break;
+		udelay(1000);
+	}
+}
+
+static int udbg_rtascon_getc_poll(void)
+{
+	int c;
+
+	if (!rtas.base)
+		return -1;
+
+	if (rtas_call(rtas_getchar_token, 0, 2, &c))
+		return -1;
+
+	return c;
+}
+
+static int udbg_rtascon_getc(void)
+{
+	int c;
+
+	while ((c = udbg_rtascon_getc_poll()) == -1)
+		;
+
+	return c;
+}
+
+
+void __init udbg_init_rtas_console(void)
+{
+	udbg_putc = udbg_rtascon_putc;
+	udbg_getc = udbg_rtascon_getc;
+	udbg_getc_poll = udbg_rtascon_getc_poll;
+}
+#endif /* CONFIG_UDBG_RTAS_CONSOLE */
+
 void rtas_progress(char *s, unsigned short hex)
 {
 	struct device_node *root;
@@ -820,6 +880,16 @@ int __init early_init_dt_scan_rtas(unsig
 		rtas.size = *sizep;
 	}
 
+#ifdef CONFIG_UDBG_RTAS_CONSOLE
+	basep = of_get_flat_dt_prop(node, "put-term-char", NULL);
+	if (basep)
+		rtas_putchar_token = *basep;
+
+	basep = of_get_flat_dt_prop(node, "get-term-char", NULL);
+	if (basep)
+		rtas_getchar_token = *basep;
+#endif
+
 	/* break now */
 	return 1;
 }
Index: to-merge/arch/powerpc/kernel/udbg.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/udbg.c
+++ to-merge/arch/powerpc/kernel/udbg.c
@@ -34,9 +34,12 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_G5)
 	/* For use on Apple G5 machines */
 	udbg_init_pmac_realmode();
-#elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS)
+#elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL)
 	/* RTAS panel debug */
-	udbg_init_rtas();
+	udbg_init_rtas_panel();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE)
+	/* RTAS console debug */
+	udbg_init_rtas_console();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_MAPLE)
 	/* Maple real mode debug */
 	udbg_init_maple_realmode();
Index: to-merge/include/asm-powerpc/udbg.h
===================================================================
--- to-merge.orig/include/asm-powerpc/udbg.h
+++ to-merge/include/asm-powerpc/udbg.h
@@ -42,7 +42,8 @@ extern void __init udbg_init_debug_lpar(
 extern void __init udbg_init_pmac_realmode(void);
 extern void __init udbg_init_maple_realmode(void);
 extern void __init udbg_init_iseries(void);
-extern void __init udbg_init_rtas(void);
+extern void __init udbg_init_rtas_panel(void);
+extern void __init udbg_init_rtas_console(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
