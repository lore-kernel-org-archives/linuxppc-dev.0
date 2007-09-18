Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DE5DDDECE
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 02:05:40 +1000 (EST)
To: Jeff Garzik <jeff@garzik.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 1/2] [FS_ENET] TX stuff should use fep->tx_lock,
	instead of fep->lock.
Date: Tue, 18 Sep 2007 20:05:27 +0400
Message-ID: <20070918160527.13525.80935.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 drivers/net/fs_enet/fs_enet-main.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index a4a2a0e..927cd9e 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -348,7 +348,7 @@ static void fs_enet_tx(struct net_device *dev)
 	int dirtyidx, do_wake, do_restart;
 	u16 sc;
 
-	spin_lock(&fep->lock);
+	spin_lock(&fep->tx_lock);
 	bdp = fep->dirty_tx;
 
 	do_wake = do_restart = 0;
@@ -428,7 +428,7 @@ static void fs_enet_tx(struct net_device *dev)
 	if (do_restart)
 		(*fep->ops->tx_restart)(dev);
 
-	spin_unlock(&fep->lock);
+	spin_unlock(&fep->tx_lock);
 
 	if (do_wake)
 		netif_wake_queue(dev);
@@ -826,7 +826,9 @@ static int fs_enet_close(struct net_device *dev)
 	phy_stop(fep->phydev);
 
 	spin_lock_irqsave(&fep->lock, flags);
+	spin_lock(&fep->tx_lock);
 	(*fep->ops->stop)(dev);
+	spin_unlock(&fep->tx_lock);
 	spin_unlock_irqrestore(&fep->lock, flags);
 
 	/* release any irqs */
