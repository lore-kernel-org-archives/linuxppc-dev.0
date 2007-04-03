Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 62D4BDE001
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:39 +1000 (EST)
Date: Tue, 3 Apr 2007 22:43:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 12/17] [POWERPC] Rename get_property to of_get_property:
	drivers/net
Message-Id: <20070403224340.5533abc9.sfr@canb.auug.org.au>
In-Reply-To: <20070403224205.807cffe0.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/bmac.c           |    5 +++--
 drivers/net/ehea/ehea_main.c |    4 ++--
 drivers/net/mace.c           |    4 ++--
 drivers/net/pasemi_mac.c     |    2 +-
 drivers/net/spider_net.c     |    4 ++--
 drivers/net/sungem.c         |    2 +-
 drivers/net/sungem_phy.c     |    2 +-
 drivers/net/ucc_geth.c       |   16 ++++++++--------
 8 files changed, 20 insertions(+), 19 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/net/bmac.c b/drivers/net/bmac.c
index c143304..aa01ba3 100644
--- a/drivers/net/bmac.c
+++ b/drivers/net/bmac.c
@@ -1261,9 +1261,10 @@ static int __devinit bmac_probe(struct macio_dev *mdev, const struct of_device_i
 		printk(KERN_ERR "BMAC: can't use, need 3 addrs and 3 intrs\n");
 		return -ENODEV;
 	}
