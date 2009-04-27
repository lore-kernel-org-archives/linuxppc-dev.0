Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1ED4EDDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 03:36:18 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3RHa7u1020045
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 10:36:13 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n3RHa63R001512
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 12:36:07 -0500 (CDT)
Date: Mon, 27 Apr 2009 12:36:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] net: Fix ucc_geth.c handling of phy 'interface' property.
Message-ID: <20090427173606.GA10292@ld0162-tx32.am.freescale.net>
References: <20090427153612.5108.10877.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090427153612.5108.10877.stgit@localhost.localdomain>
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 09:36:13AM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Previous rework to ucc_geth.c to add of_mdio support (net: Rework
> ucc_geth driver to use of_mdio infrastructure) added a block of
> code which broke older openfirmware device trees which use an
> 'interface' property in the phy node to describe the connection
> between the MAC and the PHY.  This patch removes the offending blurb.
[snip]
>  	prop = of_get_property(np, "phy-connection-type", NULL);
>  	if (!prop) {
>  		/* handle interface property present in old trees */
> -		if (!phy)
> -			return -ENODEV;
> -
>  		prop = of_get_property(phy, "interface", NULL);
>  		if (prop != NULL) {
>  			phy_interface = enet_to_phy_interface[*prop];

The above test only makes a difference when there is no phy node -- so I
don't see how it was breaking device trees that had a phy node (with or
without an "interface" property).  I can see it breaking fixed link
device trees, though.

-Scott
