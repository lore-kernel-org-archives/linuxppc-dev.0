Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4DF4DDFDB
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 14:55:39 +1100 (EST)
Date: Thu, 22 Mar 2007 21:55:30 -0600 (CST)
Message-Id: <200703230355.l2N3tUSL082743@sullivan.realtime.net>
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1174573524.6595.509.camel@ld0161-tx32>
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri Mar 23 01:25:24 EST 2007, Jon Loeliger wrote:
> +	cpus {
> +		#cpus = <1>;
> +		#address-cells = <1>;
> +	

#cpus is not needed, please remove.


> +		mpic: pic at 40000 {
..
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";

Since its shared, we could add another type here to let us know.
[and yes, the interrupts property here needs to become something else,
probably with ranges in its name].

> 
>  	/* Alloc mpic structure and per isu has 16 INT entries. */
>  	mpic1 = mpic_alloc(np, res.start,
> +#ifdef CONFIG_ASMP
> +			MPIC_PRIMARY | MPIC_BIG_ENDIAN,
> +#else
>  			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
> +#endif

How about:
+#ifndef CONFIG_ASMP
+			MPIC_WANTS_RESET | 
+#endif
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN,

Just a suggestion.

> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index bcfb900..739d8bf 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -707,9 +707,15 @@ static void mpic_set_affinity(unsigned int irq, cpumask_t cpumask)
>  	cpumask_t tmp;
>  
>  	cpus_and(tmp, cpumask, cpu_online_map);
> -
> +#ifdef CONFIG_ASMP
> +	unsigned int pir;
> +	pir = mfspr(SPRN_PIR);
> +	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
> +			1 << pir);
> +#else
>  	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
> -		       mpic_physmask(cpus_addr(tmp)[0]));	
> +		       mpic_physmask(cpus_addr(tmp)[0]));
> +#endif

NAK.
Don't use mfspr in mpic.c.  
set hard_smp_processor_id() instead, mpic_physmask already uses it.

> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index 1f83988..7ec67d9 100644
> --- a/drivers/net/gianfar.c
> +++ b/drivers/net/gianfar.c
> @@ -692,11 +692,21 @@ int startup_gfar(struct net_device *dev)
>  
>  	priv->tx_bd_base = (struct txbd8 *) vaddr;
>  
> +#ifdef CONFIG_ASMP
> +	unsigned int pir;
> +	pir = mfspr(SPRN_PIR);
> +	/* enet DMA only understands physical addresses */
> +	gfar_write(&regs->tbase0, ((unsigned int)addr + 0x10000000 * pir));
> +
> +	/* Start the rx descriptor ring where the tx ring leaves off */
> +	addr = addr + sizeof (struct txbd8) * priv->tx_ring_size + 0x10000000 * pir;
> +#else

Hard coded memory layout?  In a driver?  Really?

Use the dma_mapping api.

Store your kernel to physical offset in a memory location.
Have the dma_mapping api add this offset.

milton
