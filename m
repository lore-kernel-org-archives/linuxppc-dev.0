Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 7AC70DDEF8
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 19:07:36 +1000 (EST)
Subject: [PATCH 3/6] 82xx: Add the support of Wind River SBC PowerQUICCII 82xx
From: Mark Zhan <rongkai.zhan@windriver.com>
To: "paulus@samba.org" <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 08 Jun 2007 16:54:38 +0800
Message-Id: <1181292878.11341.15.camel@mark>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following problems:

(1) The bus_id fs_enet device should be the same with its associated phy
device bus_id, which is the combination of mdio bus ID and phy_addr,
otherwise fs_enet driver will not be able to attach to its PHY device.
MDIO bus ID is equal to fs_enet platform device ID.

(2) The phy irq map should not be hardcoded. It should match the PHY
address provided by the platform DevTree Blob.

(3) Add the support of CPM2 SMC serial.

Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
---
 b/arch/powerpc/sysdev/fsl_soc.c |   49
++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c
b/arch/powerpc/sysdev/fsl_soc.c
index cad1757..fe40c86 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -689,7 +689,8 @@ static int __init fs_enet_of_init(void)
 			fs_enet_data.cp_block = CPM_CR_FCC_SBLOCK(fcc_index);
 
 			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
-							(u32)res.start, fs_enet_data.phy_addr);
+				fs_enet_dev->id, fs_enet_data.phy_addr);
+
 			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
 			fs_enet_data.init_ioports = init_fcc_ioports;
 
@@ -716,11 +717,9 @@ static int __init fs_enet_of_init(void)
 				fs_enet_mdio_bb_data.delay =
 					mdio_bb_prop[5];
 
-				fs_enet_mdio_bb_data.irq[0] = phy_irq[0];
-				fs_enet_mdio_bb_data.irq[1] = -1;
-				fs_enet_mdio_bb_data.irq[2] = -1;
-				fs_enet_mdio_bb_data.irq[3] = phy_irq[0];
-				fs_enet_mdio_bb_data.irq[31] = -1;
+				memset(fs_enet_mdio_bb_data.irq, -1,
+					sizeof(fs_enet_mdio_bb_data.irq));
+				fs_enet_mdio_bb_data.irq[(*phy_addr)] = phy_irq[0];
 
 				fs_enet_mdio_bb_data.mdio_dat.offset =
 					(u32)&cpm2_immr->im_ioport.iop_pdatc;
@@ -757,8 +756,8 @@ err:
 
 arch_initcall(fs_enet_of_init);
 
-static const char scc_regs[] = "regs";
-static const char scc_pram[] = "pram";
+static const char cpm_uart_regs[] = "regs";
+static const char cpm_uart_pram[] = "pram";
 
 static int __init cpm_uart_of_init(void)
 {
@@ -775,38 +774,42 @@ static int __init cpm_uart_of_init(void)
 		const int *id;
 		const char *model;
 
+		cpm_uart_dev = NULL;
 		memset(r, 0, sizeof(r));
 		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
 
 		ret = of_address_to_resource(np, 0, &r[0]);
 		if (ret)
 			goto err;
-
-		r[0].name = scc_regs;
+		r[0].name = cpm_uart_regs;
 
 		ret = of_address_to_resource(np, 1, &r[1]);
 		if (ret)
 			goto err;
-		r[1].name = scc_pram;
+		r[1].name = cpm_uart_pram;
 
 		of_irq_to_resource(np, 0, &r[2]);
 
-		cpm_uart_dev =
-		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r[0], 3);
-
-		if (IS_ERR(cpm_uart_dev)) {
-			ret = PTR_ERR(cpm_uart_dev);
-			goto err;
-		}
-
 		id = of_get_property(np, "device-id", NULL);
 		cpm_uart_data.fs_no = *id;
 
 		model = of_get_property(np, "model", NULL);
 		strcpy(cpm_uart_data.fs_type, model);
 
-		cpm_uart_data.uart_clk = ppc_proc_freq;
+		if (strstr(model, "SMC")) {
+			cpm_uart_dev = platform_device_register_simple("fsl-cpm-smc:uart",
+							i, &r[0], 3);
+		} else if (strstr(model, "SCC")) {
+			cpm_uart_dev = platform_device_register_simple("fsl-cpm-scc:uart",
+							i, &r[0], 3);
+		}
+
+		if (IS_ERR(cpm_uart_dev)) {
+			ret = PTR_ERR(cpm_uart_dev);
+			goto err;
+		}
 
+		cpm_uart_data.uart_clk = ppc_proc_freq;
 		cpm_uart_data.tx_num_fifo = 4;
 		cpm_uart_data.tx_buf_size = 32;
 		cpm_uart_data.rx_num_fifo = 4;
@@ -816,10 +819,8 @@ static int __init cpm_uart_of_init(void)
 		cpm_uart_data.clk_tx = *((u32 *)of_get_property(np,
 						"tx-clock", NULL));
 
-		ret =
-		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
-					     sizeof(struct
-						    fs_uart_platform_info));
+		ret = platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
+					sizeof(struct fs_uart_platform_info));
 		if (ret)
 			goto unreg;
 	}
