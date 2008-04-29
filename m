Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AEAB8DF08B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 06:26:35 +1000 (EST)
Subject: [PATCH v3] sysdev,mv64x60: MV64x60 device bus
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>, Dale Farnsworth <dale@farnsworth.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 29 Apr 2008 13:26:38 -0700
Message-Id: <1209500798.14407.32.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Follow up of my email of 4/16/2008 titled "MV64x60 device bus".
For each mv64360 entry in the OpenFirmware database, add the 
registration of an of_bus to take care of devices connected to
the MV64x60 asynchronous devices controller.

Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)
---
Use the compatible field to detect devices to register (on Dale Farnsworth
suggestion).
Added __initdata to variable of_mv64x60_devices (thanks to Stephen Rothwell 
for pointing that out).

 arch/powerpc/sysdev/mv64x60_dev.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 41af122..c38695e 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -15,6 +15,7 @@
 #include <linux/console.h>
 #include <linux/mv643xx.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 
 #include <asm/prom.h>
 
@@ -25,6 +26,11 @@
  * PowerPC of_platform_bus_type.  They support platform_bus_type instead.
  */
 
+static struct of_device_id __initdata of_mv64x60_devices[] = {
+	{ .compatible = "marvell,mv64306-devctrl", },
+	{}
+};
+
 /*
  * Create MPSC platform devices
  */
@@ -482,6 +488,10 @@ static int __init mv64x60_device_setup(void)
 		of_node_put(np);
 	}
 
+	/* Now add every node that is on the device bus (type is devicectrl */
+	for_each_compatible_node(np, NULL, "marvell,mv64360")
+		of_platform_bus_probe(np, of_mv64x60_devices, NULL);
+
 	return 0;
 }
 arch_initcall(mv64x60_device_setup);
