Date: Wed, 17 Feb 1999 13:12:36 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
cc: Cort Dougan <cort@persephone.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <36C99DC8.357EEF2A@mailserv.rz.fh-muenchen.de>
Message-ID: <Pine.HPP.3.96.990217124600.26713C-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 16 Feb 1999, Christian Zankel wrote:

> Actually, the Force PowerCore 6750 has nothing (or almost nothing). I've
> just started with the port, but ran
> into some difficulties: There seems to be a lot of dependencies between
> different machines (ie. pmac, prep, chrp, mbx, etc.), I didn't want to
> pay attention to. (E.g. I do not need PMac's keyboard and SCSI driver,
> which seems to be compiled in per default. Especially, I do not need any
> calls to read the OF tree, residual data, etc.)

Actually it seemes the board uses an MPC106, so it must have either a PreP
like map or a CHRP like one (it might even be switchable with a jumper).

> I've seen that you have setup a directory for those patches. But
> couldn't you start with a seperate cvs tree to move the process of
> restructuring the kernel forward? I mean, having a kind of 'official'
> inofficial LinuxPPC developer kernel. I'd also really appreciate it if
> there could be a kind of a statement(?) and perhaps a short discussion
> about the restructured arch/ppc tree. I'd like to ask especially you,
> Cort, as you seem to be the maintainer of the LinuxPPC port, how you see
> the restructured arch/ppc tree. I'd like to help, but need to know where
> arch/ppc is going to be. 
> 
> I hope that a little discussion is allowed here:
> (Please, understand that my point of view is from a board where the
> initialization is different from those with an OF)
> 
> 1. Directory Structure
> It seems that efforts are going to create one 'super' PPC-kernel
> suitable for all the PPC machines.
> I can't say that I'm really happy about it. I think there might be more
> overhead, unreadibility (i.e. a lot #ifdef's), bigger kernels, etc. I'd
> like to see the Macintosh, PreP, CHRP, etc. more seperated, ie. in
> different directories (one for pmac, prep, chrp, apus, mbx, pcore6750,
> etc.) I think, it's then much easier to add new machines, new PPC
> generations, etc. Short: I don't think is wise to have only one
> CONFIG_PMAC_PREP_CHRP_?_? for all machines and let the kernel decide at
> boot time what to do. Do I overlook here something?

Not that much, actually once you smooth out the differences in:
a) the interrupt controllers,
b) the address at which you access PCI I/O space,
c) the way you access PCI configuration space,
d) a few oddities like virt_to_bus and offsets to access PCI MMIO space
   (ioremap).

PreP, CHRP and PMAC are very similar, except for individual drivers, so it
makes sense to have common files. The 4/5/8xx series on the other hand are
so different from the 6xx/7xx (espcially the MMU) that some files should
indeed be splitted and the ifdef moved up to the Makefile level.

> 2. kernel/head.S
> It seems that the basic initialization varies from board to board.
> Porting LinuxPPC to the Force board would result in more #ifdef's. I'd
> suggest to seperate the 'exceptions' part (into trap.S) from the
> initialization code and put the later one into the mach-dirs.
> 
> 3. OF
> The Force board has no OF and no residual structures. What I have in
> mind is to replace the firmware of the board completely with a MILO-like
> firmware. This firmware should be able to boot an elf-vmlinux image
> either from the same flash, or the user-flash, from network, or scsi.
> Would it possible to seperate the calls to read data from OF and to read
> residual data, from the generic sources (especially in arch/ppc/mm) ? 

That's one of my goals on an MVME board, I'm going to upload patches with
a new prepboot directory which now needs more widespread testing. For now
it relies on residual data, but it should be less necessary on every
iteration (except for interrupt routing which is hopeless on some boards).

I'd rather see it the other way around, the MILO-like should be board
specific and build a minimal parameter table for the kernel so that the
same kernel can run on different boards. Note that prepboot enables the
MMU and maps all memory and I/O with correct attributes so that it would
probably allow the addition of simplified drivers to the ROM image (it
also includes a simple but powerful enough for most cases memory
management system). It also includes an x86 emulator which allows me to
initialize my S3 Trio64 PMC board, which was never working properly with
earlier versions of PPC vga init code. 

The only thing I did not want to add was interrupt handling. So the
drivers will have to be modified to do polling, I don't think that this is
an issue in a bootloader: it would make it more fragile for no good
reason.

	Regards,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
