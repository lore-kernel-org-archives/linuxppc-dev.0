Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (host32.eke.fi [194.100.64.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80FB767C66
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 22:22:24 +1100 (EST)
Date: Wed, 1 Nov 2006 13:22:17 +0200 (EET)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: linuxppc-embedded@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH/RFC] FS_ENET: Removed MII bitbang check for TA
Message-ID: <Pine.LNX.4.64.0611011317280.848@host32.eke.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The PHY abstraction layer expects to receive 0xffff when
reading PHY registers if there is no PHY at that address. The
all-ones condition is guaranteed by the pull-up in the MDIO line, so
there is no need to check for the TA bits.

With this, the PHY layer is able to probe the MDIO bus as it expects.
This also removes one board dependency from the fs_enet driver, as there
is no need to set the phy_mask bits anymore.

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
---
  drivers/net/fs_enet/mii-bitbang.c |   17 ++---------------
  1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/net/fs_enet/mii-bitbang.c b/drivers/net/fs_enet/mii-bitbang.c
index 0b9b8b5..af36f3e 100644
--- a/drivers/net/fs_enet/mii-bitbang.c
+++ b/drivers/net/fs_enet/mii-bitbang.c
@@ -194,19 +194,6 @@ static int fs_enet_mii_bb_read(struct mi
  	mdc(bitbang, 1);
  	mii_delay(bitbang);

-	/* check the turnaround bit: the PHY should be driving it to zero */
-	if (mdio_read(bitbang) != 0) {
-		/* PHY didn't drive TA low */
-		for (j = 0; j < 32; j++) {
-			mdc(bitbang, 0);
-			mii_delay(bitbang);
-			mdc(bitbang, 1);
-			mii_delay(bitbang);
-		}
-		ret = -1;
-		goto out;
-	}
-
  	mdc(bitbang, 0);
  	mii_delay(bitbang);

@@ -229,7 +216,7 @@ static int fs_enet_mii_bb_read(struct mi
  	mii_delay(bitbang);

  	ret = rdreg;
-out:
+
  	return ret;
  }

@@ -338,7 +325,7 @@ static int __devinit fs_enet_mdio_probe(
  	new_bus->reset = &fs_enet_mii_bb_reset,
  	new_bus->id = pdev->id;

-	new_bus->phy_mask = ~0x9;
+	new_bus->phy_mask = 0;
  	pdata = (struct fs_mii_bb_platform_info *)pdev->dev.platform_data;

  	if (NULL == pdata) {
-- 
1.4.1.1
