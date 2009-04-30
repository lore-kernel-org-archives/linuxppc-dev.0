Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AA299DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 08:27:47 +1000 (EST)
Date: Fri, 1 May 2009 02:27:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl_soc: Remove mpc83xx_wdt_init, again
Message-ID: <20090430222745.GA10985@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 ("gianfar: Convert
gianfar to an of_platform_driver"), possibly due merge issues,
reintroduced completely unneded mpc83xx_wdt_init call, which
I removed some time ago in commit 20d38e01d48019c578ab0ec1464454c0
("powerpc/fsl_soc: remove mpc83xx_wdt code").

Remove it once again.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   46 -----------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index afe8dbc..5c64ccd 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -208,52 +208,6 @@ static int __init of_add_fixed_phys(void)
 arch_initcall(of_add_fixed_phys);
 #endif /* CONFIG_FIXED_PHY */
 
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
1.6.2.2
