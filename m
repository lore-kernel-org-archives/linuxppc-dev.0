Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74A0E67B54
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 03:39:16 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/7] POWERPC: Add cpm2 stuff support to the fsl_soc.c
Date: Fri, 15 Sep 2006 21:38:57 +0400
Message-Id: <20060915173857.7984.36024.stgit@localhost.localdomain>
In-Reply-To: <20060915213751.128e85f3@localhost.localdomain>
References: <20060915213751.128e85f3@localhost.localdomain>
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


This patch contains necessary modifications to support the CPM2 SoC peripherals.
For the time being, those are fs_enet Ethernet driver and cpm_uart serial.
Written initially to support mpc8560, it also suites to the part of the large PQ2
(more specifically, mpc8260) family.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/sysdev/fsl_soc.c |  268 ++++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_soc.h |    2 
 2 files changed, 265 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 92ba378..c722685 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -3,6 +3,9 @@
  *
  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
  *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -20,14 +23,20 @@ #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/fsl_devices.h>
+#include <linux/fs_enet_pd.h>
+#include <linux/fs_uart_pd.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/time.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 #include <mm/mmu_decl.h>
+#ifdef CONFIG_CPM2
+#include <asm/cpm2.h>
+#endif
 
 static phys_addr_t immrbase = -1;
 
@@ -42,7 +51,9 @@ phys_addr_t get_immrbase(void)
 	if (soc) {
 		unsigned int size;
 		const void *prop = get_property(soc, "reg", &size);
-		immrbase = of_translate_address(soc, prop);
+
+		if (prop)
+			immrbase = of_translate_address(soc, prop);
 		of_node_put(soc);
 	};
 
@@ -51,6 +62,57 @@ phys_addr_t get_immrbase(void)
 
 EXPORT_SYMBOL(get_immrbase);
 
