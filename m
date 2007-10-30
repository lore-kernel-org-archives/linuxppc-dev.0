Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 10:27:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071030232730.GD2784@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 07:56:33AM -0700, Yoder Stuart-B08248 wrote:
[snip]
> > Yeah.. what he said.
> > 
> > The *only* substantive change with the "class" proposal is the fact
> > that multiple classes can be specified.  That's nice, but I don't
> > think it's worth the trouble of attempting to define a whole new chunk
> > of standard for.
> 
> I tend to agree, but I think device_type serves a useful
> purpose.   I don't think we should deprecate it.
> 
> > Stuart, I think you overestimate the value of this class property to a
> > human reader.  The generic names convention (not followed as much as
> > it should be) means the name should give the reader some idea of what
> > the device is, in most cases.  For trickier cases, if we really want
> > something for humans reading the tree, we could add an optional
> > "comment" or "description" property with purely human readable
> > information.
> > 
> > I think we should leave existing IEEE1275 defined uses of device_type,
> > in order not to make flat trees gratuitously different from real-OF
> > trees, but we should avoid any new use of device_type.
> 
> I'm fine with keeping device_type, but there are a few
> of things I don't like about the 'no new use'.
> 
> 1.  There are types of nodes that don't have a programming
>     inteface per se and thus no compatible.
>     "cpu", "memory", "cache" are 3 that come to mind.

Well, yes, this is why I suggested treating these "fundamental" nodes
as a special case in an earlier mail.

>     What if there is a _new_ class of nodes of this type?
>     What is wrong with a new use of device_type for something
>     say like "i2c"?

Memory and cpu are pretty clearly special cases - if they're not
there, you don't have a computer at all.  The programming model for
"memory" is always the same", and the programming model for the cpu
has to be known before reading the device tree anyway.  I don't think
we need to worry about new classes of such things - i2c is *certainly*
not an example of such.

cache is a bit weird, because although there can be different types,
the programming model is essentially determined by the cpu to which it
is attached, and the nodes for cache are really just to give details
of sizes and levels.

>     Conceptually and ideally, what _is_ the right way to
>     represent these types of devices.
> 
> 2.  'Existing IEEE1275 defined uses' of device_type is 
>     actually very vague.  There are a conglomeration of
>     old bindings, recommended practices, proposals and
>     it is not clear at all which are useful or not.  What
>     are the existing IEEE1275 uses???   I actually went
>     through all the OF documents and there are dozens
>     of device types that have no practical use.
> 
>     Also, many 'real-OF' trees seem to follow no published
>     binding at all.
> 
>     Conceptually, I'd like to a crisp list of 'official'
>     bindings and hope that the current ePAPR work in
>     power.org will establish this list.    

Yeah, sorry, I am being a bit vauge here and we do need to be more
specific.  My point is that if you take a tree from a real OF, with
lots of device_type values representing programming interfaces, then
flatten it, it shouldn't be considered "bad" as a flattened tree.
It's fine if most or all of the device_type values are optional in the
flattened tree, so that it's ok whether or not they're present.

> 3.  You're advocating deprecating device_class, but still
>     requiring it for certain node types.  So a "network"
>     node is _required_ to have the deprecated
>     device_type="network".   But a "i2c" node is required
>     _not_ to have device_type.  Long term, I'd like to see
>     any inconsitency be removed.  If device_type is 
>     deprecated, it's use should be optional in flat 
>     device trees.   That goes for "cpu", "memory", etc.
> 
> I think what we should do is keep device_type, including
> permitting new uses of it in a limited way-- only permitting
> the use of device_type when there is an official binding
> (like in the power.org ePAPR) defined.    

That's what I was thinking when we first started defining flat tree
bindings.  But the more time I've spent thinking about it, and the
more time I've spent reviewing people's proposed bindings, the less
useful I think it is.

The *only* reason I'm suggesting leaving device_type values for
IEEE1275 defined classes is so that flat trees written as flat trees
look more similar to OF derived trees.

> > Explicitly specifying what device class bindings / conventions the
> > node complies with is cute, but not actually all that useful in
> > practice.  If it looks like a "duck" class device node, and it
> > quacks^Whas the properties of a "duck" class device node, it's "duck"
> > class compliant.
> > 
> > Or to look at it another way, "class bindings" aren't really bindings,
> > but rather a set of conventions that device bindings for specific
> > devices in that class ought to follow.
> 
> I tend to think of a 'binding' as a 'set of conventions'.

Well, whatever.  My point is that conventions are most flexible if you
don't have to explicitly announce that you're following them - you
just go ahead and follow as many conventions as make sense for your
device.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
