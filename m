Message-ID: <36C99DC8.357EEF2A@mailserv.rz.fh-muenchen.de>
Date: Tue, 16 Feb 1999 17:33:12 +0100
From: Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Restructuring Efforts
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

> > [ some sentences about porting LinuxPPC to Force CPCI 750 board ]

> It depends on what the board provides, some residual data, an OF like
> device tree or nothing (worst case since interrupt routing may be the [...]

Actually, the Force PowerCore 6750 has nothing (or almost nothing). I've
just started with the port, but ran
into some difficulties: There seems to be a lot of dependencies between
different machines (ie. pmac, prep, chrp, mbx, etc.), I didn't want to
pay attention to. (E.g. I do not need PMac's keyboard and SCSI driver,
which seems to be compiled in per default. Especially, I do not need any
calls to read the OF tree, residual data, etc.)

> Restructuring efforts have been announced and some patches are floating
> around.

I've seen that you have setup a directory for those patches. But
couldn't you start with a seperate cvs tree to move the process of
restructuring the kernel forward? I mean, having a kind of 'official'
inofficial LinuxPPC developer kernel. I'd also really appreciate it if
there could be a kind of a statement(?) and perhaps a short discussion
about the restructured arch/ppc tree. I'd like to ask especially you,
Cort, as you seem to be the maintainer of the LinuxPPC port, how you see
the restructured arch/ppc tree. I'd like to help, but need to know where
arch/ppc is going to be. 

I hope that a little discussion is allowed here:
(Please, understand that my point of view is from a board where the
initialization is different from those with an OF)

1. Directory Structure
It seems that efforts are going to create one 'super' PPC-kernel
suitable for all the PPC machines.
I can't say that I'm really happy about it. I think there might be more
overhead, unreadibility (i.e. a lot #ifdef's), bigger kernels, etc. I'd
like to see the Macintosh, PreP, CHRP, etc. more seperated, ie. in
different directories (one for pmac, prep, chrp, apus, mbx, pcore6750,
etc.) I think, it's then much easier to add new machines, new PPC
generations, etc. Short: I don't think is wise to have only one
CONFIG_PMAC_PREP_CHRP_?_? for all machines and let the kernel decide at
boot time what to do. Do I overlook here something?

2. kernel/head.S
It seems that the basic initialization varies from board to board.
Porting LinuxPPC to the Force board would result in more #ifdef's. I'd
suggest to seperate the 'exceptions' part (into trap.S) from the
initialization code and put the later one into the mach-dirs.

3. OF
The Force board has no OF and no residual structures. What I have in
mind is to replace the firmware of the board completely with a MILO-like
firmware. This firmware should be able to boot an elf-vmlinux image
either from the same flash, or the user-flash, from network, or scsi.
Would it possible to seperate the calls to read data from OF and to read
residual data, from the generic sources (especially in arch/ppc/mm) ? 

These are some questions I ran into porting LinuxPPC to the Force board.
Mainly, I do not understand why those three machines, PowerMac
(PPC601-PPC750), CHRP and PReP are put so closely together. For me, it
seems that a lot of #ifdef's, switch(es) and branches are necessary to
achieve this. Perhaps someone can point me in the right direction here.


Thanks,
Christian

-- 
Christian Zankel       <zankel@mailserv.rz.fh-muenchen.de>

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
