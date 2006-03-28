Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 421AB679E0
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 10:40:56 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143547826.13615.24.camel@localhost>
References: <1143547826.13615.24.camel@localhost>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 10:40:34 +1100
Message-Id: <1143589234.2284.63.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> GPIO stuff. Currently, the only GPIO I touch is the amp-mute one to turn
> on the internal speakers. This is done in the onyx codec module which
> obviously isn't the right place for it. This should be moved into the
> layout fabric module which draws on some common gpio code to program the
> GPIOs. Then it creates controls alsa for amp-mute etc. instead of
> unconditionally turning it on, and also registers the interrupts for
> headhpone detection etc.

The GPIO stuff is a bit can-of-worms-ish ... we need at least 2
different implementations for machines using "old style" direct GPIO
access and machines using platform functions. So we may need a gpio
"driver" with 2 instances there.

I think we need to hook that with the input/output net... basically we
just say things like mute/unmute(id) and the gpio "layer" sort of
matches the input/output "id" with whatever gpios it has at hand. That's
also why I think your input/output IDs should have separate entries for
combo connectors vs. analog line out (at least you used not to, I
haven't looked at the latest code).

Then, the core would get events from interrupts (or clock switches from
the codecs) via a yet-to-be-defined call and would react by calling the
various mute/unmutes accordingly for available inputs and outputs on the
bus where the event occured.

For things like headphone/speaker automute, I think we need a kind of
tristate.. either that, or we need a bit mask of mute conditions. When
any of them is set, it's muted. That way, the "user" mute control sticks
regardless of the automute action or temporary mute to analog outputs
because, for example, the digital input lost its clock and we are
switching (we need to mute to avoid "clics").

> Clock setting. I'm clueless as to programming keylargo in linux. Thing
> is, I need to stop the clock to the i2s cell before reprogramming it's
> serial format register, and this requires access to the FCR registers.
> But I don't know how to get at them best. Need help here. Clock setting
> also includes running the i2s cell in slave mode so we can have digital
> input. The infrastructure for slave mode isn't too established yet, but
> it should be easy to fit it over what is currently there in
> soundbus.h/i2sbus.

Hrm... So my feature calls are doing too much at once... (they both do
the clocks and the cell enable). I don't do clock refcounting like Apple
does tho, thus the main clock sources are always enabled. So I think all
you have to do is toggle the I2Sn_CLK_ENABLE bits ...

Can you verify if all machines that have digital inputs (thus all
machines for which you may need to do that kind of clock switching) also
have working platform functions for doing so ? If they do, then it's
really just a matter of calling those. If not, then we can either
ioremap the FCR's in the driver and play with them (evil solution +
possibly locking problems) or add a feature call.

In the later case, you add a feature call in pmac_feature.h and the
appropriate entry in the table in feature.c and then you can toggle bits
as you wish with appropriate locking (look at eixsting code in there). I
can give you more details on irc if you need.

But it would be nice if it could all be done with platform functions
instead.

> Modalias situtation. I played some tricks: i2sbus depends on soundbus
> but announces its willingness to be bound to the i2s OF thing that macio
> exports on its bus, so i2sbus is loaded automatically. i2sbus creates
> some soundbus devices that have a name based on the layout ID if
> possible, which should in turn auto-load snd-aoa-fabric-layout which
> declares its willingness to be bound to such devices. This doesn't
> happen during boot, even though modprobe `cat ...../modalias` works just
> fine. No idea, need help from someone versed with hotplugging.
> But hey, it's already much much closer than snd-powermac ever was ;)

Yeah :) There might be some issue with the macio automatching from
userland, not sure yet, could just be missing bits in hotplug scripts.

> Recording. There's code to record sound, but it doesn't do anything on
> my machine. I have no idea why.

What machine ? The quad ? maybe you need some gpio manipulation or maybe
you just didn't get something right in onyx ... I'll try later. 

> Suspend. I have a plan for it, so before thinking about it you may want
> to look at some old revisions of my code where a huge comment about
> suspend is buried in soundbus.h (I removed it again because it wasn't
> quite right any more, but still has the essence of what I intend to do).

No time to look now, but the idea would be that:

 - macio_device gets the suspend resume event. That is, the i2s busses
basically. That code should forward to all attaches sub-busses which
then dispatch to codecs.

 - ordering of things should be: mute all, stop alsa, stop codecs
(enable whatever internal power management mode they may have), stop
clocks, disable i2s cells.
 
> Onyx digital output. Currently, onyx always declares that the digital
> output is usable even if it is turned off, leading to a restriction in
> the output formats you can play. Note that due to 'clock switching'
> above, you can only play 44.1KHz currently anyway. But Onyx should make
> that depend on the status of the control, and then lock the control if a
> bitrate was chosen that isn't compatible with the digital output.

Yup.

> Make i2sbus compatible with old machines. I wrote i2sbus for new
> machines only, it relies a lot on stuff that older machines may not have
> in the device tree. So someone who has older machines should look into
> it and give me patches.

I'll play with adapting the whole stuff to older machines, I have plenty
of those :) We also need to implement a davbus module, so make sure you
don't have too much i2s-related assumptions in your core.. No timeframe
for that though, I'm fairly busy with other things at the moment

> Now, that said, it's actually working fine for just playing sound on the
> internal speakers now :)
> The GPIO stuff should be a fairly low-hanging fruit so if someone wants
> to take it...

It's also a complicated thing because of the need to deal with old
machines and the need to coordinate properly & serialize... things like
interrupts or events from the codec should, if possible, use alsa hidden
controls or whatever other ways to properly serialize, if possible, be
run at task level (from a work queue) and things like that (due to the
need for delays etc...

Ben.
