Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A3D2A679E6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 10:13:01 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1143637899.9481.28.camel@localhost>
References: <1143547826.13615.24.camel@localhost>
	<1143589234.2284.63.camel@localhost.localdomain>
	<1143637899.9481.28.camel@localhost>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 10:11:47 +1100
Message-Id: <1143673907.32206.19.camel@localhost.localdomain>
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


> Note sure what you mean here...

I'll come back with a better explanation later :) I want first to have a
look at the most recent code and think a bit more :)

> > Then, the core would get events from interrupts (or clock switches from
> > the codecs) via a yet-to-be-defined call and would react by calling the
> > various mute/unmutes accordingly for available inputs and outputs on the
> > bus where the event occured.
> 
> Ah but you see, the codec actually "mutes" the digital output when it
> isn't usable, and the codec also mutes the analog output when we
> transfer compressed data. We don't amp-mute in that case, but just from
> the codec, so no analog audio is even leaving the codec.

Yes, but we should probably still mute the amps... especially when using
a separate analog codec (like tas3004 + topaz setups).

> > For things like headphone/speaker automute, I think we need a kind of
> > tristate.. either that, or we need a bit mask of mute conditions. When
> > any of them is set, it's muted. That way, the "user" mute control sticks
> > regardless of the automute action or temporary mute to analog outputs
> > because, for example, the digital input lost its clock and we are
> > switching (we need to mute to avoid "clics").
> 
> Yeah. I have to think a bit about an in-snd-aoa api for all this.

I was thinking about an event based mecanism... snd-aoa has an array of
all inputs & outputs, which codec handles them, and, if relevant,
handles to connector detect GPIOs and amp mute GPIOs.

Then it has an event notification callback that's called in by the codec
and the GPIO interrupts as a result of state changes, clock changes
etc...

>From these, snd-aoa can "do the right thing", do mutes, unmutes, etc..
when needed.

> > Hrm... So my feature calls are doing too much at once... (they both do
> > the clocks and the cell enable). I don't do clock refcounting like Apple
> > does tho, thus the main clock sources are always enabled. So I think all
> > you have to do is toggle the I2Sn_CLK_ENABLE bits ...
> 
> Hmm. How do I get at those bits? Clock refcounting would be nice too,
> along with proper power save management...

Clock refcounting will be done ... some other time :)

> > Can you verify if all machines that have digital inputs (thus all
> > machines for which you may need to do that kind of clock switching) also
> > have working platform functions for doing so ? If they do, then it's
> > really just a matter of calling those. If not, then we can either
> > ioremap the FCR's in the driver and play with them (evil solution +
> > possibly locking problems) or add a feature call.
> 
> The former isn't feasible since I need to do clock switching even on
> analog-only machines to support more sample rates than the 44.1 KHz that
> the firmware sets for the boing sound :)

And you need to turn the clock off for that ? All the FCRs are useful
for you is to turn the clock input on and off, you shouldn't need that
except when switching to an external clock no ? And even then ... AFAIK,
Darwin AppleOnBoardAudio isn't playing with those FCRs at all unless
I've missed something, all it does is to call in PowerI2S via platform
calls to AppleKeyLargo which is equivalent to the existing pmac feature
call...

I need to understand better what you are exactly trying to do here and
what FCR bits you want to toggle and when.

In any case, if you look at arch/powerpc/platforms/powermac/feature.c,
You can see how FCRs are manipulated. The macros MACIO_IN/OUT read/write
from FCRs and MACIO_BIC/BIS clear/set bits. LOCK/UNLOCK are used to
protect (it's just a spinlock).

Look specifically at g5_i2s_enable() for K2/shasta based machines. There
is also core99_sound_chip_enable() for Keylargo based machines (32 bits
machines) though the current version does nothing to the i2s bus, it
just toggles a GPIO known to control power to the codec on some
machines. That is, it assumes that i2s is enabled and clocked at boot.
The sleep code in there does switch it off on sleep and back on though
but that's a different thing.
 
> > In the later case, you add a feature call in pmac_feature.h and the
> > appropriate entry in the table in feature.c and then you can toggle bits
> > as you wish with appropriate locking (look at eixsting code in there). I
> > can give you more details on irc if you need.
> 
> Ok. I definitely need more details I think.
>
> > But it would be nice if it could all be done with platform functions
> > instead.
> 
> Hardly possible though, see above.

Well, again, I have to understand better why here ...You shouldn't need
to touch the FCRs for normal frequency changes unless I missed
something.

> > > Modalias situtation. I played some tricks: i2sbus depends on soundbus
> 
> > Yeah :) There might be some issue with the macio automatching from
> > userland, not sure yet, could just be missing bits in hotplug scripts.
> 
> macio automatching is working, i2sbus loads, but the latter modules
> don't. I guess there's a userland issue in that it doesn't pick up new
> devices that are added to /sys while it is loading another module.

How so ? autoloading only works for devices on a bus type known by the
autoloader.. like macio. Thus other modules won't autoload unless you
have a bus type that supports the loading stuff for hotplug and
appropriate scripts... macio has such things, I don't think it will
handle your soundbus though without some changes, and the modules
themselves must expose via tables what they match on. I'm not sure I
fully understand what you are expecting there

> > > Recording. There's code to record sound, but it doesn't do anything on
> > > my machine. I have no idea why.
> > 
> > What machine ? The quad ? maybe you need some gpio manipulation or maybe
> > you just didn't get something right in onyx ... I'll try later. 
> 
> Yeah the quad. I was thinking that no matter what, I should at least be
> recording silence, but my userland app (arecord) doesn't get *any* data
> at all. It's like the dbdma controller isn't doing anything.

Maybe you aren;t getting the right addresses for it from OF :) I told
you there are some dodgy things going on with the device-tree ... I
think tx is at 0x8000 and rx at 0x8100 inside the MacIO ASIC (thus
0x8008000 and 0x8008100). Another possibility is that you are
programming it wrong or haven't enabled something somewhere in the codec
to actually emit data :) I'll have a look as soon as I manage to find
some time. Maybe on the plane this week-end.

> >  - macio_device gets the suspend resume event. That is, the i2s busses
> > basically. That code should forward to all attaches sub-busses which
> > then dispatch to codecs.
> 
> right.
> 
> >  - ordering of things should be: mute all, stop alsa, stop codecs
> > (enable whatever internal power management mode they may have), stop
> > clocks, disable i2s cells.
> 
> yeah. It's slightly more complicated unless we assume that the control
> interface (i2c) is always available, because we'd also get power
> management through the i2c device stuff.

It is always available. Just ignore PM callbacks from i2c

> > I'll play with adapting the whole stuff to older machines, I have plenty
> > of those :) We also need to implement a davbus module, so make sure you
> > don't have too much i2s-related assumptions in your core.. No timeframe
> > for that though, I'm fairly busy with other things at the moment
> 
> I don't think there are any i2s assumptions. Well, except that on any
> given soundbus_dev, you have at most one input and one output stream... 

That should be ok.

> > It's also a complicated thing because of the need to deal with old
> > machines and the need to coordinate properly & serialize... things like
> > interrupts or events from the codec should, if possible, use alsa hidden
> > controls or whatever other ways to properly serialize, if possible, be
> > run at task level (from a work queue) and things like that (due to the
> > need for delays etc...
> 
> Good points.
> 
> johannes
