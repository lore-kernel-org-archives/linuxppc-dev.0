Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 30796DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 03:47:13 +1100 (EST)
Subject: [PATCH 2/2] MPC8641 HPCN: publish all soc and flash devices
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1201019917.5716.154.camel@rhino>
References: <1201019917.5716.154.camel@rhino>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 09:47:12 -0700
Message-Id: <1201020432.5716.159.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Publish all soc and flash devices from the device tree, similar to what
is done for other boards.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 14f4e52..f266264 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -18,6 +18,7 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -212,6 +213,21 @@ mpc86xx_time_init(void)
 	return 0;
 }
 
+static struct of_device_id mpc86xx_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "cfi-flash", },
+	{},
+};
+
+static int __init mpc86xx_publish_devices(void)
+{
+	of_platform_bus_probe(NULL, mpc86xx_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc86xx_publish_devices);
+
 define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
 	.probe			= mpc86xx_hpcn_probe,
