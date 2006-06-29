Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32767679E0
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 08:57:39 +1000 (EST)
Subject: Re: new IRQ work status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
In-Reply-To: <200606291525.53254.arnd.bergmann@de.ibm.com>
References: <1151570165.28229.15.camel@localhost.localdomain>
	<200606291525.53254.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 08:57:23 +1000
Message-Id: <1151621843.32016.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >  /* Get an IRQ number from the pending state register of the IIC */
> > -int iic_get_irq(struct pt_regs *regs)
> > +unsigned int iic_get_irq(struct pt_regs *regs)
> 
> Is unsigned the right thing here? NO_IRQ is defined as (-1).

One of the patches changes NO_IRQ to 0 and generally virtual irq numbers
to unsigned int

> I'd prefer to throw out the hardcoded part from the official tree
> completely. It's only needed on the very first FW versions that
> were shipped and those need some other patches that we never merged
> upstream anyway. So better move it to an extra patch that we keep
> external for some time and eventually drop.

Ok, will move it to a separate patch then.

> >  static irqreturn_t iic_ipi_action(int irq, void *dev_id, struct pt_regs
> > *regs) {
> > -	smp_message_recv(iic_irq_to_ipi(irq), regs);
> > +	int ipi = (int)(long)dev_id;
> > +	smp_message_recv(ipi, regs);
> >  	return IRQ_HANDLED;
> >  }
> 
> Nice one. this looks a lot cleaner than looking at the irq number here.

Yeah, I had the calculation wrong at first :) the irq number you get
here is the virtual one. So you 'd need to convert it through the
reverse map. With the above trick, I avoid that.

> Considering that name is know to be rather short and we have a fixed
> number of these, can't we just put the strings into struct iic
> instead of doing the kzalloc?

Good point, I'll look into it.

> >  enum {
> > -	IIC_EXT_OFFSET   = 0x00, /* Start of south bridge IRQs */
> > -	IIC_EXT_CASCADE  = 0x20, /* There is no interrupt 32 on spider */
> > -	IIC_NUM_EXT      = 0x40, /* Number of south bridge IRQs */
> > -	IIC_SPE_OFFSET   = 0x40, /* Start of SPE interrupts */
> > -	IIC_CLASS_STRIDE = 0x10, /* SPE IRQs per class    */
> > -	IIC_IPI_OFFSET   = 0x70, /* Start of IPI IRQs */
> > -	IIC_NUM_IPIS     = 0x10, /* IRQs reserved for IPI */
> > -	IIC_NODE_STRIDE  = 0x80, /* Total IRQs per node   */
> > +	IIC_IRQ_INVALID		= 0xff,
> 
> Where is IIC_IRQ_INVALID used?

Just to give an invalid number to the remapping core. It uses that to
fill up allocated but not-yet mapped slots 

> See above about the hardcoded stuff.

Yup.

> 
> > @@ -664,11 +688,18 @@ static int __init create_spu(struct devi
> >  	if (ret)
> >  		goto out_free;
> >
> > +	/* XXX FIXME: Those node vs. nid things are crap, we need
> > +	 * only one information, but fixing that goes along with fixing
> > +	 * all of the node vs chip vs thread code all over the cell
> > +	 * platform. To do soon hopefully...
> > +	 */
> >  	spu->node = find_spu_node_id(spe);
> >  	spu->nid = of_node_to_nid(spe);
> >  	if (spu->nid == -1)
> >  		spu->nid = 0;
> 
> The idea at some point was to keep the notion of nid (as in address
> on the inter-chip protocol) separate from the NUMA node ID, which
> may in theory be less fine-grained. Defining them to be the same
> at least requires the device tree to be very careful with the numbers
> in ibm,associativity properties to match the bus numbers.

Yeah, I've discussed that with Paul and Anton, I want to do a generic
layer to take care of all these conversions with a 4 level
representation:

 - thread -> match linux CPU numbers
 - core
 - chip
 - node

Anyway, that's the sort of cleanup I'll do later.

> > Index: linux-work-mm/include/asm-powerpc/spu.h
> > ===================================================================
> > --- linux-work-mm.orig/include/asm-powerpc/spu.h	2006-06-23
> > 13:38:19.000000000 +1000 +++
> > linux-work-mm/include/asm-powerpc/spu.h	2006-06-29 16:32:35.000000000 +1000
> > @@ -117,7 +117,7 @@ struct spu {
> >  	struct list_head sched_list;
> >  	int number;
> >  	int nid;
> > -	u32 isrc;
> > +	unsigned int irqs[3];
> >  	u32 node;
> >  	u64 flags;
> >  	u64 dar;
> 
> We've started exporting the isrc property in sysfs recently, so I think
> we need to keep that in here.

Why would we do that ? It makes no sense on HV platforms. Is there
anything that makes use of it ?

Ben.
