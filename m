Date: Mon, 12 Jun 2000 19:57:17 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Ken Maier <kpm@pt.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: interrupt handler and gnu
In-Reply-To: <200006121714.NAA11767@notes1.pt.com>
Message-ID: <Pine.HPX.4.10.10006121928560.6279-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 12 Jun 2000, Ken Maier wrote:

>
> How do I get the gnu compiler to save processor state for a interrupt handler?

Simple, you don't. The compiler does not even know that some registers
exist (XER, SRR0, SRR1, SR0-SR15), also don't forget that entering the
interrupt may involve switching stack and you decide how to do it, not the
processor. Basically you have to save:

SRR0, SRR1, CR, LR, CTR, XER, R0-R12 (R1 is the stack so it depends),
perhaps R13 (system convention dependant). Don't forget that the interrupt
handler starts with the MMU disabled which is definitely not what you want
to access I/O.

Ok, that's for a minimalistsic system. In a linux device driver, you
kindly ask the kernel to call a function you specify when a given
interrupt occurs. The kernel handles all the gory details for you,
reenables the MMU, fetches the interrupt vector and dispatches to the
registered routines (see request_irq and free_irq).

> I have tried #pragma interrupt but it didn't work.  I'm compiling for the 8260
> pqII.  I have started writing the code myself.  Do I need to save the fp regs?
> Any help will be welcomed.

You normally don't need to save the FP regs, using FP in the kernel is
strictly prohibited (and the MSR will have the FP bit reset to prevent you
from accidentally using FP).

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
