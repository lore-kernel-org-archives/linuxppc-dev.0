Return-Path: <gknispel@proformatique.com>
Date: Sun, 15 Feb 2009 05:50:40 +0100
From: Guillaume Knispel <gknispel@proformatique.com>
To: Linuxppc-dev@ozlabs.org
Subject: OpenPIC / CPM2 PIC and cascading interrupt priorities
Message-ID: <20090215055040.41672e36@xilun.lan.proformatique.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm programming a board with an MPC8555E on which an external chip can
raise low priority interrupts through the port C of the CPM2. Under
nominal conditions it generates few interrupts, but they take a
relatively long time to be processed.

I also use some CPM2 controllers in such a way that their interrupts
need to be served with a short latency. At first I thought that this
would not be a problem if IRQF_DISABLED is not set for the port C ISR,
because the CPM2 controller interrupt has a higher priority.

But the thing is: the primary interrupt controller of the MPC8555E is
an OpenPIC and the CPM2 PIC is cascaded behind.

=46rom the behavior I observe and if I understand both Linux code and the
MPC8555E manual correctly, if the CPM2 PIC is idle and then a port C
interrupt arrives on it, it will put its code in SIVEC and send a
signal to the OpenPIC, which will assert the interrupt signal of the
core, then some assembly language magic happens and eventually do_IRQ()
is called with external interrupts masked, which calls *handle_irq
which in this case is cpm2_cascade() which is consistently written in
every platform where it exists as :

static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
{
	int cascade_irq;

	while ((cascade_irq =3D cpm2_get_irq()) >=3D 0)
		generic_handle_irq(cascade_irq);

	desc->chip->eoi(irq);
}

cascade_irq will be retrieved thanks to SIVEC and this time the flow
handler will be handle_edge_irq (set in cpm2_set_irq_type() ) which
will ack it (to the CPM2 PIC) and call the ISR (IRQF_DISABLED not set).

Now if the CPM2 controller interrupt occurs while the port C ISR is
running (at a higher CPM2 PIC priority), the CPM2 PIC will tell the
OpenPIC. But the OpenPIC won't interrupt the core again because for the
OpenPIC this is just yet another CPM2 interrupt, the same that the one
being handled, which has not yet been cleared by the ->eio() call at the
end of cpm2_cascade.

So, IRQF_DISABLED or not IRQF_DISABLED, the port C ISR won't be
interrupted by the controller ISR.

Now the big question: does anybody think it could be interesting to
reorganize the Linux irq layers such as the priorities of cascaded
interrupts are respected (that would need some changes in the
architecture independent code), or is this a stupid idea and I should
just use a tasklet?

Cheers,
Guillaume KNISPEL
