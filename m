Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5754367B19
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 00:58:45 +1000 (EST)
To: Jeff Garzik <jeff@garzik.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 3/3] FS_ENET: phydev pointer may be dereferenced without NULL
	check
Date: Tue, 20 Jun 2006 18:58:43 +0400
Message-Id: <20060620145843.24807.34893.stgit@vitb.ru.mvista.com>
In-Reply-To: <20060620145825.24807.310.stgit@vitb.ru.mvista.com>
References: <20060620145825.24807.310.stgit@vitb.ru.mvista.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


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
