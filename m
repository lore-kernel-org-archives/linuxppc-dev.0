Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id AB1DEDE023
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 04:20:08 +1100 (EST)
Date: Mon, 13 Oct 2008 20:19:00 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Lennert Buytenhek <buytenh@marvell.com>,
	Andy Fleming <afleming@freescale.com>, jgarzik@pobox.com
Subject: [2.6 patch] export genphy_restart_aneg
Message-ID: <20081013171900.GK29938@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes the following build error caused by
commit ed94493fb38a665cebcf750dfabe8a6dd13e136f
(mv643xx_eth: convert to phylib):

<--  snip  -->

...
  Building modules, stage 2.
  MODPOST 1280 modules
ERROR: "genphy_restart_aneg" [drivers/net/mv643xx_eth.ko] undefined!
...
make[2]: *** [__modpost] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1716274..f11e900 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -557,6 +557,7 @@ int genphy_restart_aneg(struct phy_device *phydev)
 
 	return ctl;
 }
+EXPORT_SYMBOL(genphy_restart_aneg);
 
 
 /**
