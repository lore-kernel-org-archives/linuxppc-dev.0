Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-41-194.msk.skylink.ru
	[83.217.41.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAF0067A70
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 09:46:38 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.6) with ESMTP id k5NNH4um006749
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 03:17:05 +0400
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 4/6] FS_ENET: phydev pointer may be dereferenced without NULL
	check
Date: Sat, 24 Jun 2006 03:17:04 +0400
Message-Id: <20060623231704.6721.85445.stgit@localhost.localdomain>
In-Reply-To: <20060623231648.6721.3495.stgit@localhost.localdomain>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When interface is down, phy is "disconnected" from the bus and phydev is NULL.
But ethtool may try to get/set phy regs even at that time, which results in
NULL pointer dereference and OOPS hereby.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/net/fs_enet/fs_enet-main.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 302ecaa..e475e22 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -882,12 +882,16 @@ static void fs_get_regs(struct net_devic
 static int fs_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
+	if (!fep->phydev)
+		return -EINVAL;
 	return phy_ethtool_gset(fep->phydev, cmd);
 }
 
 static int fs_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct fs_enet_private *fep = netdev_priv(dev);
+	if (!fep->phydev)
+		return -EINVAL;
 	phy_ethtool_sset(fep->phydev, cmd);
 	return 0;
 }
