Return-Path: <benh@kernel.crashing.org>
Subject: Re: Deprecating of_platform, the path from here...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20091209.161550.168794100.davem@davemloft.net>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.161550.168794100.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Dec 2009 12:45:35 +1100
Message-ID: <1260409535.16132.109.camel@pasglop>
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-09 at 16:15 -0800, David Miller wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Wed, 9 Dec 2009 15:06:29 -0700
> 
> > 1) of_platform will be deprecated in preference of the platform bus.
> 
> What a shame, it's one of the cleanest driver probing models
> in the tree.

It is indeed. However, I'm not 100% convinced it requires keeping a
separate bus & device type, if we can make the base platform_device
benefit from it transparently.

So here's a (long) email summarizing my thoughts in those matters. I
would really appreciate if you took the time to read it through, think
it through and then speak your mind. As you will notice, I'm not myself
completely sold on the way to go there myself and some of your ideas do
tempt me very much indeed :-)

First let's clearly separate the two different aspects of this
discussion for the sake of lurkers :-) One is the probing & matching
mechanism.  The other one is how the driver retrieves it's various
parameters, either from a device node, or from pdata. From our IRC
discussion you have valid points on both aspect of the argument so I'll
try to discuss this here separately and we'll see what others think too.

First the probing because that's the real important issue, I believe the
other one is mostly academic and can be dealt on a per driver basis
(I'll discuss it later too).

I'm not totally sold on the idea of the table that Grant proposed. I
think I proposed it initially in a discussion we had on IRC as one
possible option and in fact it was suggested by Paulus so don't
completely blame Grant for it though. It does mean that either platform
code or core code will have some kind of big table that associates a
whole pile of of_device_id with a platform device name. It somewhat
sucks when I think more about it and it does feel like a step backward
from of_platform_device.

If we could make platform_driver grow an of_device_id match list it
would be indeed nicer. Of course you'll reply to that "let's just use
of_platform" instead :-)

I would then argue that I don't like having two different bus types,
platform and of_platform for "generic platform" devices that aren't
typed on a bus type. There's a lot of existing "platform device" and it
would be quite hard to convert them all. Especially since a lot of them
are used today on archs that don't have device trees and may never grow
one.

IE. I believe it's going to be an easier path to grow platform_device
into something that has the of_device probing functionality rather than
turn everything into of_platform. (I'm not talking here about the pdata
and retrieval of informations from the tree, this is the second part of
the discussion, discussed below).

The main problem with moving existing platform_device to of_platform is
how do we deal with archs that don't have the device-tree infrastructure
and use those drivers today ?

We could I suppose create a helper that looks a lot like the current
platform device creation one, which would create an of_platform device
instead, along with a struct device_node attached (which isn't part of a
tree) to it, and create a single "compatible" property whose content is
the platform data name.

But that means that for every driver we want to be able to use a
device-tree probing for, we would have to convert all archs & platforms
that may instanciate it to use the new helpers, in addition to replacing
whatever pdata they have statically stored into a device node (see the
second part of the discussion).

It's possible I suppose. I just feel that it's going to be a tougher
sell to the rest of the world.

There's one nit to be careful of. Some drivers (sadly) have the fact
that they appear under /sys/bus/platform/ as a userspace ABI thingy. Sad
but a fact. This is one of the reasons why rather than actually
converting to of_platform I'd rather find a way to add the of_device_id
match mechanism to the existing platform_device and deprecate the pdata
over time. 

It will also provide with an easier transition. Basically transform
platform_device into of_platform_device by first adding the missing bits
and -then- trimming the crufty remains.

Now let's move to the second part of the discussion which is the
retrieval of various configuration informations by the driver.

Here too, our model is better, I think there's little argument there. A
named list of properties is just so much more flexible than a statically
data structure that has to be in sync between the driver and all
platforms using it leaves little room for improvement or adding platform
specific attributes which some drivers might need, etc...

Grant proposal is to have drivers create the pdata from the device-tree.
This is something I believe we both disagree with, though you more
vehemently than me I suppose :-)

There are various things at play here:

First, let me make it clear that imho, the device type
(of_platform_device vs. platform_device) is irrelevant to that aspect of
the problem since nowadays we have the ability to carry a device node
pointer in any descendant of struct device (and we use that heavily for
devices using specific bus types already).

If you take an existing platform driver that you want to use on a
device-tree enabled platform (other than just creating it and pdata from
arch code which we all agree sucks), the two choices have different
consequences:

In one case, converting to of_platform_device, you pretty much _have_ to
get rid of pdata, and convert the driver into using of_get_property()
instead. This is probably not a bad thing in the long run, except that
this means you also -have- to convert all platforms in all archs that
use that specific platform driver to also generate a device node
(possibly statically in many cases).

This can be a lot of code churn deep into platform code for things like
ARM which can be pretty nasty, for which none of us have any way to test
on the relevant hardware. Other arch people will (maybe rightfully so)
protest especially if they have no intent to use the device-tree stuff
in their architecture or not yet anyways. And that for each platform
driver involved.

On the other case, converting to platform_device, adding the device
node, we have the ability to do an easier transition and easier to sell.
yes, we do take the risk of getting in that limbo land where drivers end
up forever in the "transition" state though. That's a con of this
approach, I do admit.

I don't agree with grant idea however that just converting the content
of the device node into properties is the way to go.

I do prefer your proposed approach (from our IRC discussion) which is
instead to allocate a struct device-node, convert pdata into properties,
and modify the drier to use these properties.

The main difference thus between the two type of conversions (convert to
of_platform vs convert to platform) is that in the first case, you have
to convert the driver to use properties -and- convert all platforms in
all archs including gory ARM cell phone stuff you really don't want to
go anywhere near. In the second case, you still convert the driver to
use properties natively, but you keep a "wart" to turn pdata into a
device-node -inside the driver-, protected by a CONFIG option maybe, so
that those archs can be left alone until it becomes so obvious to
everybody what approach is better that they'll end up being converted
too and the wart can go.

I believe the second approach, while less "clean" in the absolute is a
more realistic path to take.

Now, orthogonally to that, I do believe it's still nice to provide a way
to statically lay out a device node in platform code, to allow archs
that don't otherwise have the device-tree to replace pdata with
something nicer and get rid of the wart quicker.

We could either find a way with macros to layout an actual struct
device_node statically along with all the properties etc... but that
sounds a tad hard.

We could have something that convert an entirely ASCII representation
into a struct device_node, but that would be akin of having dtc in the
kernel, might be a bit bloated no ? Though it could be made simpler and
more restrictive.

Or we could find an in-between .. .A different struct type that is more
suitable for being laid out statically (a name, a type, and an enum of
structs for various property "types", ie, strings, words, bytes, ...)
with a little helper function that conver that into a device node at
runtime ?

What do you think ?

Cheers,
Ben.
