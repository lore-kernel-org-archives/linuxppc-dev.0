Date: Tue, 8 Jun 1999 21:08:04 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioremap() on ISA memory space
In-Reply-To: <Pine.LNX.4.10.9906082022070.25878-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPP.3.96.990608205122.27048K-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Jun 1999, Geert Uytterhoeven wrote:

> 
> 
> I found one reason why current kernels don't work on my LongTrail: my NVRAM is
> in ISA memory space. When the kernel tries to ioremap() it in
> pmac_nvram_init(), I get
> 
>     __ioremap(): phys addr e0000 is RAM lr c000e43c
> 
> and ioremap() returns NULL, causing all later accesses to NVRAM (e.g. in atyfb)
> to fail due to NULL pointer dereferences.
> 
> Do all CHRP boxes have NVRAM in ISA memory space? The comment (by Corey) near
> the call to pmac_nvram_init() in chrp_init2() already wonders whether
> pmac_nvram_init() should be called or not.

I don't know, but according to M.Mares (the PCI guy), all addresses passed
to ioremap should be processor physical addresses. So you should modify
the call to ioremap to add the physical offset at which the ISA memory
space (address 0-16 Mb) appears on the PCI bus. 

The hacks done on the i386 port are not valid since on a standard PC
addresses from 640kB to 1Mb-64kB are directly forwarded to PCI/ISA.
On a PC, the addresses on both sides of the host bridge are always the
same. It is simply not possible to stick to this rule when you want to
have all physical memory contiguous and starting at address 0.

The 8088 is still going to bite us for some time with these ambiguous
addresses and DMA problems :-(.  

> Besides, I'd say one must call ioremap() to access ISA memory space anyway, so
> it sounds like a bug in the memory management subsystem to me.

Indeed (note that Linus indicated that ioremap for ISA memory space would 
be compulsory in 2.3 even on i386), but this is not necessarily a mm bug
IMHO. It would be better to define a macro that conditionally adds a
platform dependant offset for addresses < 16 Mb (I've heard that
ISA_MEM_BASE has been killed, and I disagree just because of this kind
of things).

I would rather use ioremap(dev->base_address[n],...) for standard PCI
devices and ioremap(ISA_PHYSICAL_ADDRESS(xxx),...) for devices which might
be on ISA with: 

#define ISA_PHYSICAL_ADDRESS(x) \ 
(((x)<0x1000000) ? ((x)+ISA_PHYSICAL_BASE) : (x))

where ISA_PHYSICAL_BASE is a boot time constant (0xfd000000 on MPC106,
don't know on others). 

	Greetings,
	Gabriel.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
