Date: Mon, 16 Aug 1999 09:32:51 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Michel Lanners <mlan@cpu.lu>
cc: mj@ucw.cz, paulus@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org
Subject: Re: Various PMac PCI patches
In-Reply-To: <199908150940.LAA00252@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9908160924290.19649-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 15 Aug 1999, Michel Lanners wrote:
> >> - The IRQ fixup code already checks for the presence of interrupts, so
> >> I'v changed Martin's comment. Also, I'm not sure if PMac PCI boards can
> >> ever use more than one interrupt, as all PCI interrupt lines are OR'ed
> >> together on the bridge....
> > 
> >    If they really are, just kill the whole comment, it's bogus.
> 
> OK, I'll do that. Paul, any idea whether the IRQ OR'ing is done on the
> MPC106 as well? Geert, what about your board?

On the LongTrail, interrupts are controlled by the OpenPIC in the Hydra Mac
I/O. This OpenPic has 20 inputs, of which 6 are used by PCI (asm-ppc/hydra.h):

#define HYDRA_INT_EXT1          12      /* PCI IRQW */
#define HYDRA_INT_EXT2          13      /* PCI IRQX */
#define HYDRA_INT_EXT3          14      /* PCI IRQY */
#define HYDRA_INT_EXT4          15      /* PCI IRQZ */
#define HYDRA_INT_EXT5          16      /* IDE Primay/Secondary */
#define HYDRA_INT_EXT6          17      /* IDE Secondary */

FYI, input 0 is used for the legacy ISA cascade.

IRQ[W-Z] are wired to INT #A-D in the 4 PCI slots using the standard interrupt
line rotating technique. Full schematics at
ftp://ftp.austin.ibm.com/pub/PPC_support/reference_designs/longtrail/ :-)

The IDE interrupts are wired to the interrupt lines on the W83C553 PCI/ISA+IDE.

> >    No driver should touch PCI_INTERRUPT_LINE at all. If it does,
> > it's buggy and should be fixed instead of working around it in generic
> > PCI code. The only correct way how to get the interrupt number is to
> > look at pci_dev->irq (on some architectures, the interrupt numbers
> > are too large to fit in the interrupt line configuration register).
>
> OK, then I'll only update pci_dev->irq. We'll see if any driver
> breaks ;-)

On the LongTrail (and other PPC boxes with OpenPIC), pci_dev->irq is changed by
the PCI fixup code since interrupts 1-16 are mapped to the legacy ISA
interrupts for compatibility reasons, while 17-36 are the 20 OpenPIC
interrupts.

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
