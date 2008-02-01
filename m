Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8B5FDDDF6
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 15:07:00 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m1146THl003927
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 21:06:44 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m1146Rk8024163
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 22:06:28 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/6] Add multi mport support.
Date: Fri, 1 Feb 2008 12:06:26 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEBD08C8@zch01exm26.fsl.freescale.net>
In-Reply-To: <1201804525.14266.45.camel@pterry-fc6.micromemory.com>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0677@zch01exm26.fsl.freescale.net>
	<EC566605-6890-4983-8700-3B15C9EFC1C5@kernel.crashing.org>
	<F2D2FCC7-D1ED-4DC6-BE7A-EE2755CCE125@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0697@zch01exm26.fsl.freescale.net>
	<1201804525.14266.45.camel@pterry-fc6.micromemory.com>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: <pterry@vmetro.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Phil,

> -----Original Message-----
> From: Phil Terry [mailto:pterry@micromemory.com]=20
>=20
> On Thu, 2008-01-31 at 14:30 +0800, Zhang Wei wrote:
> > =20
> > > >
> > I consider each RIO controller will has its own network,=20
> the device IDs
> > should be
> > unique only in its port network.
> Hmmm, I see two cases:

Good questions! They are very important and also my concern now.

>=20
> 1. I have two mport to two controllers each connected to different
> physical fabrics. This system can act as an application bridge between
> the two fabrics.
>=20

The current driver just looks two mport as two independent fabrics.
We can add bridge driver to implement your idea.

> 2. I have two mports to two controllers each connected directly or
> indirectly to the same fabric. I want to use the extra bandwidth and
> load balance and/or have a fall back redundant connection via an
> alternate physical connection to the fabric etc.
>=20

That's a terrible thing in the current driver. Two mports get the same
 ID in one fabric. About the port bound, it's a good idea, I also need
 a new driver to support it.

In fact, our first mission is to make the RapidIO driver ported from ppc
to powerpc can
 be compiled and run. Fortunately, there is no more than one port in
processor now,
 we have time to implement it.

> What should be the rules for allocating the initial IDs to the two
> mports to allow system wide enumeration to work in both of the above
> cases?=20
>=20

A choice is add ID option into dts node. I have some ideas about RapidIO
 driver in u-boot. U-boot can assign ID in dts and tell kernel.

> What do you expect the semantics of higher level addressing to be:
>  a pair <mport,id>, where <x,n> is a different device from <y,n>,
>  a pair <mport,id>, where <x,n> is the same device as <y,n>,or
>  a singleton n, where n is unique and identifies the first=20
> routing step
> of which controller, x or y, to use.

It seems the address pair is a must-be selection as pci bus.
But now, no connection between ports. Every operations in only
 in its own port view.

> I smell a can of worms.... :-)

A good nose! Thanks! :)

Cheers!
Wei
