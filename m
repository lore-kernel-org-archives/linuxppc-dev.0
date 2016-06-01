Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKJmb3HyRzDqYh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 15:28:31 +1000 (AEST)
Message-ID: <1464758911.30958.113.camel@neuling.org>
Subject: Re: [PATCH 1/2] powerpc/timer - large decrementer support
From: Michael Neuling <mikey@neuling.org>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Balbir Singh <bsingharora@gmail.com>, Jack Miller <jack@codezen.org>
Date: Wed, 01 Jun 2016 15:28:31 +1000
In-Reply-To: <1464679016-10347-1-git-send-email-oohall@gmail.com>
References: <1464675936.30958.22.camel@neuling.org>
 <1464679016-10347-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-31 at 17:16 +1000, Oliver O'Halloran wrote:
> POWER ISA v3 adds large decrementer (LD) mode of operation which
> increases
> the size of the decrementer register from 32 bits to an implementation
> defined with of up to 64 bits.
>=20
> This patch adds support for the LD on processors with the
> CPU_FTR_ARCH_300
> cpu feature flag set. For CPUs with this feature LD mode is enabled when
> when the ibm,dec-bits devicetree property is supplied for the boot CPU.
> The
> decrementer value is a signed quantity (with negative values indicating a
> pending exception) and this property is required to find the maximum
> positive decrementer value. If this property is not supplied then the
> traditional decrementer width of 32 bits is assumed and LD mode is
> disabled.
>=20
> This patch was based on initial work by Jack Miller.
>=20
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Cc: Michael Neuling <mikey@neuling.org>

Acked-by: Michael Neuling <mikey@neuling.org>

> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Jack Miller <jack@codezen.org>
> ---
> =C2=A0arch/powerpc/include/asm/reg.h=C2=A0=C2=A0|=C2=A0=C2=A01 +
> =C2=A0arch/powerpc/include/asm/time.h |=C2=A0=C2=A06 +--
> =C2=A0arch/powerpc/kernel/time.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 94
> +++++++++++++++++++++++++++++++++++++----
> =C2=A03 files changed, 90 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/reg.h
> b/arch/powerpc/include/asm/reg.h
> index c1e82e968506..2793f3f03f9b 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -332,6 +332,7 @@
> =C2=A0#define=C2=A0=C2=A0=C2=A0LPCR_AIL_0	0x00000000	/* MMU off exception
> offset 0x0 */
> =C2=A0#define=C2=A0=C2=A0=C2=A0LPCR_AIL_3	0x01800000	/* MMU on exception =
offset
> 0xc00...4xxx */
> =C2=A0#define=C2=A0=C2=A0=C2=A0LPCR_ONL	0x00040000	/* online - PURR/SPURR=
 count
