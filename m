Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:56 +1100
Subject: [PATCH 15/24] powerpc: early debug forces console log level to max
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061200.4BAF9DDFAE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
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

 arch/powerpc/kernel/udbg.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-work/arch/powerpc/kernel/udbg.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/udbg.c	2007-11-30 13:29:51.000000000 +1100
+++ linux-work/arch/powerpc/kernel/udbg.c	2007-11-30 13:29:56.000000000 +1100
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
