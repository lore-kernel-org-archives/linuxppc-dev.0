Message-ID: <380B75A7.3DEE604C@amberdata.demon.co.uk>
Date: Mon, 18 Oct 1999 20:31:51 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.* broken on IBM 850?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

has anybody got a 2.2 kernel working properly on an IBM PowerSeries 850
(codenamed Carolina I think)?

I can boot an old 2.0.32 kernel on it and it mostly seems to work,
although the interrupt assignments are a little odd - NT on the same box
claims that ide0 is on 16, ide1 is on 17 and my ncr825 card is on 15.
Linux seems to think that ide0 is on 13, ide1 doesn't exist (and that
the IDE cdrom on it isn't there either) and that the SCSI card is on irq
10. Is ARC playing games with me?

2.2 kernels (and I've tried quite a few, namely install images for
yellow dog, debian and linuxppc, plus random other bits and bobs)
exhibit symptoms which to me look like the interrupts aren't getting
through. I get "hda IRQ probe failed (0)" several times, the partition
table read fails, and then the ncr53c8xx driver gets a timeout on every
command, which is exactly what happens on x86 machines when the
interrupt mappings get stuffed and the driver isn't getting the
interrupts.

The debian install image (bootprep.bin) behaved slightly differently -
when I took the SCSI card out it managed to get the partition table from
the hard drive while whinging about it all the time (timeouts I think),
and then as soon as it got to mounting the ramdisk the screen went black
and stayed that way. Trying to get it to boot hda1 in single user mode
actually got as far as starting init, and I saw a shell prompt for a
split second before the screen went black :-(

The interrupt mappings seem to be the same under 2.2 as under 2.0.

Oh, does anybody know if the ibmtr driver works with either 2.0 or 2.2?

This is my first attempt at messing with PPC, although I've had a fair
bit of experience with x86 and alpha boxes under linux.

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
