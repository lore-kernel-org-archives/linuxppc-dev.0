Date: Fri, 9 Jun 2000 06:09:21 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX hang (tlbia)
Message-ID: <Pine.LNX.4.21.0006090548410.18644-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've been playing with the mpc8xx-2.2.13.tgz kernel on a MBX/821
board.

To help learn about PowerPC innards, and with an eye towards making
a self-bootable system, I've been trying to get the board to boot
without help from EPPCBug.  I borrowed some init code from eCos
(I think Murray did something similar), wrote a small elf loader,
and packed the whole thing up (loader+zImage.initrd) into flash
memory to boot.

Its actually coming along Ok, I get as far as,

  loaded at:     00210000 0021B1D8
  relocated to:  00100000 0010B1D8
  board data at: 003F4558 003F4580
  relocated to:  00200100 00200128
  zimage at:     00216000 00271893
  initrd at:     00271893 00273E7D
  avail ram:     00274000 00400000

  Linux/PPC load:
  Uncompressing Linux...done.
  Now booting the kernel

but it hangs in arch/ppc/kernel/head.S at

	tlbia			/* Invalidate all TLB entries */

(I narrowed this down by essentially doing a binary search
 inserting a macro to set the LEDs on the MBX; insert it
 before the tlbia and the LED glows - after, it does not;
 the LED is on a control register at 0xFA100001 btw.)

Now, I realize that the eCos initializations must be a little
different from those done by EPPCBug, because it works when
I load with EPPCBug.  But if anyone knows why this particular
instruction would hang, I'd appreciate a clue.

Thanks,
-Jamie

p.s.  I read that MBX is an end-of-life product.  I preferred
it over the FADS for its simplicity, so I'm looking for something
similar (price, size, features, documentation).  Recommendations
are welcome.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
