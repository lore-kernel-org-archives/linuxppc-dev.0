Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id AAEECDDE0E
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 22:54:42 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <cbou@mail.ru>,
	"'Jochen Friedrich'" <jochen@scram.de>
References: <20071126142906.19642.45540.stgit@localhost.localdomain><47516646.9000803@scram.de>
	<20071201213403.GA2350@zarina>
Subject: RE: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate PHYlayer
	functionality
Date: Sun, 2 Dec 2007 12:54:36 +0100
Message-ID: <051e01c834da$1cce82f0$5267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20071201213403.GA2350@zarina>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	'Jeff Garzik' <jeff@garzik.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[SNIP]
> ^^ the correct solution is to implement arch_initcall function
> which will create fixed PHYs, and then leave only
> snprintf(fpi->bus_id, 16, PHY_ID_FMT, 0, *data); part in the
> fs_enet's find_phy().
> 
> Try add something like this to the fsl_soc.c (compile untested):
> 
> - - - -
> static int __init of_add_fixed_phys(void)
> {
> 	struct device_node *np;
> 	const u32 *prop;
> 	struct fixed_phy_status status = {};
> 
> 	while ((np = of_find_node_by_name(NULL, "ethernet"))) {
> 		data  = of_get_property(np, "fixed-link", NULL);
> 		if (!data)
> 			continue;
> 
> 		status.link = 1;
> 		status.duplex = data[1];
> 		status.speed  = data[2];

What about Pause and Asym_Pause? Dunno why so few, if any, eth drivers
impl. it, but the PHY lib supports it.
Even if fixed PHYs doesn't support it directly I think the OF interface
should have it.

    - fixed-link : <a b c d e> where a is emulated phy id - choose any,
      but unique to the all specified fixed-links, b is duplex - 0 half,
      1 full, c is link speed - d#10/d#100/d#1000, d is pause - 0 no pause,
      1 pause, d asym_pause - 0 no asym_pause, 1 asym_pause.

Jocke

> 
> 		ret = fixed_phy_add(PHY_POLL, data[0], &status);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	return 0;
> }
> arch_initcall(of_add_fixed_phys);
> - - - -
> 
> And remove fixed_phy_add() from the fs_enet. This should work
> nicely and also should be ideologically correct. ;-)
> 
> > How is this supposed to work for modules or for the
> > PPC_CPM_NEW_BINDING mode where the device tree is no longer scanned
> > during fs_soc initialization but during device initialization?
> 
> We should mark fixed.c as bool. Fake/virtual/fixed/platform PHYs
> creation is architecture code anyway, can't be =m.
> 
> -- 
> Anton Vorontsov
> email: cbou@mail.ru
> backup email: ya-cbou@yandex.ru
> irc://irc.freenode.net/bd2
