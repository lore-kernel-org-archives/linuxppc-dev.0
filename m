Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7C3C967A46
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 16:14:05 +1100 (EST)
Date: Fri, 4 Mar 2005 23:12:59 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: jgarzik@pobox.com
Message-ID: <Pine.LNX.4.61.0503042305570.23572@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initialize a spin lock in gianfar driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Initialize the mdio_lock spin lock in mii_info struct, which is otherwise 
accessed prior to initialization.

Signed-off-by: Jaka Mocnik <jaka@activetools.si>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/drivers/net/gianfar.c b/drivers/net/gianfar.c
--- a/drivers/net/gianfar.c	2005-03-04 23:03:27 -06:00
+++ b/drivers/net/gianfar.c	2005-03-04 23:03:27 -06:00
@@ -377,6 +377,8 @@
 			ADVERTISED_1000baseT_Full);
 	mii_info->autoneg = 1;
 
+	spin_lock_init(&mii_info->mdio_lock);
+
 	mii_info->mii_id = priv->einfo->phyid;
 
 	mii_info->dev = dev;
