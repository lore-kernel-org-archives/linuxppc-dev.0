Date: Tue, 6 Apr 1999 22:09:13 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Dave Weis <djweis@plconline.com>
cc: Roy Wood <roy@centricsystems.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Resurrecting mkLinux
In-Reply-To: <Pine.LNX.3.95.990406200339.14652L-100000@catbert.desm.plconline.com>
Message-ID: <Pine.LNX.3.96.990406213629.32614A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Apr 1999, Dave Weis wrote:

> We got around a lot of this in the linux-ma68k port. I think these series
> of powermacs are pretty similar to the top-of-the-line 68k's. I've put
> more comments below.

They're remarkably like the AV Quadras, yes, though I belive the DMA
hardware is different.  They may also have a slightly different SCSI chip,
though I'm fuzzy on that.  They're similar enough, though, that it's
probably no big deal.  And don't the Quadras use a SWIM II for floppy? 
The 5200, which was based on one of the 040/LC040 designs, uses a SWIM II,
which is why I was asking.  Anyway, floppy support isn't quite as critical
as memory mapping or interrupt handling....  ;-)


> > In a related problem, it you're using motherboard video, it claims
> > motherboard RAM.  Thus, you have to do some additional memory mapping in
> > that case.  Something to watch out for.
> 
> Used the macos routines to find the beginning of video memory and passed
> that along too.

No problem there.  That's how we do it under MkLinux, too.  Be careful,
though, as you need to use that address to detect whether it's using the
motherboard video or an AV or HPV card.  MkLinux does the motherboard RAM
with a BAT.  I'm not sure if that's essential, but unlike memory up in the
pre-mapped normal i/o space like you'd find with a card, you can't just
ignore the fact that it starts near 0, I believe....  I'm very, very fuzzy
on that aspect of things, still.


> > Next issue: interrupts.  Few, if any drivers would be functional without
> > interrupts.  Unlike on PCI macs, they aren't assigned neat little PCI
> > interrupt numbers.  The numbers used by MkLinux are arbitrary.  PDM
> > machines also have two VIA "chips" (they're really part of another chip) 
> > that are cascaded as part of the interrupt controller (in contrast, I
> > believe PCI machines only have one).  The way the interrupts are set up is
> > substantially different from PCI machines, too.  DMA interrupts are all
> > cascaded into a single interrupt on the VIA, if I remember correctly.
> > Thus, once you've detected a DMA interrupt, you have to check a series of
> > locations to see if a DMA interrupt occurred for each device that you have
> > DMA code for.  The Mach kernel's interrupt handling code should be a good
> > model.
> 
> That took a while to get running. We didn't get dma running on the few
> machines that supported it either (AV's).

I don't know much about the Quadra AV DMA engine, except that I don't
think it's the same one used in the PowerMacs.  Anyway, about the PowerMac
PDM DMA, there's a lot of information available in various docs, but there
are still some details that can only be obtained (legally) from MkLinux's
source.  If anyone wants a copy of these two PDF files with a bunch of
AMIC info and VIA register info and stuff, let me know, but really, the
MkLinux source says it more readably (and accurately)....  :-)


> > Beyond that, it's mostly a matter of hard-coding addresses into drivers,
> > putting if then else statements around all of the DBDMA stuff, writing
> > appropriate AMIC DMA code (MkLinux, again, should be a good model), and
> > writing additional drivers for video and audio (AWACS support is
> > apparently substantially different on PDM's, as it's a separate driver
> > under MkLinux).  All of the other hardware already has drivers (SCSI, ADB,
> > serial) that will just need some modifications (DMA, addresses, possibly
> > differences in the register maps).
> 
> Between the 68k and ppc scsi drivers, there should be enough info. I did
> most of the 68k one and used info from the macbsd driver.

Sure.  Either one would probably be compatible, simply by adjusting the
base address (and DMA address, if you use DMA).  The x100's use a 53C96
SCSI chip, just like the external bus on most PCI PowerMacs.  Note,
however, that the 8100 has two SCSI busses: the standard 53C96 for
external SCSI (a superset of the 53C94 which IIRC was used in the AV
Quadras), and a 53FC96 (or is it CF?) fast SCSI for its internal bus. 
Again, all of the details can be found in the MkLinux driver or in Apple's
technical specs PDF file (I forget what Apple site I dl'ed that from, but
I can't seem to find it anymore... dunno).  A word of warning: the Apple
PDF file appears to contain numerous errors in the VIA register diagram,
especially where SCSI is concerned. Specifically, on one of the registers,
the bits were nearly all marked SCSI B, where some were obviously SCSI A.
I'd strongly advise using working source (Mach Kernel) as a reference,
because...  well, it's working.  ;-)


Later,
David

p.s. globegate: 119 days uptime under MkLinux.  ;-)

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
