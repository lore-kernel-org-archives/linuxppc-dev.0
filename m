Message-Id: <200003041030.LAA00512@piglet.grunz.lu>
Date: Sat, 4 Mar 2000 11:30:30 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: RE: [Linux1394-devel] Re: FireWire + Apple PB G3: some success
To: mknecht@controlnet.com
cc: andreas.bombe@munich.netsurf.de, maxim@storagecraft.com,
        ad@mpifr-bonn.mpg.de, linux1394-devel@eclipt.uni-klu.ac.at,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <F14842317963D111817100805F0DFE4D4FFF9A@server1.controlnet.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  24 Feb, this message from Mark Knecht echoed through cyberspace:
> According to the LV23 spec the IO_ENB bit is read only, so one would presume
> that writing the a 1 to the IO_ENB ( I presume that this is what is actually
> happening with PCI_COMMAND_IO) would not cause any problems.

No idea here.... PCI_COMMAND_IO in general enables a PCI device to
listen (and maybe react) to IO cycles on the PCI bus.

> As for some of the performance issues, is the Memory Write and Invalidate
> bit in the same PCI register turned off or is it getting turned on? The
> default state is OFF.

On PowerMacs in general, OpenFirmware (the BIOS, if you prefer) should
set the Memory Write and Invalidate bit, as the Mac's PCI bus
implementation is optimised for these cycles. However....

> If not, then DMA writes from the OHCI controller could
> potentially be causing cache flushes and slowing the system down. I am
> presuming here that all or some of the memory addressed by OHCI is marked as
> cacheable which may or may not be the case...)

By default, all memory that is not real RAM is marked as
cache-inhibited. So, to get the maximum performance here, one has to
change cache settings on PCI space. However, I think that this means
you need to bother about cache coherency yourself, i.e. doing cache
flushes by hand. And that's beyond me...

Michel, sometimes working on PowerMac PCI issues

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
