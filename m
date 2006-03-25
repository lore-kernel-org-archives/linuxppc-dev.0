Return-Path: <mikey@ozlabs.org>
To: Hollis Blanchard <hollis@penguinppc.org>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: legacy_serial loop cleanup 
In-reply-to: <200603241226.13171.hollis@penguinppc.org> 
References: <20060324041727.F131267B56@ozlabs.org>
	<200603241226.13171.hollis@penguinppc.org>
Date: Sat, 25 Mar 2006 15:45:11 +1100
Sender: mikey@ozlabs.org
Message-Id: <20060325044501.D32A267A58@ozlabs.org>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I don't understand: it's only used once, so make it a function? Why not just 
> change the "while" to an "if"?

Because you can't use a break statements inside an if.  We could you
gotos, but the idea was to increase read ability :-)

> Regardless, two style issues:
> - remove the plain "return"
> - reduce indenting like so:
> 	if (console < 0)
> 		return;
> 	struct legacy_serial_info *info = ...

Agreed.  Updated patch below.

Mikey


We only ever execute the loop once, so let's move it to a function
making it more readable.  Cleanup patch, no functional change.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/legacy_serial.c |   38 ++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

Index: linux-2.6-powerpc-merge/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-2.6-powerpc-merge.orig/arch/powerpc/kernel/legacy_serial.c
+++ linux-2.6-powerpc-merge/arch/powerpc/kernel/legacy_serial.c
@@ -236,6 +236,25 @@ static int __init add_legacy_pci_port(st
 }
 #endif
 
+static void __init setup_legacy_serial_console(int console)
+{
+	struct legacy_serial_info *info =
+		&legacy_serial_infos[legacy_serial_console];
+	void __iomem *addr;
+
+	if (console < 0)
+		return;
+	if (info->taddr == 0)
+		return;
+	addr = ioremap(info->taddr, 0x1000);
+	if (addr == NULL)
+		return;
+	if (info->speed == 0)
+		info->speed = udbg_probe_uart_speed(addr, info->clock);
+	DBG("default console speed = %d\n", info->speed);
+	udbg_init_uart(addr, info->speed, info->clock);
+}
+
 /*
  * This is called very early, as part of setup_system() or eventually
  * setup_arch(), basically before anything else in this file. This function
@@ -319,24 +338,7 @@ void __init find_legacy_serial_ports(voi
 
 	DBG("legacy_serial_console = %d\n", legacy_serial_console);
 
-	/* udbg is 64 bits only for now, that will change soon though ... */
-	while (legacy_serial_console >= 0) {
-		struct legacy_serial_info *info =
-			&legacy_serial_infos[legacy_serial_console];
-		void __iomem *addr;
-
-		if (info->taddr == 0)
-			break;
-		addr = ioremap(info->taddr, 0x1000);
-		if (addr == NULL)
-			break;
-		if (info->speed == 0)
-			info->speed = udbg_probe_uart_speed(addr, info->clock);
-		DBG("default console speed = %d\n", info->speed);
-		udbg_init_uart(addr, info->speed, info->clock);
-		break;
-	}
-
+	setup_legacy_serial_console(legacy_serial_console);
 	DBG(" <- find_legacy_serial_port()\n");
 }
 
