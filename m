Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 Jan 2008 16:01:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Message-ID: <20080104050113.GE4326@localhost.localdomain>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<20080103044432.GB25357@localhost.localdomain>
	<9e4733910801030654i7409e383n6b7f844aa543f234@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910801030654i7409e383n6b7f844aa543f234@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 03, 2008 at 09:54:45AM -0500, Jon Smirl wrote:
> On 1/2/08, David Gibson <david@gibson.dropbear.id.au> wrote:
[snip]
> > Instantiating the fabric driver off any node is wrong, precisely
> > because it is an abstraction.  The fabric driver should be
> > instantiated by the platform code.
> 
> Instantiating it from the platform code forces me to put it either the
> of_platform_bus or the platform_bus since there aren't any other buses
> around when the platform code runs. Platform bus doesn't implement
> dynamic module loading. So that means it has to go onto the
> of_platform_bus. That implies that is it a pseudo-device without a
> pseudo-device entry in the device tree which is fine with me. I'll
> need to poke around in the of_bus code and see if the driver will load
> without a device tree entry.

You're letting implementation warts influence basic design decisions.
This is not sensible.  Step back and think for a moment, work out a
sane organization *then* think how you might need to fix or workaround
limitations of existing infrastructure.

> A simple fix to this would be to let me instantiate the driver off
> from the root node of the tree. That's the conceptually correct place
> for instantiating a driver that extends the platform code. Should I
> try adjusting the of probing code to pass the node in, or are there
> major objections?

The current probing system can't instantiate a device for the root
node in any sane way, since it takes a list of suitable busses.

The constructor based approach we're looking at implementing could do
it.  It should, in any case, be constructing a platform_device - so
the platform bus code would still need to be extended to handle the
module loading.  Creating it as an of_platform device bound to the
root node might be a workable interim solution though.

of_platform_device simply does not *ever* make sense conceptually: the
type of struct device wrapper in use depends on the bus the device is
attached to, not on how we figured out the device was there.  OF can
potentially give information about any sort of device be it
simple-bus, i2c, PCI or whatever connected.

> Also, as others have pointed out, this driver is not an abstraction.
> It represents the mess of wires hooking the codec up to the jacks on
> the back panel and possibly GPIO pins that control the wiring. You
> need this because the pins on HD audio codecs are completely
> reconfigurable and the same chip can be wired in a thousand different
> ways. It lets you have a generic codec driver and the move the
> platform specific code out of the driver.

Well, "abstraction" is maybe not the right word.  But the point is
that the fabric driver doesn't represent a neatly isolated device with
well defined bus connections.  Instead it represents the tangle of
essentially every link between audio devices in the platform.  About
the clearest possible example of a true "platform device" (as opposed
to a device on some bus that just doesn't have any bus-specific
logic).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
