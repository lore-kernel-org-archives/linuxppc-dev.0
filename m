Message-ID: <4926614F7A31D411820F00D0B74FF7E0013D1A21@RDC03>
From: "Gallant, John" <jgallant@vanteon.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Assistance with using /dev/fb0 and No X windows
Date: Tue, 14 Jan 2003 17:17:22 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I want to thank Claus and Chirag for their responses.  I believe that my
access problems are more lower level than I originally thought.

In our searching's we were only able to find an XFree86 driver for the
Silicon Motion LynxEM chip and one that was in the PPCBoot tree.  I could
not use the XFree86 driver, it was too dependent on support from the XFree86
environment, and even then the "VGA" stuff was from some other file.  As
"per usual" here, things were in crisis and we needed something ASAP.

My original plan was to use the "generic" VGA stuff already in the MVL
kernel to access the chip.  The first problem had to do with the "canned"
address that vga16fb.c was using, with the I/O registers being "offset 0 in
I/O space" and the frame buffer at 0xA0000.  Are these the "In the PC world"
addresses?  With the chip being accessed via the PCI bus, I did not
understand how to "map" the chip via it's single BAR0 Register.  After a
while I realized that the chip has a "default" PCI I/O address of 0, all I
needed to do was make sure that the COMMAND_IO bit was set as part of the
PCI config cycles.  I also needed to discover the proper PCI memory address
by putting in some PCI search code, (only temporary honest!) into the
vga16fb.c code to find the device and store it's PCI memory address.  I was
able to access the I/O registers, i.e. read the MISC and ISR0-1 and read
frame buffer memory.  But still nothing I did with /sbin/getty tty1, fbset
or /dev/fb0 appeared to work at all!

So all this rambling leads me to these questions to the distribution list:

1) Does the "generic" VGA stuff expect that the VGA device is already
initialized and setup by the BIOS/LILO/BOOT code?

2) Does anyone know of a driver for the LynxEM chip that is not from the
XFree86 code base?

I am planning to "strategically advance to the rear" and go back to the
PPCBoot code where I was able to get a few bands of color when the LOGO was
supposed to be drawn on the screen.  If I can get that to work I am hoping
that I can form a better understanding of the LynxEM chip to either create a
limited driver or hack up the vga16fb.c file some more before I work on a
limited driver.

Thank you for any help or information you can send my way.

--------------------------------------------
John A. Gallant
Sr. Embedded Software Engineer
Vanteon Inc.
2851 Clover Street
Pittsford, NY 14534
Phone: 585.248.0510 x279
Fax  : 585.248.0537
email: jgallant@vanteon.com
web: www.vanteon.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
