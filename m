Message-Id: <200108261457.QAA02711@piglet.grunz.lu>
Date: Sun, 26 Aug 2001 16:57:31 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Call for help: altivec-enabled vlc
To: linuxppc-dev@lists.linuxppc.org
Cc: debian-powerpc@lists.debian.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've sat down a bit ;-) and came up with an Altivec-optimised IDCT
implementation in vlc (well, I integrated Motorla's Altivec IDCT).

This is in fact the same code that already exists in vlc for MacOS X,
but it uses the Motorola-published assembler code (you can find it on
their site).

After some hacking around, I got it integrated into vlc, got it to
compile, and eventually to run.

However, there's something wrong with the IDCT code; the output is
essentially garbage. Makes for some interesting visual effects, but
that's about it....

So, I need help to figure out what's going wrong here, to check my asm
integration (never done that before), and so on.

Attached is a diff against vlc-0.2.82. Have a look; my code is in
plugins/idct/idctaltivecasm.h, called from plugins/idct/idctaltivec.c.

One thing I'm not sure is if all arguments are passed alright to the asm
code. I added code to send to pointers back as output; however they
don't seem to match what went in...  Have a look at PreScale[],
SpecialConstants[], and ps and sc.

Anyway, the non-Altivec code gives me:

vpar stats: 706 loops among 47 sequence(s)
vpar stats: cpu usage (user: 957, system: 6)
vpar stats: Read 611 frames/fields (I 49/P 186/B 376)
vpar stats: Decoded 228 frames/fields (I 49/P 178/B 1)
vpar stats: Read 0 malformed frames/fields (I 0/P 0/B 0)

whereas the Altivec one gives:

vpar stats: 709 loops among 48 sequence(s)
vpar stats: cpu usage (user: 991, system: 3)
vpar stats: Read 613 frames/fields (I 50/P 187/B 376)
vpar stats: Decoded 305 frames/fields (I 50/P 154/B 101)
vpar stats: Read 0 malformed frames/fields (I 0/P 0/B 0)

Quite a noticeable improvement, no? ;-)

Cheers

Michel

PS When replying, answer to one list only...

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
