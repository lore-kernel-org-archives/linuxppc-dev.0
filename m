Return-Path: <matt@genesi-usa.com>
Message-ID: <4741C0C4.4070502@genesi-usa.com>
Date: Mon, 19 Nov 2007 16:58:44 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
	<621f1d7bb87a49559d22162314b98398@kernel.crashing.org>
In-Reply-To: <621f1d7bb87a49559d22162314b98398@kernel.crashing.org>
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

Segher Boessenkool wrote:
>> And I forgot the rant you guys usually get - for god's sake, why isn't
>> anyone using the "model" property?
> 
> Probably because it isn't useful all that often.
> 
>> sound@0 {
>>     \\ this is our magic audio fabric
>>     device_type = "digispeaker,flinger";
> 
> This is wrong in so many ways; see David's mail for a start.

Why? I'm sorry but I am living in the real world where we have real
firmwares and real dynamic device trees here. You can't just say
"this is wrong because it has a device_type".

>>     \\ and this defines the layout Jon picked for the DACs
>>     \\ just like Apple's layout-id value
>>     model = "flinger,2"
> 
> "flinger" is some company that sells something they call the "2"?
> Interesting.

No, but who cares of the format of the model? It's for information -
in this case it's just there so that Jon can find out what "layout"
his codec, control interface, GPIOs, ports on the board, mixer
names, what colour the sky was on that day in June when he met his
wife-to-be, the name of his first dog, whatever information he needs
to implement on ANY driver model on ANY operating system is on that
particular version.

Maybe it should be digispeaker,2 or digispeaker,666 - who cares?
It's for the driver to know what it means.

I suggest it because I think Apple's "layout-id" is cryptic and
ridiculous duplication. Jon suggested to me a couple days back
that the layout-id is so model-specific (it increments each time
they brought out a new board, so it is synchronised with the
root "model" property!) that it's redundant. He suggested using
the root "model" property to switch his driver on the layout.

In this scenario, why not use the "model" property to keep the
audio driver more self-contained here? That was the theory
behind it.

> "model" should be the real-world exact model name/number of the device.

Well, on this example, it's quite obvious it's an MPC5200B I2S bus,
but you're not describing solely the i2s bus (although in the
example it will operate with a standard mpc5200b-psc-i2s driver)
but the entire audio solution and indirectly how to program that
audio solution (ta-da!) - i2s bus, pcm codec, it's control interface,
and anything else besides, which is...

>> Isn't the primary concern of an audio codec, to play audio?
> 
> And the primary purpose of the device tree is to describe the hardware,
> and (indirectly) how to program it.

.. exactly what it does.

> For an audio codec that has I2C and I2S connections, the interface
 > over which you program it is I2C.

What if you don't connect I2C to something Linux can access directly?

> There are other technicalities, too; for example, if the codec node
> would be a child node of the I2S bus, you cannot have two codecs with
> the same name on one such bus (since that bus isn't a "bus" really,
> it's more like a broadcast interface; it cannot address separate devices
> on that "bus", so in the device tree the codecs wouldn't get a "reg",
> etc.)

*shrug* as an example..

>> Therefore, shouldn't the audio codec point back to it's control
>> interface?
> 
> No.  The codec node _is_ the "control interface".

I think that flies in the face of the implementation of a bunch of
codecs.

>> Also, why give the name as 'i2s-handle'?
> 
> Why not?
> 
>> Surely it could be any interface.
> 
> No it cannot; this property is only present for audio codecs that have
> an I2S bus (and not even all those, it is dependent on the device binding
> in use).

See below.

>> In reverse, it would be, perhaps, as
>> above, i2c-handle, but then what if you change the interface
>> type (for instance a bunch of Wolfson codecs can do i2c and
>> spi for control). Your property name is obselete, then and
>> drivers will need to switch on property names to find out
>> which control interface is present.
> 
> That's another great argument against doing as you suggest, yes.

Why? The i2s codec sits on the i2s bus. You're right there is no
addressing on i2s it just has a stream of auduo going through it.

The i2s bus is one thing. This defines a PCM transport. This is
standardised.

The codec node defines which PCM/DAC you have on the end. This
DAC may have certain features - it may only have certain sample
rates supported, or may only support certain clock speeds. This
is what the codec node under the bus is for.

