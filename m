Date: Wed, 9 Jun 1999 09:38:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Daniel Jacobowitz <drow@false.org>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioremap() on ISA memory space
In-Reply-To: <19990608161648.A7950@drow.res.cmu.edu>
Message-ID: <Pine.LNX.4.10.9906090937100.31065-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Jun 1999, Daniel Jacobowitz wrote:
> On Tue, Jun 08, 1999 at 09:08:04PM +0200, Gabriel Paubert wrote:
> > be compulsory in 2.3 even on i386), but this is not necessarily a mm bug
> > IMHO. It would be better to define a macro that conditionally adds a
> > platform dependant offset for addresses < 16 Mb (I've heard that
> > ISA_MEM_BASE has been killed, and I disagree just because of this kind
> > of things).
> > 
> > I would rather use ioremap(dev->base_address[n],...) for standard PCI
> > devices and ioremap(ISA_PHYSICAL_ADDRESS(xxx),...) for devices which might
> > be on ISA with: 
> > 
> > #define ISA_PHYSICAL_ADDRESS(x) \ 
> > (((x)<0x1000000) ? ((x)+ISA_PHYSICAL_BASE) : (x))
> > 
> > where ISA_PHYSICAL_BASE is a boot time constant (0xfd000000 on MPC106,
> > don't know on others). 
> 
> Incidentally, and somewhat related to this:
> 
> When I was hacking on tulip.c, I wanted to use tulip-daig to get the
> state of the card.  But it uses inl/outl, and on powerpc these have a
> kernel private variable (isa_io_base) in their macro expansion.  Is
> there any way to make the PCI space available to userland on powerpc,
> as iopl() and inb/outb can on x86?

You have to mmap() /dev/mem and store the result in a variable called
isa_io_base first. But the address region you have to map depends on the
machine type :-(

Example: http://www.cs.kuleuven.ac.be/~geert/PowerPC/sio.c

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
