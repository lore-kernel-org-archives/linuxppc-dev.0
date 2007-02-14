Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A87DEDDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 07:08:07 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l1EK82Gh026696
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 13:08:03 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l1EK82Nr008128
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 14:08:02 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 15/16] Add device tree for Ebony
Date: Wed, 14 Feb 2007 13:08:01 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
In-Reply-To: <6206de08b7f12175bebe669291c66334@kernel.crashing.org>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Josh Boyer" <jwboyer@jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> >> Hmm.  There are two "soc" devices here, one nested under the
> >> first??
> >>
> >> I'm assuming these are two levels of busses the opb bus is attached
> >> to the plb bus.  Is the "soc" device_type the right way to
> >> do this?
> >
> > Right, OPB hangs off of PLB in this case.  I dunno if "soc" is the=20
> > right
> > device type for them though.
>=20
> I would use device_type "plb" (or "plb4") and "opb" I think.
> Similar to how PCI and ISA etc. busses are represented.

I think we should avoid making up new device_types unlesss it
really is necessary.

Is it really necessary to distinguish between devices on
the PLB or OPB?

As I undestand it the "soc" device type is a logical container
for a group of devices in an SOC, not necessarily a group
of devices on the same bus.  Could we simply list all those
devices under an "soc" node at the same level.

If for some reason the bus hierarchy distinction _is_ required,
my suggestion would be to create new generic device type for
representing an internal bus.   The "device_type" is supposed
to be somewhat general-- "network", "serial", etc.

We could create something like "soc-bus" or "internal-bus" with
a compatible field that identifies the type of bus.

The general philosophy is a general device_type prooperty and
a specific compatible property.

Stuart Yoder
