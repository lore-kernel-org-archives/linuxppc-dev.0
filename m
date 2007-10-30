Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8F1C9DE1E9
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 01:56:48 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9UEuWrb029264
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 07:56:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9UEuWUn022759
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 09:56:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Tue, 30 Oct 2007 07:56:33 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
In-Reply-To: <20071030005146.GF29263@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Olof Johansson" <olof@lixom.net>
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
> From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
> Sent: Monday, October 29, 2007 7:52 PM
> To: Olof Johansson
> Cc: Yoder Stuart-B08248; linuxppc-dev@ozlabs.org
> Subject: Re: RFC: replace device_type with new "class" property?
>=20
> On Mon, Oct 29, 2007 at 04:22:13PM -0500, Olof Johansson wrote:
> [snip]
> > I don't see how switching the property name from "device_type" to
> > "class" is going to stop people from misunderstanding it's intended
> > use. There's nothing inherently more understandable in calling it
> > "class" -- it also invites people to make up their own class names
> > as they go along, just as what happened to "device_type".
> >=20
> > I also don't understand the people wanting to use "compatible"
> > for _everything_. It's just mashing together two separate pieces of
> > information into one property, and I seriously don't see=20
> how that helps
> > anything or anyone. It's absolutely useless for a driver to=20
> be able to
> > bind to a compatible field of "standard,network" or=20
> whatever it might be,
> > since there's no way that "standard," will imply that the=20
> register layout
> > and programming model is somehow the same as all other=20
> standard-labelled
> > devices.
> >=20
> > So yes, there is a problem with the device trees and how=20
> people build
> > them, and it requires education on how to properly craft=20
> one. I don't
> > think changing the layout to either be flatter (only using=20
> compatible),
> > or changing names of a property (device_type->class) will=20
> help anything
> > at all.
> >=20
> > I actually prefer keeping device_type myself, since it=20
> means existing
> > OF-based device trees will already have some of the labels.
>=20
> Yeah.. what he said.
>=20
> The *only* substantive change with the "class" proposal is the fact
> that multiple classes can be specified.  That's nice, but I don't
> think it's worth the trouble of attempting to define a whole new chunk
> of standard for.

I tend to agree, but I think device_type serves a useful
purpose.   I don't think we should deprecate it.

> Stuart, I think you overestimate the value of this class property to a
> human reader.  The generic names convention (not followed as much as
> it should be) means the name should give the reader some idea of what
> the device is, in most cases.  For trickier cases, if we really want
> something for humans reading the tree, we could add an optional
> "comment" or "description" property with purely human readable
> information.
>=20
> I think we should leave existing IEEE1275 defined uses of device_type,
> in order not to make flat trees gratuitously different from real-OF
> trees, but we should avoid any new use of device_type.

I'm fine with keeping device_type, but there are a few
of things I don't like about the 'no new use'.

1.  There are types of nodes that don't have a programming
    inteface per se and thus no compatible.
    "cpu", "memory", "cache" are 3 that come to mind.

    What if there is a _new_ class of nodes of this type?
    What is wrong with a new use of device_type for something
    say like "i2c"?

    Conceptually and ideally, what _is_ the right way to
    represent these types of devices.

2.  'Existing IEEE1275 defined uses' of device_type is=20
    actually very vague.  There are a conglomeration of
    old bindings, recommended practices, proposals and
    it is not clear at all which are useful or not.  What
    are the existing IEEE1275 uses???   I actually went
    through all the OF documents and there are dozens
    of device types that have no practical use.

    Also, many 'real-OF' trees seem to follow no published
    binding at all.

    Conceptually, I'd like to a crisp list of 'official'
    bindings and hope that the current ePAPR work in
    power.org will establish this list.   =20

3.  You're advocating deprecating device_class, but still
    requiring it for certain node types.  So a "network"
    node is _required_ to have the deprecated
    device_type=3D"network".   But a "i2c" node is required
    _not_ to have device_type.  Long term, I'd like to see
    any inconsitency be removed.  If device_type is=20
    deprecated, it's use should be optional in flat=20
    device trees.   That goes for "cpu", "memory", etc.

I think what we should do is keep device_type, including
permitting new uses of it in a limited way-- only permitting
the use of device_type when there is an official binding
(like in the power.org ePAPR) defined.   =20

> Explicitly specifying what device class bindings / conventions the
> node complies with is cute, but not actually all that useful in
> practice.  If it looks like a "duck" class device node, and it
> quacks^Whas the properties of a "duck" class device node, it's "duck"
> class compliant.
>=20
> Or to look at it another way, "class bindings" aren't really bindings,
> but rather a set of conventions that device bindings for specific
> devices in that class ought to follow.

I tend to think of a 'binding' as a 'set of conventions'.
