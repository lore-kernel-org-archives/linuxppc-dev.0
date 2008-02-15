Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D66D0DDF29
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 08:08:11 +1100 (EST)
Date: Fri, 15 Feb 2008 15:08:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH] fs_enet: Don't call phy_mii_ioctl() in atomic context.
Message-ID: <20080215210804.GA14468@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The lock acquisition in fs_ioctl() does not appear to actually be necessary,
and thus is simply removed.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This fixes the following bug:
http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051564.html

 drivers/net/fs_enet/fs_enet-main.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 42d94ed..af869cf 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -946,16 +946,11 @@ static int fs_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
 	struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&rq->ifr_data;
-	unsigned long flags;
-	int rc;
 
 	if (!netif_running(dev))
 		return -EINVAL;
 
-	spin_lock_irqsave(&fep->lock, flags);
-	rc = phy_mii_ioctl(fep->phydev, mii, cmd);
-	spin_unlock_irqrestore(&fep->lock, flags);
-	return rc;
+	return phy_mii_ioctl(fep->phydev, mii, cmd);
 }
 
 extern int fs_mii_connect(struct net_device *dev);
-- 
1.5.3.8
