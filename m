Date: Tue, 6 Apr 1999 18:16:50 -0500 (CDT)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Roy Wood <roy@centricsystems.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Resurrecting mkLinux
In-Reply-To: <1288712801-202206156@mail.centricsystems.ca>
Message-ID: <Pine.LNX.3.96.990406174533.31580B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 6 Apr 1999, Roy Wood wrote:

> I've got a little time and an old 6100, so I'm giving some thought to 
> raiding the mkLinux sources and getting a monolithic version of the 
> kernel going (i.e. getting rid of the whole Mach layer).
> 
> My plan is to get video working first, then the ADB keyboard, followed by 
> SCSI and network support.  Oh-- and maybe serial too, eventually.
> 
> Stop me right now if this is a stupid idea, please, but don't forget to 
> tell me why it is.  :-)

It's not a stupid idea, but there are a handful of issue sthat would have
to be resolved before drivers come into play.  The biggest one is the
physical RAM.  On the x100 PowerMacs, RAM is not (ever) contiguous.  I
have some info about it in a PDF file somewhere, but not with me.  Anyway,
there's a table you can read to get the addresses of the banks of memory.
That will produce a wrinkle, if I'm reading the LinuxPPC code right, since
it appears to only be willing to handle a single memory region.  Also, the
LinuxPPC booter would have to incorporate the code to read that table, and
pass it in as part of the kernel boot args or whatever.  Further, since
the machines don't have OpenFirmware and there are substantial differences
between them and PCI machines, it would be wise to pass in the machine ID
(gestalt) along with that.  There's no reason to fake an OF tree -- it
would clutter the booter unnecessarily, and in virtually every place where
you'd do an OF check for addresses or interrupts, you'd probably have to
have a switch statement with a PDM case anyway, so there's not much point.

In a related problem, it you're using motherboard video, it claims
motherboard RAM.  Thus, you have to do some additional memory mapping in
that case.  Something to watch out for.

Next issue: interrupts.  Few, if any drivers would be functional without
interrupts.  Unlike on PCI macs, they aren't assigned neat little PCI
interrupt numbers.  The numbers used by MkLinux are arbitrary.  PDM
machines also have two VIA "chips" (they're really part of another chip) 
that are cascaded as part of the interrupt controller (in contrast, I
believe PCI machines only have one).  The way the interrupts are set up is
substantially different from PCI machines, too.  DMA interrupts are all
cascaded into a single interrupt on the VIA, if I remember correctly.
Thus, once you've detected a DMA interrupt, you have to check a series of
locations to see if a DMA interrupt occurred for each device that you have
DMA code for.  The Mach kernel's interrupt handling code should be a good
model.

Surprisingly, the original PDF file about the hardware virtually contained
enough information to write the interrupt handler....  Addresses amd
everything.  Sadly, it doesn't give DMA addresses.  YOu'll just have to
rip those from MkLinux.  BTW, the floppy addresses aren't all correct yet.
Just a word of warning.  Still working on it.  :-)

But really, before either of those, you should work up the serial driver.
Be sure to set it up to allow use in polling mode so that it can be used
for debugging before interrupts are enabled.  

Last, you'll need a compile option to use one of two macros for eieio(),
sync(), and isync().  There are certain common cards used in a large
percentage of PowerMac x100's that will do some sort of illegal access at
the address stored in some register (I forget the details) if you use
those without clearing the register first, so... well, it's in one of the
header files in the POWERMAC directory.

Beyond that, it's mostly a matter of hard-coding addresses into drivers,
putting if then else statements around all of the DBDMA stuff, writing
appropriate AMIC DMA code (MkLinux, again, should be a good model), and
writing additional drivers for video and audio (AWACS support is
apparently substantially different on PDM's, as it's a separate driver
under MkLinux).  All of the other hardware already has drivers (SCSI, ADB,
serial) that will just need some modifications (DMA, addresses, possibly
differences in the register maps).

Oh yeah.  The Swim III used for floppies has different register spacing on
PDMs.  I would expect other chips to have something similar.  MkLinux gets
around this by having a structure containing pointers to the registers,
and filling them by adding the base address to the offset from one of two
static structures. according to the machine class.  Thanks to the Copland
team for the idea -- the structures and the idea were in the headers, just
not implemented.... :-)  Anyway, it's something to watch out for.


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
