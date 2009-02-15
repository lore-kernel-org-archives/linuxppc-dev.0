Return-Path: <gknispel@proformatique.com>
Date: Mon, 16 Feb 2009 00:32:11 +0100
From: Guillaume Knispel <gknispel@proformatique.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: OpenPIC / CPM2 PIC and cascading interrupt priorities
Message-ID: <20090216003211.51222ecd@xilun.lan.proformatique.com>
In-Reply-To: <1234731860.26036.95.camel@pasglop>
References: <20090215055040.41672e36@xilun.lan.proformatique.com>
	<1234731860.26036.95.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 16 Feb 2009 08:04:20 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
> > {
> > 	int cascade_irq;
> > 
> > 	while ((cascade_irq = cpm2_get_irq()) >= 0)
> > 		generic_handle_irq(cascade_irq);
> > 
> > 	desc->chip->eoi(irq);
> > }
> 
> You can try doing an early EOI see that helps. Ie, stick it inside the loop,
> after cpm_2_get_irq() and before generic_handle_irq() and see if that helps,
> but make sure you do that EOI only once, ie, only on the first iteration.
> 
> Depending on how the CPM2 works, you may also be able to just get rid
> of the loop... ie, if CPM2 output is level sensitive.
> 
> Ben.

Well the CPM2 -> OpenPIC signal is level sensitive and cpm2_get_irq()
just read SIVEC (register containing the CPM2 interrupt code) with no
side effect so doing an EOI just after cpm2_get_irq() will
unconditionally schedule a new (spurious) interrupt (which is latched
in the OpenPIC) which will reach the core as soon as it
local_irq_enable(), which is just before the ISR is called.

So I think to respect priorities of cascaded interrupts without
generating spurious interrupts, EOI of the master must be called from
within the flow handler of the slave after the slave has been acked,
that's why I wrote "that would need some changes in the architecture
independent code".

And now, after having explicitly written all of the above and thought
about the various possible modes of the master and of the slave and
their combinations (in the general case for Linux, not just for OpenPIC
and CPM2), I'm starting to think that it would be quite complicated and
error prone, so i guess i'll happily use a tasklet :)

Thanks!
Guillaume Knispel
