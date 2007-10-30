Return-Path: <dgibson@ozlabs.org>
Date: Tue, 30 Oct 2007 11:51:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071030005146.GF29263@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071029212213.GA28073@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 04:22:13PM -0500, Olof Johansson wrote:
[snip]
> I don't see how switching the property name from "device_type" to
> "class" is going to stop people from misunderstanding it's intended
> use. There's nothing inherently more understandable in calling it
> "class" -- it also invites people to make up their own class names
> as they go along, just as what happened to "device_type".
> 
> I also don't understand the people wanting to use "compatible"
> for _everything_. It's just mashing together two separate pieces of
> information into one property, and I seriously don't see how that helps
> anything or anyone. It's absolutely useless for a driver to be able to
> bind to a compatible field of "standard,network" or whatever it might be,
> since there's no way that "standard," will imply that the register layout
> and programming model is somehow the same as all other standard-labelled
> devices.
> 
> So yes, there is a problem with the device trees and how people build
> them, and it requires education on how to properly craft one. I don't
> think changing the layout to either be flatter (only using compatible),
> or changing names of a property (device_type->class) will help anything
> at all.
> 
> I actually prefer keeping device_type myself, since it means existing
> OF-based device trees will already have some of the labels.

Yeah.. what he said.

The *only* substantive change with the "class" proposal is the fact
that multiple classes can be specified.  That's nice, but I don't
think it's worth the trouble of attempting to define a whole new chunk
of standard for.

Stuart, I think you overestimate the value of this class property to a
human reader.  The generic names convention (not followed as much as
it should be) means the name should give the reader some idea of what
the device is, in most cases.  For trickier cases, if we really want
something for humans reading the tree, we could add an optional
"comment" or "description" property with purely human readable
information.

I think we should leave existing IEEE1275 defined uses of device_type,
in order not to make flat trees gratuitously different from real-OF
trees, but we should avoid any new use of device_type.

Explicitly specifying what device class bindings / conventions the
node complies with is cute, but not actually all that useful in
practice.  If it looks like a "duck" class device node, and it
quacks^Whas the properties of a "duck" class device node, it's "duck"
class compliant.

Or to look at it another way, "class bindings" aren't really bindings,
but rather a set of conventions that device bindings for specific
devices in that class ought to follow.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
