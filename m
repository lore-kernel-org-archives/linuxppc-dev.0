Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Feb 2007 13:22:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [powerpc] Use udbg_early_init() on ppc32
Message-ID: <20070207022208.GB23870@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, please apply

udbg_early_init() is a function used on 64 bit systems, which
initializes whichever early udbg backend is configured.  This function
is not called on 32-bit, however if btext early debug is enabled it
does have an explicit, inline, #ifdef-ed assignment performing
analagous initialization.

This patch makes things more uniform by folding the btext
initialization as an option into udbg_early_init() and calling that
from the 32-bit setup path.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/powerpc/kernel/btext.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/btext.c	2007-01-12 17:11:38.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/btext.c	2007-01-12 17:19:40.000000000 +1100
@@ -372,7 +372,7 @@ static void scrollscreen(void)
 }
 #endif /* ndef NO_SCROLL */
 
-void btext_drawchar(char c)
+static void btext_drawchar(char c)
 {
 	int cline = 0;
 #ifdef NO_SCROLL
@@ -912,3 +912,11 @@ static unsigned char vga_font[cmapsz] = 
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00,
 };
+
+void __init udbg_init_btext(void)
+{
+	/* If btext is enabled, we might have a BAT setup for early display,
+	 * thus we do enable some very basic udbg output
+	 */
+	udbg_putc = btext_drawchar;
+}
Index: working-2.6/arch/powerpc/kernel/setup_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/setup_32.c	2007-01-12 17:11:38.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/setup_32.c	2007-01-12 17:19:40.000000000 +1100
@@ -115,12 +115,8 @@ unsigned long __init early_init(unsigned
  */
 void __init machine_init(unsigned long dt_ptr, unsigned long phys)
 {
-	/* If btext is enabled, we might have a BAT setup for early display,
-	 * thus we do enable some very basic udbg output
-	 */
-#ifdef CONFIG_BOOTX_TEXT
-	udbg_putc = btext_drawchar;
-#endif
+	/* Enable early debugging if any specified (see udbg.h) */
+	udbg_early_init();
 
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
Index: working-2.6/arch/powerpc/kernel/udbg.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/udbg.c	2007-01-12 17:11:38.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/udbg.c	2007-01-12 17:19:40.000000000 +1100
@@ -45,6 +45,8 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
 	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
 	udbg_init_iseries();
+#elif defined(CONFIG_BOOTX_TEXT)
+	udbg_init_btext();
 #endif
 }
 
Index: working-2.6/include/asm-powerpc/udbg.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/udbg.h	2007-01-12 17:11:38.000000000 +1100
+++ working-2.6/include/asm-powerpc/udbg.h	2007-01-12 17:19:40.000000000 +1100
@@ -44,6 +44,7 @@ extern void __init udbg_init_maple_realm
 extern void __init udbg_init_iseries(void);
 extern void __init udbg_init_rtas_panel(void);
 extern void __init udbg_init_rtas_console(void);
+extern void __init udbg_init_btext(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
