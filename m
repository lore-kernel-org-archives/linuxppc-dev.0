Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id D47B9DDEC8
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2007 06:42:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for MPC8641D]
Date: Wed, 28 Mar 2007 13:40:52 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D750F380@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.532.1174628450.2645.linuxppc-dev@ozlabs.org>
References: <mailman.532.1174628450.2645.linuxppc-dev@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I also noticed that you have a defined all the PCI devices in the tree,
but CONFIG_PCI is actually not set. Is it really required to define the
tree when it is not really used.

* In 8641D running in ASMP mode, does this patch support PCI?

* Does the same uImage built will work for both the Cores, or Core0 is
expected to boot different image with PCI enabled, and Core1 this image?

Thanks
Siva



Date: Thu, 22 Mar 2007 21:55:30 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Subject: Re: [Fwd: [PATCH Resend 01/02] Add Linux ASMP support for
	MPC8641D]
To: Jon Loeliger <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Message-ID: <200703230355.l2N3tUSL082743@sullivan.realtime.net>


On Fri Mar 23 01:25:24 EST 2007, Jon Loeliger wrote:
> +	cpus {
> +		#cpus =3D <1>;
> +		#address-cells =3D <1>;
> +=09

#cpus is not needed, please remove.


> +		mpic: pic at 40000 {
..
> +			compatible =3D "chrp,open-pic";
> +			device_type =3D "open-pic";

Since its shared, we could add another type here to let us know.
[and yes, the interrupts property here needs to become something else,
probably with ranges in its name].

>=20
>  	/* Alloc mpic structure and per isu has 16 INT entries. */
>  	mpic1 =3D mpic_alloc(np, res.start,
> +#ifdef CONFIG_ASMP
> +			MPIC_PRIMARY | MPIC_BIG_ENDIAN,
> +#else
>  			MPIC_PRIMARY | MPIC_WANTS_RESET |
MPIC_BIG_ENDIAN,
> +#endif

How about:
+#ifndef CONFIG_ASMP
+			MPIC_WANTS_RESET |=20
+#endif
 			MPIC_PRIMARY | MPIC_BIG_ENDIAN,

Just a suggestion.

> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index bcfb900..739d8bf 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -707,9 +707,15 @@ static void mpic_set_affinity(unsigned int irq,
cpumask_t cpumask)
>  	cpumask_t tmp;
> =20
>  	cpus_and(tmp, cpumask, cpu_online_map);
> -
> +#ifdef CONFIG_ASMP
> +	unsigned int pir;
> +	pir =3D mfspr(SPRN_PIR);
> +	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
> +			1 << pir);
> +#else
>  	mpic_irq_write(src, MPIC_INFO(IRQ_DESTINATION),
> -		       mpic_physmask(cpus_addr(tmp)[0]));=09
> +		       mpic_physmask(cpus_addr(tmp)[0]));
> +#endif

NAK.
Don't use mfspr in mpic.c. =20
set hard_smp_processor_id() instead, mpic_physmask already uses it.

> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index 1f83988..7ec67d9 100644
> --- a/drivers/net/gianfar.c
> +++ b/drivers/net/gianfar.c
> @@ -692,11 +692,21 @@ int startup_gfar(struct net_device *dev)
> =20
>  	priv->tx_bd_base =3D (struct txbd8 *) vaddr;
> =20
> +#ifdef CONFIG_ASMP
> +	unsigned int pir;
> +	pir =3D mfspr(SPRN_PIR);
> +	/* enet DMA only understands physical addresses */
> +	gfar_write(&regs->tbase0, ((unsigned int)addr + 0x10000000 *
pir));
> +
> +	/* Start the rx descriptor ring where the tx ring leaves off */
> +	addr =3D addr + sizeof (struct txbd8) * priv->tx_ring_size +
0x10000000 * pir;
> +#else

Hard coded memory layout?  In a driver?  Really?

Use the dma_mapping api.

Store your kernel to physical offset in a memory location.
Have the dma_mapping api add this offset.

milton


------------------------------
