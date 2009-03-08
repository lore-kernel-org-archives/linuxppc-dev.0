Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5CB0EDDEE9
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Mar 2009 23:29:19 +1100 (EST)
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
From: Wolfgang Ocker <weo@reccoware.de>
To: Michael Guntsche <mike@it-loops.com>
In-Reply-To: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
Content-Type: text/plain
Date: Sun, 08 Mar 2009 13:18:44 +0100
Message-Id: <1236514724.3710.20.camel@goedel.recco.de>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-26 at 20:15 +0100, Michael Guntsche wrote:
> For testing purposes I tried a recent git snapshot and noticed  
> that the gianfar driver had problems.
> While the the Gianfar was detected
> [...]
> trying to up either of the devices gave me
> 
> [    8.724818] mdio@24520:01 not found
> [    8.728330] eth1: Could not attach to PHY
> [    8.732945] mdio@24520:01 not found
> [    8.737720] eth1: Could not attach to PHY

I saw exactly the same symptoms on an 8560 board, and the patch below
helped. But I have no idea what's going on there ...

Wolfgang

From: Wolfgang Ocker <weo@reccoware.de>
Date: Sat, 7 Mar 2009 14:27:50 +0100
Subject: [PATCH] fsl-gianfar: improved detection of unoccupied PHY address

At least on one 8560 board the id 0x000ffff is returned at an
unoccupied PHY address.

Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
---
 drivers/net/gianfar_mii.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index f49a426..9c5e0c1 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -211,7 +211,7 @@ static int gfar_mdio_find_free(struct mii_bus *new_bus)
 		if (get_phy_id(new_bus, i, &phy_id))
 			return -1;
 
-		if (phy_id == 0xffffffff)
+		if (phy_id == 0xffffffff || phy_id == 0x0000ffff)
 			break;
 	}
 
-- 
1.6.0.6
