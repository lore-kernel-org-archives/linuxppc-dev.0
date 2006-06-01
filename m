Return-Path: <Alexandre.Bounine@tundra.com>
Received: from atanerk.tundra.com (sentry.tundra.com [142.46.200.189])
	by ozlabs.org (Postfix) with ESMTP id 24C6867A6C
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 06:55:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
Date: Thu, 1 Jun 2006 16:45:23 -0400
Message-ID: <8A1F97E8A7ACE847B1DB69DFDCBC6E807D633A@caribou.pc.tundra.com>
From: "Alexandre Bounine" <Alexandre.Bounine@tundra.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Zang Roy-r61911" <tie-fei.zang@freescale.com>
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All differences in the Tsi108/109 PIC code from the standard MPIC are =
caused by the HW behavior. The Tsi108/109 PIC looks like standard =
OpenPIC but, in fact, is different in registers mapping and behavior. =
Its logic is close but not exactly as MPIC. =20

Here are replies on comments to the code:

1.Why do you have to check if its a LEVEL irq?

Check for LEVEL irqs is required in the ack/end pair to enable nested =
interrupt servicing and
does not hang when core (local) interrupts are re-enabled in the ISR. =
Otherwise we have to use=20
SA_INTERRUPT flag for all level signaled interrupts.

2. if the PIC works like other openpic's you dont need an 'ack' we =20
handle it via 'end'

Tsi108/109 needs it.

3. why the changes to where we do mpic_eoi for TSI108?
The Tsi108 PIC requires EOI for spurious interrupt (as all other =
interrupt sources).
The do_IRQ() does not call end routine for spurious interrupts. =20

The MPIC code patch for Tsi108/109 demonstrates HW differences and why =
we originally considered having separate code for Tsi108 pic.

Regards,

Alex.
=20


-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: Tuesday, May 30, 2006 3:18 PM
To: Zang Roy-r61911
Cc: Benjamin Herrenschmidt; linuxppc-dev list; Yang Xin-Xin-r48390; Paul
Mackerras; Alexandre Bounine
Subject: Re: [PATCH/2.6.17-rc4 4/10]Powerpc: Add tsi108 pic support



On May 29, 2006, at 10:28 PM, Zang Roy-r61911 wrote:

>>
>> On Wed, 2006-05-17 at 18:14 +0800, Zang Roy-r61911 wrote:
>>> Add Tundra Semiconductor tsi108 host bridge interrupt
>> controller support.
>>
>> It looks a bit like an hacked up MPIC... Is it different
>> enough to justify a separate driver ? Or would it be possible
>> to define a TSI108 flag to pass the current mpic driver and
>> add the necessary bits to it ?
>>
>
> Tsi108 implementation of MPIC has many differences form the =20
> original one,  the following
> code implements it with mpic. Any comment? The following patch is =20
> just based on
> my previous send out patches.

In the future please provide it against the base, much easier to read.

> Integrate Tundra Semiconductor tsi108 host bridge interrupt controller
> to mpic arch.
>
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
>

[snip]

>
> --- linux-2.6.17-rc4-tun/arch/powerpc/sysdev/mpic.c	2006-03-20 =20
> 00:53:29.000000000 -0500
> +++ linux-2.6.17-rc4-hpc2/arch/powerpc/sysdev/mpic.c	2006-05-29 =20
> 16:07:03.000000000 -0400
> @@ -81,7 +81,7 @@ static inline void _mpic_write(unsigned
>  static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
>  {
>  	unsigned int be =3D (mpic->flags & MPIC_BIG_ENDIAN) !=3D 0;
> -	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
> +	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * =20
> MPIC_GREG_IPI_STRIDE);
>
>  	if (mpic->flags & MPIC_BROKEN_IPI)
>  		be =3D !be;
> @@ -90,7 +90,7 @@ static inline u32 _mpic_ipi_read(struct
>
>  static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int =20
> ipi, u32 value)
>  {
> -	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
> +	unsigned int offset =3D MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * =20
> MPIC_GREG_IPI_STRIDE);
>
>  	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset, =20
> value);
>  }
> @@ -393,7 +393,11 @@ static inline struct mpic * mpic_from_ir
>  static inline void mpic_eoi(struct mpic *mpic)
>  {
>  	mpic_cpu_write(MPIC_CPU_EOI, 0);
> +#ifndef CONFIG_TSI108_BRIDGE
>  	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
> +#else
> +	(void)mpic_cpu_read(MPIC_CPU_OUTPUT);
> +#endif
>  }
>
>  #ifdef CONFIG_SMP
> @@ -514,9 +518,26 @@ static void mpic_end_irq(unsigned int ir
>  	}
>  #endif /* CONFIG_MPIC_BROKEN_U3 */
>
> +#ifdef CONFIG_TSI108_BRIDGE
> +	if ((irq_desc[irq].status & IRQ_LEVEL) !=3D 0)
> +#endif

