Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 01 May 2006 10:53:42 +1000
Subject: [RFC/PATCH 1/4] powerpc: Register udbg_console for early debugging
In-Reply-To: <1146444821.660434.518701003988.qpush@concordia>
Message-Id: <20060501005345.03D1667B16@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we have early debugging enabled, then register the udbg console, so we
can use printk rather than udbg_printf.

I'm not sure about the jiggering with console_loglevel, but without it you
need to add "loglevel=8" to the command line, which I think might annoy people.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/udbg.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: to-merge/arch/powerpc/kernel/udbg.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/udbg.c
+++ to-merge/arch/powerpc/kernel/udbg.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/console.h>
+#include <linux/kernel.h>
 #include <asm/processor.h>
 #include <asm/udbg.h>
 
@@ -30,18 +31,23 @@ void __init udbg_early_init(void)
 #if defined(CONFIG_PPC_EARLY_DEBUG_LPAR)
 	/* For LPAR machines that have an HVC console on vterm 0 */
 	udbg_init_debug_lpar();
+	register_early_udbg_console();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_G5)
 	/* For use on Apple G5 machines */
 	udbg_init_pmac_realmode();
+	register_early_udbg_console();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_RTAS)
 	/* RTAS panel debug */
 	udbg_init_rtas();
+	register_early_udbg_console();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_MAPLE)
 	/* Maple real mode debug */
 	udbg_init_maple_realmode();
+	register_early_udbg_console();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
 	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
 	udbg_init_iseries();
+	register_early_udbg_console();
 #endif
 }
 
@@ -141,12 +147,11 @@ static int early_console_initialized;
 
 void __init disable_early_printk(void)
 {
-#if 1
 	if (!early_console_initialized)
 		return;
 	unregister_console(&udbg_console);
+	console_loglevel = default_console_loglevel;
 	early_console_initialized = 0;
-#endif
 }
 
 /* called by setup_system */
@@ -155,6 +160,7 @@ void register_early_udbg_console(void)
 	if (early_console_initialized)
 		return;
 	early_console_initialized = 1;
+	console_loglevel = 8;
 	register_console(&udbg_console);
 }
 
