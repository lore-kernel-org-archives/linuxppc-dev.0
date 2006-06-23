Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:22 +1000
Subject: [PATCH 7/8] Enable the RTAS udbg console on IBM Cell Blade
Message-Id: <20060623082021.0547867B1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable the RTAS udbg console on IBM Cell Blade, this allows xmon
to work.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig                |    1 +
 arch/powerpc/platforms/cell/setup.c |    4 ++++
 2 files changed, 5 insertions(+)

Index: to-merge/arch/powerpc/Kconfig
===================================================================
--- to-merge.orig/arch/powerpc/Kconfig
+++ to-merge/arch/powerpc/Kconfig
@@ -419,6 +419,7 @@ config PPC_IBM_CELL_BLADE
 	select PPC_RTAS
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
+	select UDBG_RTAS_CONSOLE
 
 config UDBG_RTAS_CONSOLE
 	bool
Index: to-merge/arch/powerpc/platforms/cell/setup.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/cell/setup.c
+++ to-merge/arch/powerpc/platforms/cell/setup.c
@@ -141,6 +141,10 @@ static int __init cell_probe(void)
 	    !of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
 		return 0;
 
+#ifdef CONFIG_UDBG_RTAS_CONSOLE
+	udbg_init_rtas_console();
+#endif
+
 	hpte_init_native();
 
 	return 1;
