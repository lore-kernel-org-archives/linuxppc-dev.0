Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 964C2DDF9C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 08:01:52 +1000 (EST)
Date: Thu, 20 Sep 2007 17:01:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 3/9] fs_enet: Don't share the interrupt.
Message-ID: <20070920220118.GC28784@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070920220043.GA28769@loki.buserror.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This driver can't handle an interrupt immediately after request_irq
(making it fail with CONFIG_DEBUG_SHIRQ), and has unshared interrupts
on all hardware I'm aware of.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/net/fs_enet/fs_enet-main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index f261b90..da79a45 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -667,7 +667,7 @@ static int fs_request_irq(struct net_device *dev, int irq, const char *name,
 	struct fs_enet_private *fep = netdev_priv(dev);
 
 	(*fep->ops->pre_request_irq)(dev, irq);
-	return request_irq(irq, irqf, IRQF_SHARED, name, dev);
+	return request_irq(irq, irqf, 0, name, dev);
 }
 
 static void fs_free_irq(struct net_device *dev, int irq)
-- 
1.5.3.1
