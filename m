Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F323767DBC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 04:32:20 +1000 (EST)
Date: Thu, 28 Jul 2005 11:32:17 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050728183217.GA28126@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: add missing 4xx EMAC sysfs nodes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add missing 4xx EMAC data sysfs nodes.

Sugned-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/include/asm-ppc/ibm_ocp.h b/include/asm-ppc/ibm_ocp.h
--- a/include/asm-ppc/ibm_ocp.h
+++ b/include/asm-ppc/ibm_ocp.h
@@ -71,6 +71,8 @@ struct ocp_func_emac_data {
 
 /* Sysfs support */
 #define OCP_SYSFS_EMAC_DATA()						\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, rgmii_idx)	\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, rgmii_mux)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, zmii_idx)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, zmii_mux)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, mal_idx)	\
@@ -78,9 +80,14 @@ OCP_SYSFS_ADDTL(struct ocp_func_emac_dat
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, mal_tx_chan)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, wol_irq)	\
 OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, mdio_idx)	\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, tah_idx)	\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "%d\n", emac, phy_mode)	\
+OCP_SYSFS_ADDTL(struct ocp_func_emac_data, "0x%08x\n", emac, phy_map)	\
 									\
 void ocp_show_emac_data(struct device *dev)				\
 {									\
+	device_create_file(dev, &dev_attr_emac_rgmii_idx);		\
+	device_create_file(dev, &dev_attr_emac_rgmii_mux);		\
 	device_create_file(dev, &dev_attr_emac_zmii_idx);		\
 	device_create_file(dev, &dev_attr_emac_zmii_mux);		\
 	device_create_file(dev, &dev_attr_emac_mal_idx);		\
@@ -88,6 +95,9 @@ void ocp_show_emac_data(struct device *d
 	device_create_file(dev, &dev_attr_emac_mal_tx_chan);		\
 	device_create_file(dev, &dev_attr_emac_wol_irq);		\
 	device_create_file(dev, &dev_attr_emac_mdio_idx);		\
+	device_create_file(dev, &dev_attr_emac_tah_idx);		\
+	device_create_file(dev, &dev_attr_emac_phy_mode);		\
+	device_create_file(dev, &dev_attr_emac_phy_map);		\
 }
 
 #ifdef CONFIG_40x
@@ -157,7 +167,7 @@ OCP_SYSFS_ADDTL(struct ocp_func_iic_data
 									\
 void ocp_show_iic_data(struct device *dev)				\
 {									\
-	device_create_file(dev, &dev_attr_iic_fast_mode);			\
+	device_create_file(dev, &dev_attr_iic_fast_mode);		\
 }
 #endif /* __IBM_OCP_H__ */
 #endif /* __KERNEL__ */
