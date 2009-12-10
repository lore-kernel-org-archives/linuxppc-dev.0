Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1260409535.16132.109.camel@pasglop>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.161550.168794100.davem@davemloft.net>
	<1260409535.16132.109.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 14:53:38 -0700
Message-ID: <fa686aa40912101353r1ab20c74s4dbf498b18e104f5@mail.gmail.com>
Subject: Re: Deprecating of_platform, the path from here...
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, jk@ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey guys, some more thoughts below...

On Wed, Dec 9, 2009 at 6:45 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> First the probing because that's the real important issue, I believe the
> other one is mostly academic and can be dealt on a per driver basis
> (I'll discuss it later too).
>
> I'm not totally sold on the idea of the table that Grant proposed. I
> think I proposed it initially in a discussion we had on IRC as one
> possible option and in fact it was suggested by Paulus so don't
> completely blame Grant for it though. It does mean that either platform
> code or core code will have some kind of big table that associates a
> whole pile of of_device_id with a platform device name. It somewhat
> sucks when I think more about it and it does feel like a step backward
> from of_platform_device.

For the record, I don't like it either.  But it is the pragmatic thing
to do because it is simple to implement, and can easily be replaced
later with a better scheme with little impact on drivers.  Basically,
it's a migration plan.

> If we could make platform_driver grow an of_device_id match list it
> would be indeed nicer. Of course you'll reply to that "let's just use
> of_platform" instead :-)
>
> I would then argue that I don't like having two different bus types,
> platform and of_platform for "generic platform" devices that aren't
> typed on a bus type. There's a lot of existing "platform device" and it
> would be quite hard to convert them all. Especially since a lot of them
> are used today on archs that don't have device trees and may never grow
> one.
>
> IE. I believe it's going to be an easier path to grow platform_device
> into something that has the of_device probing functionality rather than
> turn everything into of_platform. (I'm not talking here about the pdata
> and retrieval of informations from the tree, this is the second part of
> the discussion, discussed below).
>
> The main problem with moving existing platform_device to of_platform is
> how do we deal with archs that don't have the device-tree infrastructure
> and use those drivers today ?
>
> We could I suppose create a helper that looks a lot like the current
> platform device creation one, which would create an of_platform device
> instead, along with a struct device_node attached (which isn't part of a
> tree) to it, and create a single "compatible" property whose content is
> the platform data name.
>
> But that means that for every driver we want to be able to use a
> device-tree probing for, we would have to convert all archs & platforms
> that may instanciate it to use the new helpers, in addition to replacing
> whatever pdata they have statically stored into a device node (see the
> second part of the discussion).
>
> It's possible I suppose. I just feel that it's going to be a tougher
> sell to the rest of the world.
>
> There's one nit to be careful of. Some drivers (sadly) have the fact
> that they appear under /sys/bus/platform/ as a userspace ABI thingy. Sad
> but a fact. This is one of the reasons why rather than actually
> converting to of_platform I'd rather find a way to add the of_device_id
> match mechanism to the existing platform_device and deprecate the pdata
> over time.
>
> It will also provide with an easier transition. Basically transform
> platform_device into of_platform_device by first adding the missing bits
> and -then- trimming the crufty remains.

I 100% agree with you here on the matching problem.

> Now let's move to the second part of the discussion which is the
> retrieval of various configuration informations by the driver.
>
> Here too, our model is better, I think there's little argument there. A
> named list of properties is just so much more flexible than a statically
> data structure that has to be in sync between the driver and all
> platforms using it leaves little room for improvement or adding platform
> specific attributes which some drivers might need, etc...
>
> Grant proposal is to have drivers create the pdata from the device-tree.
> This is something I believe we both disagree with, though you more
> vehemently than me I suppose :-)

See my pdata comment lower down.

> There are various things at play here:
>
> First, let me make it clear that imho, the device type
> (of_platform_device vs. platform_device) is irrelevant to that aspect of
> the problem since nowadays we have the ability to carry a device node
> pointer in any descendant of struct device (and we use that heavily for
> devices using specific bus types already).

And even if we kept of_platform; the same problem of parsing device
tree data exists for all other bus types.  Places where of_platform
isn't used today (i2c, spi, pci, mdio, etc).  It makes sense to
establish a pattern for matching and probing with device tree data
that is usable by all bus types.

