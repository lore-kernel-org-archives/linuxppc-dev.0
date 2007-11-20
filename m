Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Nov 2007 11:33:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Revisited, audio codec device tree entries.
Message-ID: <20071120003316.GB3126@localhost.localdomain>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
	<20071119001209.GD20794@localhost.localdomain>
	<4741BA7D.10608@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4741BA7D.10608@genesi-usa.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2007 at 04:31:57PM +0000, Matt Sealey wrote:
> David Gibson wrote:
> > On Sun, Nov 18, 2007 at 11:31:13PM +0000, Matt Sealey wrote:
> > 
> > Gah!  For the benefit of others on this list who may be misled.
> > 
> > *Neither* of you correctly understands the device tree, what I've seen
> > of *both* your suggested approaches is crap.
> > 
> > The device tree describes the _hardware_.  If you start reasoning
> > about how to lay out the device tree based on your driver model,
> > you're already wrong.
> > 
> > Matt, the various properties you list do not mean what you think they
> > mean.
> 
> No, David, I understand exactly what they mean, in the context of a
> guy who works on Open Firmware, real Open Firmware, as was
> standardised 12 years ago.

No, you really don't.  Either your knowledge of OF is out of date, or
you've forgotten what you thought you knew.

> Not your whacky newspeak device trees, which to be fair, are a good
> idea, but it seems you all have tried to change something for the
> sake of changing something.

With a couple of tiny exceptions, everything I've said applies equally
to real OF trees.

[snip]
> > device_type - indicates the open firmware method interface for the
> > device.  Therefore, meaningless in flattened trees.  No new driver
> > should use this.
> 
> .. you seem to think you must only design for the guys making Linux
> flattened device trees. I'm sorry, but I am not one of those guys and
> I am much more concerned with how this will affect the OF device tree
> and the usage for anyone else.

No, which is exactly why it's wrong to organize the device tree so
that it's convenient for loading this "fabric driver" thing (which
AFAICT is a Linux-specific driver model limitation).

> Meaningless in flattened device trees, but useful information in real
> OF device trees, do you implement it or not? I'd say, yes. Even if
> you don't agree with "real firmware", you can't just ignore it, shrug
> it away and say it doesn't matter.

Useful information in a real OF tree *if* an OF runtime interface for
the device is defined and implemented.

[snip]
> > compatible - *this* is the one for driver selection.  It describes the
> > hardware level interface(s) of the device.
> 
> Compatible is meant to list alternative, compatible devices as a
> *supplement* to device_type. device_type is your "primary" and
> compatible is your "secondary". In this case, device_type is
> exactly what Jon wants, something to mark out that the audio device
> is his board design and requires special work (it is not merely an
> i2s bus that you can just "use" - although throwing PCM data at it
> would work, who knows what mixer it goes to, and what controls are
> needed to define the bitrate or other features)

No, as Segher explains, that's Just Plain Wrong.  Originally "name"
did perform the function you think device_type had.  But the generic
names convention, which has been very well established for a long time
now means that the register-level (or equivalent) programming
interface is described by "compatible".  Period.

> > model - usually just for debugging / diagnosis / human-readable
> > purposes, describes exact model / revision of the hardware.  It can be
> > used to enable driver quirks / workarounds for when various devices
> > are supposed to be compatible (as encoded in 'compatible') but
> > aren't, due to hardware bugs.  However, you should never aim to use it
> > this way in design.
> 
> I don't see why "model" can't encode the particular revision of the
> hardware in this way when it comes to the audio group of features on
> his board. After all, if you are looking at a "digispeaker,flinger"
> (I made that name up) then you need to know depending on the board
> or even based on weird configurability options of the board, what
> certain things may be - Apple used layout-id and a number. Why NOT
> encode the "model" in the "model"?
> 
> Why choose some magical, new property, which then has to be further
> standardised for no reason?
> 
> I also think that specifying an audio codec - after all the Open
> Firmware standard defines an audio interface and device tree
> requirements for it, even if they are methods that we don't
> implement and you don't care about - as a function of it's
> control interface is so backwards it doesn't bare thinking about.

Sure, it's fine for a firmware to implement the OF method interface
and put in the relevant device_type for audio in the appropriate place
(although with complex sound systems with many components, the right
place may be non-obvious or even not well defined).  It's *not* fine
to make up random new device_type values because you think it's
convenient.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
