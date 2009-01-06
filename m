Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1430CDDF04
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 16:39:17 +1100 (EST)
Date: Tue, 6 Jan 2009 16:39:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] ibmveth: use consistent types
Message-Id: <20090106163908.2e6134f4.sfr@canb.auug.org.au>
In-Reply-To: <20081231140225.48b695ef.sfr@canb.auug.org.au>
References: <20081231140225.48b695ef.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These variables are only used with an interface that just dumps their
values into registers to be passed to the hypervisor. The arguments
to that interface are declared to be "unsigned long", so make these
variables match.  The macros are only used with these variables, so make
them match as well.

This code is currently only built for 64bit powerpc, so the transformation
is really a noop.  If the interface was ever ported to 32 bit, it would
almost certainly still use registers to pass the parameters and so
"unsigned long" would still be appropriate.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ibmveth.c |    4 ++--
 drivers/net/ibmveth.h |   10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
index 9bc0f17..ca3bb9f 100644
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -754,7 +754,7 @@ static int ibmveth_set_csum_offload(struct net_device *dev, u32 data,
 				    void (*done) (struct net_device *, u32))
 {
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
-	u64 set_attr, clr_attr, ret_attr;
+	unsigned long set_attr, clr_attr, ret_attr;
 	long ret;
 	int rc1 = 0, rc2 = 0;
 	int restart = 0;
@@ -1209,7 +1209,7 @@ static int __devinit ibmveth_probe(struct vio_dev *dev, const struct vio_device_
 	long ret;
 	struct net_device *netdev;
 	struct ibmveth_adapter *adapter;
-	u64 set_attr, ret_attr;
+	unsigned long set_attr, ret_attr;
 
 	unsigned char *mac_addr_p;
 	unsigned int *mcastFilterSize_p;
diff --git a/drivers/net/ibmveth.h b/drivers/net/ibmveth.h
index d281869..ec76ace 100644
--- a/drivers/net/ibmveth.h
+++ b/drivers/net/ibmveth.h
@@ -39,11 +39,11 @@
 #define IbmVethMcastRemoveFilter     0x2UL
 #define IbmVethMcastClearFilterTable 0x3UL
 
-#define IBMVETH_ILLAN_PADDED_PKT_CSUM	0x0000000000002000ULL
-#define IBMVETH_ILLAN_TRUNK_PRI_MASK	0x0000000000000F00ULL
-#define IBMVETH_ILLAN_IPV6_TCP_CSUM		0x0000000000000004ULL
-#define IBMVETH_ILLAN_IPV4_TCP_CSUM		0x0000000000000002ULL
-#define IBMVETH_ILLAN_ACTIVE_TRUNK		0x0000000000000001ULL
+#define IBMVETH_ILLAN_PADDED_PKT_CSUM	0x0000000000002000UL
+#define IBMVETH_ILLAN_TRUNK_PRI_MASK	0x0000000000000F00UL
+#define IBMVETH_ILLAN_IPV6_TCP_CSUM		0x0000000000000004UL
+#define IBMVETH_ILLAN_IPV4_TCP_CSUM		0x0000000000000002UL
+#define IBMVETH_ILLAN_ACTIVE_TRUNK		0x0000000000000001UL
 
 /* hcall macros */
 #define h_register_logical_lan(ua, buflst, rxq, fltlst, mac) \
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
