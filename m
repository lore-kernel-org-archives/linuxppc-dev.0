Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43740DDDEC
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 18:26:19 +1000 (EST)
Subject: Re: on the topic of of_device resources...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080505.005958.186160264.davem@davemloft.net>
References: <20080505.005958.186160264.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 05 May 2008 18:26:11 +1000
Message-Id: <1209975971.21644.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-05 at 00:59 -0700, David Miller wrote:
> Since it came to my attention due to the build error fix
> I just had to fix, I figured I'd mention some things.
> 
> Right now, powerpc and sparc differ in how they resolve
> interrupts and resources.
> 
> Powerpc uses an on-demand model, whereas Sparc pre-resolves
> everything at bootup when parsing the OF tree.

We used to do that but moved away from that model for various reasons.

> Unfortunately they operate on differing objects too, otherwise I could
> provide routines to match the interfaces that powerpc OF drivers want
> :-/

Yeah, we have more/less "generic" parsers that operate on raw device
nodes. I prefer that because we don't necessarily have of_devices in all
cases (or rather, there's a whole lot of cases where we want to resolve
things without having an of_device).

> Powerpc drivers want device_node objects, whereas sparc roots all
> driver usable objects under of_platform_bus using of_device objects
> (which point to the device_node if the driver needs that).

You should easily be able to use device_node based parsers to fill up
your of_platform_bus objects no ?

> Inside of the of_device is where we hang the fully resolved resources
> and interrupts.
> 
> I'd like to see consolidation in this area, and in return I'll be
> compiling all of your PPC_OF devices in my allmodconfig builds on
> sparc :-)

Heh :-)

Well, we aren't totally clear as to whether we'll use of_device much or
not in the long term. For bus types that already have their own
descendant of struct device (such as PCI, but also i2c, USB, etc...) it
makes little sense to create a "special" version with OF device...

That leaves platform devices, and there, experience has shown that it's
not very practical neither when a driver is shared between powerpc and
some other non-OF arch.

So we are trying to move toward a slightly different approach: Any
device can optionally be linked to a device_node (via dev_archdata), and
we provide "constructors" to build the various kind of struct device
descendants based on the device nodes.

This is in no way something done though. As you may have noticed,
macio_device is still around, though on the other hand, we have code to
build the PCI tree from the ground up straight off the OF nodes (that
you may want to use too at one point ...) though it's not using the
"constructor" approach. Some work hsa been done in the i2c layer to
create i2c devices based on device nodes, and there are other areas like
that.

Note that I haven't done much in that area myself other than
implementing some of the parsers a while ago, this is mostly driven by
others on the list, look around embedded folks and freescale :-)

It would be nice to find a nice generic way to "register" constructors
for devices based on OF nodes, and have them called automagically,
though there are a few pitfalls that may look like details at first but
can be nasty to do that properly. The main one is that the rules to
create a device can depend either on the bus it sits on (ie pci_dev)
rather than properties within the device node itself, or on the contrary
within the device node itself (platform devices typically). We might
need something "special" for a second-pass lookup for platform devices.
In addition, keeping track of parents would be nice to lay things out
properly in sysfs.

Cheers,
Ben.
