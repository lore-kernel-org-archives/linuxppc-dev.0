Subject: Re: Fix for autonegotiation of ppc 40x ethernet driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ronald Wahl <rwa@peppercon.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <m3brss87p4.fsf@gandalf.peppercon.de>
References: <m3brss87p4.fsf@gandalf.peppercon.de>
Content-Type: text/plain
Message-Id: <1065602490.30751.84.camel@gaston>
Mime-Version: 1.0
Date: Wed, 08 Oct 2003 10:41:31 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-10-08 at 10:17, Ronald Wahl wrote:
> Hello,
>
> I have found a bug in the ethernet driver for the PPC 40x. The problem
> is that the driver doesn't deal correctly if a user wants a limited
> advertising range (via ethtool interface) - lets say 10Mbps/Halfduplex
> and 10MBps/Fullduplex. The link always enters 100MBps/Fullduplex mode if
> the link partner supports it. This is an incorrect behavior. I appended
> a fix for this (against 2.4.22+ of the linuxppc 3.4 devel tree). It
> would be nice if this change could be reviewed and incorporated into the
> official code. If any questions arise - just ask...

Hi !

There may well be a bug in the code, but I'm not sure this is
the proper fix. When setting up a forced mode, I'm not sure it's
worth playing with advertise at all in fact... Just having the
link up shall be enough if aneg is disabled, we could ignore
LPA/ADVERTISE completely. Or maybe just read back BMCR from
read_link...

Ben.

> - ron
>
> Index: drivers/net/ibm_emac/ibm_ocp_enet.c
> ===================================================================
> RCS file: /var/CVS/eric_firmware/linuxnew/drivers/net/ibm_emac/ibm_ocp_enet.c,v
> retrieving revision 1.1.23.1
> diff -u -r1.1.23.1 ibm_ocp_enet.c
> --- drivers/net/ibm_emac/ibm_ocp_enet.c	4 Sep 2003 12:27:54 -0000	1.1.23.1
> +++ drivers/net/ibm_emac/ibm_ocp_enet.c	8 Oct 2003 07:59:34 -0000
> @@ -928,8 +928,7 @@
>  	int forced_duplex;
>
>  	/* Default advertise */
> -	advertise = ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full |
> -		    ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full;
> +	advertise = fep->advertising;
>  	autoneg = fep->want_autoneg;
>  	forced_speed = fep->phy_mii.speed;
>  	forced_duplex = fep->phy_mii.duplex;
> @@ -938,6 +937,7 @@
>  	if (ep) {
>  	    if (ep->autoneg == AUTONEG_ENABLE) {
>  		advertise = ep->advertising;
> +		fep->advertising = advertise;
>  		autoneg = 1;
>  	    } else {
>  		autoneg = 0;
> @@ -1114,7 +1114,7 @@
>  emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  {
>  	struct ocp_enet_private *fep = dev->priv;
> -	uint *data = (uint *) & rq->ifr_data;
> +	ushort *data = (ushort *) & rq->ifr_data;
>
>  	switch (cmd) {
>          case SIOCETHTOOL:
> @@ -1367,8 +1367,12 @@
>  	if (ep->phy_mii.def->ops->init)
>  	        ep->phy_mii.def->ops->init(&ep->phy_mii);
>  	netif_carrier_off(ndev);
> -        if (ep->phy_mii.def->features & SUPPORTED_Autoneg)
> +        if (ep->phy_mii.def->features & SUPPORTED_Autoneg) {
>                  ep->want_autoneg = 1;
> +		ep->advertising =
> +			ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full |
> +			ADVERTISED_100baseT_Half | ADVERTISED_100baseT_Full;
> +	}
>  	emac_start_link(ep, NULL);
>
>
> Index: drivers/net/ibm_emac/ibm_ocp_enet.h
> ===================================================================
> RCS file: /var/CVS/eric_firmware/linuxnew/drivers/net/ibm_emac/ibm_ocp_enet.h,v
> retrieving revision 1.1.23.1
> diff -u -r1.1.23.1 ibm_ocp_enet.h
> --- drivers/net/ibm_emac/ibm_ocp_enet.h	4 Sep 2003 12:27:54 -0000	1.1.23.1
> +++ drivers/net/ibm_emac/ibm_ocp_enet.h	8 Oct 2003 07:59:34 -0000
> @@ -136,6 +136,7 @@
>  	struct mii_phy phy_mii;
>          int mii_phy_addr;
>          int want_autoneg;
> +	u32 advertising;
>          int timer_ticks;
>  	struct timer_list link_timer;
>  	struct net_device *mdio_dev;
> Index: drivers/net/ibm_emac/ibm_ocp_phy.c
> ===================================================================
> RCS file: /var/CVS/eric_firmware/linuxnew/drivers/net/ibm_emac/ibm_ocp_phy.c,v
> retrieving revision 1.1.23.1
> diff -u -r1.1.23.1 ibm_ocp_phy.c
> --- drivers/net/ibm_emac/ibm_ocp_phy.c	4 Sep 2003 12:27:54 -0000	1.1.23.1
> +++ drivers/net/ibm_emac/ibm_ocp_phy.c	8 Oct 2003 07:59:34 -0000
> @@ -151,16 +151,17 @@
>
>  static int genmii_read_link(struct mii_phy *phy)
>  {
> -	u16 lpa;
> +	u16 adv, lpa;
>
>  	if (phy->autoneg) {
> +		adv = phy_read(phy, MII_ADVERTISE);
>  		lpa = phy_read(phy, MII_LPA);
>
> -		if (lpa & (LPA_10FULL | LPA_100FULL))
> +		if ((lpa & adv) & (LPA_10FULL | LPA_100FULL))
>  			phy->duplex = DUPLEX_FULL;
>  		else
>  			phy->duplex = DUPLEX_HALF;
> -		if (lpa & (LPA_100FULL | LPA_100HALF))
> +		if ((lpa & adv) & (LPA_100FULL | LPA_100HALF))
>  			phy->speed = SPEED_100;
>  		else
>  			phy->speed = SPEED_10;
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