The codec node references the package handle of it's control
interface. If you want to play audio - well, go ahead, stream
some audio to the i2s bus, based on the abilities of the codec
(which are well defined in the datasheet you'd hope). You may
even use the OF standard properties for a "sound" node to define
these too - after all, it has a binding already and it would
improve driver support.

If you want to fiddle with it you need control interface, but
the primary purpose of an *audio device* is to play audio.

It is not to switch mixers on and off and change bass boost, that
is a totally secondary feature of an audio output or input
device, which may not even be present.

>> What they should really do, is be told where their control
>> interface handle is, then you can look at that handle and
>> the device it contains
> 
> What you *should* do is just look at the parent node if you want to
> know how to talk to the device.  This is the same for *all* nodes in
> *all* device trees.

Sorry Segher but you argued against this last time we had this
discussion. You said that all device nodes should be self-contained
and looking elsewhere in the tree is ridiculous.

What if you have a chip which has an SPI control interface, and
uses a custom FIFO setup to stream audio? What do you use then,
i2s-handle? Ha ha ha. Don't encode bus names in properties. They
should be descriptive. i2s-handle would point to a node which
has a device_type (on real firmware) and compatible property which
gives you ALL the information you need to determine

>> Remember, it doesn't matter what NAME you give it, the name
>> is for people to read,
> 
> Not only.  When the generic naming recommended practice is in use, "name"
> can be used to find all nodes of a certain type.  Neither "name" nor
> "device_type" should be used for device driver matching though; 

Then, no real Open Firmware implementation can work. What you need to
do, then is repeat the device_type information in the compatible
property on real firmwares. This is dumb. Stop sidelining real firmwares
for the sake of the Linux device tree.

> "compatible" is for that.

Why don't we propose a solution then? device_type is the type of
device you're looking at. This might be chrp,iic or it might be
fsl,i2c or it could be something else. Write this into your device
tree spec. This is important for real firmwares and other operating
systems which try and conform to IEEE 1275.

Then get your fdt blob builder and fix it so that it concatenates
the device_type value into the compatible property, and ditches
the device_type value for FDT's.

Don't start killing off part of the Open Firmware spec for the sake
of it. If you expect real Open Firmware developers to actually pay
attention to the Linux device tree specs it needs to take them into
account and not just run off on the justification that it was
"decided by the community so it's canon" - you need to design the
trees based on users of the technology.

> [As a historic note, before the "generic naming" thing, "name" was used
> for exactly what the first entry in "compatible" is used for now.  But
> let's try to forget that, okay?]
> 
>> device_type is what you search for,
> 
> Unless you are programming in "real" Open Firmware itself, you do _not_
> search for "device_type".  Ever.

Hello, we license one, so we're concerned about this.

Last time we shipped a real Open Firmware itself, you were the biggest
opponent on getting the device tree checked and standardised. Now you
want to just remove features, I don't see how we should even care if
you're going to be like that, but you're forcing us to do your bidding
against better knowledge.

When you have your own firmware to play with you can do what you like
with it, you can remove the property..  and Linux can happily support
it, but we *really* need to support other systems here and defining
things in backwards Linux ways is bad.

>> and model is to give you the enviable ability
>> to define PRECISELY what you are looking at beyond a chip
>> name.
> 
> When a device driver uses "model" for anything, it is typically because
> "compatible" says the device is a member of some family of devices that
> all behave identically, but uh-oh, this isn't actually true.
> 
> It's also not all that great for human readers, since the format is
> vendor-specific.

It's hard to define a value which describes something human readable
yet being simple to parse by a machine. Remember the whole justification
for XML? I don't think "model" (or by that regard, name, device_type
or compatible) *MUST* be human readable, but where and if it can be,
it should be.

name = some pretty name to differentiate it from something else in
the device tree. Not searchable, but just pretty in the output of
'.properties'

device_type = primary driver switch to look for the device, since it's
part of the OF spec, we have to implement it on our firmware. you
needn't in FDTs, but, please help us out on this.

compatible = if you don't find it in device_type, look here. I don't
think it should need to repeat device_type on real OF implementations.

model = you found the driver but you're concerned about some very
exact functionality which may not be present or software-detectable,
so you encode it here. Be that the SVR, be that the full part number
lasered into the die of the chip, be it mpc5200b,1.4 - this is up
to the guy who designed the hardware and the driver SHOULD be able
to use it AT IT'S OPTION to handle certain quirks, layout issues or
bugs in the device.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
