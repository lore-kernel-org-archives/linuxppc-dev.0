Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144]) by ozlabs.org (Postfix) with ESMTP id 778E4B70E1
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 04:26:01 +1000 (EST)
Received: from mail28-db3 (localhost.localdomain [127.0.0.1])	by
	mail28-db3-R.bigfish.com (Postfix) with ESMTP id 19B125B83CE	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 18:25:57 +0000 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.249])	by
	mail28-db3.bigfish.com (Postfix) with ESMTP id C3E40D2804F	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 18:25:56 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6MIPoJ5023991	for
	<linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 11:25:50 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6MId3N4018804	for <linuxppc-dev@ozlabs.org>;
	Thu, 22 Jul 2010 13:39:03 -0500 (CDT)
Date: Thu, 22 Jul 2010 13:25:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 2/2] mpc85xx_edac: change to use new definitions for PCI
	EDAC regspace
Message-ID: <20100722132548.6eef941b@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
References: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
	<1279756992-29543-2-git-send-email-dbaryshkov@gmail.com>
	<566EC982-1CDA-4806-8EC0-8C9F36448F83@kernel.crashing.org>
	<AANLkTim7kbHsouc==7gRAuRO6AYMNVdA4yyPFpRBC+QR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jul 2010 20:48:15 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> Hello,
>=20
> On Thu, Jul 22, 2010 at 7:38 PM, Kumar Gala <galak@kernel.crashing.org> w=
rote:
> >
> > On Jul 21, 2010, at 7:03 PM, Dmitry Eremin-Solenikov wrote:
> >
> >> Currently (as mpc8540-pci) devices are not created on of_platform bus,
> >> mpc85xx_edac can't probe to them. Follow the change to dts trees to bi=
nd
> >> not to the main mpc8540-pci node but to special mpc85xx-pci-error node=
s,
> >> present on soc bus.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> >> drivers/edac/mpc85xx_edac.c | =A0 18 +++++++++---------
> >> 1 files changed, 9 insertions(+), 9 deletions(-)
> >
> > Nak.
> >
> > We already have a node in the dts for the PCI controller. =A0Lets updat=
e the platform code to add the pci controller to the of_platform_bus_probe =
list.
>=20
> I've had that idea. However it's really look strange to me to call
> of_platform_bus_probe() on the bus node, for which we (IMO) explicitly
> won't like for
> child devices (PCI devices) to be added to of_platform bus.

Right, and it's also not great for a driver for one aspect of PCI to
claim to be the driver for the whole thing.

But changing the device tree because of this Linux-internal concern is
also not good.

How about keeping the error stuff as a separate device from Linux's
perspective, but have the main Freescale PCI code create it as a
platform device instead of putting it in the device tree?

-Scott
