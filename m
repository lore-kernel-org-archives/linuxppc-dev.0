Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0AC1FDDEB6
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 23:57:17 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id ADB6C8815
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 18:57:15 +0500 (SAMST)
Date: Thu, 26 Jul 2007 17:56:55 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] fsl_soc: add support for fsl_spi
Message-ID: <20070726135655.GA5643@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
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
 arch/powerpc/sysdev/fsl_soc.c |   76 +++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h |    3 ++
 2 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3289fab..0599851 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1125,3 +1125,79 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+void (*fsl_spi_activate_cs)(u8 cs, u8 polarity) = NULL;
+EXPORT_SYMBOL(fsl_spi_activate_cs);
+void (*fsl_spi_deactivate_cs)(u8 cs, u8 polarity) = NULL;
+EXPORT_SYMBOL(fsl_spi_deactivate_cs);
+
+static int __init fsl_spi_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+
+	for (np = NULL, i = 1;
+	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
+	     i++) {
+		int ret = 0;
+		const char *devid, *sysclk, *mode, *max_cs;
+		struct resource res[2];
+		struct platform_device *pdev = NULL;
+		struct fsl_spi_platform_data pdata = {
+			.activate_cs = fsl_spi_activate_cs,
+			.deactivate_cs = fsl_spi_deactivate_cs,
+		};
+
+		memset(res, 0, sizeof(res));
+
+		devid = of_get_property(np, "device-id", NULL);
+		sysclk = of_get_property(np, "sysclk", NULL);
+		mode = of_get_property(np, "mode", NULL);
+		max_cs = of_get_property(np, "max-chipselect", NULL);
+		if (!devid || !sysclk || !mode || !max_cs)
+			goto err;
+
+		pdata.bus_num = *(u32 *)devid;
+		pdata.sysclk = *(u32 *)sysclk;
+		pdata.max_chipselect = *(u32 *)max_cs;
+		if (!strcmp(mode, "qe"))
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
+		ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
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
+	return 0;
+}
+
+arch_initcall(fsl_spi_of_init);
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..c9de2a2 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -8,5 +8,8 @@ extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
 
+extern void (*fsl_spi_activate_cs)(u8 cs, u8 polarity);
+extern void (*fsl_spi_deactivate_cs)(u8 cs, u8 polarity);
+
 #endif
 #endif
-- 
1.5.0.6
