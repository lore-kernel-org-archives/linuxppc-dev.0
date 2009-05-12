Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 93025DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 17:44:53 +1000 (EST)
Date: Tue, 12 May 2009 17:44:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Subject: Re: [PowerPC] Next May 8 boot failure: OOPS during ibmveth moduleinit
Message-Id: <20090512174451.eeed4126.sfr@canb.auug.org.au>
In-Reply-To: <20090512170458.39c4ffb7.sfr@canb.auug.org.au>
References: <20090508180251.f53f204e.sfr@canb.auug.org.au>
	<4A042B20.4090903@in.ibm.com>
	<20090508.125722.54378771.davem@davemloft.net>
	<20090508223332.GA4881@psychotron.englab.brq.redhat.com>
	<4A085B3D.5000806@in.ibm.com>
	<20090512170458.39c4ffb7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org, netdev@vger.kernel.org,
	Jiri Pirko <jpirko@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Dave,

This fixes it (I wonder if this bug is lurking in any other drivers):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 12 May 2009 17:24:02 +1000
Subject: [PATCH] net/ibmveth: fix panic in probe

netdev->dev_addr changed from being an array to being a pointer, so we
should not take its address for memcpy().

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ibmveth.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
index 7902e5e..8daffad 100644
--- a/drivers/net/ibmveth.c
+++ b/drivers/net/ibmveth.c
@@ -1285,7 +1285,7 @@ static int __devinit ibmveth_probe(struct vio_dev *dev, const struct vio_device_
  	netdev->features |= NETIF_F_LLTX;
 	spin_lock_init(&adapter->stats_lock);
 
-	memcpy(&netdev->dev_addr, &adapter->mac_addr, netdev->addr_len);
+	memcpy(netdev->dev_addr, &adapter->mac_addr, netdev->addr_len);
 
 	for(i = 0; i<IbmVethNumBufferPools; i++) {
 		struct kobject *kobj = &adapter->rx_buff_pool[i].kobj;
-- 
1.6.3


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
