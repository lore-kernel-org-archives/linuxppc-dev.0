Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4B0E5DE04E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 23:21:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2NCLAh9032423
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 08:21:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2NCLAUr063032
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:21:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2NCL9og013415
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 06:21:09 -0600
Subject: Re: [PATCH 4/10] Add arch/powerpc driver for UIC, PPC4xx interrupt
	controller
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070322092202.1299EDDF3E@ozlabs.org>
References: <20070322092202.1299EDDF3E@ozlabs.org>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 07:20:47 -0500
Message-Id: <1174652447.3518.22.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-22 at 20:22 +1100, David Gibson wrote:
> 
> Index: working-2.6/arch/powerpc/sysdev/uic.c
> ===================================================================

 <snip>

> +static struct uic * __init uic_init_one(struct device_node *node)
> +{
> +	struct uic *uic;
> +	const u32 *indexp, *dcrreg;
> +	int len;
> +
> +	BUG_ON(! device_is_compatible(node, "ibm,uic"));
> +
> +	uic = alloc_bootmem(sizeof(*uic));
> +	if (! uic)
> +		return NULL; /* FIXME: panic? */
> +
> +	memset(uic, 0, sizeof(*uic));
> +	uic->of_node = of_node_get(node);
> +	indexp = get_property(node, "cell-index", &len);
> +	if (!indexp || (len != sizeof(u32))) {
> +		printk(KERN_ERR "uic: Device node %s has missing or invalid "
> +		       "cell-index property\n", node->full_name);
> +		return NULL;
> +	}
> +	uic->index = *indexp;
> +
> +	dcrreg = get_property(node, "dcr-reg", &len);
> +	if (!dcrreg || (len != 2*sizeof(u32))) {
> +		printk(KERN_ERR "uic: Device node %s has missing or invalid "
> +		       "dcr-reg property\n", node->full_name);
> +		return NULL;
> +	}
> +	uic->dcrbase = *dcrreg;
> +
> +	uic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NR_UIC_INTS,
> +				      &uic_host_ops, -1);
> +	if (! uic->irqhost) {
> +		of_node_put(node);
> +		return NULL; /* FIXME: panic? */
> +	}
> +
> +	uic->irqhost->host_data = uic;
> +
> +	/* Start with all interrupts disable and non-critical */
> +	mtdcr(uic->dcrbase + UIC_ER, 0);
> +	mtdcr(uic->dcrbase + UIC_CR, 0);

I think at this point we should also clear the interrupts in the SR
register as well.  When playing with the Bamboo port, I found that the
firmware leaves pending interrupts, which can lead to some not nice
results when the cascade bits are enabled.

josh
