Message-ID: <B895EFF5AF34724880036BDB5B5B81481355C0@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Kent Borg'" <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: boot/simple in ROM?
Date: Thu, 24 Apr 2003 11:06:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I based mine off boot/simple.  It runs fine from ROM.

Suppose for example I have 32MB SDRAM from 0x00000000
to 0x01ffffff, and 16MB flash from 0xff000000 to 0xffffffff.
The key is that arch/ppc/boot/ld.script, and
arch/ppc/boot/simple/Makefile with -Ttext (say) 0x00400000,
make zImage.initrd an ELF file which should go at 0x00400000.
I build zImage.initrd and store it in flash at 0xff000000,
not at 0x00400000.

There is firmware on the board which initializes the memory
controller, etc.  This firmware then jumps into the image
in flash -- jumps directly to 0xff010000, with the extra
0x00010000 to get around the ELF header -- and zImage.initrd
does start executing there.  It immediately checks its PC and
sees that it's not at 0x00400000 where it belongs, so it copies
itself there (to RAM) and keeps running from there.  Then its
BSS, data and stack are in RAM as they should be.

You can see that zImage.initrd copies itself from *anywhere*
to where it should belong.  This is why, as Dan pointed out,
you can use a single zImage.initrd.  If I am developing,
I TFTP it to the board, say to 0x01000000.  Then I jump to
0x01010000.  If I am happy with it, I store it in flash
at 0xff000000.  Then I jump to 0xff010000.  Wherever I put
it, it will copy itself to where it belongs.


-----Original Message-----
From: Kent Borg [mailto:kentborg@borg.org]
Sent: Thursday, April 24, 2003 10:39 AM
To: Kerl, John
Subject: Re: boot/simple in ROM?


On Thu, Apr 24, 2003 at 10:35:21AM -0700, Kerl, John wrote:
> Why won't it run from ROM?

It puts the stack and bss in ROM.  Am I doing something wrong or using
a bad version??

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
