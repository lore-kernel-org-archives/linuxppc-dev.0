Date: Fri, 27 Aug 1999 13:20:03 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: linuxppc-dev@lists.linuxppc.org
Subject: CHRP boards and VGA text mode.
Message-ID: <Pine.HPX.4.10.9908271248020.9440-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	Hi, 

I have setup my boards (with Raven/Falcon chipset) to a CHRP like mapping.
I need this to have large windows on VME, so I program the chipset
to operate like an MPC106 in address map B (all Macs with MPC106 probably 
use this mode). 

However there is a problem because I also have a graphics board (actually
a PMC module) which I use in text mode for now. To avoid problems with
several devices responding to the same address I enable the io-hole on the
PCI side of the bridge (I can also enable the alias low memory space
although it's not yet done). But right now the bus_to_virt and virt_to_bus
macros only add or subtract an offset. The problem appears when a bus
mastering PCI device tries to address the 640k to 1Mb range of memory
since actually no device (or the graphics board and not the host bridge)
responds to the access.

Acyually the worst is that this only happens if you have a small kernel so
nobody might actually have noticed it. My standalone kernels
(ext2/nfs/ncr53c8xx/de4x5) never have any problem because all DMA
addresses actually happen to be high enough.

Small nfsroot kernels do exhibit the problem (no ext2 and no scsi driver),
and then the symptoms are hard to interpret, when I load the scsi driver
as a module and then try an mke2fs everything seems to succeed but en
immediate e2fsck reports a few errors on the disk. dd if=/dev/zero
of=/dev/sda1 seems to work fine, but then od /dev/sda1 shows that some
apparently random disk blocks are filled with garbage (many 0xff but not
all). I first believed I had some SCSI cabling or drive problems until I
exchanged cables/drives/CPU board and it stayed the same (but slightly
different errors on every iteration).

There are at least 2 solutions to the problem: 

- make bus_to_virt and virt_to_bus more complex to handle the case of <1Mb
physical addresses. I don't like it, since it will result in even more
code expansion.

- Make the kernel code loaded at 640 k physical (except for the interrupt
vectors...). There is no way to build a kernel with less than 384k of
code (my nfsroot kernels are truly minimal). Reserve the first 16 kB or so 
for interrupt handlers/whatever, then 624k of normal memory followed by
the kernel and then higher memory. I would actually prefer this solution,
but feel free to suggest any other...

Intel's 20 bit addresses will bite us forever, it seeems :-(. 

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
