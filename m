Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0952DF24F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:36:24 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6I1aJPf027795
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:36:20 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1aJ3H001620
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:19 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1Bcpf008010
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:11:38 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 40FFBAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:36:18 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1aIwR015494
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:36:18 -0500
Date: Tue, 17 Jul 2007 20:36:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 58/61] fs_enet: Don't share the interrupt.
Message-ID: <20070718013618.GD15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
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
