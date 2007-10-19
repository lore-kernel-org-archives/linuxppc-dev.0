Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 898CDDDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 09:25:01 +1000 (EST)
Date: Fri, 19 Oct 2007 18:31:34 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: mpic: minor optimization of ipi handler
Message-ID: <20071019233134.GA17851@lixom.net>
References: <20071019185110.GA11911@lixom.net>
	<1192835859.17235.12.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192835859.17235.12.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 20, 2007 at 09:17:39AM +1000, Benjamin Herrenschmidt wrote:
> 
> On Fri, 2007-10-19 at 13:51 -0500, Olof Johansson wrote:
> > Jeff Garzik pointed out that we don't actually have to lookup the mpic
> > instance since it's passed in as the interrupt handler data for IPIs.
> 
> Note that's typically one of the annoying case where we use "irq"
> for a good reasons, getting the way of Jeff attempt at removing
> this argument.
> 
> I suppose a working approach would be to have 4 mpic IPI handlers...

We still need the _irq_, but we don't need to lookup the mpic based on it.

We knew the mpic pointer at irq setup time, and passed it in as the
argument to pass to the handler. Doing a second lookup is just extra
overhead, it should return the same controller:


void mpic_request_ipis(void)
{
        struct mpic *mpic = mpic_primary;
        int i, err;
        static char *ipi_names[] = {
                "IPI0 (call function)",
                "IPI1 (reschedule)",
                "IPI2 (unused)",
                "IPI3 (debugger break)",
        };
        BUG_ON(mpic == NULL);

        printk(KERN_INFO "mpic: requesting IPIs ... \n");

        for (i = 0; i < 4; i++) {
                unsigned int vipi = irq_create_mapping(mpic->irqhost,
                                                       mpic->ipi_vecs[0] + i);
                if (vipi == NO_IRQ) {
                        printk(KERN_ERR "Failed to map IPI %d\n", i);
                        break;
                }
                err = request_irq(vipi, mpic_ipi_action,
                                  IRQF_DISABLED|IRQF_PERCPU,
                                  ipi_names[i], mpic);
                if (err) {
                        printk(KERN_ERR "Request of irq %d for IPI %d failed\n",
                               vipi, i);
                        break;
                }
        }
}


-Olof
