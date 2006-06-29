Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EDE267A6C
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:25:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5TDPtTu010220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 09:25:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5TDPtHC240052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 09:25:55 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5TDPtWR009203
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 09:25:55 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: new IRQ work status
Date: Thu, 29 Jun 2006 15:25:52 +0200
References: <1151570165.28229.15.camel@localhost.localdomain>
In-Reply-To: <1151570165.28229.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606291525.53254.arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 29 June 2006 10:36, Benjamin Herrenschmidt wrote:
> http://gate.crashing.org/~benh/irq-WIP/
> 
> Comments welcome.
> 

Looks great!

> -}
> -
>  /* Get an IRQ number from the pending state register of the IIC */
> -int iic_get_irq(struct pt_regs *regs)
> +unsigned int iic_get_irq(struct pt_regs *regs)

Is unsigned the right thing here? NO_IRQ is defined as (-1).

> +
> +/*
> + * Hardcoded setup part to be compatible with older firmware. We don't
> + * associate a device-node to the hosts in this case, which mean that
> + * no mapping from the device-tree is supposed. That's ok as there is
> + * none anyway
> + */
>  static int __init setup_iic_hardcoded(void)
>  {

I'd prefer to throw out the hardcoded part from the official tree
completely. It's only needed on the very first FW versions that
were shipped and those need some other patches that we never merged
upstream anyway. So better move it to an extra patch that we keep
external for some time and eventually drop.

>  static irqreturn_t iic_ipi_action(int irq, void *dev_id, struct pt_regs
> *regs) {
> -	smp_message_recv(iic_irq_to_ipi(irq), regs);
> +	int ipi = (int)(long)dev_id;
> +	smp_message_recv(ipi, regs);
>  	return IRQ_HANDLED;
>  }

Nice one. this looks a lot cleaner than looking at the irq number here.

>  static void iic_request_ipi(int ipi, const char *name)
>  {
> -	int irq;
> -
> -	irq = iic_ipi_to_irq(ipi);
> +	int node, virq;
>
> -	/* IPIs are marked SA_INTERRUPT as they must run with irqs
> -	 * disabled */
> -	set_irq_chip_and_handler(irq, &iic_chip, handle_percpu_irq);
> -	request_irq(irq, iic_ipi_action, SA_INTERRUPT, name, NULL);
> +	for (node = 0; node < IIC_NODE_COUNT; node++) {
> +		char *rname;
> +		if (iic_hosts[node] == NULL)
> +			continue;
> +		virq = irq_create_mapping(iic_hosts[node],
> +					  iic_ipi_to_irq(ipi), 0);
> +
> +		if (virq == NO_IRQ) {
> +			printk(KERN_ERR
> +			       "iic: failed to map IPI %s on node %d\n",
> +			       name, node);
> +			continue;
> +		}
> +		rname = kzalloc(strlen(name) + 16, GFP_KERNEL);
> +		if (rname)
> +			sprintf(rname, "%s node %d", name, node);
> +		else
> +			rname = (char *)name;

Considering that name is know to be rather short and we have a fixed
number of these, can't we just put the strings into struct iic
instead of doing the kzalloc?

>  enum {
> -	IIC_EXT_OFFSET   = 0x00, /* Start of south bridge IRQs */
> -	IIC_EXT_CASCADE  = 0x20, /* There is no interrupt 32 on spider */
> -	IIC_NUM_EXT      = 0x40, /* Number of south bridge IRQs */
> -	IIC_SPE_OFFSET   = 0x40, /* Start of SPE interrupts */
> -	IIC_CLASS_STRIDE = 0x10, /* SPE IRQs per class    */
> -	IIC_IPI_OFFSET   = 0x70, /* Start of IPI IRQs */
> -	IIC_NUM_IPIS     = 0x10, /* IRQs reserved for IPI */
> -	IIC_NODE_STRIDE  = 0x80, /* Total IRQs per node   */
> +	IIC_IRQ_INVALID		= 0xff,

Where is IIC_IRQ_INVALID used?


> +			}
> +		} else if (device_is_compatible(dn, "sti,platform-spider-pic")
> +			   && (chip < 2)) {
> +			static long hard_coded_pics[] =
> +				{ 0x24000008000, 0x34000008000 };
> +			r.start = hard_coded_pics[chip];
>  		} else

See above about the hardcoded stuff.


> @@ -664,11 +688,18 @@ static int __init create_spu(struct devi
>  	if (ret)
>  		goto out_free;
>
> +	/* XXX FIXME: Those node vs. nid things are crap, we need
> +	 * only one information, but fixing that goes along with fixing
> +	 * all of the node vs chip vs thread code all over the cell
> +	 * platform. To do soon hopefully...
> +	 */
>  	spu->node = find_spu_node_id(spe);
>  	spu->nid = of_node_to_nid(spe);
>  	if (spu->nid == -1)
>  		spu->nid = 0;

The idea at some point was to keep the notion of nid (as in address
on the inter-chip protocol) separate from the NUMA node ID, which
may in theory be less fine-grained. Defining them to be the same
at least requires the device tree to be very careful with the numbers
in ibm,associativity properties to match the bus numbers.


> Index: linux-work-mm/include/asm-powerpc/spu.h
> ===================================================================
> --- linux-work-mm.orig/include/asm-powerpc/spu.h	2006-06-23
> 13:38:19.000000000 +1000 +++
> linux-work-mm/include/asm-powerpc/spu.h	2006-06-29 16:32:35.000000000 +1000
> @@ -117,7 +117,7 @@ struct spu {
>  	struct list_head sched_list;
>  	int number;
>  	int nid;
> -	u32 isrc;
> +	unsigned int irqs[3];
>  	u32 node;
>  	u64 flags;
>  	u64 dar;

We've started exporting the isrc property in sysfs recently, so I think
we need to keep that in here.

	Arnd <><
