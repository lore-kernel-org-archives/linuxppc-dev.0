Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E9CCE68641
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 03:56:12 +1100 (EST)
In-Reply-To: <20051030151847.C4383353416@atlas.denx.de>
References: <20051030151847.C4383353416@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <F77EFD95-B5B3-4B6F-8A99-27EE6F58C568@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Mon, 31 Oct 2005 10:56:10 -0600
To: Wolfgang Denk <wd@denx.de>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: use of phy_connect() in drivers/net/gianfar.c ? 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 30, 2005, at 09:18, Wolfgang Denk wrote:

> Dear Matthew,
>
> in message <1130632707.7470.16.camel@localhost.localdomain> you wrote:
> >
> > As far as I understand there are patches in the -mm tree with =20
> contain
> > the updates for the Gianfar driver. The issue is due to a
>
> Do you happen to know of a specific (set of) patch(es)? URL?
>
> > synchronization issue with the new PHY abstraction layer that was =20=

> added.
>
> Yes, obviously. But I am still so na=EFve to expect that  such  =
changes
> would not make it untested (the code is not even compile clean) to an
> official kernel release like 2.6.14 ?

Sorry about that.  The problem was that the offending changes needed =20
to be broken into two patches.  The PHY Layer (a separate patch) =20
required changes to the driver, which required concurrent changes in =20
the platform init code (the MDIO bus was set up as its own device).  =20
Unfortunately, the driver changes needed to be handled through =20
netdev, while the platform changes were through -mm.  We tried to =20
sync it up so that the changes got into Linus' tree at the same time, =20=

but that did not happen.  If you pull the tree today, you will find =20
that patch is now in the main tree.
