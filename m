Date: Wed, 9 Jun 1999 11:06:46 +1000
Message-Id: <199906090106.LAA05407@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: drow@false.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990608161648.A7950@drow.res.cmu.edu> (message from Daniel
	Jacobowitz on Tue, 8 Jun 1999 16:16:49 -0400)
Subject: Re: ioremap() on ISA memory space
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9906082022070.25878-100000@mercator.cs.kuleuven.ac.be> <Pine.HPP.3.96.990608205122.27048K-100000@gra-ux1.iram.es> <19990608161648.A7950@drow.res.cmu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz <drow@false.org> wrote:

> When I was hacking on tulip.c, I wanted to use tulip-daig to get the
> state of the card.  But it uses inl/outl, and on powerpc these have a
> kernel private variable (isa_io_base) in their macro expansion.  Is
> there any way to make the PCI space available to userland on powerpc,
> as iopl() and inb/outb can on x86?

You have to open /dev/mem and do a mmap of the physical pages for the
PCI I/O space.  You would then need to have a variable called
isa_io_base and put the address you get back from mmap into it.
PCI I/O space is usually at 0xf2000000 on older powermacs.  If you
want to get fancy, you can wander through /proc/device-tree looking
for the primary PCI bridge and use that to work out where the I/O
space is.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
