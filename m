Message-ID: <39D0C2C5.6BC5153@mvista.com>
Date: Tue, 26 Sep 2000 11:37:41 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ruedi.Hofer@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Subject: Re: Limon & PowerQUICC II, Booting the kernel
References: <0G1G0093N5EZUI@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ruedi.Hofer@ascom.ch wrote:

> After I've loaded the kernel I can see the kernel in the RAM from addr 0.

I don't know what limon does, but zImage doesn't load at address 0......

> limon> debug
> limon> dw
> 00000000   48000005  7c6b1b78  7cb92b78  38600040  H...|k.x|.+x8`.@
> 00000010   7c600124  3c800040  60840000  7c6802a6  |`.$<..@`...|h..
> 00000020   3863fffc  7c681b78  7c032000  40820028  8c..|h.x|. .@..(
> 00000030   3c800040  60840000  3ca00040  60a5b274  <..@`...<..@`..t
> 00000040   38a50003  7ca42850  54a5f0be  7ca72b78  8...|.(PT...|.+x

If this is really address zero, these instructions are left over
from the last kernel boot.

> 2. Is the start address 0 correct?

No.

> 3. Some data are transferred from limon to the kernel.
>  - Does Limon handle this correctly?
>  - Where are these data located?

I don't know.  On the PQ-II (8260), the zImage should be loaded at or
above 0x900000, then jump to that address.  The code will relocate,
uncompress and start the kernel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