+#ifdef CONFIG_CPM2
+
+static u32 brgfreq = -1;
+
+u32 get_brgfreq(void)
+{
+	struct device_node *node;
+
+	if (brgfreq != -1)
+		return brgfreq;
+
+	node = of_find_node_by_type(NULL, "cpm");
+	if (node) {
+		unsigned int size;
+		unsigned int *prop = (unsigned int*)get_property(node, "brg-frequency", &size);
+
+		if (prop)
+			brgfreq = *prop;
+		of_node_put(node);
+	};
+
+	return brgfreq;
+}
+
+EXPORT_SYMBOL(get_brgfreq);
+
+static u32 fs_baudrate = -1;
+
+u32 get_baudrate(void)
+{
+	struct device_node *node;
+
+	if (fs_baudrate != -1)
+		return fs_baudrate;
+
+	node = of_find_node_by_type(NULL, "serial");
+	if (node) {
+		unsigned int size;
+		unsigned int *prop = (unsigned int*)get_property(node, "current-speed", &size);
+
+		if (prop)
+			fs_baudrate = *prop;
+		of_node_put(node);
+	};
+
+	return fs_baudrate;
+}
+
+EXPORT_SYMBOL(get_baudrate);
+#endif /* CONFIG_CPM2 */
+
 static int __init gfar_mdio_of_init(void)
 {
 	struct device_node *np;
@@ -85,8 +147,11 @@ static int __init gfar_mdio_of_init(void
 			mdio_data.irq[k] = -1;
 
 		while ((child = of_get_next_child(np, child)) != NULL) {
-			const u32 *id = get_property(child, "reg", NULL);
-			mdio_data.irq[*id] = irq_of_parse_and_map(child, 0);
+			int irq = irq_of_parse_and_map(child, 0);
+			if (irq != NO_IRQ) {
+				const u32 *id = get_property(child, "reg", NULL);
+				mdio_data.irq[*id] = irq;
+			}
 		}
 
 		ret =
@@ -128,7 +193,7 @@ static int __init gfar_of_init(void)
 		const char *model;
 		const void *mac_addr;
 		const phandle *ph;
-		int n_res = 1;
+		int n_res = 2;
 
 		memset(r, 0, sizeof(r));
 		memset(&gfar_data, 0, sizeof(gfar_data));
@@ -159,7 +224,7 @@ static int __init gfar_of_init(void)
 
 		gfar_dev =
 		    platform_device_register_simple("fsl-gianfar", i, &r[0],
-						    n_res + 1);
+						    n_res);
 
 		if (IS_ERR(gfar_dev)) {
 			ret = PTR_ERR(gfar_dev);
@@ -478,3 +543,196 @@ err:
 }
 
 arch_initcall(fsl_usb_of_init);
+
+#ifdef CONFIG_CPM2
+
+static const char *fcc_regs = "fcc_regs";
+static const char *fcc_regs_c = "fcc_regs_c";
+static const char *fcc_pram = "fcc_pram";
+static char bus_id[9][BUS_ID_SIZE];
+
+static int __init fs_enet_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *fs_enet_dev;
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
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+		r[0].name = fcc_regs;
+
+		ret = of_address_to_resource(np, 1, &r[1]);
+		if (ret)
+			goto err;
+		r[1].name = fcc_pram;
+
+		ret = of_address_to_resource(np, 2, &r[2]);
+		if (ret)
+			goto err;
+		r[2].name = fcc_regs_c;
+
+		r[3].start = r[3].end = irq_of_parse_and_map(np, 0);
+		r[3].flags = IORESOURCE_IRQ;
+
+		fs_enet_dev =
+		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
+
+		if (IS_ERR(fs_enet_dev)) {
+			ret = PTR_ERR(fs_enet_dev);
+			goto err;
+		}
+
+		model = (char *)get_property(np, "model", NULL);
+		if (model == NULL) {
+			ret = -ENODEV;
+			goto unreg;
+		}
+
+		mac_addr = (void *)get_property(np, "mac-address", NULL);
+		memcpy(fs_enet_data.macaddr, mac_addr, 6);
+
+		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		phy = of_find_node_by_phandle(*ph);
+
+		if (phy == NULL) {
+			ret = -ENODEV;
+			goto unreg;
+		}
+
+		phy_addr = (u32 *) get_property(phy, "reg", NULL);
+		fs_enet_data.phy_addr = *phy_addr;
+
+		id = (u32 *) get_property(np, "device-id", NULL);
+		fs_enet_data.fs_no = *id;
+
+		mdio = of_get_parent(phy);
+                ret = of_address_to_resource(mdio, 0, &res);
+                if (ret) {
+                        of_node_put(phy);
+                        of_node_put(mdio);
+                        goto unreg;
+                }
+
+		if (strstr(model, "FCC")) {
+			int fcc_index = fs_get_fcc_index(*id);
+
+			fs_enet_data.dpram_offset = (u32)cpm2_immr->im_dprambase;
+			fs_enet_data.rx_ring = 32;
+			fs_enet_data.tx_ring = 32;
+			fs_enet_data.rx_copybreak = 240;
+			fs_enet_data.use_napi = 0;
+			fs_enet_data.napi_weight = 17;
+			fs_enet_data.mem_offset = FCC_MEM_OFFSET(fcc_index);
+			fs_enet_data.cp_page = CPM_CR_FCC_PAGE(fcc_index);
+			fs_enet_data.cp_block = CPM_CR_FCC_SBLOCK(fcc_index);
+
+			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
+							(u32)res.start, fs_enet_data.phy_addr);
+			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
+		}
+
+		of_node_put(phy);
+		of_node_put(mdio);
+
+		ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
+					     sizeof(struct
+						    fs_platform_info));
+		if (ret)
+			goto unreg;
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
+static const char *scc_regs = "regs";
+static const char *scc_pram = "pram";
+
+static int __init cpm_uart_of_init(void)
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
+
+		memset(r, 0, sizeof(r));
+		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+
+		r[0].name = scc_regs;
+
+		ret = of_address_to_resource(np, 1, &r[1]);
+		if (ret)
+			goto err;
+		r[1].name = scc_pram;
+
+		r[2].start = r[2].end = irq_of_parse_and_map(np, 0);
+		r[2].flags = IORESOURCE_IRQ;
+
+		cpm_uart_dev =
+		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
+
+		if (IS_ERR(cpm_uart_dev)) {
+			ret = PTR_ERR(cpm_uart_dev);
+			goto err;
+		}
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
+arch_initcall(cpm_uart_of_init);
+#endif /* CONFIG_CPM2 */
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index c433d3f..25230ce 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -3,6 +3,8 @@ #define __PPC_FSL_SOC_H
 #ifdef __KERNEL__
 
 extern phys_addr_t get_immrbase(void);
+extern u32 get_brgfreq(void);
+extern u32 get_baudrate(void);
 
 #endif
 #endif
