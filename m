Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5577DDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 16:36:04 +1000 (EST)
From: Andy Fleming <afleming@freescale.com>
To: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] Fix error checking in Vitesse IRQ config
Date: Wed, 18 Jul 2007 01:35:50 -0500
Message-Id: <11847405503115-git-send-email-afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

phy_read() returns a negative number if there's an error, but the
error-checking code in the Vitesse driver's config_intr function
triggers if phy_read() returns non-zero.  Correct that.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
I made a really stupid mistake in the 4 patches I sent out, earlier.  I
thought those patches had been tested, but they hadn't been.  This one
corrects a tiny error in the patch, and they have now been tested.  As before
this change can be pulled from:

http://opensource.freescale.com/pub/scm/linux-2.6-85xx.git netdev

Really, REALLY sorry about that.  I have been given a paper bag of appropriate
size and shape to fit over my head.

 drivers/net/phy/vitesse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 6a53856..8874497 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -109,7 +109,7 @@ static int vsc824x_config_intr(struct phy_device *phydev)
 		 */
 		err = phy_read(phydev, MII_VSC8244_ISTAT);
 
-		if (err)
+		if (err < 0)
 			return err;
 
 		err = phy_write(phydev, MII_VSC8244_IMASK, 0);
-- 
1.5.0.2.230.gfbe3d-dirty
