Date: Tue, 30 Nov 1999 01:28:19 +0100
To: paulus@linuxcare.com
CC: linuxppc-dev@lists.linuxppc.org, dan@netx4.com
From: BenH <bh40@calva.net>
Subject: dmasound problems
Message-Id: <19991130012819.012476@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 29, 1999, BenH <bh40@calva.net> wrote:

>BTW, dmasound is broken in Paul's current stable 2.2.14pre. I don't know yet
>what's going on but it looks like the driver had major changes (backported
>sound in from 2.3.x ?). I can't get any sound output on my wallstreet
anymore.
>I'll try to look into this next week.

It's not so broken finally, but I didn't find the solution yet. What
happens is that sometimes, the dmasound module has to be removed and
inserted back for sound to work.
Also, I don't think there is actually any difference between 2.2.13 and
2.2.14pre9 versions of the driver, the differences I experienced were
probably due to the state of the sound chip left by MacOS.

I've tried to track this down and found the following:

 - the sound chip can be controlled via 2 FCR bits in heathrow (mac-io +
0x38), 0x10000 must be cleared and 0x20000 must be set. (You should
endian-inverse them, those are the "readable" version matching
definitions in ohare.h ;) One is the power, the other one controls the
clock, and according to OF, the 0x10000 one is the power (and is inverted
logic). Looks a bit weird, I tend to think that it's actually a reset (OF
is sometimes wrong), but this is the way they work. Eventually, one of
them may be actually the amplifiers but I'm not sure (I'll try hacking
the i2c later).
Basically, look with xmon at mac-io + 0x39. If the byte you see contains
bit 0 unset and bit 1 set, that's ok. Any other combination means no
sound. (And I can somtimes hear a slight "click" when toggling the bits).

 - If I shut the chip down and re-enable it using xmon (dmasound.o not
installed), and then I do a insmod of the module, I have no sound

 - If I shut the chip down, re-enable it using xmon, and then insmod
dmasound.o, rmmod dmasound, and re-insmod dmasound.o immediately, then
sound works.

I tried reproducing the complete init-cleanup-init sequence in
dmasound_init() without luck (weird...). There must be some kind of
timing issue out there, or I missed something. I don't know the AWACS
chip very well so it's difficult to guess.

The machine is a wallstreet with an awacs revision 3 and no CUDA (so the
i2c code is not used).


Any clues ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
