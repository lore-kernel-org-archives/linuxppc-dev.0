Date: Wed, 9 Jun 1999 09:41:54 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Gabriel Paubert <paubert@iram.es>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioremap() on ISA memory space
In-Reply-To: <Pine.HPP.3.96.990608205122.27048K-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.10.9906090939060.31065-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Jun 1999, Gabriel Paubert wrote:
> On Tue, 8 Jun 1999, Geert Uytterhoeven wrote:
> > I found one reason why current kernels don't work on my LongTrail: my NVRAM is
> > in ISA memory space. When the kernel tries to ioremap() it in
> > pmac_nvram_init(), I get
> > 
> >     __ioremap(): phys addr e0000 is RAM lr c000e43c
> > 
> > and ioremap() returns NULL, causing all later accesses to NVRAM (e.g. in atyfb)
> > to fail due to NULL pointer dereferences.
> > 
> > Do all CHRP boxes have NVRAM in ISA memory space? The comment (by Corey) near
> > the call to pmac_nvram_init() in chrp_init2() already wonders whether
> > pmac_nvram_init() should be called or not.
> 
> I don't know, but according to M.Mares (the PCI guy), all addresses passed
> to ioremap should be processor physical addresses. So you should modify
> the call to ioremap to add the physical offset at which the ISA memory
> space (address 0-16 Mb) appears on the PCI bus. 

Oops, you're right (in my case that's an offset of 0xf7000000). Hence we have
to `fix up' the OF device tree first...

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
