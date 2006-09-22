Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-41-7.msk.skylink.ru [83.217.41.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29D7C67B5C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 13:10:10 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/3] POWERPC: 8272ads merge to powerpc: common stuff
Date: Fri, 22 Sep 2006 06:48:40 +0400
Message-Id: <20060922024840.27185.47684.stgit@localhost.localdomain>
In-Reply-To: <20060922064610.0943f1fc@localhost.localdomain>
References: <20060922064610.0943f1fc@localhost.localdomain>
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


This has modules of common directories related to the
mpc8272ADS board, mainly common cpm2 changes and fsl_soc.c
portions related to the bitbang MDIO and other mechanisms specific
for this family.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/Kconfig           |    1 +
 arch/powerpc/sysdev/cpm2_pic.c |    2 +
 arch/powerpc/sysdev/cpm2_pic.h |    2 +
 arch/powerpc/sysdev/fsl_soc.c  |   68 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index de1ef2f..1810216 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -594,6 +594,7 @@ endmenu
 
 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
+source arch/powerpc/platforms/82xx/Kconfig
 source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/86xx/Kconfig
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 5175299..28b0189 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -147,7 +147,7 @@ static struct irq_chip cpm2_pic = {
 	.end = cpm2_end_irq,
 };
 
-int cpm2_get_irq(struct pt_regs *regs)
+unsigned int cpm2_get_irq(struct pt_regs *regs)
 {
 	int irq;
 	unsigned long bits;
diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/cpm2_pic.h
index d63e45d..3c513e5 100644
--- a/arch/powerpc/sysdev/cpm2_pic.h
+++ b/arch/powerpc/sysdev/cpm2_pic.h
@@ -3,7 +3,7 @@ #define _PPC_KERNEL_CPM2_H
 
 extern intctl_cpm2_t *cpm2_intctl;
 
-extern int cpm2_get_irq(struct pt_regs *regs);
+extern unsigned int cpm2_get_irq(struct pt_regs *regs);
 
 extern void cpm2_pic_init(struct device_node*);
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 022ed27..39b76f9 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -37,6 +37,7 @@ #include <mm/mmu_decl.h>
 #include <asm/cpm2.h>
 
 extern void init_fcc_ioports(struct fs_platform_info*);
+extern void init_scc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
 
 phys_addr_t get_immrbase(void)
@@ -566,7 +567,7 @@ static int __init fs_enet_of_init(void)
 		struct resource r[4];
 		struct device_node *phy, *mdio;
 		struct fs_platform_info fs_enet_data;
-		const unsigned int *id, *phy_addr;
+		const unsigned int *id, *phy_addr, phy_irq;
 		const void *mac_addr;
 		const phandle *ph;
 		const char *model;
@@ -588,6 +589,7 @@ static int __init fs_enet_of_init(void)
 		if (ret)
 			goto err;
 		r[2].name = fcc_regs_c;
+		fs_enet_data.fcc_regs_c = r[2].start;
 
 		r[3].start = r[3].end = irq_of_parse_and_map(np, 0);
 		r[3].flags = IORESOURCE_IRQ;
@@ -620,6 +622,8 @@ static int __init fs_enet_of_init(void)
 		phy_addr = get_property(phy, "reg", NULL);
 		fs_enet_data.phy_addr = *phy_addr;
 
+		phy_irq = get_property(phy, "interrupts", NULL);
+
 		id = get_property(np, "device-id", NULL);
 		fs_enet_data.fs_no = *id;
 		strcpy(fs_enet_data.fs_type, model);
@@ -637,6 +641,7 @@ static int __init fs_enet_of_init(void)
 
 		if (strstr(model, "FCC")) {
 			int fcc_index = *id - 1;
+			unsigned char* mdio_bb_prop;
 
 			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
 			fs_enet_data.rx_ring = 32;
@@ -652,14 +657,63 @@ static int __init fs_enet_of_init(void)
 							(u32)res.start, fs_enet_data.phy_addr);
 			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
 			fs_enet_data.init_ioports = init_fcc_ioports;
-		}
 
-		of_node_put(phy);
-		of_node_put(mdio);
+			mdio_bb_prop = get_property(phy, "bitbang", NULL);
+			if (mdio_bb_prop) {
+			struct platform_device *fs_enet_mdio_bb_dev;
+			struct fs_mii_bb_platform_info fs_enet_mdio_bb_data;
+
+			fs_enet_mdio_bb_dev =
+			platform_device_register_simple("fsl-bb-mdio",
+			i, NULL, 0);
+			memset(&fs_enet_mdio_bb_data, 0,
+			sizeof(struct fs_mii_bb_platform_info));
+				fs_enet_mdio_bb_data.mdio_dat.bit =
+					mdio_bb_prop[0];
+				fs_enet_mdio_bb_data.mdio_dir.bit =
+					mdio_bb_prop[1];
+				fs_enet_mdio_bb_data.mdc_dat.bit =
+					mdio_bb_prop[2];
+				fs_enet_mdio_bb_data.mdio_port =
+					mdio_bb_prop[3];
+				fs_enet_mdio_bb_data.mdc_port =
+					mdio_bb_prop[4];
+				fs_enet_mdio_bb_data.delay =
+					mdio_bb_prop[5];
+
+				fs_enet_mdio_bb_data.irq[0] = phy_irq[0];
+				fs_enet_mdio_bb_data.irq[1] = -1;
+				fs_enet_mdio_bb_data.irq[2] = -1;
+				fs_enet_mdio_bb_data.irq[3] = phy_irq[0];
+				fs_enet_mdio_bb_data.irq[31] = -1;
+
+				fs_enet_mdio_bb_data.mdio_dat.offset =
+					(u32)&cpm2_immr->im_ioport.iop_pdatc;
+				fs_enet_mdio_bb_data.mdio_dir.offset =
+					(u32)&cpm2_immr->im_ioport.iop_pdirc;
+				fs_enet_mdio_bb_data.mdc_dat.offset =
+					(u32)&cpm2_immr->im_ioport.iop_pdatc;
+
+				ret = platform_device_add_data(
+					fs_enet_mdio_bb_dev,
+					&fs_enet_mdio_bb_data,
+					sizeof(struct fs_mii_bb_platform_info));
+				if (ret)
+					goto unreg;
+				} else {
+					printk(KERN_ERR
+					"mii-properties isn't found in device tree\n");
+					ret = -ENODEV;
+					goto unreg;
+				}
+			}
 
-		ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
-					     sizeof(struct
-						    fs_platform_info));
+			of_node_put(phy);
+			of_node_put(mdio);
+
+			ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
+						     sizeof(struct
+							    fs_platform_info));
 		if (ret)
 			goto unreg;
 	}