> If you take an existing platform driver that you want to use on a
> device-tree enabled platform (other than just creating it and pdata from
> arch code which we all agree sucks), the two choices have different
> consequences:
>
> In one case, converting to of_platform_device, you pretty much _have_ to
> get rid of pdata, and convert the driver into using of_get_property()
> instead. This is probably not a bad thing in the long run, except that
> this means you also -have- to convert all platforms in all archs that
> use that specific platform driver to also generate a device node
> (possibly statically in many cases).
>
> This can be a lot of code churn deep into platform code for things like
> ARM which can be pretty nasty, for which none of us have any way to test
> on the relevant hardware. Other arch people will (maybe rightfully so)
> protest especially if they have no intent to use the device-tree stuff
> in their architecture or not yet anyways. And that for each platform
> driver involved.
>
> On the other case, converting to platform_device, adding the device
> node, we have the ability to do an easier transition and easier to sell.
> yes, we do take the risk of getting in that limbo land where drivers end
> up forever in the "transition" state though. That's a con of this
> approach, I do admit.
>
> I don't agree with grant idea however that just converting the content
> of the device node into properties is the way to go.

s/properties/pdata

I'm being pragmatic here.  pdata sucks, but the lowest impact path to
getting device tree data into a lot of existing drivers is to populate
the data source it is already using.  However, at least by putting the
translator into the driver itself, the pdata isn't an anonymous
pointer anymore and the compiler can correctly type check it.

But this is a minor point.  It really is contained within the driver
with no external impact.  pdata can be eliminated one driver at a
time.

> I do prefer your proposed approach (from our IRC discussion) which is
> instead to allocate a struct device-node, convert pdata into properties,
> and modify the drier to use these properties.

I like this approach.  It would actually be quite easy to convert on a
driver-by-driver basis from .pdata to device nodes.  Even platforms
that statically declare their platform devices could be changed by
statically declaring the sub tree for the device.  For (a completely
bogus) example:

  static struct platform_device omap3beagle_nand_device = {
  	.name		= "omap2-nand",
  	.id		= -1,
- 	.dev		= {
- 		.platform_data	= &omap3beagle_nand_data,
- 	},
- 	.num_resources	= 1,
- 	.resource	= &omap3beagle_nand_resource,
+ 	.device_node = (struct device_node *) {
+ 		.name = "nand",
+ 		.properties = (struct property *) {
+ 			.name = "blah",
+ 			.length = sizeof("foo"),
+ 			.value = "foo"
+ 			.next = (struct property *)
+ 		{
+ 			.name = "bar",
+ 			.length = sizeof("wazzit"),
+ 			.value = "wazzit"
+ 		} }
+ 	},
  };

Naturally this example is brutally ugly, and it could be done in a far
cleaner manner; but you get the idea.  As you and I just discussed on
IRC, the device_node structure isn't really designed for static
declarations, but it could work.  Basically it would allow the
migration to a better model that ugly, non-type-checked anonymous
pdata pointers.

> The main difference thus between the two type of conversions (convert to
> of_platform vs convert to platform) is that in the first case, you have
> to convert the driver to use properties -and- convert all platforms in
> all archs including gory ARM cell phone stuff you really don't want to
> go anywhere near. In the second case, you still convert the driver to
> use properties natively, but you keep a "wart" to turn pdata into a
> device-node -inside the driver-, protected by a CONFIG option maybe, so
> that those archs can be left alone until it becomes so obvious to
> everybody what approach is better that they'll end up being converted
> too and the wart can go.
>
> I believe the second approach, while less "clean" in the absolute is a
> more realistic path to take.
>
> Now, orthogonally to that, I do believe it's still nice to provide a way
> to statically lay out a device node in platform code, to allow archs
> that don't otherwise have the device-tree to replace pdata with
> something nicer and get rid of the wart quicker.
>
> We could either find a way with macros to layout an actual struct
> device_node statically along with all the properties etc... but that
> sounds a tad hard.

Heh.  I hacked out my example above before reading this far.

> We could have something that convert an entirely ASCII representation
> into a struct device_node, but that would be akin of having dtc in the
> kernel, might be a bit bloated no ? Though it could be made simpler and
> more restrictive.

Ewh.  Ugly.

> Or we could find an in-between .. .A different struct type that is more
> suitable for being laid out statically (a name, a type, and an enum of
> structs for various property "types", ie, strings, words, bytes, ...)
> with a little helper function that conver that into a device node at
> runtime ?

I think this bears some investigation.  A slightly different layout
(ie, using arrays instead of linked list for properties) would be
easier to prepare.  Worth some investigation.

> What do you think ?

I liked what I read.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
