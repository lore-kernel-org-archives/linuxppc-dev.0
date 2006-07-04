Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 15/20] [powerpc,netdevices] Constify & voidify get_property()
Message-ID: 1151993427.2210.16@pokey
Date: Tue,  4 Jul 2006 16:47:17 +1000 (EST)
Cc: netdev@oss.sgi.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

powerpc-specific network device driver changes.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 bmac.c       |   13 ++++++++-----
 mace.c       |    2 +-
 spider_net.c |   12 ++++++------
 sungem.c     |    2 +-
 4 files changed, 16 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/net/bmac.c
===================================================================
--- linux-2.6.orig/drivers/net/bmac.c
+++ linux-2.6/drivers/net/bmac.c
@@ -1264,7 +1264,8 @@ static int __devinit bmac_probe(struct m
 {
	int j, rev, ret;
	struct bmac_data *bp;
-	unsigned char *addr;
+	const unsigned char *prop_addr;
+	unsigned char addr[6];
	struct net_device *dev;
	int is_bmac_plus = ((int)match->data) != 0;
 
@@ -1272,14 +1273,16 @@ static int __devinit bmac_probe(struct m
		printk(KERN_ERR "BMAC: can't use, need 3 addrs and 3 intrs\n");
		return -ENODEV;
	}
-	addr = get_property(macio_get_of_node(mdev), "mac-address", NULL);
-	if (addr == NULL) {
-		addr = get_property(macio_get_of_node(mdev), "local-mac-address", NULL);
-		if (addr == NULL) {
+	prop_addr = get_property(macio_get_of_node(mdev), "mac-address", NULL);
+	if (prop_addr == NULL) {
+		prop_addr = get_property(macio_get_of_node(mdev),
+				"local-mac-address", NULL);
+		if (prop_addr == NULL) {
			printk(KERN_ERR "BMAC: Can't get mac-address\n");
			return -ENODEV;
		}
	}
+	memcpy(addr, prop_addr, sizeof(addr));
 
	dev = alloc_etherdev(PRIV_BYTES);
	if (!dev) {
Index: linux-2.6/drivers/net/mace.c
===================================================================
--- linux-2.6.orig/drivers/net/mace.c
+++ linux-2.6/drivers/net/mace.c
@@ -113,7 +113,7 @@ static int __devinit mace_probe(struct m
	struct device_node *mace = macio_get_of_node(mdev);
	struct net_device *dev;
	struct mace_data *mp;
-	unsigned char *addr;
+	const unsigned char *addr;
	int j, rev, rc = -EBUSY;
 
	if (macio_resource_count(mdev) != 3 || macio_irq_count(mdev) != 3) {
Index: linux-2.6/drivers/net/sungem.c
===================================================================
--- linux-2.6.orig/drivers/net/sungem.c
+++ linux-2.6/drivers/net/sungem.c
@@ -2896,7 +2896,7 @@ static int __devinit gem_get_device_addr
	if (use_idprom)
		memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
 #elif defined(CONFIG_PPC_PMAC)
-	unsigned char *addr;
+	const unsigned char *addr;
 
	addr = get_property(gp->of_node, "local-mac-address", NULL);
	if (addr == NULL) {
Index: linux-2.6/drivers/net/spider_net.c
===================================================================
--- linux-2.6.orig/drivers/net/spider_net.c
+++ linux-2.6/drivers/net/spider_net.c
@@ -1812,10 +1812,10 @@ spider_net_setup_phy(struct spider_net_c
  */
 static int
 spider_net_download_firmware(struct spider_net_card *card,
-			     u8 *firmware_ptr)
+			     const void *firmware_ptr)
 {
 	int sequencer, i;
-	u32 *fw_ptr = (u32 *)firmware_ptr;
+	const u32 *fw_ptr = firmware_ptr;
 
 	/* stop sequencers */
 	spider_net_write_reg(card, SPIDER_NET_GSINIT,
@@ -1872,7 +1872,7 @@ spider_net_init_firmware(struct spider_n
 {
 	struct firmware *firmware = NULL;
 	struct device_node *dn;
-	u8 *fw_prop = NULL;
+	const u8 *fw_prop = NULL;
 	int err = -ENOENT;
 	int fw_size;
 
@@ -1898,7 +1898,7 @@ try_host_fw:
 	if (!dn)
 		goto out_err;
 
-	fw_prop = (u8 *)get_property(dn, "firmware", &fw_size);
+	fw_prop = get_property(dn, "firmware", &fw_size);
 	if (!fw_prop)
 		goto out_err;
 
@@ -2058,7 +2058,7 @@ spider_net_setup_netdev(struct spider_ne
 	struct net_device *netdev = card->netdev;
 	struct device_node *dn;
 	struct sockaddr addr;
-	u8 *mac;
+	const u8 *mac;
 
 	SET_MODULE_OWNER(netdev);
 	SET_NETDEV_DEV(netdev, &card->pdev->dev);
@@ -2089,7 +2089,7 @@ spider_net_setup_netdev(struct spider_ne
 	if (!dn)
 		return -EIO;
 
-	mac = (u8 *)get_property(dn, "local-mac-address", NULL);
+	mac = get_property(dn, "local-mac-address", NULL);
 	if (!mac)
 		return -EIO;
 	memcpy(addr.sa_data, mac, ETH_ALEN);
