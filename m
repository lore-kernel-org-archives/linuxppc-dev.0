Message-Id: <200008302102.WAA18554@hyperion.valhalla.net>
Date: Wed, 30 Aug 2000 22:03:19 +0100
Subject: Re: [PATCH] via-cuda (CUDA_COMBINED_FORMAT_IIC)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Wed, Aug 30, 2000, David A. Gatwood wrote:
> On Wed, 30 Aug 2000, Iain Sandoe wrote:
>> I really would be very grateful if anyone has any more sources of info
>> on the command packets contents for it (CUDA)...
>
> Like what sort of info, and what sort of command?

OK. I want to read the contents of an I2c chip.
I checked the data sheet for the chip - it can do it.

I look in cuda.h - we have a command called CUDA_GET_SET_IIC - which is used
by the dmasound driver to set values in the chip.  The name implies I can
read values using it... but.. with the (several) permutations I tried
(guesswork) - no joy.

So then someone tells me that what I need is COMBINED_FORMAT_IIC - so I've
implemented it - which involves a re-jig of the CUDA state machine... this
is the patch.

I was very happy to see data streaming out of the i2c bus... and then very
disappointed that several devices (including the one I want) return nothing
but 0xff...

now the COMBINED_FORMAT_IIC command is of the form:

[0x01, 0x25] aa ?? aa|1

Looking at the i2c spec. ?? is probably the sub address (or the second byte
for a 10 bit address)... but when I try other than 00 in this - often the
CUDA becomes confused...   So I wonder whether there are different command
lengths I can try and, ....... many permutations (and re-boots) later I
conclude that:

00 is the only reliable working value for ??
COMBINED_FORMAT_IIC commands must be 5 bytes long (0x01, 0x25, aa, ??, aa|1)
or they do not work (or lock up the CUDA)...

**of course** I'm guessing and there could just be one bit I need to set
somewhere to make it work... but I've run out of time for trying random
permutations....

=====
In general...

The command works properly - when there is no i2c device on the bus it
returns an error.  BUT something is wrong with the command for four devices
on the bus in my g3-beige - they only return an endless stream of 0xff.


A long response (sorry) - but the answer is:
(a) Either some hint on how to use the GET_SET_IIC command for the purpose
or
(b) some hint on what extra needs to be done with COMBINED_FORMAT_IIC for
the job.

TIA,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
