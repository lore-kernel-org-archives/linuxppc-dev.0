Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by ozlabs.org (Postfix) with ESMTP id 471F8DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 05:29:13 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so206115nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 12:29:12 -0700 (PDT)
Message-ID: <fa686aa40709121229h6bb2902etffcd197e2e5af722@mail.gmail.com>
Date: Wed, 12 Sep 2007 13:29:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
In-Reply-To: <20070912183038.GA5682@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
	<20070911182811.GA3582@sfrouter>
	<fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
	<20070912183038.GA5682@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/12/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> Hello,
>
> > > I have looked up "kernel/irq/manage.c". "-ENOSYS" is returned on function
> > > "setup_irq" because the used irq(MPC52xx_IRQ2) is the same as no_irq_chip.
> > >
> > > THE MPC52xx_IRQ2 is a excerpt from "include/ppc/mpc52xx.h" (per copy
> > > paste), but mpc52xx is (now) a powerpc-arch. What is the desired value for
> > > IRQ-2 on a mpc5200b?
> >
> > The irq number you pass into request_irq is a system-wide irq number;
> > it doesn't necessarily map directly onto the MPC52xx irq number.
> > Typically, you'd have a node for your device in the device tree which
> > has a phandle back to the interrupt node and you would use
> > irq_of_parse_and_map() to map it back to a system-wide irq number.
>
> The IRQ-pin-2 belongs to "PIN-configuration-nodes" described in
> "booting-without-of.txt"? Than, what is the QE for my MPC5200B?
>
> Can u give me an example with a single IRQ of a configuration-node for a
> dts?

myreallycooldevice@0 {
        interrupts = <1 2 3>;
        interrupt-parent = <&mpc5200_pic>;
};

The interrupts property matches the size of the #interrupt-cells
property in the interrupt controller node.  For the 5200-intc, each
interrupt is described by 3 cells; l1, l2 and sense which is a
reflection of the interrupt controller architecture.  For IRQ0, l1=0,
l2=0; IRQ1, l1=1, l2=1; IRQ2, l1=1 and l2=2; IRQ3, l1=1, l2=3 Sense is
described in mpc52xx-device-tree-bindings.txt

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
