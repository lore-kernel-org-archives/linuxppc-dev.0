Message-ID: <3871BD9C.2DB00160@wanadoo.fr>
Date: Tue, 04 Jan 2000 10:30:04 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel Compile Fun
References: <Pine.GSO.4.10.10001031922430.26986-100000@unix1.wm.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This has been discussed for at least 8 months (see the list archives),
and it was always asked why this is not corrected in the kernel trees. I
ask this again.

Some explanation: In arch/ppc/kernel/pmac_setup.c, the header file
<asm/dma.h> is included via <asm/scatterlist.h> via
"drivers/scsi/scsi.h", but only 
#if defined(CONFIG_SCSI) && defined(CONFIG_BLK_DEV_SD)
On the other hand, the variables ISA_DMA_THRESHOLD and so on are used
outside of any #if. This certainly looks like a bug.

--
Martin

Rob Lineweaver wrote:
> 
> This is from the list archives:
> 
> You can fix this by inserting the line
> 
> #include <asm/dma.h>
> into the file pmac_setup.c.
> 
> Thanks to Michael Fenske, who originally posted that message.  That fixed
> the problem for me.
> 
> hope that works
> 
> Rob Lineweaver
> :)
> 
> On Mon, 3 Jan 2000, Kyle R. Green wrote:
> 
> >
> > I am having the worst possible time getting a newer kernel to compile.  I
> > received this error with both the stock 2.2.13 (and 2.2.14-pre18) kernel
> > on ftp.kernel.org and the linux-pmac-stable tree I rsynced from
> > linuxcare.com.au today:
> >
> > make[1]: Entering directory `/usr/src/linux-pmac-stable/arch/ppc/kernel'
> > gcc -D__KERNEL__ -I/usr/src/linux-pmac-stable/include -Wall
> > -Wstrict-prototypes
> > -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
> > -msoft
> > -float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
> > -mstring   -c
> >  -o pmac_setup.o pmac_setup.c
> > pmac_setup.c: In function `pmac_init':
> > pmac_setup.c:597: `ISA_DMA_THRESHOLD' undeclared (first use in this
> > function)
> > pmac_setup.c:597: (Each undeclared identifier is reported only once
> > pmac_setup.c:597: for each function it appears in.)
> > pmac_setup.c:598: `DMA_MODE_READ' undeclared (first use in this function)
> > pmac_setup.c:599: `DMA_MODE_WRITE' undeclared (first use in this function)
> > make[1]: *** [pmac_setup.o] Error 1
> > make[1]: Leaving directory `/usr/src/linux-pmac-stable/arch/ppc/kernel'
> > make: *** [_dir_arch/ppc/kernel] Error 2
> > [root@portamoose linux-pmac-stable]#

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
