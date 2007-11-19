Return-Path: <dgibson@ozlabs.org>
Date: Mon, 19 Nov 2007 11:12:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Revisited, audio codec device tree entries.
Message-ID: <20071119001209.GD20794@localhost.localdomain>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4740CB41.8030101@genesi-usa.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 18, 2007 at 11:31:13PM +0000, Matt Sealey wrote:
> Matt Sealey wrote:
> > Jon Smirl wrote:
> >
> > If you require the codec to be subservient to some "fabric" then I
> > suggest you make a "sound" node with a compatible entry which is
> > defined as something specific to your board (digispeaker,audio) and
> > let your driver pick that up and then switch on the model (rather like
> > Apple's layout-id) of that device to pick out the specifics of that
> > fabric. If it needs an audio codec (ac97 or i2s) and a control
> > interface (i2c or spi) then it knows which ones it is looking for
> > based on the model.
> 
> Sigh, I suck, I forgot the example :D
> 
> And I forgot the rant you guys usually get - for god's sake, why isn't
> anyone using the "model" property? Do I have to whine about this some
> more to get your attention, guys? name, device_type, compatible and
> model are your tools for building device trees and detecting
> things. That's FOUR unique properties.
> 
> How come I only see device trees defined using "name", with the same
> device_type, and "compatible"? This is braindead design.

Gah!  For the benefit of others on this list who may be misled.

*Neither* of you correctly understands the device tree, what I've seen
of *both* your suggested approaches is crap.

The device tree describes the _hardware_.  If you start reasoning
about how to lay out the device tree based on your driver model,
you're already wrong.

Matt, the various properties you list do not mean what you think they
mean.

name - should be named according to the generic names convention.
It's pretty much arbitrary, meant for human readability of the device
tree.  Drivers should not depend on it (some do, historically, but new
drivers and trees should not).

device_type - indicates the open firmware method interface for the
device.  Therefore, meaningless in flattened trees.  No new driver
should use this.

compatible - *this* is the one for driver selection.  It describes the
hardware level interface(s) of the device.

model - usually just for debugging / diagnosis / human-readable
purposes, describes exact model / revision of the hardware.  It can be
used to enable driver quirks / workarounds for when various devices
are supposed to be compatible (as encoded in 'compatible') but
aren't, due to hardware bugs.  However, you should never aim to use it
this way in design.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
