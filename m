Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8282DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 11:27:28 +1000 (EST)
From: Andy Fleming <afleming@freescale.com>
To: jgarzik@pobox.com, paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 1/4] phy: Fix Vitesse 824x PHY interrupt acking
Date: Mon, 16 Jul 2007 20:26:58 -0500
Message-Id: <1184635622653-git-send-email-afleming@freescale.com>
In-Reply-To: <1184635621688-git-send-email-afleming@freescale.com>
References: <1184635621688-git-send-email-afleming@freescale.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Vitesse 824x PHY doesn't allow an interrupt to be cleared if
the mask bit for that interrupt isn't set.  This means that the PHY
Lib's order of handling interrupts (disable, then clear) breaks on this
PHY.  However, clearing then disabling the interrupt opens up the code
for a silly race condition.  So rather than change the PHY Lib, we change
the Vitesse driver so it always clears interrupts before disabling them.
Further, the ack function only clears the interrupt if interrupts are
enabled.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: York Sun <yorksun@freescale.com>
Acked-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 drivers/net/phy/vitesse.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 596222b..f39ab76 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -65,7 +65,15 @@ static int vsc824x_config_init(struct phy_device *phydev)
 
 static int vsc824x_ack_interrupt(struct phy_device *phydev)
 {
-	int err = phy_read(phydev, MII_VSC8244_ISTAT);
+	int err = 0;
+	
+	/*
+	 * Don't bother to ACK the interrupts if interrupts
+	 * are disabled.  The 824x cannot clear the interrupts
+	 * if they are disabled.
+	 */
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		err = phy_read(phydev, MII_VSC8244_ISTAT);
 
 	return (err < 0) ? err : 0;
 }
@@ -77,8 +85,19 @@ static int vsc824x_config_intr(struct phy_device *phydev)
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
 		err = phy_write(phydev, MII_VSC8244_IMASK,
 				MII_VSC8244_IMASK_MASK);
-	else
+	else {
+		/*
+		 * The Vitesse PHY cannot clear the interrupt
+		 * once it has disabled them, so we clear them first
+		 */
+		err = phy_read(phydev, MII_VSC8244_ISTAT);
+
+		if (err)
+			return err;
+
 		err = phy_write(phydev, MII_VSC8244_IMASK, 0);
+	}
+
 	return err;
 }
 
-- 
1.5.0.2.230.gfbe3d-dirty