Why do you have to check if its a LEVEL irq?

>  	mpic_eoi(mpic);
>  }
>
> +#ifdef CONFIG_TSI108_BRIDGE
> +static void mpic_ack_irq(unsigned int irq)
> +{
> +	struct mpic *mpic =3D mpic_from_irq(irq);
> +
> +#ifdef DEBUG_IRQ
> +	DBG("%s: ack_irq: %d\n", mpic->name, irq);
> +#endif
> +
> +	if ((irq_desc[irq].status & IRQ_LEVEL) =3D=3D 0)
> +		mpic_eoi(mpic);
> +}
> +#endif /* CONFIG_TSI108_BRIDGE */
> +

if the PIC works like other openpic's you dont need an 'ack' we =20
handle it via 'end'

>  #ifdef CONFIG_SMP
>
>  static void mpic_enable_ipi(unsigned int irq)
> @@ -596,6 +617,9 @@ struct mpic * __init mpic_alloc(unsigned
>  	mpic->hc_irq.enable =3D mpic_enable_irq;
>  	mpic->hc_irq.disable =3D mpic_disable_irq;
>  	mpic->hc_irq.end =3D mpic_end_irq;
> +#ifdef CONFIG_TSI108_BRIDGE
> +	mpic->hc_irq.ack =3D mpic_ack_irq;
> +#endif
>  	if (flags & MPIC_PRIMARY)
>  		mpic->hc_irq.set_affinity =3D mpic_set_affinity;
>  #ifdef CONFIG_SMP
> @@ -955,8 +979,13 @@ void mpic_send_ipi(unsigned int ipi_no,
>  	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
>  #endif
>
> +#ifndef CONFIG_TSI108_BRIDGE
>  	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
>  		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
> +#else /* CONFIG_TSI108_BRIDGE */
> +	mpic_write(mpic->gregs, MPIC_CPU_IPI_DISPATCH,
> +		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
> +#endif /* !CONFIG_TSI108_BRIDGE */
>  }
>
>  int mpic_get_one_irq(struct mpic *mpic, struct pt_regs *regs)
> @@ -972,11 +1001,20 @@ int mpic_get_one_irq(struct mpic *mpic,
>  		DBG("%s: cascading ...\n", mpic->name);
>  #endif
>  		irq =3D mpic->cascade(regs, mpic->cascade_data);
> +#ifdef DEBUG_LOW
> +		DBG("%s: cascaded irq: %d\n", mpic->name, irq);
> +#endif
> +#ifndef CONFIG_TSI108_BRIDGE
>  		mpic_eoi(mpic);
> +#endif
>  		return irq;
>  	}
> -	if (unlikely(irq =3D=3D MPIC_VEC_SPURRIOUS))
> +	if (unlikely(irq =3D=3D MPIC_VEC_SPURRIOUS)) {
> +#ifdef CONFIG_TSI108_BRIDGE
> +		mpic_eoi(mpic);
> +#endif
>  		return -1;
> +	}

why the changes to where we do mpic_eoi for TSI108?

>  	if (irq < MPIC_VEC_IPI_0) {
>  #ifdef DEBUG_IRQ
>  		DBG("%s: irq %d\n", mpic->name, irq + mpic->irq_offset);



[snip]