-	prop_addr = get_property(macio_get_of_node(mdev), "mac-address", NULL);
+	prop_addr = of_get_property(macio_get_of_node(mdev),
+			"mac-address", NULL);
 	if (prop_addr == NULL) {
-		prop_addr = get_property(macio_get_of_node(mdev),
+		prop_addr = of_get_property(macio_get_of_node(mdev),
 				"local-mac-address", NULL);
 		if (prop_addr == NULL) {
 			printk(KERN_ERR "BMAC: Can't get mac-address\n");
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index d1a8134..6d5effd 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2336,7 +2336,7 @@ static int ehea_setup_single_port(struct ehea_port *port,
 	port->of_dev_node = dn;
 
 	/* Determine logical port id */
-	dn_log_port_id = get_property(dn, "ibm,hea-port-no", NULL);
+	dn_log_port_id = of_get_property(dn, "ibm,hea-port-no", NULL);
 
 	if (!dn_log_port_id) {
 		ehea_error("bad device node: dn_log_port_id=%p",
@@ -2502,7 +2502,7 @@ static int __devinit ehea_probe(struct ibmebus_dev *dev,
 		goto out;
 	}
 
-	adapter_handle = get_property(dev->ofdev.node, "ibm,hea-handle",
+	adapter_handle = of_get_property(dev->ofdev.node, "ibm,hea-handle",
 					    NULL);
 	if (adapter_handle)
 		adapter->handle = *adapter_handle;
diff --git a/drivers/net/mace.c b/drivers/net/mace.c
index 9ec24f0..7018ba9 100644
--- a/drivers/net/mace.c
+++ b/drivers/net/mace.c
@@ -110,9 +110,9 @@ static int __devinit mace_probe(struct macio_dev *mdev, const struct of_device_i
 		return -ENODEV;
 	}
 
-	addr = get_property(mace, "mac-address", NULL);
+	addr = of_get_property(mace, "mac-address", NULL);
 	if (addr == NULL) {
-		addr = get_property(mace, "local-mac-address", NULL);
+		addr = of_get_property(mace, "local-mac-address", NULL);
 		if (addr == NULL) {
 			printk(KERN_ERR "Can't get mac-address for MACE %s\n",
 			       mace->full_name);
diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
index d670ac7..cb7a8e7 100644
--- a/drivers/net/pasemi_mac.c
+++ b/drivers/net/pasemi_mac.c
@@ -80,7 +80,7 @@ static int pasemi_get_mac_addr(struct pasemi_mac *mac)
 		return -ENOENT;
 	}
 
-	maddr = get_property(dn, "mac-address", NULL);
+	maddr = of_get_property(dn, "mac-address", NULL);
 	if (maddr == NULL) {
 		dev_warn(&pdev->dev,
 			 "no mac address in device tree, not configuring\n");
diff --git a/drivers/net/spider_net.c b/drivers/net/spider_net.c
index 3b91af8..6984761 100644
--- a/drivers/net/spider_net.c
+++ b/drivers/net/spider_net.c
@@ -1831,7 +1831,7 @@ try_host_fw:
 	if (!dn)
 		goto out_err;
 
-	fw_prop = get_property(dn, "firmware", &fw_size);
+	fw_prop = of_get_property(dn, "firmware", &fw_size);
 	if (!fw_prop)
 		goto out_err;
 
@@ -2237,7 +2237,7 @@ spider_net_setup_netdev(struct spider_net_card *card)
 	if (!dn)
 		return -EIO;
 
-	mac = get_property(dn, "local-mac-address", NULL);
+	mac = of_get_property(dn, "local-mac-address", NULL);
 	if (!mac)
 		return -EIO;
 	memcpy(addr.sa_data, mac, ETH_ALEN);
diff --git a/drivers/net/sungem.c b/drivers/net/sungem.c
index 616be8d..1d0f5ca 100644
--- a/drivers/net/sungem.c
+++ b/drivers/net/sungem.c
@@ -2900,7 +2900,7 @@ static int __devinit gem_get_device_address(struct gem *gp)
 #elif defined(CONFIG_PPC_PMAC)
 	const unsigned char *addr;
 
-	addr = get_property(gp->of_node, "local-mac-address", NULL);
+	addr = of_get_property(gp->of_node, "local-mac-address", NULL);
 	if (addr == NULL) {
 		printk("\n");
 		printk(KERN_ERR "%s: can't get mac-address\n", dev->name);
diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index 56a110c..61843fd 100644
--- a/drivers/net/sungem_phy.c
+++ b/drivers/net/sungem_phy.c
@@ -451,7 +451,7 @@ static int bcm5421_init(struct mii_phy* phy)
 	if (phy->platform_data) {
 		struct device_node *np = of_get_parent(phy->platform_data);
 		int can_low_power = 1;
-		if (np == NULL || get_property(np, "no-autolowpower", NULL))
+		if (np == NULL || of_get_property(np, "no-autolowpower", NULL))
 			can_low_power = 0;
 		if (can_low_power) {
 			/* Enable automatic low-power */
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 639e1e6..12d394f 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -4080,16 +4080,16 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 
 	ugeth_vdbg("%s: IN", __FUNCTION__);
 
-	prop = get_property(np, "device-id", NULL);
+	prop = of_get_property(np, "device-id", NULL);
 	ucc_num = *prop - 1;
 	if ((ucc_num < 0) || (ucc_num > 7))
 		return -ENODEV;
 
 	ug_info = &ugeth_info[ucc_num];
 	ug_info->uf_info.ucc_num = ucc_num;
-	prop = get_property(np, "rx-clock", NULL);
+	prop = of_get_property(np, "rx-clock", NULL);
 	ug_info->uf_info.rx_clock = *prop;
-	prop = get_property(np, "tx-clock", NULL);
+	prop = of_get_property(np, "tx-clock", NULL);
 	ug_info->uf_info.tx_clock = *prop;
 	err = of_address_to_resource(np, 0, &res);
 	if (err)
@@ -4098,15 +4098,15 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	ug_info->uf_info.regs = res.start;
 	ug_info->uf_info.irq = irq_of_parse_and_map(np, 0);
 
-	ph = get_property(np, "phy-handle", NULL);
+	ph = of_get_property(np, "phy-handle", NULL);
 	phy = of_find_node_by_phandle(*ph);
 
 	if (phy == NULL)
 		return -ENODEV;
 
-	prop = get_property(phy, "reg", NULL);
+	prop = of_get_property(phy, "reg", NULL);
 	ug_info->phy_address = *prop;
-	prop = get_property(phy, "interface", NULL);
+	prop = of_get_property(phy, "interface", NULL);
 	ug_info->enet_interface = *prop;
 	ug_info->phy_interrupt = irq_of_parse_and_map(phy, 0);
 	ug_info->board_flags = (ug_info->phy_interrupt == NO_IRQ)?
@@ -4127,7 +4127,7 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 	/* timing.						*/
 	/* The following compensates by writing to the reserved */
 	/* QE Port Output Hold Registers (CPOH1?).              */
-	prop = get_property(phy, "interface", NULL);
+	prop = of_get_property(phy, "interface", NULL);
 	phy_interface = *prop;
 	if ((phy_interface == ENET_1000_RGMII) ||
 			(phy_interface == ENET_100_RGMII) ||
@@ -4140,7 +4140,7 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 		soc = of_find_node_by_type(NULL, "soc");
 		if (soc) {
 			unsigned int size;
-			const void *prop = get_property(soc, "reg", &size);
+			const void *prop = of_get_property(soc, "reg", &size);
 			immrbase = of_translate_address(soc, prop);
 			of_node_put(soc);
 		};
-- 
1.5.0.3
