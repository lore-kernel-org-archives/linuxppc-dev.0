Message-Id: <199908271827.UAA00377@piglet.cpu.lu>
Date: Fri, 27 Aug 1999 20:27:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: IBM 850 LinuxPPC installation?
To: hollis+@andrew.cmu.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96L.990824214016.3087N-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Aug, this message from Hollis R Blanchard echoed through cyberspace:
> I've gotten a kernel compiled (and it boots!) with ethernet ("Lance") support.
> It also has IDE disk and cdrom support (which makes installing to a hard disk
> much easier). Unfortunately, I've run into a problem - the kernel hangs on
> Partition check:
>   hda:

I have this exact same problem with _some_ disks on my Promise PCI
adapter. My Maxtor drive works, a 32x CDRom worked as well, but a
Seagate and a Quantum both hung the box. I haven't found the problem;
but it might be related to timings on the interface, so that some disks
might work, and others not.

> Here's the IDE info I get before it hangs:
> hda: DPEA-31080, ATA DISK drive
> hda: IRQ probe failed (0)
> hdb: DSAA-3720, ATA DISK drive
> hdb: IRQ probe failed (0)
> hdc: IRQ probe failed (0)
> hdc: IRQ probe failed (0)
> hdc: no response (status = 0xd1), resetting drive
> hdc: no response (status =0x80)

This means the driver is not able to acces the controller for ide1.
That might be a problem with the IO-port addresses.

Also, you might want to try patching your kernel with Andre Hedrick's
multi-platform uniform IDE driver (look at
ftp://ftp.kernel.org/pub/linux/kernel/people/hedrick/). You _might_
need additional patches to get it to boot; if so, get back to me, and
I'll produce a diff against my working kernel.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
