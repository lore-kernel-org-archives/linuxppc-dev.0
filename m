Message-Id: <200008300937.KAA26644@hyperion.valhalla.net>
Date: Wed, 30 Aug 2000 10:37:53 +0100
Subject: Re: [PATCH] via-cuda (CUDA_COMBINED_FORMAT_IIC)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Michel,

>> With the modified driver posted, the CUDA_COMBINED_FORMAT_IIC command
>> recognises that there is a device at address 0x8a - but returns all 0xff
>> bytes instead of the hoped for register contents :-(
>
> Ah, ok. So you have been able to see the device... Are you sure that it does
> return register contents? I'm no I2C specialist, but for PlanB, the video
> chip on I2C can only return a single byte on a read request, not a stream of
> data (like a register file). Also, that chip uses bit 0 of the address as
> R/W flag, and, IIRC, bit 0 set to one indicates read. So, have you tried
> reading from address 0x8b?

I'm no i2c specialist either :-)  [just doing the Linux standard - learning
about it as a consequence of wanting to to something completely different]

The LSB being 1/0 (R/~W) is specified by the i2c standard.  The TDA7433
should be able to do auto-increment (by setting 0x10 as the sub-address).
However... I'm not sure (exactly) of the syntax of the
CUDA_COMBINED_FORMAT_IIC command - I posted darwin-dev... but no useful
replies.

>> I checked the TDA7433 data sheet and it should be able to do
>> COMBINED_FORMAT...
>
> What exactly is COMBINED_FORMAT?

Allows you to write to the chip followed by read (or vice versa) without
changing i2c bus mastership - so you do something like

aa ss <dd> aa|1  - which tells device aa that you want sub address ss (and
maybe want to write data <dd> and then you read it...

>From the name of the command - I might have thought that I could read the
regs with GET_SET_IIC - but I can't seem to make that work for any chip
address (the COMBINED_FORMAT_IIC *does* work for a number of the addresses).

>
>> Yes, there are different implementations for i2c on different models...
>> CUDA, PMU (PlanB and other mac-IO implementations).... and on the newer
>> machines "cereal" (and multiple i2c busses)...  if the ability to probe the
>> i2c bus is useful, I guess we'll have a few more drivers to update... :-)
>
> We could even provide a generic I2C interface (isn't that available on i386
> already?)... Give the different buses numbers, ala PCI, have a list of
> devices found on the bus, etc... Wouldn't that be a nice overkill? ;-))

A common method is a good idea (in spite of your smilie...)   At the moment
we have umpteen platform-dependent ways of doing power-down etc. etc.

Apple have a "Platform Expert" motif where you call PE_read_IIC() and it
buries the actual 'which driver' issue underneath...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
