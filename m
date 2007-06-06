Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch 08/18] PS3: Kexec support
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4666233F.1080103@am.sony.com>
References: <20070606024407.786638029@am.sony.com> >
	<4666233F.1080103@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pnOjYxhsVSQPZe0CL6Z/"
Date: Wed, 06 Jun 2007 14:01:50 +1000
Message-Id: <1181102510.5536.15.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-pnOjYxhsVSQPZe0CL6Z/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-06-05 at 20:00 -0700, Geoff Levand wrote:
> Fixup the core platform parts needed for kexec to work on the PS3.
>  - Setup ps3_hpte_clear correctly.
>  - Mask interrupts on irq removal.
>  - Release all hypervisor resources.

The irq changes might be kexec related, but it's a mess to review. You
seem to moving a bunch of code around in the patch as well.


> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
>  arch/powerpc/platforms/ps3/htab.c      |   14 +-
>  arch/powerpc/platforms/ps3/interrupt.c |  199 ++++++++++++++++++++------=
-------
>  arch/powerpc/platforms/ps3/setup.c     |   29 ++--
>  3 files changed, 147 insertions(+), 95 deletions(-)
>=20
> --- a/arch/powerpc/platforms/ps3/htab.c
> +++ b/arch/powerpc/platforms/ps3/htab.c
> @@ -234,10 +234,18 @@ static void ps3_hpte_invalidate(unsigned
> =20
>  static void ps3_hpte_clear(void)
>  {
> -	/* Make sure to clean up the frame buffer device first */
> -	ps3fb_cleanup();
> +	int result;
> =20
> -	lv1_unmap_htab(htab_addr);
> +	DBG(" -> %s:%d\n", __func__, __LINE__);
> +
> +	result =3D lv1_unmap_htab(htab_addr);
> +	BUG_ON(result);
> +
> +	ps3_mm_shutdown();
> +
> +	ps3_mm_vas_destroy();
> +
> +	DBG(" <- %s:%d\n", __func__, __LINE__);
>  }

Do you really want to be calling DBG() here? Hmm, it looks like it
doesn't actually do anything?

> =20
>  void __init ps3_hpte_init(unsigned long htab_size)
> --- a/arch/powerpc/platforms/ps3/interrupt.c
> +++ b/arch/powerpc/platforms/ps3/interrupt.c
> @@ -91,6 +91,92 @@ struct ps3_private {
>  static DEFINE_PER_CPU(struct ps3_private, ps3_private);
> =20
>  /**
> + * ps3_chip_mask - Set an interrupt mask bit in ps3_bmp.
> + * @virq: The assigned Linux virq.
> + *
> + * Sets ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
> + */
> +
> +static void ps3_chip_mask(unsigned int virq)
> +{
> +	struct ps3_private *pd =3D get_irq_chip_data(virq);
> +	u64 bit =3D 0x8000000000000000UL >> virq;
> +	u64 *p =3D &pd->bmp.mask;
> +	u64 old;
> +	unsigned long flags;
> +
> +	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq)=
;
> +
> +	local_irq_save(flags);
> +	asm volatile(
> +		     "1:	ldarx %0,0,%3\n"
> +		     "andc	%0,%0,%2\n"
> +		     "stdcx.	%0,0,%3\n"
> +		     "bne-	1b"
> +		     : "=3D&r" (old), "+m" (*p)
> +		     : "r" (bit), "r" (p)
> +		     : "cc" );
> +
> +	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> +	local_irq_restore(flags);

How is this different from set_bit() ?  (asm-powerpc/bitops.h)

ps. now that I see you're just moving this code around someone's
probably already asked that question.

> +/**
> + * ps3_chip_unmask - Clear an interrupt mask bit in ps3_bmp.
> + * @virq: The assigned Linux virq.
> + *
> + * Clears ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
> + */
> +
> +static void ps3_chip_unmask(unsigned int virq)
> +{
> +	struct ps3_private *pd =3D get_irq_chip_data(virq);
> +	u64 bit =3D 0x8000000000000000UL >> virq;
> +	u64 *p =3D &pd->bmp.mask;
> +	u64 old;
> +	unsigned long flags;
> +
> +	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq)=
;
> +
> +	local_irq_save(flags);
> +	asm volatile(
> +		     "1:	ldarx %0,0,%3\n"
> +		     "or	%0,%0,%2\n"
> +		     "stdcx.	%0,0,%3\n"
> +		     "bne-	1b"
> +		     : "=3D&r" (old), "+m" (*p)
> +		     : "r" (bit), "r" (p)
> +		     : "cc" );
> +
> +	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> +	local_irq_restore(flags);
> +}
> +
> +/**
> + * ps3_chip_eoi - HV end-of-interrupt.
> + * @virq: The assigned Linux virq.
> + *
> + * Calls lv1_end_of_interrupt_ext().
> + */
> +
> +static void ps3_chip_eoi(unsigned int virq)
> +{
> +	const struct ps3_private *pd =3D get_irq_chip_data(virq);
> +	lv1_end_of_interrupt_ext(pd->node, pd->cpu, virq);
> +}
> +
> +/**
> + * ps3_irq_chip - Represents the ps3_bmp as a Linux struct irq_chip.
> + */
> +
> +static struct irq_chip ps3_irq_chip =3D {
> +	.typename =3D "ps3",
> +	.mask =3D ps3_chip_mask,
> +	.unmask =3D ps3_chip_unmask,
> +	.eoi =3D ps3_chip_eoi,
> +};
> +
> +/**
>   * ps3_virq_setup - virq related setup.
>   * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
>   * serviced on.
> @@ -134,6 +220,8 @@ int ps3_virq_setup(enum ps3_cpu_binding=20
>  		goto fail_set;
>  	}
> =20
> +	ps3_chip_mask(*virq);
> +
>  	return result;
> =20
>  fail_set:
> @@ -225,6 +313,8 @@ int ps3_irq_plug_destroy(unsigned int vi
>  	pr_debug("%s:%d: node %lu, cpu %d, virq %u\n", __func__, __LINE__,
>  		pd->node, pd->cpu, virq);
> =20
> +	ps3_chip_mask(virq);
> +
>  	result =3D lv1_disconnect_irq_plug_ext(pd->node, pd->cpu, virq);
> =20
>  	if (result)
> @@ -282,7 +372,9 @@ int ps3_event_receive_port_destroy(unsig
>  {
>  	int result;
> =20
> -	pr_debug(" -> %s:%d virq: %u\n", __func__, __LINE__, virq);
> +	pr_debug(" -> %s:%d virq %u\n", __func__, __LINE__, virq);
> +
> +	ps3_chip_mask(virq);
> =20
>  	result =3D lv1_destruct_event_receive_port(virq_to_hw(virq));
> =20
> @@ -290,17 +382,13 @@ int ps3_event_receive_port_destroy(unsig
>  		pr_debug("%s:%d: lv1_destruct_event_receive_port failed: %s\n",
>  			__func__, __LINE__, ps3_result(result));
> =20
> -	/* lv1_destruct_event_receive_port() destroys the IRQ plug,
> -	 * so don't call ps3_irq_plug_destroy() here.
> +	/* Can't call ps3_virq_destroy() here since ps3_smp_cleanup_cpu()
> +	 * calls from interrupt context (smp_call_function).
>  	 */
> =20
> -	result =3D ps3_virq_destroy(virq);
> -	BUG_ON(result);
> -
>  	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>  	return result;
>  }
> -EXPORT_SYMBOL_GPL(ps3_event_receive_port_destroy);
> =20
>  int ps3_send_event_locally(unsigned int virq)
>  {
> @@ -372,6 +460,13 @@ int ps3_sb_event_receive_port_destroy(co
>  	result =3D ps3_event_receive_port_destroy(virq);
>  	BUG_ON(result);
> =20
> +	/* ps3_event_receive_port_destroy() destroys the IRQ plug,
> +	 * so don't call ps3_irq_plug_destroy() here.
> +	 */
> +
> +	result =3D ps3_virq_destroy(virq);
> +	BUG_ON(result);
> +
>  	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>  	return result;
>  }
> @@ -412,16 +507,23 @@ EXPORT_SYMBOL_GPL(ps3_io_irq_setup);
>  int ps3_io_irq_destroy(unsigned int virq)
>  {
>  	int result;
> +	unsigned long outlet =3D virq_to_hw(virq);
> =20
> -	result =3D lv1_destruct_io_irq_outlet(virq_to_hw(virq));
> +	ps3_chip_mask(virq);
> =20
> -	if (result)
> -		pr_debug("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
> -			__func__, __LINE__, ps3_result(result));
> +	/* lv1_destruct_io_irq_outlet() will destroy the IRQ plug,
> +	 * so call ps3_irq_plug_destroy() first.
> +	 */
> =20
>  	result =3D ps3_irq_plug_destroy(virq);
>  	BUG_ON(result);
> =20
> +	result =3D lv1_destruct_io_irq_outlet(outlet);
> +
> +	if (result)
> +		pr_debug("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
> +			__func__, __LINE__, ps3_result(result));
> +
>  	return result;
>  }
>  EXPORT_SYMBOL_GPL(ps3_io_irq_destroy);
> @@ -466,6 +568,7 @@ int ps3_vuart_irq_destroy(unsigned int v
>  {
>  	int result;
> =20
> +	ps3_chip_mask(virq);
>  	result =3D lv1_deconfigure_virtual_uart_irq();
> =20
>  	if (result) {
> @@ -514,9 +617,14 @@ int ps3_spe_irq_setup(enum ps3_cpu_bindi
> =20
>  int ps3_spe_irq_destroy(unsigned int virq)
>  {
> -	int result =3D ps3_irq_plug_destroy(virq);
> +	int result;
> +
> +	ps3_chip_mask(virq);
> +
> +	result =3D ps3_irq_plug_destroy(virq);
>  	BUG_ON(result);
> -	return 0;
> +
> +	return result;
>  }
> =20
>=20
> @@ -565,67 +673,6 @@ static void __maybe_unused _dump_mask(st
>  static void dump_bmp(struct ps3_private* pd) {};
>  #endif /* defined(DEBUG) */
> =20
> -static void ps3_chip_mask(unsigned int virq)
> -{
> -	struct ps3_private *pd =3D get_irq_chip_data(virq);
> -	u64 bit =3D 0x8000000000000000UL >> virq;
> -	u64 *p =3D &pd->bmp.mask;
> -	u64 old;
> -	unsigned long flags;
> -
> -	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq)=
;
> -
> -	local_irq_save(flags);
> -	asm volatile(
> -		     "1:	ldarx %0,0,%3\n"
> -		     "andc	%0,%0,%2\n"
> -		     "stdcx.	%0,0,%3\n"
> -		     "bne-	1b"
> -		     : "=3D&r" (old), "+m" (*p)
> -		     : "r" (bit), "r" (p)
> -		     : "cc" );
> -
> -	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> -	local_irq_restore(flags);
> -}
> -
> -static void ps3_chip_unmask(unsigned int virq)
> -{
> -	struct ps3_private *pd =3D get_irq_chip_data(virq);
> -	u64 bit =3D 0x8000000000000000UL >> virq;
> -	u64 *p =3D &pd->bmp.mask;
> -	u64 old;
> -	unsigned long flags;
> -
> -	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq)=
;
> -
> -	local_irq_save(flags);
> -	asm volatile(
> -		     "1:	ldarx %0,0,%3\n"
> -		     "or	%0,%0,%2\n"
> -		     "stdcx.	%0,0,%3\n"
> -		     "bne-	1b"
> -		     : "=3D&r" (old), "+m" (*p)
> -		     : "r" (bit), "r" (p)
> -		     : "cc" );
> -
> -	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> -	local_irq_restore(flags);
> -}
> -
> -static void ps3_chip_eoi(unsigned int virq)
> -{
> -	const struct ps3_private *pd =3D get_irq_chip_data(virq);
> -	lv1_end_of_interrupt_ext(pd->node, pd->cpu, virq);
> -}
> -
> -static struct irq_chip irq_chip =3D {
> -	.typename =3D "ps3",
> -	.mask =3D ps3_chip_mask,
> -	.unmask =3D ps3_chip_unmask,
> -	.eoi =3D ps3_chip_eoi,
> -};
> -
>  static void ps3_host_unmap(struct irq_host *h, unsigned int virq)
>  {
>  	set_irq_chip_data(virq, NULL);
> @@ -637,7 +684,7 @@ static int ps3_host_map(struct irq_host=20
>  	pr_debug("%s:%d: hwirq %lu, virq %u\n", __func__, __LINE__, hwirq,
>  		virq);
> =20
> -	set_irq_chip_and_handler(virq, &irq_chip, handle_fasteoi_irq);
> +	set_irq_chip_and_handler(virq, &ps3_irq_chip, handle_fasteoi_irq);
> =20
>  	return 0;
>  }
> @@ -657,7 +704,7 @@ void __init ps3_register_ipi_debug_brk(u
>  		cpu, virq, pd->bmp.ipi_debug_brk_mask);
>  }
> =20
> -unsigned int ps3_get_irq(void)
> +static unsigned int ps3_get_irq(void)
>  {
>  	struct ps3_private *pd =3D &__get_cpu_var(ps3_private);
>  	u64 x =3D (pd->bmp.status & pd->bmp.mask);
> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -209,31 +209,28 @@ static int __init ps3_probe(void)
>  #if defined(CONFIG_KEXEC)
>  static void ps3_kexec_cpu_down(int crash_shutdown, int secondary)
>  {
> -	DBG(" -> %s:%d\n", __func__, __LINE__);
> +	int result;
> +	u64 ppe_id;
> +	u64 thread_id =3D secondary ? 1 : 0;
> +
> +	DBG(" -> %s:%d: (%d)\n", __func__, __LINE__, secondary);
> +	ps3_smp_cleanup_cpu(thread_id);
> +
> +	lv1_get_logical_ppe_id(&ppe_id);
> +	result =3D lv1_configure_irq_state_bitmap(ppe_id, secondary ? 0 : 1, 0)=
;
> =20
> -	if (secondary) {
> -		int cpu;
> -		for_each_online_cpu(cpu)
> -			if (cpu)
> -				ps3_smp_cleanup_cpu(cpu);
> -	} else
> -		ps3_smp_cleanup_cpu(0);
> +	/* seems to fail on second call */
> +	DBG("%s:%d: lv1_configure_irq_state_bitmap (%d) %s\n", __func__,
> +		__LINE__, secondary, ps3_result(result));
> =20
>  	DBG(" <- %s:%d\n", __func__, __LINE__);
>  }
> =20
>  static void ps3_machine_kexec(struct kimage *image)
>  {
> -	unsigned long ppe_id;
> -
>  	DBG(" -> %s:%d\n", __func__, __LINE__);
> =20
> -	lv1_get_logical_ppe_id(&ppe_id);
> -	lv1_configure_irq_state_bitmap(ppe_id, 0, 0);
> -	ps3_mm_shutdown();
> -	ps3_mm_vas_destroy();
> -
> -	default_machine_kexec(image);
> +	default_machine_kexec(image); // needs ipi, never returns.

Just get rid of ps3_machine_kexec() and hook default_machine_kexec()
directly into your ppc_md.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-pnOjYxhsVSQPZe0CL6Z/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGZjGudSjSd0sB4dIRAt3DAJ43mibqpugnjM9GgpxVcz9aY0zcNACeLbr1
bvrLQy8UBLnYwNbbyaGEXGw=
=oSUu
-----END PGP SIGNATURE-----

--=-pnOjYxhsVSQPZe0CL6Z/--
