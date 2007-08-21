Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E63D3DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 23:46:43 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 67CB78814
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 18:46:42 +0500 (SAMST)
Date: Tue, 21 Aug 2007 17:47:03 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 1/2] [POWERPC] fsl_soc: add support for fsl_spi
Message-ID: <20070821134703.GA13308@localhost.localdomain>
References: <20070821134537.GA7428@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070821134537.GA7428@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   85 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h |    7 +++
 2 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 1cf29c9..25a96b5 100644
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
@@ -1187,3 +1188,87 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+int fsl_spi_init(struct spi_board_info *board_infos,
+		 unsigned int num_board_infos,
+		 void (*activate_cs)(u8 cs, u8 polarity),
+		 void (*deactivate_cs)(u8 cs, u8 polarity))
+{
+	struct device_node *np;
+	unsigned int i;
+	u32 sysclk;
+
+	np = of_find_node_by_type(NULL, "qe");
+	if (!np)
+		return -ENODEV;
+
+	sysclk = *(u32 *)of_get_property(np, "bus-frequency", NULL);
+
+	for (np = NULL, i = 1;
+	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
+	     i++) {
+		int ret = 0;
+		unsigned int j;
+		const char *mode;
+		struct resource res[2];
+		struct platform_device *pdev = NULL;
+		struct fsl_spi_platform_data pdata = {
+			.activate_cs = activate_cs,
+			.deactivate_cs = deactivate_cs,
+		};
+
+		memset(res, 0, sizeof(res));
+
+		mode = of_get_property(np, "mode", NULL);
+		pdata.sysclk = sysclk;
+		pdata.bus_num = *(u32 *)of_get_property(np, "reg", NULL);
+
+		for (j = 0; j < num_board_infos; j++) {
+			if (board_infos[j].bus_num == pdata.bus_num)
+				pdata.max_chipselect++;
+		}
+
+		if (!pdata.max_chipselect)
+			goto err;
+
+		if (!strcmp(mode, "cpu-qe"))
+			pdata.qe_mode = 1;
+
+		ret = of_address_to_resource(np, 0, &res[0]);
+		if (ret)
+			goto err;
+
+		res[1].start = res[2].end = irq_of_parse_and_map(np, 0);
+		if (res[1].start == NO_IRQ)
+			goto err;
+
+		res[1].name = "mpc83xx_spi";
+		res[1].flags = IORESOURCE_IRQ;;
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
+EXPORT_SYMBOL(fsl_spi_init);
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
1.5.0.6
