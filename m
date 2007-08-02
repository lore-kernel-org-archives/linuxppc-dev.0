Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2DF0EDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 03:37:07 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 5A4478810
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 22:37:06 +0500 (SAMST)
Date: Thu, 2 Aug 2007 21:35:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/2] [RFC][POWERPC] fsl_soc: add support for fsl_spi
Message-ID: <20070802173556.GB25643@localhost.localdomain>
References: <20070802173335.GA25369@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070802173335.GA25369@localhost.localdomain>
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
 arch/powerpc/sysdev/fsl_soc.c |  109 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h |   12 +++++
 2 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 727453d..8c0576d 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -23,6 +23,7 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
@@ -1186,3 +1187,111 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+static int fsl_spi_get_max_chipselect(struct device_node *spi_node,
+				      struct fsl_spi_board_info *binfo,
+				      s16 bus_num)
+{
+	struct device_node *child = NULL;
+	unsigned int i = 0;
+	unsigned int dt_num_children = 0;
+	unsigned int bi_num_children = 0;
+
+	while ((child = of_get_next_child(spi_node, child)))
+		dt_num_children++;
+
+	for (; i < binfo->num_board_infos; i++) {
+		if (binfo->board_infos[i].bus_num == bus_num)
+			bi_num_children++;
+	}
+
+	if (dt_num_children != bi_num_children) {
+		printk(KERN_WARNING "%s: board file and device tree are "
+		       "disagreeing about max chipselects: %d vs %d\n",
+		       __func__, bi_num_children, dt_num_children);
+	}
+
+	return max(dt_num_children, bi_num_children);
+}
+
+int fsl_spi_init(struct fsl_spi_board_info *binfo)
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
+		const char *devid;
+		const char *mode;
+		struct resource res[2];
+		struct platform_device *pdev = NULL;
+		struct fsl_spi_platform_data pdata = {
+			.activate_cs = binfo->activate_cs,
+			.deactivate_cs = binfo->deactivate_cs,
+		};
+
+		memset(res, 0, sizeof(res));
+
+		devid = of_get_property(np, "fsl,device-id", NULL);
+		mode = of_get_property(np, "mode", NULL);
+		if (!devid || !mode)
+			goto err;
+
+		pdata.sysclk = sysclk;
+		pdata.bus_num = *(u32 *)devid;
+		pdata.max_chipselect = fsl_spi_get_max_chipselect(np, binfo,
+							pdata.bus_num);
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
+	return spi_register_board_info(binfo->board_infos,
+				       binfo->num_board_infos);
+}
+EXPORT_SYMBOL(fsl_spi_init);
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..a83998d 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -8,5 +8,17 @@ extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
 
+struct spi_board_info;
+
+struct fsl_spi_board_info {
+	struct spi_board_info *board_infos;
+	unsigned int num_board_infos;
+
+	void (*activate_cs)(u8 cs, u8 polarity);
+	void (*deactivate_cs)(u8 cs, u8 polarity);
+};
+
+extern int fsl_spi_init(struct fsl_spi_board_info *info);
+
 #endif
 #endif
-- 
1.5.0.6
