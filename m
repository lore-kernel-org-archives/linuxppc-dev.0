Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.242])
	by ozlabs.org (Postfix) with ESMTP id B8A68DDF22
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 05:05:49 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 9so860952agd
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 12:05:48 -0700 (PDT)
Message-ID: <fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
Date: Tue, 11 Sep 2007 13:05:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
In-Reply-To: <20070911182811.GA3582@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
	<20070911182811.GA3582@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/11/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> Hello,
>
> > >[...]
> > >     intr = mpc52xx_find_and_map("mpc52xx-pic");
> > >     if(!intr) {
> > >         panic(__FILE__ ": mpc52xx-pic - MAP failed");
> > >     }
> > >
> > >     set_irq_chip(MPC52xx_IRQ2, &my_irq_chip);
> >
> > You probably don't want to do this (unless you are cascading IRQs to
> > custom external hardware).  All you should need is the call to
> > request_irq() to register your irq handler, and code in your ISR
> > handler to clear the interrupt condition.
> >
> > You do *NOT* want to program the interrupt controller directly.  The
> > mpc5200 interrupt controller already has a driver.  Don't go twiddling
> > the registers manually.
>
> OK!
>
> I have tried it before and i get a "-ENOSYS" returned.
>
> My code was/is now:
> --==>
> request_irq(MPC52xx_IRQ2, intmod_isr, IRQF_DISABLED , "intmod",
>             INTMOD_IRQ_BOARD);
> <==--
>
> I have looked up "kernel/irq/manage.c". "-ENOSYS" is returned on function
> "setup_irq" because the used irq(MPC52xx_IRQ2) is the same as no_irq_chip.
>
> THE MPC52xx_IRQ2 is a excerpt from "include/ppc/mpc52xx.h" (per copy
> paste), but mpc52xx is (now) a powerpc-arch. What is the desired value for
> IRQ-2 on a mpc5200b?

The irq number you pass into request_irq is a system-wide irq number;
it doesn't necessarily map directly onto the MPC52xx irq number.
Typically, you'd have a node for your device in the device tree which
has a phandle back to the interrupt node and you would use
irq_of_parse_and_map() to map it back to a system-wide irq number.

Otherwise, you need to call of_irq_map_raw with the pointer to the
52xx interrupt controller node and the interrupt number in the form
expected by the device tree.  (But adding a device tree node for your
device is far easier).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
