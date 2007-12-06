Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:14 +1100
Subject: [PATCH 15/25] powerpc: early debug forces console log level to max
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080126.1DE11DDF1E@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the early debug option force the console loglevel
to the max. The early debug option is meant to catch messages very
early in the kernel boot process, in many cases, before the kernel
has a chance to parse the "debug" command line argument. Thus it
makes sense when CONFIG_PPC_EARLY_DEBUG is set, to force the console
log level to the max at boot time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/Kconfig.debug |    7 +++++++
 arch/powerpc/kernel/udbg.c |    4 ++++
 2 files changed, 11 insertions(+)

Index: linux-work/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg.c	2007-12-03 12:56:19.000000000 +1100
+++ linux-work/arch/powerpc/kernel/udbg.c	2007-12-03 12:56:43.000000000 +1100
@@ -60,6 +60,10 @@ void __init udbg_early_init(void)
 #elif defined(CONFIG_PPC_EARLY_DEBUG_CPM)
 	udbg_init_cpm();
 #endif
+
+#ifdef CONFIG_PPC_EARLY_DEBUG
+	console_loglevel = 10;
+#endif
 }
 
 /* udbg library, used by xmon et al */
Index: linux-work/arch/powerpc/Kconfig.debug
===================================================================
--- linux-work.orig/arch/powerpc/Kconfig.debug	2007-12-03 12:57:16.000000000 +1100
+++ linux-work/arch/powerpc/Kconfig.debug	2007-12-03 12:58:33.000000000 +1100
@@ -151,6 +151,13 @@ config BOOTX_TEXT
 
 config PPC_EARLY_DEBUG
 	bool "Early debugging (dangerous)"
+	help
+	  Say Y to enable some early debugging facilities that may be available
+	  for your processor/board combination. Those facilities are hacks
+	  intended to debug problems early during boot, this should not be
+	  enabled in a production kernel.
+	  Note that enabling this will also cause the kernel default log level
+	  to be pushed to max automatically very early during boot
 
 choice
 	prompt "Early debugging console"
