Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88F46B7D49
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 23:59:34 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add P1021MDS board support
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1274449867.3003.2.camel@r54964-12.am.freescale.net>
Date: Fri, 21 May 2010 08:59:27 -0500
Message-Id: <EABBA439-1BC0-4D86-AEEC-EB174F9060D6@kernel.crashing.org>
References: <20100415183631.GA25923@oksana.dev.rtsoft.ru>
	<5D3C6BEB-8F69-407B-BE6D-C99D23EB90F4@kernel.crashing.org>
	<1274449867.3003.2.camel@r54964-12.am.freescale.net>
To: Haiying Wang <Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> +
> +	if (machine_is(p1021_mds)) {
> +#define MPC85xx_PMUXCR_OFFSET           0x60
> +#define MPC85xx_PMUXCR_QE0              0x00008000
> +#define MPC85xx_PMUXCR_QE3              0x00001000
> +#define MPC85xx_PMUXCR_QE9              0x00000040
> +#define MPC85xx_PMUXCR_QE12             0x00000008
> +		static __be32 __iomem *pmuxcr;
> +
> +		np = of_find_node_by_name(NULL, "global-utilities");
> +
> +		if (np) {
> +			pmuxcr = of_iomap(np, 0) + MPC85xx_PMUXCR_OFFSET;
> +			if (!pmuxcr)
> +				printk(KERN_EMERG "Error: Alternate function"
> +					" signal multiplex control register not"
> +					" mapped!\n");

if we error shouldn't we not do the setbit32?

> +
> +			/* P1021 has pins muxed for QE and other functions. To
> +			 * enable QE UEC mode, we need to set bit QE0 for UCC1
> +			 * in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
> +			 * and QE12 for QE MII management singals in PMUXCR
> +			 * register.
> +			 */
> +			setbits32(pmuxcr,
> +				MPC85xx_PMUXCR_QE0 | MPC85xx_PMUXCR_QE3 |
> +				MPC85xx_PMUXCR_QE9 | MPC85xx_PMUXCR_QE12);
> +		}
> +
> +		of_node_put(np);
> +	}
> #endif	/* CONFIG_QUICC_ENGINE */
> 
> #ifdef CONFIG_SWIOTLB
> @@ -330,6 +375,16 @@ static struct of_device_id mpc85xx_ids[] = {
> 	{},
> };
> 
> +static struct of_device_id p1021_ids[] = {
> +	{ .type = "soc", },
> +	{ .compatible = "soc", },
> +	{ .compatible = "simple-bus", },
> +	{ .type = "qe", },
> +	{ .compatible = "fsl,qe", },
> +	{ .compatible = "gianfar", },
> +	{},
> +};
> +
> static int __init mpc85xx_publish_devices(void)
> {
> 	if (machine_is(mpc8568_mds))
> @@ -342,11 +397,22 @@ static int __init mpc85xx_publish_devices(void)
> 
> 	return 0;
> }
> +
> +static int __init p1021_publish_devices(void)
> +{
> +	/* Publish the QE devices */
> +	of_platform_bus_probe(NULL, p1021_ids, NULL);
> +
> +	return 0;
> +}
> +
> machine_device_initcall(mpc8568_mds, mpc85xx_publish_devices);
> machine_device_initcall(mpc8569_mds, mpc85xx_publish_devices);
> +machine_device_initcall(p1021_mds, p1021_publish_devices);
> 
> machine_arch_initcall(mpc8568_mds, swiotlb_setup_bus_notifier);
> machine_arch_initcall(mpc8569_mds, swiotlb_setup_bus_notifier);
> +machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
> 
> static void __init mpc85xx_mds_pic_init(void)
> {
> @@ -366,7 +432,7 @@ static void __init mpc85xx_mds_pic_init(void)
> 
> 	mpic = mpic_alloc(np, r.start,
> 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN |
> -			MPIC_BROKEN_FRR_NIRQS,
> +			MPIC_BROKEN_FRR_NIRQS | MPIC_SINGLE_DEST_CPU,
> 			0, 256, " OpenPIC  ");
> 	BUG_ON(mpic == NULL);
> 	of_node_put(np);
> @@ -380,7 +446,11 @@ static void __init mpc85xx_mds_pic_init(void)
> 		if (!np)
> 			return;
> 	}
> -	qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
> +	if (machine_is(p1021_mds))
> +		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> +				qe_ic_cascade_high_mpic);
> +	else
> +		qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
> 	of_node_put(np);
> #endif				/* CONFIG_QUICC_ENGINE */
> }
> @@ -426,3 +496,26 @@ define_machine(mpc8569_mds) {
> 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> #endif
> };
> +
> +static int __init p1021_mds_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root();
> +
> +	return of_flat_dt_is_compatible(root, "fsl,P1021MDS");
> +
> +}
> +
> +define_machine(p1021_mds) {
> +	.name		= "P1021 MDS",
> +	.probe		= p1021_mds_probe,
> +	.setup_arch	= mpc85xx_mds_setup_arch,
> +	.init_IRQ	= mpc85xx_mds_pic_init,
> +	.get_irq	= mpic_get_irq,
> +	.restart	= fsl_rstcr_restart,
> +	.calibrate_decr	= generic_calibrate_decr,
> +	.progress	= udbg_progress,
> +#ifdef CONFIG_PCI
> +	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
> +#endif
> +};
> +
> -- 
> 1.6.0.2
> 
> 
