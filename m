From: "Andy Lowe" <andy_lowe@mvista.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH and RFC] Remove request_8xxirq
Date: Thu, 20 Jun 2002 23:54:24 -0500
Message-ID: <DIEAKNAFAEAMABGFAOOKKEILDIAA.andy_lowe@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <3D12ACFA.1070005@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
> Any 8xx that included a PCI configuration had request_irq() defined.
> One of the things Wolfgang did was to map callers of request_irq() to
> interrupts that made sense on a particular hardware design.  That is
> the only change that should have been necessary.  None of the other
> changes, especially to change all of the other irq requests to call
> request_irq() were necessary.

As I pointed out, it isn't necessary to change the existing request_8xxirq
and cpm_install_handler functions to request_irq.  You can continue to use
the old favorites if that is your preference, although frankly I don't
understand the attraction of request_8xxirq and cpm_install_handler.

> The proper solution is to implement a request_irq() function that will
> map interrupts properly for the board design, not modify everything to use
> that function.

You have it backwards.  Every Linux device driver in the known universe
except a few 8xx-specific drivers already use request_irq to install
interrupt handlers.  All the patch does is allow request_irq to work on 8xx
targets the same as on every other architecture supported by Linux.

> You can have a board design that connects the PCI interrupt
> lines to GPIOs or external interrupt lines, and in that case request_irq()
> would have to know what PCI interrupt numbers are used and would map them
> to a CPM interrupt.  Along with that comes other special SIU
> configuration, so it's uniqueness is quite evident.

Not only can you have such a design, but as I pointed out I have already
used this patch on an 8xx design with a qspan bridge that uses a mixture of
both SIU and CPM Port C interrupts for PCI interrupts instead of an 8259.
It fits beautifully into this scheme with absolutely no additional changes
to request_irq.  In the PCI interrupt routing table for the board, the PCI
interrupts that are routed to SIU IRQs have IRQ vectors in the range 0 to
15.  The PCI interrupts that are routed to CPM interrupts have IRQ vectors
in the range 16 to 47.  A PCI device driver will look up its assigned IRQ
vector via the normal method and will use it as the interrupt vector
argument to request_irq.  The interrupt handler installation works
regardless of whether the corresponding vector is mapped to the SIU or to
the CPM interrupt controller, and this detail is completely transparent to
the device driver.  Interrupt handler installation works properly in all
cases with no modifcations required to any existing PCI device driver.

> This patch works for exactly one board design like the MBX, that
> uses an 8259 connected in a particular way for PCI interrupts.

This same technique can work for all 8xx boards with any number of external
interrupt controllers cascaded in any fashion you please.  It works with no
modifcations whatsoever on every 8xx board that has no external interrupt
controllers.

Andy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
