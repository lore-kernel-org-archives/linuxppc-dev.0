Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85A06DDEBF
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 15:35:41 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6O5ZCFd014576
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jul 2007 22:35:27 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6O5ZBf5000046
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 00:35:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 5/6 v2] 85xxCDS: Misc 8548 PCI Corrections.
Date: Tue, 24 Jul 2007 13:35:09 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E957AB6@zch01exm23.fsl.freescale.net>
In-Reply-To: <46A4ED9E.6010307@mvista.com>
References: <46A10578.6030609@mvista.com>	
	<DF1A9889-840C-4D19-9824-177DFEFE298F@kernel.crashing.org>	
	<46A133CF.6010407@mvista.com> <46A137C1.3080105@mvista.com>
	<1185185072.25737.1.camel@localhost.localdomain>
	<46A4ED9E.6010307@mvista.com>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Randy Vinson" <rvinson@mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Randy Vinson [mailto:rvinson@mvista.com]=20
> Zang Roy-r61911 wrote:
> > On Sat, 2007-07-21 at 06:31, Randy Vinson wrote:
> >=20
> >> @@ -272,10 +272,10 @@ static void __init=20
> mpc85xx_cds_setup_arch(void)
> >>         for (np =3D NULL; (np =3D of_find_node_by_type(np, "pci")) =
!=3D
> >> NULL;) {
> >>                 struct resource rsrc;
> >>                 of_address_to_resource(np, 0, &rsrc);
> >> -               if ((rsrc.start & 0xfffff) =3D=3D 0x9000)
> >> -                       fsl_add_bridge(np, 0);
> >> -               else
> >> +               if ((rsrc.start & 0xfffff) =3D=3D 0x8000)
> >>                         fsl_add_bridge(np, 1);
> >> +               else
> >> +                       fsl_add_bridge(np, 0);
> > Why this is needed?
> > For pcie@a000, fsl_add_bridge(np, 0)?
> The old version of the code would call fsl_add_bridge(np, 1) for the
> host bridges @8000 and @a000. When I tried it that way, it=20
> didn't work
What did not work? I tried two Ethernet cards @8000 and @a000. they
worked..
> I don't think you can have 2 primary bridges.
Why?
They belong to two separate pci domain.
Roy
