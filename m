Message-Id: <200008300837.JAA16257@hyperion.valhalla.net>
Date: Wed, 30 Aug 2000 09:37:37 +0100
Subject: Re: [PATCH] via-cuda (CUDA_COMBINED_FORMAT_IIC)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michel,
On Wed, Aug 30, 2000, Michel Lanners wrote:
> On  30 Aug, this message from Iain Sandoe echoed through cyberspace:
>> Unfortunately, the one chip I *really* want to probe (the TDA7433 on the
>> audio card -  i2c address 0x8a) doesn't seem to give a proper response... so
>> if anyone knows more about this - I'd be interested.
>
> Hmm, are you sure it is actually attached to the CUDA's I2C bus? The
> 7x00/8x00 series have a video input chip on an I2C bus as well, but not
> on CUDA... it's on PlanB, which includes its own I2C implementation. I
> don't know about the sound chips in those boxes, however. My first bet
> would be looking around AWACS if there is no I2C bus hidden there
> somewhere.

Well, you could be right... I'm only going on Apple's h'ware docs (& the
existing Linux & Darwin drivers ;-).

The G3-beige has a perch slot and in the perch slot is one of three types of
card... all of these have either AWACS or Burgundy - but also a "tone
control" chip controlled by i2c.  The so called "tone control" chip does a
fair bit of the level & routing control (which is why I want to access it's
settings)

Apple's stuff from Darwin refers to this as an SGS7433 (and, after looking
at SGS/Thompson's web site) I came up with the TDA7433 which does the right
things.  It has i2c address 0x8a - which is the address that the dmasound
driver writes to to set the volume on g3-beige (using the GET_SET_IIC
command).

With the modified driver posted, the CUDA_COMBINED_FORMAT_IIC command
recognises that there is a device at address 0x8a - but returns all 0xff
bytes instead of the hoped for register contents :-(

I checked the TDA7433 data sheet and it should be able to do
COMBINED_FORMAT...

ah well...

Yes, there are different implementations for i2c on different models...
CUDA, PMU (PlanB and other mac-IO implementations).... and on the newer
machines "cereal" (and multiple i2c busses)...  if the ability to probe the
i2c bus is useful, I guess we'll have a few more drivers to update... :-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
