Date: Tue, 6 Apr 1999 20:11:59 -0500 (CDT)
From: Dave Weis <djweis@plconline.com>
To: "David A. Gatwood" <marsmail@globegate.utm.edu>
cc: Roy Wood <roy@centricsystems.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Resurrecting mkLinux
In-Reply-To: <Pine.LNX.3.96.990406174533.31580B-100000@globegate.utm.edu>
Message-ID: <Pine.LNX.3.95.990406200339.14652L-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



We got around a lot of this in the linux-ma68k port. I think these series
of powermacs are pretty similar to the top-of-the-line 68k's. I've put
more comments below.

> It's not a stupid idea, but there are a handful of issue sthat would have
> to be resolved before drivers come into play.  The biggest one is the
> physical RAM.  On the x100 PowerMacs, RAM is not (ever) contiguous.  I
> have some info about it in a PDF file somewhere, but not with me.  Anyway,
> there's a table you can read to get the addresses of the banks of memory.
> That will produce a wrinkle, if I'm reading the LinuxPPC code right, since
> it appears to only be willing to handle a single memory region.  Also, the
> LinuxPPC booter would have to incorporate the code to read that table, and
> pass it in as part of the kernel boot args or whatever.  Further, since
> the machines don't have OpenFirmware and there are substantial differences
> between them and PCI machines, it would be wise to pass in the machine ID
> (gestalt) along with that.  There's no reason to fake an OF tree -- it
> would clutter the booter unnecessarily, and in virtually every place where
> you'd do an OF check for addresses or interrupts, you'd probably have to
> have a switch statement with a PDM case anyway, so there's not much point.

We passed along a structure that contained addresses of ram chunks to be
mapped.

> In a related problem, it you're using motherboard video, it claims
> motherboard RAM.  Thus, you have to do some additional memory mapping in
> that case.  Something to watch out for.

Used the macos routines to find the beginning of video memory and passed
that along too.

> Next issue: interrupts.  Few, if any drivers would be functional without
> interrupts.  Unlike on PCI macs, they aren't assigned neat little PCI
> interrupt numbers.  The numbers used by MkLinux are arbitrary.  PDM
> machines also have two VIA "chips" (they're really part of another chip) 
> that are cascaded as part of the interrupt controller (in contrast, I
> believe PCI machines only have one).  The way the interrupts are set up is
> substantially different from PCI machines, too.  DMA interrupts are all
> cascaded into a single interrupt on the VIA, if I remember correctly.
> Thus, once you've detected a DMA interrupt, you have to check a series of
> locations to see if a DMA interrupt occurred for each device that you have
> DMA code for.  The Mach kernel's interrupt handling code should be a good
> model.

That took a while to get running. We didn't get dma running on the few
machines that supported it either (AV's).

> Beyond that, it's mostly a matter of hard-coding addresses into drivers,
> putting if then else statements around all of the DBDMA stuff, writing
> appropriate AMIC DMA code (MkLinux, again, should be a good model), and
> writing additional drivers for video and audio (AWACS support is
> apparently substantially different on PDM's, as it's a separate driver
> under MkLinux).  All of the other hardware already has drivers (SCSI, ADB,
> serial) that will just need some modifications (DMA, addresses, possibly
> differences in the register maps).

Between the 68k and ppc scsi drivers, there should be enough info. I did
most of the 68k one and used info from the macbsd driver.


djweis

-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231
http://www.plconline.com/ | "Great spirits will always encounter violent
                          | opposition from mediocre minds" - Einstein


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
