Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-40-144.msk.skylink.ru
	[83.217.40.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B56A6800F
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 12:59:54 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 3/5] [POWERPC] 8xx: platform-related changes to the fsl_soc.c
Date: Tue, 14 Nov 2006 04:28:19 +0300
Message-Id: <20061114012819.17455.53319.stgit@localhost.localdomain>
In-Reply-To: <20061114012504.17455.13833.stgit@localhost.localdomain>
References: <20061114012504.17455.13833.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Added 8xx SoC peripherials: fec for Ethernet and smc for UARTs.
Ordinary routines to extract values from the device tree and insert respective
platform devices

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/sysdev/fsl_soc.c |  270 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 269 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ad31e56..61aa8d4 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -39,6 +39,8 @@ #include <asm/cpm2.h>
 
 extern void init_fcc_ioports(struct fs_platform_info*);
 extern void init_scc_ioports(struct fs_uart_platform_info*);
+extern void init_fec_ioports(struct fs_platform_info*);
+extern void init_smc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
 
 phys_addr_t get_immrbase(void)
@@ -63,7 +65,7 @@ phys_addr_t get_immrbase(void)
 
 EXPORT_SYMBOL(get_immrbase);
 
-#ifdef CONFIG_CPM2
+#if defined(CONFIG_CPM2) || defined(CONFIG_8xx)
 
 static u32 brgfreq = -1;
 
@@ -792,3 +794,269 @@ err:
 
 arch_initcall(cpm_uart_of_init);
 #endif /* CONFIG_CPM2 */
