Date: Wed, 10 Apr 02 20:46:33 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204110346.AA27237@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> Not quite.  DINK32/PPCBug/PMON/Force firmware (pcore?)/other commerical
> firmwares which know 0 about Linux and won't ever quite probably is the
> 'fly in the ointment'.

I disagree. StarMON also knows 0 about Linux, which is how it should be as it's
none of the firmware's business to care what OS the user wants to run, and yet
I've got Linux to work with it very beautifully as you can see. Same with OF on
PMacs and CHRPs.

I think you have some confusion here. It seems to me like you think that
StarMON is something like PPCBoot. No, it's nowhere near that. It's a lot
closer to DINK or PPCBug. Actually what it's most like is a mechanical boot
console with blinking lights and toggle-switches. Wanna boot something? Toggle
in your boot code in binary into memory from switches. Or load it from a
punched paper tape. NO FRILLS. And forget about ELF, it has never heard of such
a thing. Every byte from the punched tape is loaded into memory at linearly
incrementing addresses, no header parsing of any kind, just straight binary.

If I've been able to make Linux/PPC boot so nicely and have one generic
configuration with my very very no-frills firmware, I claim you've gotta be
able to do that with other people's modern full-of-frills firmware.

OK, I added a few frills to StarMON later on, like those sc calls you see me
using in my new arch/ppc/boot/ppcstar. But those weren't in the original
design, they were an afterthought added not so much to help Linux but for my
internal use (in add-on modules for StarMON that add extra functionality where
I wanted to use the same binary for all boards without changes for different
serial ports etc), and Linux could do just fine without them as my original
design did. I also have a board ID as an ASCIZ string at FFF00010. But again
that isn't strictly necessary, my original plan was to tell users to put an OS-
defined machine type code in one of the registers manually before booting the
kernel.

Or you could make the zImage wrapper grep the ROM region for various strings to
identify what board/firmware it's running on. Right now you could take your
"simple" wrappers for different boards and merge them into one that will first
select the board and then proceed as it does now. The only problem would be
with board identification. Now my idea of having a board ID somewhere in the
ROM is nothing earth-shattering, DEC has done 16 years before me, and I think
just about company does that.

Now the problem with the PowerPC architecture (which doesn't exist in VAX and I
think Alpha and SPARC too) is that there is no central authority over it and no
universal standard for all board manufacurers, so while one company may have
some convention across its boards, there nothing across *all* boards. That's
where the grep idea comes in. I can bet that a board made by Mumbletech model
ABC will have strings "Mumbletech" and "ABC" somewhere in the ROM. Just look
for those magic strings and you'll know what you are running on. Past this step
for everything else there already is a solution.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
