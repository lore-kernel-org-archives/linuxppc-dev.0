Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 3D8AC2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 03:51:54 +1100 (EST)
Date: Fri, 10 Dec 2004 09:51:52 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: jgarzik@pobox.com, akpm@osdl.org
Message-ID: <20041210095152.A31319@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][EMAC] fix ibm_emac autonegotiation result parsing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix aneg result parsing in ibm_emac driver.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== drivers/net/ibm_emac/ibm_emac_phy.c 1.1 vs edited =====
--- 1.1/drivers/net/ibm_emac/ibm_emac_phy.c	2004-05-22 10:13:08 -07:00
+++ edited/drivers/net/ibm_emac/ibm_emac_phy.c	2004-11-24 15:23:54 -08:00
@@ -191,17 +191,18 @@
 	u16 lpa;
 
 	if (phy->autoneg) {
-		lpa = phy_read(phy, MII_LPA);
+		lpa = phy_read(phy, MII_LPA) & phy_read(phy, MII_ADVERTISE);
 
-		if (lpa & (LPA_10FULL | LPA_100FULL))
-			phy->duplex = DUPLEX_FULL;
-		else
-			phy->duplex = DUPLEX_HALF;
-		if (lpa & (LPA_100FULL | LPA_100HALF))
-			phy->speed = SPEED_100;
-		else
-			phy->speed = SPEED_10;
+		phy->speed = SPEED_10;
+		phy->duplex = DUPLEX_HALF;
 		phy->pause = 0;
+
+		if (lpa & (LPA_100FULL | LPA_100HALF)) {
+			phy->speed = SPEED_100;
+			if (lpa & LPA_100FULL) 
+				phy->duplex = DUPLEX_FULL;
+		} else if (lpa & LPA_10FULL)
+			phy->duplex = DUPLEX_FULL;
 	}
 	/* On non-aneg, we assume what we put in BMCR is the speed,
 	 * though magic-aneg shouldn't prevent this case from occurring
