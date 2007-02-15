Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8C7D0DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 08:26:46 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1FLQg3O013083
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 14:26:43 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1FLQggA011895
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 15:26:42 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: purpose of /chosen node (was RE: [PATCH] powerpc: delete boot-cpu and
	chosen nodes from all DTSfiles)
Date: Thu, 15 Feb 2007 14:26:41 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
In-Reply-To: <c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
References: <11713852392294-git-send-email-timur@freescale.com><20070214003119.GF11491@localhost.localdomain><45D29BBA.7090401@freescale.com><20070214052440.GB12609@localhost.localdomain><45D31734.7030808@freescale.com><20070214233348.GH16279@localhost.localdomain>
	<c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
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
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Segher Boessenkool
> Sent: Wednesday, February 14, 2007 7:40 PM
> To: David Gibson
> Cc: linuxppc-dev@ozlabs.org; Tabi Timur-B04825
> Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen=20
> nodes from all DTSfiles
>=20
> > My point is that the interrupt-controller property in=20
> /chosen *should*
> > be there, but it doesn't make a lot of sense for it to be set by the
> > bootloader (because it's a fixed property of the board).
>=20
> And that means it shouldn't be in /chosen at all.  It's not
> just a fixed property of the board, it is a physical property
> of the board.  It doesn't belong in /chosen.

I agree with Segher here.  The interrupt-controller property doesn't
belong in /chosen.

The 1275 OF spec says about /chosen:

   Has properties describing parameters chosen or specified at
   runtime.

The typical properties are boot device, boot args, console, etc--=20
i.e. dynamic stuff set by software and not describing the physical
hardware.

I think we should stick with this definition.  Separating the
dynamic properties set by firmware with physical properties of
board is cleaner and follows the original intent of /chosen.

If the kernel needs a convenient place to keep a phandle to the
top level interrupt controller, how about just under root?
(Or, we could make up a new node)

If we can remove physical board dependencies from /chosen then
we could also remove it from the DTS files and require that firmware
set up /chosen.

For obscure cases where firmware can't do this for some reason,
the developer can simply add a /chosen section to his private
DTS file.

Thoughts?

Stuart Yoder
