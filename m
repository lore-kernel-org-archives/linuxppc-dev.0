Message-Id: <199908010723.JAA00303@piglet.cpu.lu>
Date: Sun, 1 Aug 1999 09:23:47 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: drow@false.org
cc: mj@ucw.cz, hedrick@Astro.Dyer.Vanderbilt.Edu,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990727230416.A457@them.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Below you'll find my experiences so far with the Ultra/66...

On  27 Jul, this message from Daniel Jacobowitz echoed through cyberspace:
> OK.  I have this working now.  In getting it to work, I've come across
> a couple of issues.
> 
> (A) You can't compile IDE as a module and enable ide-pmac.  There will
> be link errors in pmac_setup.c.

Compiling workes for me. I've not been able to boot that kernel,
though... for other reasons (crashes in MacOS; I need BootX).

> (B) Very closely tied to that, if ide-pmac is not enabled, a dummy
> pmac_ide_init_hwif_ports() is compiled in pmac_setup.c.  But the real
> version of this function (in ide-pmac.c) does more than just onboard
> IDE specific tasks.  For PCI IDE cards it is still needed.  Enabling
> ide-pmac eventually let me make use of the card.

I agree; I had the same problem. I first tried to comment out
pmac_ide_init_hwif_ports(), without enabling ide-pmac; but that
resulted in a kernel panic upon initializing of the IDE driver. (Now
that I think about it: the panic might have been due to PCI stuff...)

In addition, I had to change include files: problem is that both
pmac_setup.c and chrp_pci.c need the definition of hw_regs_t, which is
defined in <linux/ide.h>. My solution was to replace
#include <asm/ide.h> with #include <linux/ide.h>; the latter including
<asm/ide.h> anyway. Is this the right solution?

There might be other platform-specific files that need this patch as
well; Andre: I think it is the changes you made to
pmac_ide_init_hwif_ports() that made this necessary; you might need to
patch all files where you changed this function.

> (C) I needed to add a patch to automatically try setting PCI_COMMAND_IO
> if powerpc.  Without this the card would be marked as not supporting
> native mode, and not be initialized.  On x86 bios32.c takes care of
> bioses which do not set this.  Should something in the PPC PCI
> initialization be doing the same?

Noticed that too. My solution is a more generic one: I copied the fixup
code from bios32.c over to arch/ppc/kernel/pmac_pci.c, minus the
I/O-port fixup. So far, it didn't break anything else, and according to
boot messages, it does correct the Ultra's PCI settings:

PCI: Probing PCI hardware
PCI: Enabling I/O for device 00:68
PCI: Enabling memory for device 00:68

Obviously, this is not the best solution neither, as it is only called
on the PowerMac platform.

> On a much less related note:
> drow:~# hdparm -p /dev/hdc
> 
> /dev/hdc:
>  attempting to auto-tune PIO mode
>  HDIO_SET_PIO_MODE failed: Function not implemented

Hmmm, according to boot messages, I'm getting PIO mode for all ports:

Uniform Multi-Platform E-IDE driver Revision: 6.20
PDC20262: IDE controller on PCI bus 00 dev 68
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0x80820000
PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x0400-0x0407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x0408-0x040f, BIOS settings: hdg:pio, hdh:pio

> As it is I get this (off a 5400 RPM Maxtor 25.4G DiamondMax)
> /dev/hdc:
>   Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec

You beat me on this one... I'm not getting anything off my disks:

hde: no response (status = 0xa1), resetting drive
hde: no response (status = 0xa1)
hdf: no response (status = 0xa1), resetting drive
hdf: no response (status = 0xa1)
hdg: no response (status = 0xa1), resetting drive
hdg: no response (status = 0xa1)
hdh: no response (status = 0xa1), resetting drive
hdh: no response (status = 0xa1)
hde: no response (status = 0xa1), resetting drive
hde: no response (status = 0xa1)
hdf: no response (status = 0xa1), resetting drive
hdf: no response (status = 0xa1)
hdg: no response (status = 0xa1), resetting drive
hdg: no response (status = 0xa1)
hdh: no response (status = 0xa1), resetting drive
hdh: no response (status = 0xa1)

Andre, any idea why it is not seing my disks? Anything you want me to
try? I've had both a Matrox and an IBM on the two ports, one via the
UDMA66 cable, the other via standard cable.

Thanks

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
