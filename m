Return-Path: <alex.bou9@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id 5ED10DDEBC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 06:35:27 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so3526642rvf.9
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 11:35:26 -0800 (PST)
Message-ID: <d5f62df20802111135i6df342e5y93db2de282f6a61a@mail.gmail.com>
Date: Mon, 11 Feb 2008 14:35:26 -0500
From: "Alex Bounine" <alex.bou9@gmail.com>
To: jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [PATCH 2/5 v3] Tsi108_eth: fix detection of 1000Mb mode
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

Bug fix for tsi108_eth network driver.
This patch fixes a problem with detection of 1000Mb speed.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
---

diff -pNur linux-2.6.24/drivers/net/tsi108_eth.c
linux-2.6.24-fix/drivers/net/tsi108_eth.c
--- linux-2.6.24/drivers/net/tsi108_eth.c	2008-02-06 15:09:19.000000000 -0500
+++ linux-2.6.24-fix/drivers/net/tsi108_eth.c	2008-02-06
15:34:12.000000000 -0500
@@ -1287,6 +1287,7 @@ static void tsi108_init_phy(struct net_d
 		spin_lock_irqsave(&phy_lock, flags);
 	}

+	data->mii_if.supports_gmii = mii_check_gmii_support(&data->mii_if);
 	printk(KERN_DEBUG "PHY_STAT reg contains %08x\n", phyval);
 	data->phy_ok = 1;
 	data->init_media = 1;
@@ -1584,7 +1585,6 @@ tsi108_init_one(struct platform_device *
 	data->mii_if.phy_id = einfo->phy;
 	data->mii_if.phy_id_mask = 0x1f;
 	data->mii_if.reg_num_mask = 0x1f;
-	data->mii_if.supports_gmii = mii_check_gmii_support(&data->mii_if);

 	data->phy = einfo->phy;
 	data->phy_type = einfo->phy_type;
