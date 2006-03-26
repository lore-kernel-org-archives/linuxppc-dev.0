Return-Path: <mikey@ozlabs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: legacy_serial loop cleanup 
In-reply-to: <20060325180535.0a680b4d.sfr@canb.auug.org.au> 
References: <20060324041727.F131267B56@ozlabs.org>
	<200603241226.13171.hollis@penguinppc.org>
	<20060325044501.D32A267A58@ozlabs.org>
	<20060325180535.0a680b4d.sfr@canb.auug.org.au>
Date: Sun, 26 Mar 2006 10:07:35 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060326000726.719C967A3F@ozlabs.org>
Cc: michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +static void __init setup_legacy_serial_console(int console)
> > +{
> > +	struct legacy_serial_info *info =3D
> > +		&legacy_serial_infos[legacy_serial_console];
> 
> Except that you don't want to do that ^  (assuming you meant "console")
> 
> > +	void __iomem *addr;
> > +
> > +	if (console < 0)
> > +		return;
> 
> before this ^ ...   :-)

Indeed, thanks.  Updated patch below. This time for sure! :-)

Mikey

We only ever execute the loop once, so let's move it to a function
making it more readable.  Cleanup patch, no functional change.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/legacy_serial.c |   38 ++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

Index: linux-2.6-powerpc-merge/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-2.6-powerpc-merge.orig/arch/powerpc/kernel/legacy_serial.c
+++ linux-2.6-powerpc-merge/arch/powerpc/kernel/legacy_serial.c
@@ -236,6 +236,23 @@ static int __init add_legacy_pci_port(st
 }
 #endif
 
+static void __init setup_legacy_serial_console(int console)
+{
+	struct legacy_serial_info *info =
+		&legacy_serial_infos[console];
+	void __iomem *addr;
+
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
@@ -318,25 +335,8 @@ void __init find_legacy_serial_ports(voi
 #endif
 
 	DBG("legacy_serial_console = %d\n", legacy_serial_console);
-
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
+	if (legacy_serial_console >= 0)
+		setup_legacy_serial_console(legacy_serial_console);
 	DBG(" <- find_legacy_serial_port()\n");
 }
 
