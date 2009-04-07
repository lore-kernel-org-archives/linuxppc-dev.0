Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 032D1DDFA1
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 04:09:58 +1000 (EST)
Date: Tue, 7 Apr 2009 22:09:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc: 85xx: Add PHY fixup to socrates board code
Message-ID: <20090407180957.GA2831@oksana.dev.rtsoft.ru>
References: <1239113988-4579-1-git-send-email-agust@denx.de>
	<20090407143011.GA15727@oksana.dev.rtsoft.ru>
	<49DB8C3C.5080306@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <49DB8C3C.5080306@denx.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2009 at 07:24:12PM +0200, Anatolij Gustschin wrote:
> Anton Vorontsov wrote:
> > On Tue, Apr 07, 2009 at 04:19:48PM +0200, Anatolij Gustschin wrote:
> >> If the firmware missed to initialize the PHY correctly,
> >> Linux may hang up on socrates while eth0/eth1 interface
> >> startup (caused by continuous unacknowledged PHY interrupt).
> >>
> >> This patch adds PHY fixup to socrates platform code to
> >> ensure the PHY is pre-initialized correctly. It is needed
> >> to be compatible with older firmware.
> > 
> > Is that really board-specific fixup, or can it be placed
> > somewhere inside drivers/net/phy/marvell.c?
> 
> On this board the multi-PHY is configured to use shared IRQ pin
> for both PHY ports. Placing this fixup in drivers/net/phy/marvell.c
> as e.g. '.config_init' callback could be done, but this will add
> more overhead as the fixup routine have to do more work:
> 
> acquire 'struct mii_bus' pointer and walk through all registered PHYs
> searching for the PHY which use the same interrupt, then getting
> the address of this PHY on the bus and disable and clear PHY irqs
> by writing/reading to/from this PHY, (but only in the case it was
> not already brought up and has interrupts enabled!) e.g.:
> 
> struct mii_bus *bus = phydev->bus;
> int addr;
> 
> for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
> 	struct phy_device *phy = bus->phy_map[addr];
> 
> 	if (addr != phydev->addr && bus->irq[addr] == phydev->irq &&
> 	    (phy->phy_id & 0x0ffffff0) == 0x01410cb0 &&
> 	    !(phy->interrupts & PHY_INTERRUPT_ENABLED)) {
> 
> 		int imask = phy_read(phy, MII_M1011_IMASK);
> 
> 		if (imask) {
> 			phy_write(phy, 0x12, 0); /* disable */
> 			phy_read(phy, 0x13); /* clear */
> 		}
> 	}
> }
> 
> All this to allow support for multiple m88e1121 devices.
> Otherwise, after registering first phy interrupt handler
> and enabling interrupt pending irq on other PHY port or
> other PHY device will lock up the board.
> 
> The fixup in this patch will only be done while mdio bus scan
> before registering a PHY device.

Still, I think you shouldn't do this in a board-specific fixup.
Maybe I'm a bit naive, but shouldn't this work too?

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index b754020..9052937 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -205,6 +205,16 @@ struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr)
 
 	phydev->bus = bus;
 
+	/*
+	 * Some PHYs may have unmasked/pending interrupts, this might
+	 * cause troubles w/ shared IRQs. So try to put the PHYs into
+	 * some sane state.
+	 *
+	 * NOTE: This won't work if you have two PHYs w/ shared IRQs
+	 *       on different MDIO buses.
+	 */
+	phy_disable_interrupts(phydev);
+
 	/* Run all of the fixups for this PHY */
 	phy_scan_fixups(phydev);
 
