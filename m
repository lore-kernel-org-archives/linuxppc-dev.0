Date: Tue, 8 Jun 1999 16:16:49 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioremap() on ISA memory space
Message-ID: <19990608161648.A7950@drow.res.cmu.edu>
References: <Pine.LNX.4.10.9906082022070.25878-100000@mercator.cs.kuleuven.ac.be> <Pine.HPP.3.96.990608205122.27048K-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPP.3.96.990608205122.27048K-100000@gra-ux1.iram.es>; from Gabriel Paubert on Tue, Jun 08, 1999 at 09:08:04PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 08, 1999 at 09:08:04PM +0200, Gabriel Paubert wrote:
> be compulsory in 2.3 even on i386), but this is not necessarily a mm bug
> IMHO. It would be better to define a macro that conditionally adds a
> platform dependant offset for addresses < 16 Mb (I've heard that
> ISA_MEM_BASE has been killed, and I disagree just because of this kind
> of things).
> 
> I would rather use ioremap(dev->base_address[n],...) for standard PCI
> devices and ioremap(ISA_PHYSICAL_ADDRESS(xxx),...) for devices which might
> be on ISA with: 
> 
> #define ISA_PHYSICAL_ADDRESS(x) \ 
> (((x)<0x1000000) ? ((x)+ISA_PHYSICAL_BASE) : (x))
> 
> where ISA_PHYSICAL_BASE is a boot time constant (0xfd000000 on MPC106,
> don't know on others). 


Incidentally, and somewhat related to this:

When I was hacking on tulip.c, I wanted to use tulip-daig to get the
state of the card.  But it uses inl/outl, and on powerpc these have a
kernel private variable (isa_io_base) in their macro expansion.  Is
there any way to make the PCI space available to userland on powerpc,
as iopl() and inb/outb can on x86?


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
