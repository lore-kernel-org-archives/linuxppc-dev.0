Message-ID: <20030328171108.15068.qmail@web41213.mail.yahoo.com>
Date: Fri, 28 Mar 2003 09:11:08 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: Flash File System Concerns
To: Jaap-Jan Boor <jjboor@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3E82F7F6.A1C684F@lucent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Folks,

I have one concern regarding FFS. If you use flash for
your entire filesystem including /var/log, /proc,
etc.., you will be accessing flash too many times.

And there is good chance that, your flash on the board
reaches maximum number of accesses/writes limited by
flash technology.

How do people generally handle that in the industry.
Especially, if you have on-board (non-replaceable)
flash?

Thanks,
Prakash


Jaap Jan: Thank you very much for precise
instructions.




--- Jaap-Jan Boor <jjboor@lucent.com> wrote:
> Prakash,
>
> You should divide your flash into parts. e.g.:
>
> - first block(s) boot
> - then some blocks for the kernel
> - all remaining blocks as root fs
>
> You do this partitioning in the maps directory of
> drivers/mtd.
>
> You can make a linux kernel with mtd and jffs2
> support and ramdisk that
> holds the erase, eraseall, dd, mkfs.jffs2 etc.
> programs.
>
> You can load the kernel into SDRAM, run it, prepare
> your flash (erase flash, then use mkfs.jffs2 on a
> /dev/mtd? device
> to prepare an fs.
>
> You should then make a new kernel that uses mtd as
> rootfs, not
> the ramdisk as rootfs.
>
> Jaap-Jan
>
> Prakash kanthi wrote:
> >
> > Hi Jaap Jan,
> >
> > Thanks for your reply. What do you mean by 'works
> out
> > of the box with denx'? I see the code you referred
> to
> > but not sure how to use it. I still have some
> > concerns. Like,
> >
> > 1. How can i initially store the image into flash?
> My
> > flash chip is on the board.
> > 2. How can i boot linux from flash?
> >
> > 3. Currently i have a 32MB SDRAM along with flash.
> I
> > have tools to download linux image into SDRAM.
> Even if
> > i go with MTD/JFFS, my concern is unless linux
> runs
> > flash can not be accessed and vice versa.
> >
> > 4. Lets say, i download linux into a safe place in
> > SDRAM, boot it and then access flash thru MTD/JFFS
> and
> > store linux image into flash. Even in this case,
> what
> > all i need to take care of for making my flash a
> boot
> > device.
> >
> > Any detailed documentation is appreciated.
> >
> > Thanks,
> > Prakash
> >
> > --- Jaap-Jan Boor <jjboor@lucent.com> wrote:
> > > Hi,
> > >
> > > I use strata flash with MTD and JFSS2 as file
> system
> > > on top of it. Works out of the box with denx'
> eldk
> > > kernel and
> > > toolchain. I've provided my own flash map but
> you
> > > can also use an existing one (look e.g. in
> > > linux/drivers/mtd/maps)
> > >
> > > Jaap-Jan
> > >
> > > Wolfgang Denk wrote:
> > > >
> > > > In message
> > >
> <20030326070131.88176.qmail@web41202.mail.yahoo.com>
> > > you wrote:
> > > > >
> > > > > I have a 32MB Intel Strata flash on my
> PPC405
> > > based
> > > > > custom board. I need to create access
> > > routines/APIs to
> > > > > access the flash. I was thinking of creating
> a
> > > Flash
> > > > > File System and mount it as a device in
> Linux
> > > > > environment.
> > > > >
> > > > > Are there any off the shelf FFS packages
> > > available?
> > > > > Generally, how the flash is used?
> > > >
> > > > Use the MTD layer.
> > > >
> > > > > I am working with micro-monitor to use its
> Tiny
> > > File
> > > > > System on flash support and eventually mount
> > > into
> > > > > linux. Did anyone use this combination
> before?
> > > >
> > > > I think you cannot do this. AFAIK the TFS code
> is
> > > not available under
> > > > a GPL compatible license which prevents it
> from
> > > being linked with the
> > > > Linux kernel code.
> > > >
> > > > Best regards,
> > > >
> > > > Wolfgang Denk
> > > >
> > > > --
> > > > Software Engineering:  Embedded and Realtime
> > > Systems,  Embedded Linux
> > > > Phone: (+49)-8142-4596-87  Fax:
> (+49)-8142-4596-88
> > >  Email: wd@denx.de
> > > > There is is no reason for any individual to
> have a
> > > computer in  their
> > > > home.      -- Ken Olsen (President of Digital
> > > Equipment Corporation),
> > > >               Convention of the World Future
> > > Society, in Boston, 1977
> > > >
> > >
> > > --
> > > J.G.J. Boor
> > > Room:  BE-525
> > > Lucent Technologies Nederland b.v.
> > > Phone: +31 35 687 4721
> > > Optical Networking Group TMS Data
> > > Fax:   +31 35 687 5976
> > > P.O. Box 1168, 1200 BD, Hilversum, The
> Netherlands
> > mailto:jjboor@lucent.com
> >
>
> --
> J.G.J. Boor
> Room:  BE-525
> Lucent Technologies Nederland b.v.
> Phone: +31 35 687 4721
> Optical Networking Group TMS Data
> Fax:   +31 35 687 5976
> P.O. Box 1168, 1200 BD, Hilversum, The Netherlands
mailto:jjboor@lucent.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
