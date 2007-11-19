Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <4740CB41.8030101@genesi-usa.com>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <621f1d7bb87a49559d22162314b98398@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Revisited, audio codec device tree entries.
Date: Mon, 19 Nov 2007 13:07:49 +0100
To: Matt Sealey <matt@genesi-usa.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> And I forgot the rant you guys usually get - for god's sake, why isn't
> anyone using the "model" property?

Probably because it isn't useful all that often.

> sound@0 {
> 	\\ this is our magic audio fabric
> 	device_type = "digispeaker,flinger";

This is wrong in so many ways; see David's mail for a start.

> 	\\ and this defines the layout Jon picked for the DACs
> 	\\ just like Apple's layout-id value
> 	model = "flinger,2"

"flinger" is some company that sells something they call the "2"?
Interesting.

"model" should be the real-world exact model name/number of the device.

> Isn't the primary concern of an audio codec, to play audio?

And the primary purpose of the device tree is to describe the hardware,
and (indirectly) how to program it.  For an audio codec that has I2C
and I2S connections, the interface over which you program it is I2C.
There are other technicalities, too; for example, if the codec node
would be a child node of the I2S bus, you cannot have two codecs with
the same name on one such bus (since that bus isn't a "bus" really,
it's more like a broadcast interface; it cannot address separate devices
on that "bus", so in the device tree the codecs wouldn't get a "reg",
etc.)

> Therefore, shouldn't the audio codec point back to it's control
> interface?

No.  The codec node _is_ the "control interface".

> Also, why give the name as 'i2s-handle'?

Why not?

> Surely it could be any interface.

No it cannot; this property is only present for audio codecs that have
an I2S bus (and not even all those, it is dependent on the device 
binding
in use).

> In reverse, it would be, perhaps, as
> above, i2c-handle, but then what if you change the interface
> type (for instance a bunch of Wolfson codecs can do i2c and
> spi for control). Your property name is obselete, then and
> drivers will need to switch on property names to find out
> which control interface is present.

That's another great argument against doing as you suggest, yes.

> What they should really do, is be told where their control
> interface handle is, then you can look at that handle and
> the device it contains

What you *should* do is just look at the parent node if you want to
know how to talk to the device.  This is the same for *all* nodes in
*all* device trees.

> Remember, it doesn't matter what NAME you give it, the name
> is for people to read,

Not only.  When the generic naming recommended practice is in use, 
"name"
can be used to find all nodes of a certain type.  Neither "name" nor
"device_type" should be used for device driver matching though; 
"compatible"
is for that.

[As a historic note, before the "generic naming" thing, "name" was used
for exactly what the first entry in "compatible" is used for now.  But
let's try to forget that, okay?]

> device_type is what you search for,

Unless you are programming in "real" Open Firmware itself, you do _not_
search for "device_type".  Ever.

> and phandles let you attach specific devices to each other.
> compatible is for when you want to tell people "it acts the
> same as this"

_Including_ "acts the same as itself".

> and model is to give you the enviable ability
> to define PRECISELY what you are looking at beyond a chip
> name.

When a device driver uses "model" for anything, it is typically because
"compatible" says the device is a member of some family of devices that
all behave identically, but uh-oh, this isn't actually true.

It's also not all that great for human readers, since the format is
vendor-specific.


Segher
