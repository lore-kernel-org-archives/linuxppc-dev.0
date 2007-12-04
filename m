Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2129DDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 18:23:40 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lB47NZEf019261
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 00:23:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB47NX5C012020
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 01:23:34 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] ipic: change ack operation that register isaccessedonly
	when needed
Date: Tue, 4 Dec 2007 15:23:30 +0800
Message-ID: <989B956029373F45A0B8AF029708189001B4D360@zch01exm26.fsl.freescale.net>
In-Reply-To: <1196734556.13230.258.camel@pasglop>
References: <1196684780-28408-1-git-send-email-leoli@freescale.com>
	<1196715747.13230.233.camel@pasglop>
	<989B956029373F45A0B8AF029708189001B4D2DE@zch01exm26.fsl.freescale.net>
	<1196734556.13230.258.camel@pasglop>
From: "Li Yang" <LeoLi@freescale.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Tuesday, December 04, 2007 10:16 AM
> To: Li Yang
> Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Subject: RE: [PATCH] ipic: change ack operation that register=20
> isaccessedonly when needed
>=20
>=20
> On Tue, 2007-12-04 at 10:06 +0800, Li Yang wrote:
> > > That should be handled by the higher level flow handler.=20
> The generic=20
> > > edge one calls ack and the level one mask_and_ack.
> > > Just make them do the right thing, no need to test for=20
> the flow type=20
> > > in the low level function.
> >=20
> > But actually ack is called by edge and per cpu handlers. =20
> Mask_and_ack=20
> > is also called by edge handler when the same interrupt is=20
> already in=20
> > progress.  So I don't think that ack/mask_and_ack=20
> implicates flow type=20
> > by design.
>=20
> They do and you can pass different irq_chip with different=20
> mask/ack routines if necessary.
Hi Ben,

I mean that mask_ack_irq() routine is used by both generic
handle_edge_irq() and handle_level_irq().  mask_ack_irq doesn't know if
the flow type is level or edge.  Do you suggest to use different
irq_chip for level and edge?

- Leo
