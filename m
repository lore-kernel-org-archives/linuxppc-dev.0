Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Feb 2007 15:54:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [resend] Use udbg_early_init() on ppc32
Message-ID: <20070213045422.GE5345@localhost.localdomain>
References: <20070209030827.GE3489@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070209030827.GE3489@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry, initial version of that patch broke compile on powermac 32-bit.
Here's a fixed version.

[powerpc] Use udbg_early_init() on ppc32

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
--- working-2.6.orig/arch/powerpc/kernel/btext.c	2007-01-24 12:01:17.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/btext.c	2007-02-13 15:53:18.000000000 +1100
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/lmb.h>
 #include <asm/processor.h>
+#include <asm/udbg.h>
 
 #define NO_SCROLL
 
@@ -912,3 +913,11 @@ static unsigned char vga_font[cmapsz] = 
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
--- working-2.6.orig/arch/powerpc/kernel/setup_32.c	2007-02-09 09:57:55.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/setup_32.c	2007-02-13 15:50:54.000000000 +1100
@@ -116,12 +116,8 @@ unsigned long __init early_init(unsigned
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
--- working-2.6.orig/arch/powerpc/kernel/udbg.c	2007-02-09 09:57:55.000000000 +1100
+++ working-2.6/arch/powerpc/kernel/udbg.c	2007-02-13 15:50:54.000000000 +1100
@@ -49,6 +49,8 @@ void __init udbg_early_init(void)
 	udbg_init_debug_beat();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE)
 	udbg_init_pas_realmode();
+#elif defined(CONFIG_BOOTX_TEXT)
+	udbg_init_btext();
 #endif
 }
 
Index: working-2.6/include/asm-powerpc/udbg.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/udbg.h	2007-02-09 09:57:55.000000000 +1100
+++ working-2.6/include/asm-powerpc/udbg.h	2007-02-13 15:50:54.000000000 +1100
@@ -46,6 +46,7 @@ extern void __init udbg_init_iseries(voi
 extern void __init udbg_init_rtas_panel(void);
 extern void __init udbg_init_rtas_console(void);
 extern void __init udbg_init_debug_beat(void);
+extern void __init udbg_init_btext(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
