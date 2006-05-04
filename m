Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4A1B667AC6
	for <linuxppc-dev@ozlabs.org>; Thu,  4 May 2006 13:49:19 +1000 (EST)
Date: Thu, 4 May 2006 13:45:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/4] powerpc: update iseries_veth device-tree information
Message-Id: <20060504134544.2fc295db.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the device-tree information more generic and more
like the pSeries virtual lan device. Also use the MAC
address from the device tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/setup.c |    8 +++++---
 drivers/net/iseries_veth.c             |   27 +++++++++++++++++----------
 2 files changed, 22 insertions(+), 13 deletions(-)

These patches are relative to the powerpc tree and built and booted for iSeries.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

9b4a8b9458558616e0b49e4beb1e27f087835d4c
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index befd36a..0a08257 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -946,10 +946,10 @@ void dt_vdevices(struct iseries_flat_dt 
 
 		if ((vlan_map & (0x8000 >> i)) == 0)
 			continue;
-		snprintf(buf, 32, "vlan@%08x", reg + i);
+		snprintf(buf, 32, "l-lan@%08x", reg + i);
 		dt_start_node(dt, buf);
-		dt_prop_str(dt, "device_type", "vlan");
-		dt_prop_str(dt, "compatible", "");
+		dt_prop_str(dt, "device_type", "network");
+		dt_prop_str(dt, "compatible", "IBM,iSeries-l-lan");
 		dt_prop_u32(dt, "reg", reg + i);
 		dt_prop_u32(dt, "linux,unit_address", i);
 
@@ -961,6 +961,8 @@ void dt_vdevices(struct iseries_flat_dt 
 		mac_addr[5] = HvLpConfig_getLpIndex_outline();
 		dt_prop(dt, "local-mac-address", (char *)mac_addr, ETH_ALEN);
 		dt_prop(dt, "mac-address", (char *)mac_addr, ETH_ALEN);
+		dt_prop_u32(dt, "max-frame-size", 9000);
+		dt_prop_u32(dt, "address-bits", 48);
 
 		dt_end_node(dt);
 	}
diff --git a/drivers/net/iseries_veth.c b/drivers/net/iseries_veth.c
index f0f04be..93394d7 100644
--- a/drivers/net/iseries_veth.c
+++ b/drivers/net/iseries_veth.c
@@ -69,6 +69,7 @@ #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/ethtool.h>
+#include <linux/if_ether.h>
 
 #include <asm/abs_addr.h>
 #include <asm/iseries/mf.h>
@@ -1035,11 +1036,22 @@ static struct ethtool_ops ops = {
 	.get_link = veth_get_link,
 };
 
-static struct net_device * __init veth_probe_one(int vlan, struct device *vdev)
+static struct net_device * __init veth_probe_one(int vlan,
+		struct vio_dev *vio_dev)
 {
 	struct net_device *dev;
 	struct veth_port *port;
+	struct device *vdev = &vio_dev->dev;
 	int i, rc;
+	const unsigned char *mac_addr;
+
+	mac_addr = vio_get_attribute(vio_dev, "local-mac-address", NULL);
+	if (mac_addr == NULL)
+		mac_addr = vio_get_attribute(vio_dev, "mac-address", NULL);
+	if (mac_addr == NULL) {
+		veth_error("Unable to fetch MAC address from device tree.\n");
+		return NULL;
+	}
 
 	dev = alloc_etherdev(sizeof (struct veth_port));
 	if (! dev) {
@@ -1064,16 +1076,11 @@ static struct net_device * __init veth_p
 	}
 	port->dev = vdev;
 
-	dev->dev_addr[0] = 0x02;
-	dev->dev_addr[1] = 0x01;
-	dev->dev_addr[2] = 0xff;
-	dev->dev_addr[3] = vlan;
-	dev->dev_addr[4] = 0xff;
-	dev->dev_addr[5] = this_lp;
+	memcpy(dev->dev_addr, mac_addr, ETH_ALEN);
 
 	dev->mtu = VETH_MAX_MTU;
 
-	memcpy(&port->mac_addr, dev->dev_addr, 6);
+	memcpy(&port->mac_addr, mac_addr, ETH_ALEN);
 
 	dev->open = veth_open;
 	dev->hard_start_xmit = veth_start_xmit;
@@ -1608,7 +1615,7 @@ static int veth_probe(struct vio_dev *vd
 	struct net_device *dev;
 	struct veth_port *port;
 
-	dev = veth_probe_one(i, &vdev->dev);
+	dev = veth_probe_one(i, vdev);
 	if (dev == NULL) {
 		veth_remove(vdev);
 		return 1;
@@ -1641,7 +1648,7 @@ static int veth_probe(struct vio_dev *vd
  * support.
  */
 static struct vio_device_id veth_device_table[] __devinitdata = {
-	{ "vlan", "" },
+	{ "network", "IBM,iSeries-l-lan" },
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, veth_device_table);
-- 
1.3.1.ge923
