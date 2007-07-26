Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 129E2DDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 08:17:17 +1000 (EST)
Date: Thu, 26 Jul 2007 15:20:21 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org
Subject: [PATCH 1/2] powerpc: publish 85xx soc dts entries as of_device on
	cds and ads platforms
Message-ID: <20070726222021.GA10427@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Publish the devices listed in dts under SOC as of_device just like what
mpc85xx_mds platforms do. The 85xx cds and ads platforms currently do not
export the devices in dts as of_device.

I need the memory controller, L2 cache-controller, and the PCI controller
published as of_device so the mpc85xx EDAC driver can claim them for usage.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---
commit 8a80b43ddd3a4f7694df75869e13c3fc6e6c89f6
tree 772b956da2f4a1a55564519ececaf2e54be32248
parent 46b2835771ad8ef19b8e081e8c90439408c7645f
author Dave Jiang <djiang@mvista.com> Thu, 26 Jul 2007 10:59:00 -0700
committer Dave Jiang <djiang@blade.(none)> Thu, 26 Jul 2007 10:59:00 -0700

 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   19 +++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 40a8286..599d7f7 100644
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
@@ -254,6 +256,23 @@ static int __init mpc85xx_ads_probe(void)
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
index 6a171e9..5294884 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -27,6 +27,8 @@
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
 
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -342,6 +344,23 @@ static int __init mpc85xx_cds_probe(void)
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
