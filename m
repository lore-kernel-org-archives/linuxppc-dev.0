From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15838.45984.311938.41129@argo.ozlabs.ibm.com>
Date: Sat, 23 Nov 2002 09:45:52 +1100
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: devel list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc_irq_dispatch_handler and unhandled interrupts
In-Reply-To: <1037897936.10521.89.camel@granite.austin.ibm.com>
References: <1037897936.10521.89.camel@granite.austin.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis Blanchard writes:

> Here's the failure mode:
> On a 405LP (using ppc405_pic), an irq is becoming unmasked[1] (in
> UIC0_ER). ppc_irq_dispatch_handler sees irq_desc[0].action == NULL, and
> correctly complains of an unhandled interrupt and masks it off. However
> at the end of the same function (label "out"), the irq is unmasked again
> because irq_desc[0].handler == ppc405_pic (irq_desc[0..NR_IRQS] =
> ppc405_pic; see ppc4xx_init_IRQ() ). So the irq is unmasked, occurs
> again, is masked, is unmasked, occurs again...
>
> The attached patch fixes the problem by checking desc->action as well as
> desc->handler - there is no sense unmasking an interrupt if we already
> know there are no drivers ready to handle it.

This is the wrong fix IMO.  The situation is no different to calling
disable_irq during an interrupt handler, and as the comment says, the
->end() handler has to deal with that.  The problem is that if we
don't have an ->end() handler we unconditionally call the ->enable()
handler, which (correctly) just unconditionally enables the
interrupt.  So the bit of code at the end of ppc_irq_dispatch_handler
should look like this:

	/*
	 * The ->end() handler has to deal with interrupts which got
	 * disabled while the handler was running.
	 */
	if (irq_desc[irq].handler) {
		if (irq_desc[irq].handler->end)
			irq_desc[irq].handler->end(irq);
		else if (irq_desc[irq].handler->enable
			 && !(irq_desc[irq_nr].status
			      & (IRQ_DISABLED|IRQ_INPROGRESS)))
			irq_desc[irq].handler->enable(irq);
	}

> [1] In my particular case, UIC0_ER is being modified by BIOS when waking

BIOS???  What BIOS?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
