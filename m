Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id A34D1DDE9C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 07:17:48 +1100 (EST)
Subject: [PATCH v2 2/2] MPC8641 HPCN: call of_platform_bus_probe()
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1201032819.5716.170.camel@rhino>
References: <1201019917.5716.154.camel@rhino> <1201032819.5716.170.camel@rhino>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 13:17:45 -0700
Message-Id: <1201033065.5716.175.camel@rhino>
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

Call of_platform_bus_probe() on the MPC8641 HPCN, similar to what is
done for other platforms.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---
Updated per Kumar's comments.

 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 14f4e52..510913e 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -18,6 +18,7 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -212,6 +213,19 @@ mpc86xx_time_init(void)
 	return 0;
 }
 
+static struct of_device_id of_bus_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(mpc86xx_hpcn, declare_of_platform_devices);
+
 define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
 	.probe			= mpc86xx_hpcn_probe,
