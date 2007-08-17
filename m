Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0370DDEC9
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 03:54:09 +1000 (EST)
Date: Fri, 17 Aug 2007 12:54:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 3/7] fs_enet: Don't share the interrupt.
Message-ID: <20070817175401.GC9218@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070817175320.GA8259@ld0162-tx32.am.freescale.net>
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
1.5.0.3
