Message-Id: <200004240635.IAA00308@piglet.grunz.lu>
Date: Mon, 24 Apr 2000 08:35:48 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Speculative Processing / 7500 with G3 upgrade
To: keys@yikes.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.BSF.4.21.0004190027440.18043-100000@nerf.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  19 Apr, this message from Matt McLean echoed through cyberspace:
> I've been trying almost every version of the kernels around lately, dave's
> CVS 2.2 and 3, paul's tree, and with all of them I have the same
> problem: random machine lockups.

I've got a 7600 G3-upgraded, and have had no such problems... However,
for me I can't use the internal (MESH) SCSI anymore with one of my SCSI
disks...

> I use a 7500 with a G3/350 upgrade, running at 400 (I have considered
> overclocking as a possible source of the problem...)

I'd rather look for this as the source of your problem. The 7x00 series
are rather picky about CPU clock speeds and bus timings; I had to
fiddle a lot with mine to get it working. Still, control sometimes
crashes (no video anymore), and I sometimes have 'ghost pixels' on the
screen...

> It just seems like places in memory are getting hosed (bad checksums, bad
> memory addresses, etc, all which lock up the kernel, and I think it might
> be a problem with Speculative Processing and my Adaptec 2940 ultra2 card.

If it's places in memory, it's not speculative adressing... plus, I
doubt the Adaptec uses a 'change on read' buffer for data transfer...
most likely, it does bus mastering anyway.

> XLR8, and I'm sure other companies, work around this by
> disabling speculative processing with their Mac OS software, but my
> question is, is the problem currently being accounted for in the linux
> kernel?  Do you just need to turn off a bit somewhere, would it be that
> simple?

As I said, other than enabling L2 cache (not done by default when OF
booting), I had nothing to tweek to get it working.. You might try and
use BootX for booting, and change the name of your card's MacOS
extension so that it loads _before_ BootX. That way, you boot into
Linux with the card's patches applied.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
