Return-Path: <Alexandre.Bounine@tundra.com>
Received: from mx2.tundra.com (mail2.tundra.com [142.46.200.162])
	by ozlabs.org (Postfix) with ESMTP id AD609DDF14
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 06:29:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH 2/5] Tsi108_eth: fix detection of 1000Mb mode
Date: Fri, 8 Feb 2008 14:17:04 -0500
Message-ID: <1B5F013528140F45B5C671039279CA5702A960A0@NANUK.pc.tundra.com>
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

Bug fix for tsi108_eth network driver.
This patch fixes a problem with detection of 1000Mb speed.=20
=20=20=20
Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06
15:09:19.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
15:34:12.000000000 -0500
@@ -1287,6 +1287,7 @@ static void tsi108_init_phy(struct net_d
 		spin_lock_irqsave(&phy_lock, flags);
 	}
=20
+	data->mii_if.supports_gmii =3D
mii_check_gmii_support(&data->mii_if);
 	printk(KERN_DEBUG "PHY_STAT reg contains %08x\n", phyval);
 	data->phy_ok =3D 1;
 	data->init_media =3D 1;
@@ -1584,7 +1585,6 @@ tsi108_init_one(struct platform_device *
 	data->mii_if.phy_id =3D einfo->phy;
 	data->mii_if.phy_id_mask =3D 0x1f;
 	data->mii_if.reg_num_mask =3D 0x1f;
-	data->mii_if.supports_gmii =3D
mii_check_gmii_support(&data->mii_if);
=20
 	data->phy =3D einfo->phy;
 	data->phy_type =3D einfo->phy_type;



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
