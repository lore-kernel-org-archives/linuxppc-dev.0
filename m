Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2D98CDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 07:50:45 +1100 (EST)
Date: Mon, 26 Jan 2009 23:50:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] gianfar: Revive VLAN support
Message-ID: <20090126205043.GA15581@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Andy Fleming <afleming@freescale.com>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit 77ecaf2d5a8bfd548eed3f05c1c2e6573d5de4ba ("gianfar: Fix VLAN
HW feature related frame/buffer size calculation") wrongly removed
priv->vlgrp assignment, and now priv->vlgrp is always NULL.

This patch fixes the issue, plus fixes following sparse warning
introduced by the same commit:
gianfar.c:1406:13: warning: context imbalance in 'gfar_vlan_rx_register' - wrong count at exit

gfar_vlan_rx_register() checks for "if (old_grp == grp)" and tries
to return w/o dropping the lock.

According to net/8021q/vlan.c VLAN core issues rx_register() callback:
1. In register_vlan_dev() only on a newly created group;
2. In unregister_vlan_dev() only if the group becomes empty.

Thus the check in the gianfar driver isn't needed.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 228b88f..6d406f9 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1408,15 +1408,11 @@ static void gfar_vlan_rx_register(struct net_device *dev,
 {
 	struct gfar_private *priv = netdev_priv(dev);
 	unsigned long flags;
-	struct vlan_group *old_grp;
 	u32 tempval;
 
 	spin_lock_irqsave(&priv->rxlock, flags);
 
-	old_grp = priv->vlgrp;
-
-	if (old_grp == grp)
-		return;
+	priv->vlgrp = grp;
 
 	if (grp) {
 		/* Enable VLAN tag insertion */
-- 
1.5.6.5
