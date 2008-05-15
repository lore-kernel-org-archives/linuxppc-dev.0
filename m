Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 56E27DE6B4
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:54:05 +1000 (EST)
Date: Thu, 15 May 2008 20:54:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 7/8] [POWERPC] fsl_soc: remove mpc83xx_wdt code
Message-ID: <20080515165404.GG3887@polina.dev.rtsoft.ru>
References: <20080515165250.GA30738@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080515165250.GA30738@polina.dev.rtsoft.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Chen Gong <G.Chen@freescale.com>, Scott Wood <scottwood@freescale.com>,
	Timur Tabi <timur@freescale.com>
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
 arch/powerpc/sysdev/fsl_soc.c |   46 -----------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a5ceeef..32a3ac8 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -545,52 +545,6 @@ err:
 arch_initcall(fsl_i2c_of_init);
 #endif
 
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
1.5.5.1
