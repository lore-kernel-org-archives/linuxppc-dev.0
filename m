Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DCC84DE044
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 21/22] [POWERPC] fsl_soc: add support for fsl_spi
Date: Thu, 13 Sep 2007 16:07:59 -0500
Message-Id: <11897177132273-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1189717711656-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
	<11897177013875-git-send-email-galak@kernel.crashing.org>
	<11897177032288-git-send-email-galak@kernel.crashing.org>
	<11897177042582-git-send-email-galak@kernel.crashing.org>
	<11897177052448-git-send-email-galak@kernel.crashing.org>
	<11897177071168-git-send-email-galak@kernel.crashing.org>
	<11897177091972-git-send-email-galak@kernel.crashing.org>
	<11897177102281-git-send-email-galak@kernel.crashing.org>
	<1189717711656-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>

Add helper function to setup SPI bus/device information

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_soc.c |   87 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h |    7 +++
 2 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 7012e51..d028e8d 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
+#include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
@@ -1199,3 +1200,89 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+int __init fsl_spi_init(struct spi_board_info *board_infos,
+			unsigned int num_board_infos,
+			void (*activate_cs)(u8 cs, u8 polarity),
+			void (*deactivate_cs)(u8 cs, u8 polarity))
+{
+	struct device_node *np;
+	unsigned int i;
+	const u32 *sysclk;
+
+	np = of_find_node_by_type(NULL, "qe");
+	if (!np)
+		return -ENODEV;
+
+	sysclk = of_get_property(np, "bus-frequency", NULL);
+	if (!sysclk)
+		return -ENODEV;
+
+	for (np = NULL, i = 1;
+	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
+	     i++) {
+		int ret = 0;
+		unsigned int j;
+		const void *prop;
+		struct resource res[2];
+		struct platform_device *pdev;
+		struct fsl_spi_platform_data pdata = {
+			.activate_cs = activate_cs,
+			.deactivate_cs = deactivate_cs,
+		};
+
+		memset(res, 0, sizeof(res));
+
+		pdata.sysclk = *sysclk;
+
+		prop = of_get_property(np, "reg", NULL);
+		if (!prop)
+			goto err;
+		pdata.bus_num = *(u32 *)prop;
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
+			goto err;
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
+		ret = platform_device_register(pdev);
+		if (ret)
+			goto unreg;
+
+		continue;
+unreg:
+		platform_device_del(pdev);
+err:
+		continue;
+	}
+
+	return spi_register_board_info(board_infos, num_board_infos);
+}
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..618d91d 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -8,5 +8,12 @@ extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
 
+struct spi_board_info;
+
+extern int fsl_spi_init(struct spi_board_info *board_infos,
+			unsigned int num_board_infos,
+			void (*activate_cs)(u8 cs, u8 polarity),
+			void (*deactivate_cs)(u8 cs, u8 polarity));
+
 #endif
 #endif
-- 
1.5.2.4
