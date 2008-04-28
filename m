Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 109F7DE49D
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 03:11:56 +1000 (EST)
Subject: [PATCH] sysdev,mv64x60: MV64x60 device bus
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>, Dale Farnsworth <dale@farnsworth.org>
Content-Type: text/plain
Date: Mon, 28 Apr 2008 10:12:09 -0700
Message-Id: <1209402729.14407.2.camel@pcds-ts102.slac.stanford.edu>
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
I did not modify the PRPMC2800 dts file to use that feature because
I cannot test it on that board. I will soon submit a patch to add
support for a board that makes use of this feature. If someone want
to use that feature to register the PRPMC2800 flash you just need
to move the NOR flash declaration in a subcategory whose device_type
field is set to "devicectrl".

 arch/powerpc/sysdev/mv64x60_dev.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 41af122..f335fd5 100644
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
 
+static struct of_device_id of_mv64x60_devices[] = {
+	{ .type = "devicectrl", },
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
