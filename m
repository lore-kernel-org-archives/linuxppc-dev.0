Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id B4B92DE13C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 22:05:56 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: netdev@vger.kernel.org
Subject: [PATCH] fs_enet: Don't call NAPI functions when NAPI is not used.
Date: Fri, 11 Apr 2008 14:05:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804111405.50896.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fs_enet_close() calls napi_disable() unconditionally. This patch skips the
call when use_napi isn't set.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 drivers/net/fs_enet/fs_enet-main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index c83bd65..1801ce3 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -835,7 +835,8 @@ static int fs_enet_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 	netif_carrier_off(dev);
-	napi_disable(&fep->napi);
+	if (fep->fpi->use_napi)
+		napi_disable(&fep->napi);
 	phy_stop(fep->phydev);
 
 	spin_lock_irqsave(&fep->lock, flags);
-- 
1.5.0

This is a bugfix and should probably go in 2.6.25.

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
