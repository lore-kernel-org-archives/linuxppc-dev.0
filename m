Return-Path: <matt@genesi-usa.com>
Message-ID: <4740CB41.8030101@genesi-usa.com>
Date: Sun, 18 Nov 2007 23:31:13 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com>
In-Reply-To: <4740C0E3.5080704@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Jon Smirl wrote:
>
> If you require the codec to be subservient to some "fabric" then I
> suggest you make a "sound" node with a compatible entry which is
> defined as something specific to your board (digispeaker,audio) and
> let your driver pick that up and then switch on the model (rather like
> Apple's layout-id) of that device to pick out the specifics of that
> fabric. If it needs an audio codec (ac97 or i2s) and a control
> interface (i2c or spi) then it knows which ones it is looking for
> based on the model.

Sigh, I suck, I forgot the example :D

And I forgot the rant you guys usually get - for god's sake, why isn't
anyone using the "model" property? Do I have to whine about this some
more to get your attention, guys? name, device_type, compatible and
model are your tools for building device trees and detecting
things. That's FOUR unique properties.

How come I only see device trees defined using "name", with the same
device_type, and "compatible"? This is braindead design.

Why is every example device tree I see defining weird little extra
nodes for anything and everything that some driver API exposes? If
you want to expose a grand new kind of driver fabric like ALSA SoC
wants, put your codec in the tree, and give it a model property
with your unique name.

I'd suggest something like this:

sound@0 {
	\\ this is our magic audio fabric
	device_type = "digispeaker,flinger";

	\\ it's actually just an i2s pcm codec
	compatible = "mpc5200-psc-i2s";

	\\ and this defines the layout Jon picked for the DACs
	\\ just like Apple's layout-id value
	model = "flinger,2"

	codec@15 {
		compatible = "TXN,tas5504";
		codec-control = <&codec-control>;
	}

	\\ and every i2s driver on the planet will just ignore these
	\\ unless it's one of our boards
	digispeaker,amp-control = <&amp-control>
}

Then you control the fabric for your boards and get to attach
whatever the hell you want to those codecs, control interfaces
and special little tweak features you always wanted.

Be careful cross-referencing devices with each other,
for instance in your example you made the i2c codec device
point back to an i2s handle - it's a good idea, but not well
executed in my opinion as it lacks context.

Isn't the primary concern of an audio codec, to play audio?

Therefore, shouldn't the audio codec point back to it's control
interface? Also, why give the name as 'i2s-handle'? Surely it
could be any interface. In reverse, it would be, perhaps, as
above, i2c-handle, but then what if you change the interface
type (for instance a bunch of Wolfson codecs can do i2c and
spi for control). Your property name is obselete, then and
drivers will need to switch on property names to find out
which control interface is present.

What they should really do, is be told where their control
interface handle is, then you can look at that handle and
the device it contains - that device itself will tell you the
bus type, any devices under it, and any quirky things you
need to do besides (above, &codec-control etc. would point to

i2c@3d40 {
	codec-control@15 {
		blah
	}
}

spi@beef {
	codec-control@19 {
		blah
	}
}

gpio@cafe {
	amp-control@0 {
		compatible = "gpio-bit";
		bit = "1";
		open-drain;
	}
}

If you couldn't tell it's a device on an i2c bus then you
are coding your driver badly. And you can have lots of
codecs, and just back reference which control interface
they have. I dunno.

Remember, it doesn't matter what NAME you give it, the name
is for people to read, device_type is what you search for,
and phandles let you attach specific devices to each other.
compatible is for when you want to tell people "it acts the
same as this" and model is to give you the enviable ability
to define PRECISELY what you are looking at beyond a chip
name. I'd suggest we use all of them for great justice.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
