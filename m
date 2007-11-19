Return-Path: <scottwood@Freescale.com>
Date: Mon, 19 Nov 2007 11:05:21 -0600
From: Scott Wood <scottwood@Freescale.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Revisited, audio codec device tree entries.
Message-ID: <20071119170521.GA4368@loki.buserror.net>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
	<20071119001209.GD20794@localhost.localdomain>
	<4741BA7D.10608@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> I never said drivers should depend on it but why do you want to name
> an i2s bus as "i2s" or the i2c bus as "i2c"?

Because that's what they are?

> There are far, far more descriptive names that can be used. i2s is
> basically audio, so why not "audio" or "sound" or "headphone"?

For i2s, that may be reasonable, but i2c can have several devices under it.

> Why is gpt a "gpt" and not a "timer", it defeats the whole object
> of having a name for it. Since drivers never switch on it, why not
> give them real names?

That one *should* be timer.  Ask whoever did the device tree for it. :-P

> > device_type - indicates the open firmware method interface for the
> > device.  Therefore, meaningless in flattened trees.  No new driver
> > should use this.
> 
> .. you seem to think you must only design for the guys making Linux
> flattened device trees. I'm sorry, but I am not one of those guys and
> I am much more concerned with how this will affect the OF device tree
> and the usage for anyone else.
> 
> Meaningless in flattened device trees, but useful information in real
> OF device trees, do you implement it or not? I'd say, yes.

Yes, if you have real OF and provide the corresponding method interface.

That doesn't mean the driver should match on it if it doesn't depend on the
method interface.

> > compatible - *this* is the one for driver selection.  It describes the
> > hardware level interface(s) of the device.
> 
> Compatible is meant to list alternative, compatible devices as a
> *supplement* to device_type. device_type is your "primary" and
> compatible is your "secondary".

No, please read the spec:

“compatible”
    Standard property name to define alternate “name” property values.

No mention of device_type anywhere in the definition.

The generic names recommendation further suggests that compatible always be
used for matching.

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

"compatible" is not a magical, new property.  I'm not going to defend what
Apple did...

> I also think that specifying an audio codec - after all the Open
> Firmware standard defines an audio interface and device tree
> requirements for it, even if they are methods that we don't
> implement and you don't care about - as a function of it's
> control interface is so backwards it doesn't bare thinking about.

It's how the device tree works.  Devices go underneath the bus (or other
attachment interface) that they're on.  If you have an audio codec that has
an i2c interface and an soc interface, then you have two nodes, because
you're on two buses.

> If you want to output audio you do it through most audio
> controllers as a simple transfer of PCM data. Be it Creative
> or Freescale I2S or AC97, you push data at some port/fifo
> and it plays a sound. It is NOT defined by i2c control ports,
> you don't ever use those to *play* audio.

You certainly do use the i2c ports in order to do anything with the device
underneath the i2c bus.

> It may also be very, very true that a codec DOES NOT REQUIRE
> implementation of it's control interface, or that control interface could
> be connected to some other chip which handles initial configuration (like
> a boot sequencer eeprom) and not to a system bus.

Sure... in that case, then that's *not the bus it's on*.  There's still some
register set somewhere that software uses to shove data at the codec; that's
where the node should go.

-Scott
