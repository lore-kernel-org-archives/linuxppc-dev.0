Return-Path: <matt@genesi-usa.com>
Message-ID: <4741BA7D.10608@genesi-usa.com>
Date: Mon, 19 Nov 2007 16:31:57 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>, Jon Smirl <jonsmirl@gmail.com>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
	<20071119001209.GD20794@localhost.localdomain>
In-Reply-To: <20071119001209.GD20794@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Sun, Nov 18, 2007 at 11:31:13PM +0000, Matt Sealey wrote:
> 
> Gah!  For the benefit of others on this list who may be misled.
> 
> *Neither* of you correctly understands the device tree, what I've seen
> of *both* your suggested approaches is crap.
> 
> The device tree describes the _hardware_.  If you start reasoning
> about how to lay out the device tree based on your driver model,
> you're already wrong.
> 
> Matt, the various properties you list do not mean what you think they
> mean.

No, David, I understand exactly what they mean, in the context of
a guy who works on Open Firmware, real Open Firmware, as was standardised
12 years ago.

Not your whacky newspeak device trees, which to be fair, are a good
idea, but it seems you all have tried to change something for the
sake of changing something.

> name - should be named according to the generic names convention.
> It's pretty much arbitrary, meant for human readability of the device
> tree.  Drivers should not depend on it (some do, historically, but new
> drivers and trees should not).

I never said drivers should depend on it but why do you want to name
an i2s bus as "i2s" or the i2c bus as "i2c"? There are far, far more
descriptive names that can be used. i2s is basically audio, so why
not "audio" or "sound" or "headphone"?

Why is gpt a "gpt" and not a "timer", it defeats the whole object
of having a name for it. Since drivers never switch on it, why not
give them real names?

> device_type - indicates the open firmware method interface for the
> device.  Therefore, meaningless in flattened trees.  No new driver
> should use this.

.. you seem to think you must only design for the guys making Linux
flattened device trees. I'm sorry, but I am not one of those guys and
I am much more concerned with how this will affect the OF device tree
and the usage for anyone else.

Meaningless in flattened device trees, but useful information in real
OF device trees, do you implement it or not? I'd say, yes. Even if
you don't agree with "real firmware", you can't just ignore it, shrug
it away and say it doesn't matter.

Jon's fabric driver should be looking for "digispeaker,flinger"
and nothing else. The name doesn't matter but I called it "sound"
because it's far, FAR more descriptive than "i2s", and of course
both the device_type and compatible properties report exactly what
Jon will need to write a driver which handles, however that might
be, his audio codec subsystem - pcm, control, magic gpios, or
whatever.

If there is an Open Firmware standard for it, I would use that name,
then it gives everyone a rough idea of what to expect. Open Firmware
developers can then CHOOSE TO IMPLEMENT THE STANDARD METHODS, and
Linux device tree authors can just ignore it.

You are cutting out a working specification for the sake of some
arbitrary simplification.

> compatible - *this* is the one for driver selection.  It describes the
> hardware level interface(s) of the device.

Compatible is meant to list alternative, compatible devices as a
*supplement* to device_type. device_type is your "primary" and
compatible is your "secondary". In this case, device_type is
exactly what Jon wants, something to mark out that the audio device
is his board design and requires special work (it is not merely an
i2s bus that you can just "use" - although throwing PCM data at it
would work, who knows what mixer it goes to, and what controls are
needed to define the bitrate or other features)

> model - usually just for debugging / diagnosis / human-readable
> purposes, describes exact model / revision of the hardware.  It can be
> used to enable driver quirks / workarounds for when various devices
> are supposed to be compatible (as encoded in 'compatible') but
> aren't, due to hardware bugs.  However, you should never aim to use it
> this way in design.

I don't see why "model" can't encode the particular revision of the
hardware in this way when it comes to the audio group of features on
his board. After all, if you are looking at a "digispeaker,flinger"
(I made that name up) then you need to know depending on the board
or even based on weird configurability options of the board, what
certain things may be - Apple used layout-id and a number. Why NOT
encode the "model" in the "model"?

Why choose some magical, new property, which then has to be further
standardised for no reason?

I also think that specifying an audio codec - after all the Open
Firmware standard defines an audio interface and device tree
requirements for it, even if they are methods that we don't
implement and you don't care about - as a function of it's
control interface is so backwards it doesn't bare thinking about.

If you want to output audio you do it through most audio
controllers as a simple transfer of PCM data. Be it Creative
or Freescale I2S or AC97, you push data at some port/fifo
and it plays a sound. It is NOT defined by i2c control ports,
you don't ever use those to *play* audio. It may also be very,
very true that a codec DOES NOT REQUIRE implementation of it's
control interface, or that control interface could be connected
to some other chip which handles initial configuration (like
a boot sequencer eeprom) and not to a system bus.

Therefore, pcm audio codecs as subordinate of control interfaces
is a dumb idea. Nuff said, I think.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
