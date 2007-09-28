Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 1518ADDE1F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:26:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3884936wag
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 13:26:14 -0700 (PDT)
Message-ID: <fa686aa40709281326g2fac0bd5n1667a14ed08335dd@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:26:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 03/18] Virtex: add xilinx interrupt controller driver
In-Reply-To: <20070928201719.GA23749@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181606.18608.30412.stgit@trillian.cg.shawcable.net>
	<20070928201719.GA23749@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 28, 2007 at 12:16:07PM -0600, Grant Likely wrote:
>
> > +/*
> > + * INTC Registers
> > + */
> > +#define ISR  0       /* Interrupt Status */
> > +#define IPR  4       /* Interrupt Pending */
> > +#define IER  8       /* Interrupt Enable */
> > +#define IAR  12      /* Interrupt Acknowledge */
> > +#define SIE  16      /* Set Interrupt Enable bits */
> > +#define CIE  20      /* Clear Interrupt Enable bits */
> > +#define IVR  24      /* Interrupt Vector */
> > +#define MER  28      /* Master Enable */
>
> The defines are fairly generic, I guess you haven't ran across cases
> where there's naming conflicts, but you might want to prefix them with
> something more unique just in case.

Will do

>
> > +static void xilinx_intc_ack(unsigned int virq)
> > +{
> > +     int irq = irq_map[virq].hwirq;
> > +     void * regs = get_irq_chip_data(virq);
> > +     pr_debug("ack: %d\n", irq);
> > +     out_be32(regs + IAR, 1 << irq);
> > +}
>
> I guess some of the above are open-coded instead of using virq_to_hw()
> for performance reasons, it could be useful to have comments regarding
> this so they aren't changed by some janitor down the road. Or, in case
> they're not performance-critical, change them to use virq_to_hw.

Or it was just that my example code from another driver wasn't using
virq_to_hw() either.  I'll fix this.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
