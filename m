Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E2A82DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 03:38:04 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l1FGc0Au002034
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 09:38:01 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1FGc02K002079
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 10:38:00 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 15/16] Add device tree for Ebony
Date: Thu, 15 Feb 2007 09:37:59 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BABF@az33exm25.fsl.freescale.net>
In-Reply-To: <889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<20070214232246.GE16279@localhost.localdomain>
	<fbff2510963c6c5bb9d5ccb0574f97b1@kernel.crashing.org>
	<20070215015316.GL16279@localhost.localdomain>
	<889579906c6fd096a82283d5a3a0227e@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
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
> From: Segher Boessenkool [mailto:segher@kernel.crashing.org]=20
> Sent: Wednesday, February 14, 2007 9:09 PM
> To: David Gibson
> Cc: linuxppc-dev@ozlabs.org; Yoder Stuart-B08248
> Subject: Re: [PATCH 15/16] Add device tree for Ebony
>=20
> >> Yes.  UIC1 is not addressed via UIC0, and as such should
> >> not be a child of it; it should be a direct child of its DCR
> >> controller, just like UIC0.
> >
> > No, the DCR tree, like the interrupt tree in most cases, is
> > independent of the main tree structure.
>=20
> Yes true; you can hang the UICs from somewhere under the
> "soc" node or whatever you want.  You need some way to
> distinguish separate identical devices though; you can't
> do it by device unit since your devices don't have any
> (they don't have a "reg" but only a "dcr-reg").  If you
> would hang them in a DCR tree, you could use the plain
> "reg" property instead of the "dcr-reg" property and
> all would be fine (if the DCR binding allows this -- and
> it better should, it is the standard OF addressing algorithm).

Is there a DCR binding?  Are the dcr-* properties documented=20
anywhere:

dcr-reg         // what do these fields mean?
dcr-parent      // in case there is more than one controller??
dcr-controller
dcr-access-method =3D "native"   // what are the other options?

Stuart
