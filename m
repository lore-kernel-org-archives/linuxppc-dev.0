Return-Path: <mikey@ozlabs.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Make RTAS console init generic
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 16 Aug 2006 23:12:14 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060817041220.4EB4867B78@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The rtas console doesn't have to be Cell specific.  If we get both
RTAS tokens, we should just enabled the console then and there.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Fixed RTAS dependency bug.

 arch/powerpc/Kconfig                |    3 ++-
 arch/powerpc/kernel/rtas.c          |    5 +++++
 arch/powerpc/platforms/cell/setup.c |    4 ----
 3 files changed, 7 insertions(+), 5 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/Kconfig
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/Kconfig
+++ linux-2.6-ozlabs/arch/powerpc/Kconfig
@@ -426,7 +426,8 @@ config PPC_IBM_CELL_BLADE
 	select UDBG_RTAS_CONSOLE
 
 config UDBG_RTAS_CONSOLE
-	bool
+	bool "RTAS based debug console"
+	depends on PPC_RTAS
 	default n
 
 config XICS
Index: linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/rtas.c
@@ -910,6 +910,11 @@ int __init early_init_dt_scan_rtas(unsig
 	basep = of_get_flat_dt_prop(node, "get-term-char", NULL);
 	if (basep)
 		rtas_getchar_token = *basep;
+
+	if (rtas_putchar_token != RTAS_UNKNOWN_SERVICE &&
+	    rtas_getchar_token != RTAS_UNKNOWN_SERVICE)
+		udbg_init_rtas_console();
+
 #endif
 
 	/* break now */
Index: linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/cell/setup.c
@@ -150,10 +150,6 @@ static int __init cell_probe(void)
 	    !of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
 		return 0;
 
-#ifdef CONFIG_UDBG_RTAS_CONSOLE
-	udbg_init_rtas_console();
-#endif
-
 	hpte_init_native();
 
 	return 1;
