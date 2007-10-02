Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C02D8DDF1C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 22:18:57 +1000 (EST)
Date: Tue, 2 Oct 2007 16:20:05 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] [POWERPC] Fix QEIC->MPIC cascading
Message-ID: <20071002122005.GA6425@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143429.GB5323@localhost.localdomain>
	<1191280461.6310.37.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1191280461.6310.37.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 02, 2007 at 09:14:21AM +1000, Benjamin Herrenschmidt wrote:
> 
> On Tue, 2007-09-25 at 18:34 +0400, Anton Vorontsov wrote:
> > set_irq_chained_handler overwrites MPIC's handle_irq function
> > (handle_fasteoi_irq) thus MPIC never gets eoi event from the
> > cascaded IRQ. This situation hangs MPIC on MPC8568E.
> > 
> > Patch adds flow level "end" handler to the MPIC, and QEIC calls
> > it when QEIC's interrupt processing finished.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> Not sure if I already NAKed it on the list, so if I didn't here's it :-)
> 
> The proper way of doing that is to have the cascade handler perform the
> EOI call to mpic.

Exactly, this is what that patch is trying to do. QEIC cascade handler is
calling mpic's eoi() (end() actually, as it's flow level, but end == eoi.
Is it main objection? Ok, I can get rid of it, and use chip level eoi()
directly).

> Look at how it's done for i8259 mpic cascade handlers.

void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
{       
        unsigned int cascade_irq = i8259_irq();
        if (cascade_irq != NO_IRQ)
                generic_handle_irq(cascade_irq);
        desc->chip->eoi(irq);
}
...
set_irq_chained_handler(cascade_irq, pseries_8259_cascade);

Quite similar... except that it's written in the board file.

> Basically, when doing a cascade nowadays, you can either just do a
> normal request_irq() of the cascade, in which case your handler don't
> have to care about the parent controller at all, but you get various
> limitations and/or overhead from being a full blown interrupt handler,

Though viable, but not an option.

> or you can use the chained handler mechanism which is a "shortcut" but
> implies that your cascade handler "knows" what needs to be done to the
> parent (and thus is specific to the combination parent/child).

Yup, exactly. Actually, QEIC's cascade handlers do not really know
what needs to be done, but they're good at guessing (if (chip->eoi)).

Sure, I can place board-specific QEIC handlers in the board file, but
that will be quite big code duplication for all machines using QEIC.

> Cheers,
> Ben.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
