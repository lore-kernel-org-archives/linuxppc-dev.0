Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 62A2BDDDFA
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 00:48:58 +1100 (EST)
Message-ID: <47516646.9000803@scram.de>
Date: Sat, 01 Dec 2007 14:48:54 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate PHY layer
	functionality
References: <20071126142906.19642.45540.stgit@localhost.localdomain>
In-Reply-To: <20071126142906.19642.45540.stgit@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

> With that patch fixed.c now fully emulates MDIO bus, thus no need
> to duplicate PHY layer functionality. That, in turn, drastically
> simplifies the code, and drops down line count.
>
> As an additional bonus, now there is no need to register MDIO bus
> for each PHY, all emulated PHYs placed on the platform fixed MDIO bus.
> There is also no more need to pre-allocate PHYs via .config option,
> this is all now handled dynamically.
>
> p.s. Don't even try to understand patch content! Better: apply patch
> and look into resulting drivers/net/phy/fixed.c.
>   
If i understand your code correctly, you seem to rely on the fact 
that fixed_phy_add() is called before the fixed MDIO bus is scanned for 
devices. How is this supposed to work for modules or for the 
PPC_CPM_NEW_BINDING mode where the device tree is no longer scanned 
during fs_soc initialization but during device initialization?

I tried to add fixed-phy support to fs_enet, but the fixed phy is not 
found this way.

--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -36,6 +36,7 @@
 #include <linux/fs.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 
 #include <linux/vmalloc.h>
 #include <asm/pgtable.h>
@@ -1174,8 +1175,24 @@ static int __devinit find_phy(struct device_node *np,
        struct device_node *phynode, *mdionode;
        struct resource res;
        int ret = 0, len;
+       const u32 *data;
+       struct fixed_phy_status status = {};
+
+       data  = of_get_property(np, "fixed-link", NULL);
+       if (data) {
+               status.link = 1;
+               status.duplex = data[1];
+               status.speed  = data[2];
+
+               ret = fixed_phy_add(PHY_POLL, data[0], &status);
+               if (ret)
+                       return ret;
+
+               snprintf(fpi->bus_id, 16, PHY_ID_FMT, 0, *data);
+               return 0;
+       }
 
-       const u32 *data = of_get_property(np, "phy-handle", &len);
+       data = of_get_property(np, "phy-handle", &len);
        if (!data || len != 4)
                return -EINVAL;

Thanks,
Jochen
