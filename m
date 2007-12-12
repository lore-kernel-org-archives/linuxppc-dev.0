Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E15FDE2C2
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:36:06 +1100 (EST)
Date: Wed, 12 Dec 2007 11:36:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 4/8] fsl_soc: Factor fsl_get_sys_freq() out of the wdt init.
Message-ID: <20071212173601.GC5596@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071212173519.GA5577@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   44 ++++++++++++++++++++++------------------
 arch/powerpc/sysdev/fsl_soc.h |    1 +
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..e1ba33c 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -66,6 +66,27 @@ phys_addr_t get_immrbase(void)
 
 EXPORT_SYMBOL(get_immrbase);
 
+u32 fsl_get_sys_freq(void)
+{
+	struct device_node *soc = of_find_node_by_type(NULL, "soc");
+	const u32 *freq;
+	u32 ret = 0;
+
+	if (!soc)
+		goto err;
+
+	freq = of_get_property(soc, "bus-frequency", NULL);
+	if (!freq)
+		goto err;
+
+	ret = *freq;
+
+err:
+	of_node_put(soc);
+	return ret;
+}
+EXPORT_SYMBOL(fsl_get_sys_freq);
+
 #if defined(CONFIG_CPM2) || defined(CONFIG_8xx)
 
 static u32 brgfreq = -1;
@@ -450,9 +471,9 @@ arch_initcall(fsl_i2c_of_init);
 static int __init mpc83xx_wdt_init(void)
 {
 	struct resource r;
-	struct device_node *soc, *np;
+	struct device_node *np;
 	struct platform_device *dev;
-	const unsigned int *freq;
+	u32 freq = fsl_get_sys_freq();
 	int ret;
 
 	np = of_find_compatible_node(NULL, "watchdog", "mpc83xx_wdt");
@@ -462,19 +483,6 @@ static int __init mpc83xx_wdt_init(void)
 		goto nodev;
 	}
 
-	soc = of_find_node_by_type(NULL, "soc");
-
-	if (!soc) {
-		ret = -ENODEV;
-		goto nosoc;
-	}
-
-	freq = of_get_property(soc, "bus-frequency", NULL);
-	if (!freq) {
-		ret = -ENODEV;
-		goto err;
-	}
-
 	memset(&r, 0, sizeof(r));
 
 	ret = of_address_to_resource(np, 0, &r);
@@ -487,20 +495,16 @@ static int __init mpc83xx_wdt_init(void)
 		goto err;
 	}
 
-	ret = platform_device_add_data(dev, freq, sizeof(int));
+	ret = platform_device_add_data(dev, &freq, sizeof(int));
 	if (ret)
 		goto unreg;
 
-	of_node_put(soc);
 	of_node_put(np);
-
 	return 0;
 
 unreg:
 	platform_device_unregister(dev);
 err:
-	of_node_put(soc);
-nosoc:
 	of_node_put(np);
 nodev:
 	return ret;
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 63e7db3..74c4a96 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -7,6 +7,7 @@
 extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
+extern u32 fsl_get_sys_freq(void);
 
 struct spi_board_info;
 
-- 
1.5.3.7
