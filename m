Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id CEDA4DDF76
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 04:29:22 +1000 (EST)
Date: Tue, 1 May 2007 11:32:20 -0700
From: Dave Jiang <djiang@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: publish 85xx soc devices as of_device on cds and ads
Message-ID: <20070501183220.GA6426@blade.az.mvista.com>
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Publish the devices in dts under soc as of_device just like what 
mpc85xx_mds platforms do. 

Signed-off-by: Dave Jiang <djiang@mvista.com>

---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   19 +++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 5d27621..217cc13 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -18,6 +18,8 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -277,6 +279,23 @@ static int __init mpc85xx_ads_probe(void)
         return of_flat_dt_is_compatible(root, "MPC85xxADS");
 }
 
+static struct of_device_id mpc85xx_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{},
+};
+
+static int __init mpc85xx_publish_devices(void)
+{
+	if (!machine_is(mpc85xx_ads))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc85xx_publish_devices);
+
 define_machine(mpc85xx_ads) {
 	.name			= "MPC85xx ADS",
 	.probe			= mpc85xx_ads_probe,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 7e71636..e783d77 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
 
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -296,6 +298,23 @@ static int __init mpc85xx_cds_probe(void)
         return of_flat_dt_is_compatible(root, "MPC85xxCDS");
 }
 
+static struct of_device_id mpc85xx_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{},
+};
+
+static int __init mpc85xx_publish_devices(void)
+{
+	if (!machine_is(mpc85xx_cds))
+		return 0;
+
+	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc85xx_publish_devices);
+
 define_machine(mpc85xx_cds) {
 	.name		= "MPC85xx CDS",
 	.probe		= mpc85xx_cds_probe,