> */
> +#define=C2=A0=C2=A0=C2=A0LPCR_LD	0x00020000	/* large decremeter */
> =C2=A0#define=C2=A0=C2=A0=C2=A0LPCR_PECE	0x0001f000	/* powersave exit cau=
se
> enable */
> =C2=A0#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LPCR_PECEDP	0x00010000	/* dire=
cted priv dbells
> cause exit */
> =C2=A0#define=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0LPCR_PECEDH	0x00008000	/* dire=
cted hyp dbells
> cause exit */
> diff --git a/arch/powerpc/include/asm/time.h
> b/arch/powerpc/include/asm/time.h
> index 1092fdd7e737..09211640a0e0 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -146,7 +146,7 @@ static inline void set_tb(unsigned int upper,
> unsigned int lower)
> =C2=A0 * in auto-reload mode.=C2=A0=C2=A0The problem is PIT stops countin=
g when it
> =C2=A0 * hits zero.=C2=A0=C2=A0If it would wrap, we could use it just lik=
e a
> decrementer.
> =C2=A0 */
> -static inline unsigned int get_dec(void)
> +static inline u64 get_dec(void)
> =C2=A0{
> =C2=A0#if defined(CONFIG_40x)
> =C2=A0	return (mfspr(SPRN_PIT));
> @@ -160,10 +160,10 @@ static inline unsigned int get_dec(void)
> =C2=A0 * in when the decrementer generates its interrupt: on the 1 to 0
> =C2=A0 * transition for Book E/4xx, but on the 0 to -1 transition for oth=
ers.
> =C2=A0 */
> -static inline void set_dec(int val)
> +static inline void set_dec(u64 val)
> =C2=A0{
> =C2=A0#if defined(CONFIG_40x)
> -	mtspr(SPRN_PIT, val);
> +	mtspr(SPRN_PIT, (u32) val);
> =C2=A0#else
> =C2=A0#ifndef CONFIG_BOOKE
> =C2=A0	--val;
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 3ed9a5a21d77..fe66f1c8d8b2 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -96,7 +96,8 @@ static struct clocksource clocksource_timebase =3D {
> =C2=A0	.read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D tim=
ebase_read,
> =C2=A0};
> =C2=A0
> -#define DECREMENTER_MAX	0x7fffffff
> +#define DECREMENTER_DEFAULT_MAX 0x7FFFFFFF
> +u64 decrementer_max =3D DECREMENTER_DEFAULT_MAX;
> =C2=A0
> =C2=A0static int decrementer_set_next_event(unsigned long evt,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct clock_event_device *=
dev);
> @@ -504,8 +505,8 @@ static void __timer_interrupt(void)
> =C2=A0		__this_cpu_inc(irq_stat.timer_irqs_event);
> =C2=A0	} else {
> =C2=A0		now =3D *next_tb - now;
> -		if (now <=3D DECREMENTER_MAX)
> -			set_dec((int)now);
> +		if (now <=3D decrementer_max)
> +			set_dec(now);
> =C2=A0		/* We may have raced with new irq work */
> =C2=A0		if (test_irq_work_pending())
> =C2=A0			set_dec(1);
> @@ -535,7 +536,7 @@ void timer_interrupt(struct pt_regs * regs)
> =C2=A0	/* Ensure a positive value is written to the decrementer, or
> else
> =C2=A0	=C2=A0* some CPUs will continue to take decrementer exceptions.
> =C2=A0	=C2=A0*/
> -	set_dec(DECREMENTER_MAX);
> +	set_dec(decrementer_max);
> =C2=A0
> =C2=A0	/* Some implementations of hotplug will get timer interrupts
> while
> =C2=A0	=C2=A0* offline, just ignore these and we also need to set
> @@ -583,9 +584,9 @@ static void generic_suspend_disable_irqs(void)
> =C2=A0	=C2=A0* with suspending.
> =C2=A0	=C2=A0*/
> =C2=A0
> -	set_dec(DECREMENTER_MAX);
> +	set_dec(decrementer_max);
> =C2=A0	local_irq_disable();
> -	set_dec(DECREMENTER_MAX);
> +	set_dec(decrementer_max);
> =C2=A0}
> =C2=A0
> =C2=A0static void generic_suspend_enable_irqs(void)
> @@ -866,7 +867,7 @@ static int decrementer_set_next_event(unsigned long
> evt,
> =C2=A0
> =C2=A0static int decrementer_shutdown(struct clock_event_device *dev)
> =C2=A0{
> -	decrementer_set_next_event(DECREMENTER_MAX, dev);
> +	decrementer_set_next_event(decrementer_max, dev);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -892,6 +893,76 @@ static void register_decrementer_clockevent(int cpu)
> =C2=A0	clockevents_register_device(dec);
> =C2=A0}
> =C2=A0
> +static inline bool cpu_has_large_dec(void)
> +{
> +	return cpu_has_feature(CPU_FTR_ARCH_300);
> +}
> +
> +static inline bool large_dec_enabled(void)
> +{
> +	return (mfspr(SPRN_LPCR) & LPCR_LD) =3D=3D LPCR_LD;
> +}
> +
> +/* enables the large decrementer for the current CPU */
> +static void enable_large_decrementer(void)
> +{
> +	/* do we have a large decrementer? */
> +	if (!cpu_has_large_dec())
> +		return;
> +
> +	/* do we need a large decrementer? */
> +	if (decrementer_max <=3D DECREMENTER_DEFAULT_MAX)
> +		return;
> +
> +	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_LD);
> +
> +	if (!large_dec_enabled()) {
> +		decrementer_max =3D DECREMENTER_DEFAULT_MAX;
> +
> +		pr_warn_once("time_init: Failed to enable large
> decrementer on CPU %d\n",
> +			smp_processor_id());
> +	}
> +}
> +
> +static void __init set_decrementer_max(void)
> +{
> +	struct device_node *cpu;
> +	const __be32 *fp;
> +	u64 bits =3D 32;
> +
> +	cpu =3D of_find_node_by_type(NULL, "cpu");
> +	if (cpu)
> +		fp =3D of_get_property(cpu, "ibm,dec-bits", NULL);
> +
> +	if (cpu && fp) {
> +		u64 dt_bits =3D of_read_number(fp, 1);
> +
> +		bits =3D dt_bits;
> +		if (bits > 64)
> +			bits =3D 64;
> +		else if (bits < 32)
> +			bits =3D 32;
> +
> +		WARN(bits !=3D dt_bits, "firmware supplied invalid
> ibm,dec-bits");
> +
> +		/*
> +		=C2=A0* Firmware says we support large dec but this cpu
> doesn't we
> +		=C2=A0* should warn about it. We can still limp along with
> default
> +		=C2=A0* 32 bit dec, but something is broken.
> +		=C2=A0*/
> +		if (!cpu_has_large_dec()) {
> +			WARN_ON(bits > 32);
> +			bits =3D 32;
> +		}
> +
> +		/* calculate the signed maximum given this many bits */
> +		decrementer_max =3D (1ul << (bits - 1)) - 1;
> +	}
> +
> +	pr_info("time_init: %llu bit decrementer (max: %llx)\n",
> +		bits, decrementer_max);
> +}
> +
> =C2=A0static void __init init_decrementer_clockevent(void)
> =C2=A0{
> =C2=A0	int cpu =3D smp_processor_id();
> @@ -899,7 +970,7 @@ static void __init init_decrementer_clockevent(void)
> =C2=A0	clockevents_calc_mult_shift(&decrementer_clockevent,
> ppc_tb_freq, 4);
> =C2=A0
> =C2=A0	decrementer_clockevent.max_delta_ns =3D
> -		clockevent_delta2ns(DECREMENTER_MAX,
> &decrementer_clockevent);
> +		clockevent_delta2ns(decrementer_max,
> &decrementer_clockevent);
> =C2=A0	decrementer_clockevent.min_delta_ns =3D
> =C2=A0		clockevent_delta2ns(2, &decrementer_clockevent);
> =C2=A0
> @@ -908,6 +979,9 @@ static void __init init_decrementer_clockevent(void)
> =C2=A0
> =C2=A0void secondary_cpu_time_init(void)
> =C2=A0{
> +	/* Enable the large decrementer (if we need to) */
> +	enable_large_decrementer();
> +
> =C2=A0	/* Start the decrementer on CPUs that have manual control
> =C2=A0	=C2=A0* such as BookE
> =C2=A0	=C2=A0*/
> @@ -973,6 +1047,10 @@ void __init time_init(void)
> =C2=A0	vdso_data->tb_update_count =3D 0;
> =C2=A0	vdso_data->tb_ticks_per_sec =3D tb_ticks_per_sec;
> =C2=A0
> +	/* initialise and enable the large decrementer (if we have one)
> */
> +	set_decrementer_max();
> +	enable_large_decrementer();
> +
> =C2=A0	/* Start the decrementer on CPUs that have manual control
> =C2=A0	=C2=A0* such as BookE
> =C2=A0	=C2=A0*/
