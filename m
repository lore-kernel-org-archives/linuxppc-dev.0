Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 85B74DDE01
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 14:19:42 +1100 (EST)
Date: Tue, 5 Feb 2008 14:19:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: fix section mismatch in iseries_veth
Message-Id: <20080205141940.c6ddb479.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Jeff Garzik <jgarzik@pobox.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x25dca0): Section mismatch in reference from the function .veth_probe() to the function .init.text:.veth_probe_one()

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/iseries_veth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Jeff, can this go in through the powerpc tree?

diff --git a/drivers/net/iseries_veth.c b/drivers/net/iseries_veth.c
index 419861c..58d3bb6 100644
--- a/drivers/net/iseries_veth.c
+++ b/drivers/net/iseries_veth.c
@@ -1020,7 +1020,7 @@ static const struct ethtool_ops ops = {
 	.get_link = veth_get_link,
 };
 
-static struct net_device * __init veth_probe_one(int vlan,
+static struct net_device *veth_probe_one(int vlan,
 		struct vio_dev *vio_dev)
 {
 	struct net_device *dev;
-- 
1.5.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
