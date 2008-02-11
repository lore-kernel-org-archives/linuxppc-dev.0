Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id BB9D3DDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 07:59:51 +1100 (EST)
Date: Mon, 11 Feb 2008 13:32:43 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: publish 85xx soc dts entries as of_device 
Message-ID: <20080211203243.GA5331@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

The memory controller, L2 cache-controller, and the PCI controller(s) are
published as of_device so the mpc85xx EDAC driver can claim them for usage.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---
commit 187841bf9dff25e4ac1a7174daa55bb036c724b1
tree 3206ffbbfc5075d195345281f72f7b52f060b41b
parent a99824f327c748b2753f4fa570eb1fefcd6a9c4d
author Dave Jiang <djiang@mvista.com> Mon, 11 Feb 2008 12:51:33 -0700
committer Dave Jiang <djiang@blade.(none)> Mon, 11 Feb 2008 12:51:33 -0700

 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   19 +++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

mpc85xx EDAC driver is in mainline kernel now

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 4e03050..024393c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -26,6 +26,8 @@
 #include <asm/mpic.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -249,6 +251,23 @@ static int __init mpc85xx_ads_probe(void)
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
index 8b1de78..8525882 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -42,6 +42,8 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/i8259.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
@@ -335,6 +337,23 @@ static int __init mpc85xx_cds_probe(void)
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
