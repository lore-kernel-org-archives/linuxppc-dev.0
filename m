Message-Id: <199907280548.HAA00294@piglet.cpu.lu>
Date: Wed, 28 Jul 1999 07:48:18 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying a Promise Ultra/66 on powerpc
To: drow@false.org
cc: mj@ucw.cz, hedrick@Astro.Dyer.Vanderbilt.Edu,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990727230416.A457@them.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Some PCI and some IDE thoughts and questions in here...

On  27 Jul, this message from Daniel Jacobowitz echoed through cyberspace:
> On Tue, Jul 27, 1999 at 04:07:28PM -0500, Andre M. Hedrick wrote:
>> What are we missing in ppc-pci stuff that does not register an interrupt?
>> I can work around this in general by asking the card if the dev->irq is
>> NULL.  However, if this is the case, logic dictates that polling the card
>> will yield the same result.
> 
> OK.  I have this working now.  In getting it to work, I've come across
> a couple of issues.
[snip]
> (C) I needed to add a patch to automatically try setting PCI_COMMAND_IO
> if powerpc.  Without this the card would be marked as not supporting
> native mode, and not be initialized.  On x86 bios32.c takes care of
> bioses which do not set this.  Should something in the PPC PCI
> initialization be doing the same?

It seems that OpenFirmware is not doing its job well in initializing all
PCI devices.For the planb driver, which uses an onboard PCI device
(video input) known to OF (i.e Apple device), I need to set
PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE. Or is
it just a problem with IO space enabling, and memory is already
switched on by OF?

On a related note, how do I find a memory region, not yet used, for
remapping a PCI device's memory space? There is a bug with an onboard
device on some Macs, in that it really decodes less address bits than
it says it does, making it overlap other devices (which then need to be
remapped). Right now, the driver uses the same region as in MacOS,
without checking...

> On a much less related note:
> drow:~# hdparm -p /dev/hdc
> 
> /dev/hdc:
>  attempting to auto-tune PIO mode
>  HDIO_SET_PIO_MODE failed: Function not implemented
> 
> pdc202xx.c has no tuneproc.  Is this deliberate?
> 
> As it is I get this (off a 5400 RPM Maxtor 25.4G DiamondMax)
> /dev/hdc:
>   Timing buffered disk reads:  32 MB in  5.83 seconds = 5.49 MB/sec

This is not brilliant, but acceptable. What mode of operation was that
in? UDMA? Or regular DMA or even PIO?

On a related note, can you provide the patches you needed to apply
(minus the uniform IDE stuff from Andre, which I have)? I'm planning to
get my Ultra66 on Friday ;-)...

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
