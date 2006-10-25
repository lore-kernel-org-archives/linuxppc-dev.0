Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 25 Oct 2006 20:28:13 +1000
Subject: [RFC/PATCH] Maple: Use RTAS power off methods if available
Message-Id: <20061025102823.CF83667BBC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some versions of SLOF have the RTAS power-off/restart methods
implemented, if they're available they should be used in preference
to the nvram based methods.

Not sure what the best way to do this is, this is the easy approach
although it leaves the system unrebootable until the callbacks get
rewired. The other option would be to do the check in maple_restart
etc. when they're called.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/Kconfig                 |    1 +
 arch/powerpc/platforms/maple/setup.c |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

Index: powerpc/arch/powerpc/Kconfig
===================================================================
--- powerpc.orig/arch/powerpc/Kconfig
+++ powerpc/arch/powerpc/Kconfig
@@ -422,6 +422,7 @@ config PPC_MAPLE
 	select GENERIC_TBSYNC
 	select PPC_UDBG_16550
 	select PPC_970_NAP
+	select PPC_RTAS
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
Index: powerpc/arch/powerpc/platforms/maple/setup.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/maple/setup.c
+++ powerpc/arch/powerpc/platforms/maple/setup.c
@@ -61,6 +61,7 @@
 #include <asm/lmb.h>
 #include <asm/mpic.h>
 #include <asm/udbg.h>
+#include <asm/rtas.h>
 
 #include "maple.h"
 
@@ -185,6 +186,26 @@ void __init maple_setup_arch(void)
 	printk(KERN_DEBUG "Using native/NAP idle loop\n");
 }
 
+static void __init maple_check_for_rtas_poweroff(void)
+{
+#ifdef CONFIG_PPC_RTAS
+	struct device_node *rtas;
+
+	rtas = of_find_node_by_path("/rtas");
+	if (rtas) {
+		if (get_property(rtas, "system-reboot", NULL))
+			ppc_md.restart = rtas_restart;
+
+		if (get_property(rtas, "power-off", NULL)) {
+			ppc_md.power_off = rtas_power_off;
+			ppc_md.halt = rtas_halt;
+		}
+
+		of_node_put(rtas);
+	}
+#endif
+}
+
 /* 
  * Early initialization.
  */
@@ -192,6 +213,8 @@ static void __init maple_init_early(void
 {
 	DBG(" -> maple_init_early\n");
 
+	maple_check_for_rtas_poweroff();
+
 	iommu_init_early_dart();
 
 	DBG(" <- maple_init_early\n");
