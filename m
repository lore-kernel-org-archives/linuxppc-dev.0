Date: Sun, 19 Sep 1999 01:45:57 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: miBoot 1.0d3
Message-Id: <19990919014557.023075@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


HI !

miBoot 1.0d3 is online at http://calvaweb.calvacom.fr/bh40/test.html

I booted successfully Paul's latest 2.2.12 with a normal xcoff zImage, it
should also work with plain images (vmlinux, usually too large for a
floppy), zImage with initrd, and plain vmlinux compressed with -vf9
option. I didn't test zImage with initrd. (Note that the image is
decompressed by miBoot, the decompression "header" is bypassed.

The kernel file name is currently stored in resource STR# 128.

next on my list:

 - get rid of the Apple boot blocs (write my own). Note that in theory,
using the 68k bootblocs, it may be possible to boot from an ext2
partition (using a first stage loader with a "map" like we do with OF)

 - add some kind of gui to choose the root volume, options, and to be
able to change the video resolution when using video=ofonly (by calling
the ROM video driver).

Another issue is that I have currently no way to exit from miBoot. If I
fail to boot Linux, I exit to the caller, the disk is ejected, but the
machine doesn't try another disk to boot from. It may ne possible, it may
not, I'll have to disassemble more of MacOS ROM in order to figure this
out. I'd like to have a choice to boot MacOS, especially when miBoot is
on a hard disk partition.  (I can still change the PRAM value and reboot).



-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
