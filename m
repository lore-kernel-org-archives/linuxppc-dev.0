Date: Sun, 12 Aug 2001 00:21:11 +0100
Subject: Re: Fix for PPC audio devices that can't reendianize samples
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Derrik Pates <demon@devrandom.net>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010811232652.D17E62F06D@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 11, 2001,  Geert Uytterhoeven wrote:
> On Fri, 10 Aug 2001, Iain Sandoe wrote:
>> > The attached patch adds code to drivers/sound/dmasound/trans_16.c to
>> > byteswap little-endian audio samples for hardware that needs it (like the
>> > DACA audio chip in the iBook and iBook FireWire), and also marks the DACA
>> > in the iBook FireWire as being unable to handle little-endian audio
>> > samples (in dmasound_awacs.c).
>>
>> we've been round this loop ;-)))
>>
>> the reason that the byte-swap code was taken out of trans_16.c is that it
>> will never be allowed into the kernel.
>
> And we'll have to remove the current byteswap code in the kernel (there still
> is some).

Well, actually, I'd like to lose all the translation stuff (rate conversion,
format conversion etc.).  This belongs in User-Land and is preventing me
from implementing mmio (which would be useful for the more serious
applications).

My main problems atm are:

(a) working out what to do about mksound() - this is messy as it is and
needs fixing in order to deal with DACA & Tumbler (it fiddles with the H/W
which makes it chip-specific at present)...

(b) wondering if losing all that stuff is going to be acceptable to the m68k
ports (or whether we will end up having a PPC-specific driver).

(c) not having any time ... (but that's an old problem) ...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
