Date: Thu, 11 Feb 1999 10:07:26 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: linuxppc-dev@lists.linuxppc.org, cort@cs.nmt.edu
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <XFMail.990210203209.jeremy@goop.org>
Message-ID: <Pine.HPP.3.96.990211100221.5352B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 10 Feb 1999, Jeremy Fitzhardinge wrote:

> 
> Hi Cort/all,
> 
> I'm trying to work out what kernel/prep_pci.c is doing with interrupt routing. 
> I'm looking at the stuff in the standard 2.2 kernel, so perhaps there's a better
> place for me to look.
> 
> Firstly, in route_pci_interrupts it does an inb(0x800) to get something to
> determine the interrupt architecture of the board.  What is this value, and
> where does it come from?

It's a value which give sthe board type on rather old IBM/Motorola boards.

> Rather than having hard-coded tables, can't the interrupt routing be determined
> from either firmware or the interrupt controller itself?  The comment at the
> top of the file is that this will go away soon.  What are you planning to
> replace it?

Indeed, that's what I do from residual data on PreP machines and it seems
to work on several kinds of boards. You'll find it embedded somewhere
in the patch file at:

	ftp://vcorr1.iram.es/pub/linux-2.2/mvm2600.generic-patch-2.2.1

> Background: I'm porting LinuxPPC to a Yellowknife-like board running Open
> Firmware.  It works well except that the drivers can't find their interrupts.

Note that this patch includes a new bootloader for PreP machines, I'd like
to extend it to support OF too but don't have te time right now.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
