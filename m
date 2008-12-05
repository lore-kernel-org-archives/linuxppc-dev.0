Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6C2A8DDEFB
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 07:10:40 +1100 (EST)
Date: Fri, 5 Dec 2008 23:10:38 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH 5/7] powerpc/fsl_soc: Isolate legacy fsl_spi support to
	mpc832x_rdb boards
Message-ID: <20081205201038.GE19758@oksana.dev.rtsoft.ru>
References: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205200936.GA19137@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The advantages of this:
- Don't encourage legacy support;
- Less external symbols, less code to compile-in for !MPC832x_RDB
  platforms.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |  107 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.c             |  107 -----------------------------
 arch/powerpc/sysdev/fsl_soc.h             |    4 -
 3 files changed, 107 insertions(+), 111 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 28e23cd..17abbd2 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -20,6 +20,7 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/mmc/host.h>
 #include <linux/of_platform.h>
+#include <linux/fsl_devices.h>
 
 #include <asm/time.h>
 #include <asm/ipic.h>
@@ -39,6 +40,112 @@
 #endif
 
 #ifdef CONFIG_QUICC_ENGINE
+static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
+				   struct spi_board_info *board_infos,
+				   unsigned int num_board_infos,
+				   void (*cs_control)(struct spi_device *dev,
+						      bool on))
+{
+	struct device_node *np;
+	unsigned int i = 0;
+
+	for_each_compatible_node(np, type, compatible) {
+		int ret;
+		unsigned int j;
+		const void *prop;
+		struct resource res[2];
+		struct platform_device *pdev;
+		struct fsl_spi_platform_data pdata = {
+			.cs_control = cs_control,
+		};
+
+		memset(res, 0, sizeof(res));
+
+		pdata.sysclk = sysclk;
+
+		prop = of_get_property(np, "reg", NULL);
+		if (!prop)
+			goto err;
+		pdata.bus_num = *(u32 *)prop;
+
+		prop = of_get_property(np, "cell-index", NULL);
+		if (prop)
+			i = *(u32 *)prop;
+
+		prop = of_get_property(np, "mode", NULL);
+		if (prop && !strcmp(prop, "cpu-qe"))
+			pdata.qe_mode = 1;
+
+		for (j = 0; j < num_board_infos; j++) {
+			if (board_infos[j].bus_num == pdata.bus_num)
+				pdata.max_chipselect++;
+		}
+
+		if (!pdata.max_chipselect)
+			continue;
+
+		ret = of_address_to_resource(np, 0, &res[0]);
+		if (ret)
+			goto err;
+
+		ret = of_irq_to_resource(np, 0, &res[1]);
+		if (ret == NO_IRQ)
+			goto err;
+
+		pdev = platform_device_alloc("mpc83xx_spi", i);
+		if (!pdev)
+			goto err;
+
+		ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
+		if (ret)
+			goto unreg;
+
+		ret = platform_device_add_resources(pdev, res,
+						    ARRAY_SIZE(res));
+		if (ret)
+			goto unreg;
+
+		ret = platform_device_add(pdev);
+		if (ret)
+			goto unreg;
+
+		goto next;
+unreg:
+		platform_device_del(pdev);
+err:
+		pr_err("%s: registration failed\n", np->full_name);
+next:
+		i++;
+	}
+
+	return i;
+}
+
+static int __init fsl_spi_init(struct spi_board_info *board_infos,
+			       unsigned int num_board_infos,
+			       void (*cs_control)(struct spi_device *spi,
+						  bool on))
+{
+	u32 sysclk = -1;
+	int ret;
+
+	/* SPI controller is either clocked from QE or SoC clock */
+	sysclk = get_brgfreq();
+	if (sysclk == -1) {
+		sysclk = fsl_get_sys_freq();
+		if (sysclk == -1)
+			return -ENODEV;
+	}
+
+	ret = of_fsl_spi_probe(NULL, "fsl,spi", sysclk, board_infos,
+			       num_board_infos, cs_control);
+	if (!ret)
+		of_fsl_spi_probe("spi", "fsl_spi", sysclk, board_infos,
+				 num_board_infos, cs_control);
+
+	return spi_register_board_info(board_infos, num_board_infos);
+}
+
 static void mpc83xx_spi_cs_control(struct spi_device *spi, bool on)
 {
 	pr_debug("%s %d %d\n", __func__, spi->chip_select, on);
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index b9da579..727f27b 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -598,113 +598,6 @@ err:
 
 arch_initcall(fsl_usb_of_init);
 
-static int __init of_fsl_spi_probe(char *type, char *compatible, u32 sysclk,
-				   struct spi_board_info *board_infos,
-				   unsigned int num_board_infos,
-				   void (*cs_control)(struct spi_device *dev,
-						      bool on))
-{
-	struct device_node *np;
-	unsigned int i = 0;
-
-	for_each_compatible_node(np, type, compatible) {
-		int ret;
-		unsigned int j;
-		const void *prop;
-		struct resource res[2];
-		struct platform_device *pdev;
-		struct fsl_spi_platform_data pdata = {
-			.cs_control = cs_control,
-		};
-
-		memset(res, 0, sizeof(res));
-
-		pdata.sysclk = sysclk;
-
-		prop = of_get_property(np, "reg", NULL);
-		if (!prop)
-			goto err;
-		pdata.bus_num = *(u32 *)prop;
-
-		prop = of_get_property(np, "cell-index", NULL);
-		if (prop)
-			i = *(u32 *)prop;
-
-		prop = of_get_property(np, "mode", NULL);
-		if (prop && !strcmp(prop, "cpu-qe"))
-			pdata.qe_mode = 1;
-
-		for (j = 0; j < num_board_infos; j++) {
-			if (board_infos[j].bus_num == pdata.bus_num)
-				pdata.max_chipselect++;
-		}
-
-		if (!pdata.max_chipselect)
-			continue;
-
-		ret = of_address_to_resource(np, 0, &res[0]);
-		if (ret)
-			goto err;
-
-		ret = of_irq_to_resource(np, 0, &res[1]);
-		if (ret == NO_IRQ)
-			goto err;
-
-		pdev = platform_device_alloc("mpc83xx_spi", i);
-		if (!pdev)
-			goto err;
-
-		ret = platform_device_add_data(pdev, &pdata, sizeof(pdata));
-		if (ret)
-			goto unreg;
-
-		ret = platform_device_add_resources(pdev, res,
-						    ARRAY_SIZE(res));
-		if (ret)
-			goto unreg;
-
-		ret = platform_device_add(pdev);
-		if (ret)
-			goto unreg;
-
-		goto next;
-unreg:
-		platform_device_del(pdev);
-err:
-		pr_err("%s: registration failed\n", np->full_name);
-next:
-		i++;
-	}
-
-	return i;
-}
-
-int __init fsl_spi_init(struct spi_board_info *board_infos,
-			unsigned int num_board_infos,
-			void (*cs_control)(struct spi_device *spi, bool on))
-{
-	u32 sysclk = -1;
-	int ret;
-
-#ifdef CONFIG_QUICC_ENGINE
-	/* SPI controller is either clocked from QE or SoC clock */
-	sysclk = get_brgfreq();
-#endif
-	if (sysclk == -1) {
-		sysclk = fsl_get_sys_freq();
-		if (sysclk == -1)
-			return -ENODEV;
-	}
-
-	ret = of_fsl_spi_probe(NULL, "fsl,spi", sysclk, board_infos,
-			       num_board_infos, cs_control);
-	if (!ret)
-		of_fsl_spi_probe("spi", "fsl_spi", sysclk, board_infos,
-				 num_board_infos, cs_control);
-
-	return spi_register_board_info(board_infos, num_board_infos);
-}
-
 #if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
 static __be32 __iomem *rstcr;
 
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index b5f3456..42381bb 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -19,10 +19,6 @@ extern u32 fsl_get_sys_freq(void);
 struct spi_board_info;
 struct device_node;
 
-extern int fsl_spi_init(struct spi_board_info *board_infos,
-			unsigned int num_board_infos,
-			void (*cs_control)(struct spi_device *spi, bool on));
-
 extern void fsl_rstcr_restart(char *cmd);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
-- 
1.5.6.5
