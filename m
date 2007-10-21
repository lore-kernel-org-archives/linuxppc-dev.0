Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
References: <9e4733910710200833x5d1c55b5l2cd400f77c13ec87@mail.gmail.com>
	<a76a128145ec8a8f779727a7e11925ac@kernel.crashing.org>
	<9e4733910710211433r7e0cf4b4sf6aed12c57dda375@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5cac8057884ac400b0596988414c7ed7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Device trees and audio codecs
Date: Mon, 22 Oct 2007 01:33:46 +0200
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

> Fabric driver tells how the generic codec is hooked up on the specific
> board. Some of the codecs are extremely flexible and can be hooked up
> hundreds of different ways. It is like GPIO pins, they are wired in
> however is convenient for the design.

Gotcha.  *Very* much like GPIOs, indeed.

>>> The fabric driver corresponds to the 'layout-id' in the Apple model.
>>> It tells how to configure the generic codec driver for the specific
>>> configuration needed by the actual platform hardware.
>>
>> The apple layout-id selects one of several tables with *lots* of info.
>> I think you want a subset of that only.
>
> The fabric/layout-id stuff is platform specific.

I mean that Apple's layout-id abstraction is "bigger" than your fabric
abstraction seems to be.  Not too important a point, anyway.

>>> My target hardware has a codec that is linked to both i2s and i2c. 
>>> How
>>> should it be represented?
>>
>> Since the codec is addressable on i2c, and not on i2s, it should be
>> a child node of the i2c bus it sits on; and then you put a property
>> in the codec node pointing to the i2s bus node it is connected to.
>> Multiple of those (or multiple entries) if it is connected to more
>> than one i2s bus.  "i2s-parent" might be a good name for such a prop.
>
> How do we want to be consistent with the Efika which uses an AC97
> codec that only connects to i2s?

Huh?  AC'97 isn't I2S.  Yeah you probably could hook it up to some I2S
device if you do all the interleaving and whatever stuff by hand -- but
then you probably shouldn't call the I2S "host" an I2S anymore, but name
it "ac97" in the device tree, or "this-or-that-i2s-controller-hooked-up-
in-this-particular-crazy-way".  You will want to know which driver to
use for the device, and if it's hooked up in "strange and unforeseen"
ways you want to know about it.

Maybe the platform code should do this, dunno.

_Please_ don't name busses that are not plain I2S "i2s" in the device
tree.  At best this means you'll need a quirk in the kernel code to deal
with this later.

</rant>


So anyway, why is it inconsistent to have an audio codec that is 
configured
over i2c sit on that i2c bus in the device tree as well, and refer to 
the i2s
bus it pumps audio data over; vs. having an ac97 codec that sits on an 
ac97
bus sit on that ac97 bus in the device tree as well?  In both cases, the
device is a child of the bus via which it is addressed.

The one exceptional case would be a dumb codec that isn't addressable 
at all;
it would be a device tree child of the dumb transport bus (where else 
could
it be put)?

> Actually those platform-XXX entries may be the solution I am looking
> for.

Like Ben already said, no you _do not_ want the platform-do stuff.  
Trust
him on this.  Or if you're feeling brave, look at the existing kernel 
code
that handles some of it ;-P


Segher
