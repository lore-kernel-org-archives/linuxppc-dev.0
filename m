Message-Id: <199908081954.VAA02923@piglet.cpu.lu>
Date: Sun, 8 Aug 1999 21:54:12 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: hedrick@Astro.Dyer.Vanderbilt.Edu
cc: drow@false.org, mj@ucw.cz, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96.990728021015.14664A-100000@Astro.Dyer.Vanderbilt.Edu>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134392852-1804289383-934142052=:2922"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134392852-1804289383-934142052=:2922
Content-Type: TEXT/plain; CHARSET=US-ASCII

Hi all,

I've got it working as well ;-) Was a big headache, though...

Read on for the details.

First, the hardware: a PowerMac 7600, upgraded G3/300, 112 MB RAM,
kernel 2.2.10 with the genam patch from Andre, Promise Ultra/66 with
BIOS 1.11.

Problems start with the changed definition of a few ide functions, now
using hw_regs_t, in asm-ppc/ide.h. As a result,
arch/ppc/kernel/pmac_setup.c and chrp_pci.c need to include linux/ide.h
instead of asm/ide.h. In addition, pmac_setup.c
defines an empty ide_init_default_hwifs(), but it was previously
defined in asm-ppc/ide.h. Patch (linux-asm-ide.patch) below.

Then, I had the problem of enabling the PCI IO space of the card; I
have tried a more generic patch which I'll send in a different mail
with other PCI-related stuff (IRQ related).

What annoyed me the most, was getting access to the I/O-ports of the
Promise going. Turns out that the PCI config registers contain the IO
address as seen from the bus, which is not the same as seen from the
CPU. In fact, they start at 0x0 on the PCI bus, but the host bridge
maps that area to 0xf2000000 on the processor bus. 

This fact was already catered for with the definition of outb/inb and
friends, which get an offset added to the port. Unfortunately, the
PowerMac IDE code undoes this and replaces it with a different
mechanism, which in essence removes the offset. Grrr..

I've solved the problem by adding the right offset directly to the
io-port values as found in the kernel's PCI structures. I think this
needs more serious rework, though. Paul, are you the author of the
PowerMac IDE stuff? So we can work this out... 

On  28 Jul, this message from Andre M. Hedrick echoed through cyberspace:
>> > pdc202xx.c has no tuneproc.  Is this deliberate?
> 
> YES, there are no known or possible way to ever get the card in to a PIO
> mode that is meaningful.  The BIOS defaults to a fixed value.

Not sure what it means, but Promise' doc says it can do PIO modes. But
I prefer DMA ;-)....

>> > As it is I get this (off a 5400 RPM Maxtor 25.4G DiamondMax)
>> > /dev/hdc:
>> >   Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec
>> 
>> This is not brilliant, but acceptable. What mode of operation was that
>> in? UDMA? Or regular DMA or even PIO?
> 
> I am glad that it meets with your approval, if you can do better do it!

;-)) How about this:

/dev/hde:
 Timing buffered disk reads:  64 MB in  6.60 seconds = 9.70 MB/sec
Maxtor 91024D4; 10G 7200 RPM, UDMA-2 ie 33 MB/s.

However, I don't know what this means:
[root@piglet ~]# hdparm -i /dev/hde  

/dev/hde:

 Model=Maxtor 91024D4, FwRev=NAN4251A, SerialNo=W407PXHA
 Config={ Fixed }
 RawCHS=19590/16/63, TrkSize=0, SectSize=0, ECCbytes=54
 BuffType=3(DualPortCache), BuffSize=512kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=2(fast)
 CurCHS=19590/16/63, CurSects=-66060037, LBA=yes, LBAsects=19746720
 WARNING 85806757 ORPHANED SECTORS :: KERNEL REPORTING ERROR
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2 
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 mode2 
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 

Any ideas? Drive bug, driver capacity calculation error, or endianess
error?

Andre, I have had my machine hang solid when doing either 

	hdparm -I /dev/hde   	or
	hdparm -d1 -X66 /dev/hde

Any idea what could be causing this?

Thanks, all!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134392852-1804289383-934142052=:2922
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Description: linux-asm-ide.patch

--- linux/arch/ppc/kernel/pmac_setup.c	Sun Aug  8 21:26:26 1999
+++ linux-ideok/arch/ppc/kernel/pmac_setup.c	Sun Aug  8 19:12:16 1999
@@ -41,6 +41,7 @@
 #include <linux/blk.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
+#include <linux/ide.h>
 #include <asm/prom.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -53,7 +54,6 @@
 #include <asm/ohare.h>
 #include <asm/mediabay.h>
 #include <asm/feature.h>
-#include <asm/ide.h>
 #include <asm/machdep.h>
 
 #include "time.h"
@@ -550,10 +550,12 @@
  * This registers the standard ports for this architecture with the IDE
  * driver.
  */
+/* It is already defined in include/asm-ppc/ide.h
 void
 ide_init_default_hwifs(void)
 {
 }
+ */
 #endif
 
 __initfunc(void
--- linux/arch/ppc/kernel/chrp_pci.c	Sat Aug  7 17:09:39 1999
+++ linux-ideok/arch/ppc/kernel/chrp_pci.c	Sat Aug  7 17:33:51 1999
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/openpic.h>
+#include <linux/ide.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -15,7 +16,6 @@
 #include <asm/hydra.h>
 #include <asm/prom.h>
 #include <asm/gg2.h>
-#include <asm/ide.h>
 #include <asm/machdep.h>
 
 #include "pci.h"

--134392852-1804289383-934142052=:2922--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
