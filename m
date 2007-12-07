Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3E998DDDEF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 14:08:49 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB738kkE021440
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:08:46 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB738kYm130032
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:08:46 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB738k6q019615
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 22:08:46 -0500
Date: Thu, 6 Dec 2007 21:05:50 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 16/25] powerpc: EP405 boards support for arch/powerpc
Message-ID: <20071206210550.520e5131@zod.rchland.ibm.com>
In-Reply-To: <20071206080127.1F2ACDDED0@ozlabs.org>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080127.1F2ACDDED0@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Dec 2007 19:00:15 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Index: linux-work/arch/powerpc/boot/dts/ep405.dts
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/boot/dts/ep405.dts	2007-12-03 12:58:45.000000000 +1100
> @@ -0,0 +1,221 @@
> +/*
> + * Device Tree Source for EP405
> + *
> + * Copyright 2007 IBM Corp.
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>

I still don't think I wrote this ;)

<snip>

> +static struct of_device_id ep405_of_bus[] = {
> +	{ .compatible = "ibm,plb3", },
> +	{ .compatible = "ibm,opb", },
> +	{ .compatible = "ibm,ebc", },
> +	{},
> +};
> +
> +static int __init ep405_device_probe(void)
> +{
> +	if (!machine_is(ep405))
> +		return 0;
> +
> +	/* FIXME: do bus probe here */

I should really remove this stupid FIXME from my files so people stop
copying it into theirs ;)

> +	of_platform_bus_probe(NULL, ep405_of_bus, NULL);
> +
> +	return 0;
> +}
> +device_initcall(ep405_device_probe);
> +
> +static void __init ep405_init_bcsr(void)
> +{
> +	const u8 *irq_routing;
> +	int i;
> +
> +	/* Find the bloody thing & map it */
> +	bcsr_node = of_find_compatible_node(NULL, NULL, "ep405-bcsr");
> +	if (bcsr_node == NULL) {
> +		printk(KERN_ERR "EP405 BCSR not found !\n");
> +		return;
> +	}
> +	bcsr_regs = of_iomap(bcsr_node, 0);
> +	if (bcsr_regs == NULL) {
> +		printk(KERN_ERR "EP405 BCSR failed to map !\n");
> +		return;
> +	}

Is there a reason you have bcsr_node and bcsr_regs as static globals
and leave the mapping present?  I can't see another use of them outside
of this function, which only gets called once.

> +
> +	/* Get the irq-routing property and apply the routing to the CPLD */
> +	irq_routing = of_get_property(bcsr_node, "irq-routing", NULL);
> +	if (irq_routing == NULL)
> +		return;
> +	for (i = 0; i < 16; i++) {
> +		u8 irq = irq_routing[i];
> +		out_8(bcsr_regs + BCSR_XIRQ_SELECT, i);
> +		out_8(bcsr_regs + BCSR_XIRQ_ROUTING, irq);
> +	}
> +	in_8(bcsr_regs + BCSR_XIRQ_SELECT);
> +	mb();
> +	out_8(bcsr_regs + BCSR_GPIO_IRQ_PAR_CTRL, 0xfe);
> +}
> +
> +static void __init ep405_setup_arch(void)
> +{
> +	/* Find & init the BCSR CPLD */
> +	ep405_init_bcsr();
> +}
> +
> +static int __init ep405_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	if (!of_flat_dt_is_compatible(root, "ep405"))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +define_machine(ep405) {
> +	.name			= "EP405",
> +	.probe			= ep405_probe,
> +	.setup_arch		= ep405_setup_arch,
> +	.progress		= udbg_progress,
> +	.init_IRQ		= uic_init_tree,
> +	.get_irq		= uic_get_irq,
> +	.calibrate_decr		= generic_calibrate_decr,
> +};

josh
