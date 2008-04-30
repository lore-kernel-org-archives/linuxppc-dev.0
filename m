Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87BD5DE060
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 02:47:06 +1000 (EST)
Subject: [PATCH v4] sysdev,mv64x60: MV64x60 device bus
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 09:47:16 -0700
Message-Id: <1209574037.14407.57.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For each mv64360 entry in the OpenFirmware database, add the 
registration of an of_bus to take care of devices connected to
the MV64x60 asynchronous devices controller.
This change makes it possible for those devices to be detected by 
drivers that support the of_platform without having a custom call 
for each of them in the board file.

Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)
---
Changes:
v2: Use the compatible field to detect devices to register (on Dale Farnsworth
suggestion).
v3: Added __initdata to variable of_mv64x60_devices (thanks to Stephen Rothwell 
for pointing that out).
v4: Re-wrote the patch description.

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
