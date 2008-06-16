Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 5A566DDE18
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 08:36:19 +1000 (EST)
Date: Mon, 16 Jun 2008 15:36:17 -0700
From: Dave Jiang <djiang@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2] 85xx: publish of device for cds platforms
Message-ID: <20080616223617.GA23646@blade.az.mvista.com>
References: <20080616213134.GA22354@blade.az.mvista.com>
	<4856DCD1.50402@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4856DCD1.50402@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Publish the devices listed in dts under SOC as of_device for 85xx_cds
platform. The devices are needed by the 85xx EDAC driver.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

Added "simple bus" per Scott Wood

 mrch/powerpc/platforms/85xx/pc85xx_cds.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)


Index: 2.6.26-rc5-mm3/arch/powerpc/platforms/85xx/mpc85xx_cds.c
===================================================================
--- 2.6.26-rc5-mm3.orig/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ 2.6.26-rc5-mm3/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -335,6 +336,20 @@ static int __init mpc85xx_cds_probe(void
         return of_flat_dt_is_compatible(root, "MPC85xxCDS");
 }
 
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	return of_platform_bus_probe(NULL, of_bus_ids, NULL);
+}
+machine_device_initcall(mpc85xx_cds, declare_of_platform_devices);
+
+
 define_machine(mpc85xx_cds) {
 	.name		= "MPC85xx CDS",
 	.probe		= mpc85xx_cds_probe,
