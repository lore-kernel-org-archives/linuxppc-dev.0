Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6BD65DDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 23:56:05 +1000 (EST)
Date: Mon, 29 Sep 2008 17:56:03 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl_soc: remove mpc83xx_wdt code
Message-ID: <20080929135603.GA27252@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc83xx_wdt is the OF driver now, so we don't need fsl_soc constructor.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Just resending the following patch:

http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056253.html

 arch/powerpc/sysdev/fsl_soc.c |   47 -----------------------------------------
 1 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 214388e..eeb0700 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -412,53 +412,6 @@ err:
 
 arch_initcall(gfar_of_init);
 
-
-#ifdef CONFIG_PPC_83xx
-static int __init mpc83xx_wdt_init(void)
-{
-	struct resource r;
-	struct device_node *np;
-	struct platform_device *dev;
-	u32 freq = fsl_get_sys_freq();
-	int ret;
-
-	np = of_find_compatible_node(NULL, "watchdog", "mpc83xx_wdt");
-
-	if (!np) {
-		ret = -ENODEV;
-		goto nodev;
-	}
-
-	memset(&r, 0, sizeof(r));
-
-	ret = of_address_to_resource(np, 0, &r);
-	if (ret)
-		goto err;
-
-	dev = platform_device_register_simple("mpc83xx_wdt", 0, &r, 1);
-	if (IS_ERR(dev)) {
-		ret = PTR_ERR(dev);
-		goto err;
-	}
-
-	ret = platform_device_add_data(dev, &freq, sizeof(freq));
-	if (ret)
-		goto unreg;
-
-	of_node_put(np);
-	return 0;
-
-unreg:
-	platform_device_unregister(dev);
-err:
-	of_node_put(np);
-nodev:
-	return ret;
-}
-
-arch_initcall(mpc83xx_wdt_init);
-#endif
-
 static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 {
 	if (!phy_type)
-- 
1.5.6.3
