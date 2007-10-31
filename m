Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7FAEBDDE2C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:31:08 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9VFV2jM008804
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:31:03 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VFV20s016358
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 10:31:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Wed, 31 Oct 2007 08:31:02 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2AC3@az33exm25.fsl.freescale.net>
In-Reply-To: <20071030232730.GD2784@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
	<20071030232730.GD2784@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> > I think what we should do is keep device_type, including
> > permitting new uses of it in a limited way-- only permitting
> > the use of device_type when there is an official binding
> > (like in the power.org ePAPR) defined.   =20
>=20
> That's what I was thinking when we first started defining flat tree
> bindings.  But the more time I've spent thinking about it, and the
> more time I've spent reviewing people's proposed bindings, the less
> useful I think it is.
>=20
> The *only* reason I'm suggesting leaving device_type values for
> IEEE1275 defined classes is so that flat trees written as flat trees
> look more similar to OF derived trees.
>=20
> > > Explicitly specifying what device class bindings / conventions the
> > > node complies with is cute, but not actually all that useful in
> > > practice.  If it looks like a "duck" class device node, and it
> > > quacks^Whas the properties of a "duck" class device node,=20
> it's "duck"
> > > class compliant.
> > >=20
> > > Or to look at it another way, "class bindings" aren't=20
> really bindings,
> > > but rather a set of conventions that device bindings for specific
> > > devices in that class ought to follow.
> >=20
> > I tend to think of a 'binding' as a 'set of conventions'.
>=20
> Well, whatever.  My point is that conventions are most flexible if you
> don't have to explicitly announce that you're following them - you
> just go ahead and follow as many conventions as make sense for your
> device.

Let me repeat what I think you are advocating--  we should
treat the collection of properties for 'established' device
classes like like "network", "serial", etc as a set of useful=20
conventions.  That is, there are no set of _required_ properties
per se, but the device tree creator picks from the established
properties plus supplementing with "company,xyz" properties
in whatever way they think makes sense for them.

This works...but certainly is weaker with respect to
standardization.  My previous argument had the assumption
that something like "mac-address" in a network node was
_required_, and thus needed a class id of some sort to tie
the standardized node to.

If we relax things so there are no required properties for
device nodes, then I agree that a device class property
has limited or no value.

However, maybe we do want to keep device_type in=20
a very limited way to define requirements for what you
call 'fundamental' types of nodes.  It may be that certain
properties in a "cpu" node (like cache-size?) should be
_required_ so that an OS that consumes the device tree
can really count on certain properties being there.  Or,
I guess we could use "compatible" for that...?

Stuart
