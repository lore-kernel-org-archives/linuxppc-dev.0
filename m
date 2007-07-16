Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D384DDF94
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 17:09:21 +1000 (EST)
Subject: Re: How to add platform specific data to a of_device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20070716065144.GH1678@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
	<20070716065144.GH1678@pengutronix.de>
Content-Type: text/plain
Date: Mon, 16 Jul 2007 17:09:12 +1000
Message-Id: <1184569752.25235.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 08:51 +0200, Robert Schwebel wrote:
> On Sun, Jul 15, 2007 at 06:48:53AM +1000, Benjamin Herrenschmidt wrote:
> > Your approach would work I suppose.... though it's a bit ugly.
> 
> Speaking of uggly, I'm still wondering why this oftree stuff for powerpc
> must be soooo complicated. If you come from the ARM-linux world like we
> do, the whole powerpc BSP stuff looks like a completely overengineered
> piece of code, introducing complexity where it isn't necessary. But it
> may be that it's just me not knowing powerpc kernel requirements deeply
> enough :)
> 
> For most of the devices on for example the MPC5200B and MPC8260 I would
> just model them as platform devices; there could be a simple
> 
> 	oftree -> oftree-interpreter -> bunch of platform devices

As I wrote a couple of times already, it's a perfectly acceptable
approach to have "constructors" (what you call oftree-interpreter) that
generate platform devices from the OF tree.

Since any struct device in the system can be associated with an OF
device node, it's actually not that interesting anymore to use something
such as of_platform_device or in general, subclasses of of_device unless
this is a platform native bus (such as sbus on sparc, or ebus on power)
that makes no sense to use without OF.

One of the idea I have for the long term but didn't have time to
implement is typically to have a bunch of generic constructors that
register to match against device name/type/compatible triplets, and are
called as part a boot time initial device-tree walk, generating the
various linux devices on the fly. This could also generate PCI devices,
thus replacing the separate walk path done by ppc64, but it could be
used to generate any type of linux device, not necessarily OF-derivative
ones, but platform devices too etc...

I just haven't had time to work on that yet. You are welcome to beat me
to it.

Note that a lot of the complexity is mostly perceived complexity due to
some of the stupid endless debates we've been having on this list. For
things like interrupt mapping, for example, the OF tree is a very useful
and very flexible representation that makes things a lot simpler on the
kernel side when you start having multiple levels of cascaded interrupt
controllers.

> mapping. Is there a reason why there is sooo much interaction of the
> platform code with the oftree? We usually have the situation that, if
> something goes wrong, you have to change
> 
> 	- the driver
> 	- the platform code
> 	- the oftree

There should generally be no need to change the platform code.

> and they often contain redundant information (like names of oftree
> nodes, which change more often than some people's panties).

Well, they aren't supposed to :-) The problem at this point is more due
to the fact that for things that haven't been specified by official OF
bindings, people are going all over trying to define their own and
sometimes conflicting bindings and then changing them.

Ben.
