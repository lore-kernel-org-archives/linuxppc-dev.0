From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <200008300922.LAA09244@mcp.cpu.lu>
Subject: Re: [PATCH] via-cuda (CUDA_COMBINED_FORMAT_IIC)
To: iain@sandoe.co.uk
Date: Wed, 30 Aug 2000 11:22:48 METDST
Cc: linuxppc-dev@lists.linuxppc.org
Reply-To: mlan@cpu.lu
In-Reply-To: <200008300837.JAA16257@hyperion.valhalla.net>; from "Iain Sandoe" at Aug 30, 100 9:37 am
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Iain,

> Hi Michel,
> The G3-beige has a perch slot and in the perch slot is one of three types of
> card... all of these have either AWACS or Burgundy - but also a "tone
> control" chip controlled by i2c.  The so called "tone control" chip does a
> fair bit of the level & routing control (which is why I want to access it's
> settings)
>
> Apple's stuff from Darwin refers to this as an SGS7433 (and, after looking
> at SGS/Thompson's web site) I came up with the TDA7433 which does the right
> things.  It has i2c address 0x8a - which is the address that the dmasound
> driver writes to to set the volume on g3-beige (using the GET_SET_IIC
> command).
>
> With the modified driver posted, the CUDA_COMBINED_FORMAT_IIC command
> recognises that there is a device at address 0x8a - but returns all 0xff
> bytes instead of the hoped for register contents :-(

Ah, ok. So you have been able to see the device... Are you sure that it does
return register contents? I'm no I2C specialist, but for PlanB, the video
chip on I2C can only return a single byte on a read request, not a stream of
data (like a register file). Also, that chip uses bit 0 of the address as
R/W flag, and, IIRC, bit 0 set to one indicates read. So, have you tried
reading from address 0x8b?

> I checked the TDA7433 data sheet and it should be able to do
> COMBINED_FORMAT...

What exactly is COMBINED_FORMAT?

> Yes, there are different implementations for i2c on different models...
> CUDA, PMU (PlanB and other mac-IO implementations).... and on the newer
> machines "cereal" (and multiple i2c busses)...  if the ability to probe the
> i2c bus is useful, I guess we'll have a few more drivers to update... :-)

We could even provide a generic I2C interface (isn't that available on i386
already?)... Give the different buses numbers, ala PCI, have a list of
devices found on the bus, etc... Wouldn't that be a nice overkill? ;-))


Michel
--
.sig home alone

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