+
+#ifdef CONFIG_8xx
+
+static int __init fs_enet_mdio_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *mdio_dev;
+	struct resource res;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "mdio", "fs_enet")) != NULL;
+	     i++) {
+		struct fs_mii_fec_platform_info mdio_data;
+
+		memset(&res, 0, sizeof(res));
+		memset(&mdio_data, 0, sizeof(mdio_data));
+
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret)
+			goto err;
+
+		mdio_dev =
+		    platform_device_register_simple("fsl-cpm-fec-mdio",
+						    res.start, &res, 1);
+		if (IS_ERR(mdio_dev)) {
+			ret = PTR_ERR(mdio_dev);
+			goto err;
+		}
+
+		mdio_data.mii_speed = ((((ppc_proc_freq + 4999999) / 2500000) / 2) & 0x3F) << 1;
+
+		ret =
+		    platform_device_add_data(mdio_dev, &mdio_data,
+					     sizeof(struct fs_mii_fec_platform_info));
+		if (ret)
+			goto unreg;
+	}
+	return 0;
+
+unreg:
+	platform_device_unregister(mdio_dev);
+err:
+	return ret;
+}
+
+arch_initcall(fs_enet_mdio_of_init);
+
+static const char *enet_regs = "regs";
+static const char *enet_pram = "pram";
+static const char *enet_irq = "interrupt";
+static char bus_id[9][BUS_ID_SIZE];
+
+static int __init fs_enet_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *fs_enet_dev = NULL;
+	struct resource res;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "network", "fs_enet")) != NULL;
+	     i++) {
+		struct resource r[4];
+		struct device_node *phy, *mdio;
+		struct fs_platform_info fs_enet_data;
+		unsigned int *id, *phy_addr;
+		void *mac_addr;
+		phandle *ph;
+		char *model;
+
+		memset(r, 0, sizeof(r));
+		memset(&fs_enet_data, 0, sizeof(fs_enet_data));
+
+		model = (char *)get_property(np, "model", NULL);
+		if (model == NULL) {
+			ret = -ENODEV;
+			goto unreg;
+		}
+
+		id = (u32 *) get_property(np, "device-id", NULL);
+		fs_enet_data.fs_no = *id;
+
+		if (platform_device_skip(model, *id))
+			continue;
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+		r[0].name = enet_regs;
+
+		mac_addr = (void *)get_property(np, "mac-address", NULL);
+		memcpy(fs_enet_data.macaddr, mac_addr, 6);
+
+		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		phy = of_find_node_by_phandle(*ph);
+
+		if (phy != NULL) {
+			phy_addr = (u32 *) get_property(phy, "reg", NULL);
+			fs_enet_data.phy_addr = *phy_addr;
+			fs_enet_data.has_phy = 1;
+		}
+
+
+		model = (char*)get_property(np, "model", NULL);
+		strcpy(fs_enet_data.fs_type, model);
+
+		mdio = of_get_parent(phy);
+                ret = of_address_to_resource(mdio, 0, &res);
+                if (ret) {
+                        of_node_put(phy);
+                        of_node_put(mdio);
+                        goto unreg;
+                }
+
+		if (strstr(model, "FEC")) {
+//			int fec_index = fs_get_fec_index(*id);
+			r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
+			r[1].flags = IORESOURCE_IRQ;
+			r[1].name = enet_irq;
+
+			fs_enet_dev =
+				    platform_device_register_simple("fsl-cpm-fec", i, &r[0], 2);
+
+			if (IS_ERR(fs_enet_dev)) {
+				ret = PTR_ERR(fs_enet_dev);
+				goto err;
+			}
+
+			fs_enet_data.rx_ring = 128;
+			fs_enet_data.tx_ring = 16;
+			fs_enet_data.rx_copybreak = 240;
+			fs_enet_data.use_napi = 1;
+			fs_enet_data.napi_weight = 17;
+
+			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
+							(u32)res.start, fs_enet_data.phy_addr);
+			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
+			fs_enet_data.init_ioports = init_fec_ioports;
+		}
+		if (strstr(model, "SCC")) {
+			ret = of_address_to_resource(np, 1, &r[1]);
+			if (ret)
+				goto err;
+			r[1].name = enet_pram;
+
+			r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
+			r[2].flags = IORESOURCE_IRQ;
+			r[2].name = enet_irq;
+
+			fs_enet_dev =
+				    platform_device_register_simple("fsl-cpm-scc", i, &r[0], 3);
+
+			if (IS_ERR(fs_enet_dev)) {
+				ret = PTR_ERR(fs_enet_dev);
+				goto err;
+			}
+
+			fs_enet_data.rx_ring = 64;
+			fs_enet_data.tx_ring = 8;
+			fs_enet_data.rx_copybreak = 240;
+			fs_enet_data.use_napi = 1;
+			fs_enet_data.napi_weight = 17;
+
+			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%s", "fixed@10:1");
+                        fs_enet_data.bus_id = (char*)&bus_id[(*id)];
+			fs_enet_data.init_ioports = init_scc_ioports;
+		}
+
+		of_node_put(phy);
+		of_node_put(mdio);
+
+		ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
+					     sizeof(struct
+						    fs_platform_info));
+		if (ret) {
+			goto unreg;
+		}
+	}
+	return 0;
+
+unreg:
+	platform_device_unregister(fs_enet_dev);
+err:
+	return ret;
+}
+
+arch_initcall(fs_enet_of_init);
+
+
+static const char *smc_regs = "regs";
+static const char *smc_pram = "pram";
+
+static int __init cpm_smc_uart_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *cpm_uart_dev;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "serial", "cpm_uart")) != NULL;
+	     i++) {
+		struct resource r[3];
+		struct fs_uart_platform_info cpm_uart_data;
+		int *id;
+		char *model;
+
+		memset(r, 0, sizeof(r));
+		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+
+		r[0].name = smc_regs;
+
+		ret = of_address_to_resource(np, 1, &r[1]);
+		if (ret)
+			goto err;
+		r[1].name = smc_pram;
+
+		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
+		r[2].flags = IORESOURCE_IRQ;
+
+		cpm_uart_dev =
+		    platform_device_register_simple("fsl-cpm-smc:uart", i, &r[0], 3);
+
+		if (IS_ERR(cpm_uart_dev)) {
+			ret = PTR_ERR(cpm_uart_dev);
+			goto err;
+		}
+
+		model = (char*)get_property(np, "model", NULL);
+		strcpy(cpm_uart_data.fs_type, model);
+
+		id = (int*)get_property(np, "device-id", NULL);
+		cpm_uart_data.fs_no = *id;
+		cpm_uart_data.uart_clk = ppc_proc_freq;
+
+		cpm_uart_data.tx_num_fifo = 4;
+		cpm_uart_data.tx_buf_size = 32;
+		cpm_uart_data.rx_num_fifo = 4;
+		cpm_uart_data.rx_buf_size = 32;
+
+		ret =
+		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
+					     sizeof(struct
+						    fs_uart_platform_info));
+		if (ret)
+			goto unreg;
+	}
+
+	return 0;
+
+unreg:
+	platform_device_unregister(cpm_uart_dev);
+err:
+	return ret;
+}
+
+arch_initcall(cpm_smc_uart_of_init);
+
+#endif /* CONFIG_8xx */
