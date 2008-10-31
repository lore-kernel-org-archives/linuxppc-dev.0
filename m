Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6274ADDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 12:17:49 +1100 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: netdev@vger.kernel.org
Subject: [PATCH 2/2] gianfar: Don't reset TBI<->SerDes link if it's already up
Date: Thu, 30 Oct 2008 18:17:07 -0700
Message-Id: <1225415827-8167-2-git-send-email-tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0810301738020.3943@t2.domain.actdsltmp>
References: <Pine.LNX.4.64.0810301738020.3943@t2.domain.actdsltmp>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The link may be up already via the chip's reset strapping, or though action
of U-Boot, or from the last time the interface was brought up.  Resetting
the link causes it to go down for several seconds.  This can significantly
increase the time from power-on to DHCP completion and a device being
accessible to the network.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
Acked-by: Andy Fleming <afleming@freescale.com>
---
 drivers/net/gianfar.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 249541a..83a5cb6 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -591,6 +591,14 @@ static void gfar_configure_serdes(struct net_device *dev)
 	if (bus)
 		mutex_lock(&bus->mdio_lock);
 
+	/* If the link is already up, we must already be ok, and don't need to
+	 * configure and reset the TBI<->SerDes link.  Maybe U-Boot configured
+	 * everything for us?  Resetting it takes the link down and requires
+	 * several seconds for it to come back.
+	 */
+	if (gfar_local_mdio_read(regs, tbipa, MII_BMSR) & BMSR_LSTATUS)
+		goto done;
+
 	/* Single clk mode, mii mode off(for serdes communication) */
 	gfar_local_mdio_write(regs, tbipa, MII_TBICON, TBICON_CLK_SELECT);
 
@@ -601,6 +609,7 @@ static void gfar_configure_serdes(struct net_device *dev)
 	gfar_local_mdio_write(regs, tbipa, MII_BMCR, BMCR_ANENABLE |
 			BMCR_ANRESTART | BMCR_FULLDPLX | BMCR_SPEED1000);
 
+	done:
 	if (bus)
 		mutex_unlock(&bus->mdio_lock);
 }
-- 
1.5.4.1
