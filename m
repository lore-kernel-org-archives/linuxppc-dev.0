Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <9e4733910710211729k2f2a065cm56670d1b0f90a1af@mail.gmail.com>
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
	<9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
	<5cac8057884ac400b0596988414c7ed7@kernel.crashing.org>
	<9e4733910710211729k2f2a065cm56670d1b0f90a1af@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca49c80c1b704a41544bd8d00192620a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Device trees and audio codecs
Date: Mon, 22 Oct 2007 20:43:46 +0200
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It seems to me there are four issues here:

1) How to describe the audio transport controller;
2) How to describe the codecs;
3) How the various parts are connected together in the device tree;
4) How to describe the "layout".

>>> How do we want to be consistent with the Efika which uses an AC97
>>> codec that only connects to i2s?
>>
>> Huh?  AC'97 isn't I2S.  Yeah you probably could hook it up to some I2S
>> device if you do all the interleaving and whatever stuff by hand -- 
>> but
>> then you probably shouldn't call the I2S "host" an I2S anymore, but 
>> name
>> it "ac97" in the device tree, or 
>> "this-or-that-i2s-controller-hooked-up-
>> in-this-particular-crazy-way".  You will want to know which driver to
>> use for the device, and if it's hooked up in "strange and unforeseen"
>> ways you want to know about it.
>
> I meant an ac97 bus. ac97 is conceptually the same as i2s with the
> control signals also routed over it. ac97 and i2s are handled in the
> same PSC on the 5200.

Okay.  On any specific board, there can _only_ be ac97 or _only_ i2s
codecs hooked onto the bus; the device node for the PSC should say
which it is, either by having different "compatible" entries for the
different modes, or by having some device-specific property in there
saying which it is.  Ideally, the name of the node would be "i2s" resp.
"ac97" as well.

This handles 1).

> I have received conflicting opinions as to whether a codec hooked to
> an ac97 bus should get a chip specific codec entry in the device tree.

Every codec gets its own device node, and its "compatible" entry 
describes
it uniquely.  This is a very basic property of device trees.

This handles 2).

> Without the codec specific entry only generic ac97 features can be
> used. The Efika has a STA9766. Looking at the data sheet for the chip
> I see that it implements some proprietary functions in addition to the
> standard ones.
>
> asoc has a generic ac97 driver. Should the ac97 bus be required to
> have a entry for the generic ac97 device? It would make loading the
> driver much easier.

If the kernel driver does _not_ recognise the codec in the device tree,
it could use a "generic" ac97 codec driver, if such a thing indeed 
exists.
If on the other hand it knows about the specific codec, it can use a 
chip-
specific driver.

AC'97 codecs are addressed over the AC'97 bus, so the codecs should be
children of the ac97 bus in the device tree, and have fully qualified
names like "audio@0" or "modem@1" etc.  I2S codecs that are addressed
(== its configuration registers written) over I2C should be children of
their I2C bus in the device tree, with fully qualified names like
"audio@6c"; they should show which I2S bus they sit on, for example by
having an "i2s-bus" property (containing the phandle of the i2s bus) in
the codec node.

This is 3).


Now for 4), the layout thing; you could try to describe the layout in
the device tree, but that would probably fail; there just is too much
variance.  If I understand you correctly, you have a platform-specific
layout driver; now you need to find a nice way to probe this from the
device tree.  Maybe you should just look at the properties in the root
node of the device tree for this.

>> _Please_ don't name busses that are not plain I2S "i2s" in the device
>> tree.  At best this means you'll need a quirk in the kernel code to 
>> deal
>> with this later.
>
> the i2s and ac97 drivers for the mpc5200 already exist. I'm using
> these preexisting drivers.

Sure, but that doesn't mean you cannot fix the way things are probed in
those drivers.  Bugs are there to fix ;-)


Segher
