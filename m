Message-ID: <B895EFF5AF34724880036BDB5B5B814813574A@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Kent Borg'" <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Large initrd and arch/ppc/boot/simple Question
Date: Tue, 1 Jul 2003 13:34:34 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


8 MB compressed (& if so: zvmlinux.initrd or
ramdisk.image.gz?) , or 8 MB uncompressed RAM
disk?

If the latter:  I've successfully used a RAM disk of
12 or 16 MB.  You need to (a) go into your kernel
config and set CONFIG_BLK_DEV_RAM_SIZE, and (b) modify
whatever it is that creates your RAM disk image
(dd + mke2fs perhaps).

If the former:  you might check the RAM address
of your firmware, the RAM runtime address of the
boot wrapper (-Ttext ???? in arch/ppc/boot/simple/Makefile),
and the size of your RAM.  The firmware needs to jump
into zvmlinux.initrd, which will copy itself to the
-Ttext address, then decompress the kernel to 0 and
copy the RAM disk to the end of RAM.  You can have
problems if any of these things overlap.


-----Original Message-----
From: Kent Borg [mailto:kentborg@borg.org]
Sent: Tuesday, July 01, 2003 1:30 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Large initrd and arch/ppc/boot/simple Question



We are booting our kernel via the arch/ppc/boot/simple mechanism to
package up our kernel and initrd.  It seems to work, until we get too
big.  What is big?  Roughly 8 MB for our one big uncompressed userland
program, plus the kernel, bash, busybox, and various userland
utilities.

Can initrd's get that large and still work?  Is the simple boot code
sensible with these sizes?  (I notice that the "avail ram" message
that gets printed is just hard coded number...)


Thanks,

-kb, the Kent who is running roughly 2.4.21-pre6.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
