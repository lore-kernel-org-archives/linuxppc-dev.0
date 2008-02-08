Return-Path: <Alexandre.Bounine@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	by ozlabs.org (Postfix) with ESMTP id 76392DDF09
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 06:29:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH 3/5] Tsi108_eth: remove not needed code
Date: Fri, 8 Feb 2008 14:17:19 -0500
Message-ID: <1B5F013528140F45B5C671039279CA5702A960A1@NANUK.pc.tundra.com>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: <jgarzik@pobox.com>, <netdev@vger.kernel.org>
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
The PHY logic requires two reads from the status register to get=20
current link status. This is done correctly inside mii_check_media().=20=20
=20=20=20
Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06
15:47:35.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
15:54:14.000000000 -0500
@@ -297,18 +297,11 @@ static void tsi108_check_phy(struct net_
 	u32 speed;
 	unsigned long flags;
=20
-	/* Do a dummy read, as for some reason the first read
-	 * after a link becomes up returns link down, even if
-	 * it's been a while since the link came up.
-	 */
-
 	spin_lock_irqsave(&phy_lock, flags);
=20
 	if (!data->phy_ok)
 		goto out;
=20
-	tsi108_read_mii(data, MII_BMSR);
-
 	duplex =3D mii_check_media(&data->mii_if, netif_msg_link(data),
data->init_media);
 	data->init_media =3D 0;
=20



---=0D
=0D
Important Notice: This message is intended for the use of the individual to=
 whom it is addressed and may contain information which is privileged, conf=
idential and/or exempt from disclosure under applicable law. If the reader =
of this message is not the intended recipient, or is not the employee or ag=
ent responsible for delivering the message to the intended recipient, you a=
re hereby notified that any dissemination, distribution, or copying of this=
 communication is strictly prohibited. If you have received this communicat=
ion in error, please notify the sender immediately by telephone or return e=
-mail and delete the original message from your systems. Thank you. =0D
