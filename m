Return-Path: <alex.bou9@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id BA83FDDECD
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 06:35:52 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4679025wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:35:51 -0800 (PST)
Message-ID: <d5f62df20802111135q36e47070w611291b2cea2253e@mail.gmail.com>
Date: Mon, 11 Feb 2008 14:35:49 -0500
From: "Alex Bounine" <alex.bou9@gmail.com>
To: jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [PATCH 3/5 v3] Tsi108_eth: remove not needed code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Code clean-up for tsi108_eth network driver.
This patch removes not needed dummy read and the corresponding comment.
The PHY logic requires two reads from the status register to get
current link status. This is done correctly inside mii_check_media().

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06 15:47:35.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
15:54:14.000000000 -0500
@@ -297,18 +297,11 @@ static void tsi108_check_phy(struct net_
 	u32 speed;
 	unsigned long flags;

-	/* Do a dummy read, as for some reason the first read
-	 * after a link becomes up returns link down, even if
-	 * it's been a while since the link came up.
-	 */
-
 	spin_lock_irqsave(&phy_lock, flags);

 	if (!data->phy_ok)
 		goto out;

-	tsi108_read_mii(data, MII_BMSR);
-
 	duplex = mii_check_media(&data->mii_if, netif_msg_link(data),
data->init_media);
 	data->init_media = 0;
