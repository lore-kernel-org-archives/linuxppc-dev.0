Message-ID: <62639.213.107.143.228.1054413401.squirrel@www.solinno.co.uk>
Date: Sat, 31 May 2003 21:36:41 +0100 (BST)
Subject: [RFC] A stand-alone boot loader for PReP
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

[If you bore easily: http://www.solinno.co.uk/leigh/pablo/pablo-0.2.tar.gz ]

Ever since I got Linux going on my PReP box I've been unhappy about the
boot loader.  There is no lilo or yaboot equivalent for PReP and it's a
pain.  For the past several months I've been trying to devise a way of
making a bootloader similar to lilo or yaboot, and this is the best I've
been able to come up with.

PABLO, the "PReP Architecture Boot LOader", has a great name, and in fact
that's probably the best thing about it right now.  Although it's far
from finished, I have actually managed to boot with it, which is a start.

At this point I'm interested in feedback on the basic concept and
implementation, especially if there is some fatal flaw that I've not
noticed.

The boot loader code (which is 90% the same as the old loader) has been
changed to be fully relocatable.  Instead of relocating the loader on
startup it fixes up the relocation entries.  The loader now compiles
into a standalone ELF executable with no attached kernel images.  The
ELF header is stripped off and the loader is written to disk when the
boot image is created.

The pablo frontend itself works much in the same way as lilo (I
modelled the config file on lilo's).  When you run pablo it reads the
config file, locates the kernel images specified in the config and
creates an appropriate prep image that it writes directly to the
prep boot partition (or any file you like).  I haven't implemented
ramdisk and System.map just yet, but the support is in there.  It
does support multiple images and I've used it boot dual-boot between
a 2.4 and 2.5 kernel.

The boot image construction takes advantage of the fact that the
PReP spec specifies an offset into the boot image at which execution
of the code starts.  The boot image is written as shown below (sorry
for the crappy ascii art):

+----------------------------+ 0x0000
|                            |
| x86 compatible boot sector |
|                            |
+----------------------------+ 0x0100
|              ENTRY POINT >-+----+
|                            |    |
|        PReP header         |    |
|                            |    |
+----------------------------+    |
|      Table of contents     |    |
+----------------------------+    |
|                            |    |
|         vmlinux.gz         |    |
|                            |    |
+----------------------------+    |
|                            |    |
|         ramdisk            |    |
|                            |    |
+----------------------------+    |
              .                   |
              .                   |
              .                   |
+----------------------------+ <--+
|                            |
|          loader            |
|                            |
+----------------------------+

The offset points to the first address of the boot loader.  The table
of contents contains a list of offsets to the various kernel images
and so on contained within the boot image.  The images are written
after the table of contents.  The loader itself must be written last
to avoid the BSS area overlapping other areas of the boot image.

When the boot loader starts it uses the passed offset to the start
of the boot image to determine where the table of contents resides.
It then uses the table of contents to display a prompt, select the
appropriate kernel and so on.  The table of contents also holds
default arguments for each image, that will be passed to the running
kernel via BI_RECS.

You can download it from here:

http://www.solinno.co.uk/leigh/pablo/pablo-0.2.tar.gz

That's it really.  Any feedback is appreciated.

Cheers,

Leigh.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
