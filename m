Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkdbq15zMzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 17:19:35 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id 184so8684753pff.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 00:19:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] powerpc/timer - large decrementer support
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1460435928-5450-1-git-send-email-oohall@gmail.com>
Cc: Jack Miller <jack@codezen.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570CA17E.1060803@gmail.com>
Date: Tue, 12 Apr 2016 17:19:26 +1000
MIME-Version: 1.0
In-Reply-To: <1460435928-5450-1-git-send-email-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/04/16 14:38, Oliver O'Halloran wrote:
> POWER ISA v3 adds large decrementer (LD) mode of operation which increases
> the size of the decrementer register from 32 bits to an implementation
> defined with of up to 64 bits.
> 
> This patch adds support for the LD on processors with the CPU_FTR_ARCH_300
> cpu feature flag set. Even for CPUs with this feature LD mode is only
> enabled when the property ibm,dec-bits devicetree property is supplied
> for the boot CPU. The decrementer value is a signed quantity (with
> negative values indicating a pending exception) and this property is
> required to find the maximum positive decrementer value. If this property
> is not supplied then the traditional decrementer width of 32 bits is
> assumed and LD mode is disabled.
> 
> This patch was based on inital work by Jack Miller.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Cc: Jack Miller <jack@codezen.org>
> ---
>  arch/powerpc/include/asm/reg.h  |  1 +
>  arch/powerpc/include/asm/time.h |  6 +--
>  arch/powerpc/kernel/time.c      | 89 +++++++++++++++++++++++++++++++++++++----
>  3 files changed, 86 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index f5f4c66bbbc9..ff581ed1ab9d 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -332,6 +332,7 @@
>  #define   LPCR_AIL_0	0x00000000	/* MMU off exception offset 0x0 */
>  #define   LPCR_AIL_3	0x01800000	/* MMU on exception offset 0xc00...4xxx */
>  #define   LPCR_ONL	0x00040000	/* online - PURR/SPURR count */
> +#define   LPCR_LD	0x00020000	/* large decremeter */
>  #define   LPCR_PECE	0x0001f000	/* powersave exit cause enable */
>  #define     LPCR_PECEDP	0x00010000	/* directed priv dbells cause exit */
>  #define     LPCR_PECEDH	0x00008000	/* directed hyp dbells cause exit */
> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
> index 1092fdd7e737..09211640a0e0 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -146,7 +146,7 @@ static inline void set_tb(unsigned int upper, unsigned int lower)
>   * in auto-reload mode.  The problem is PIT stops counting when it
>   * hits zero.  If it would wrap, we could use it just like a decrementer.
>   */
> -static inline unsigned int get_dec(void)
> +static inline u64 get_dec(void)
>  {
>  #if defined(CONFIG_40x)
>  	return (mfspr(SPRN_PIT));
> @@ -160,10 +160,10 @@ static inline unsigned int get_dec(void)
>   * in when the decrementer generates its interrupt: on the 1 to 0
>   * transition for Book E/4xx, but on the 0 to -1 transition for others.
>   */
> -static inline void set_dec(int val)
> +static inline void set_dec(u64 val)
>  {
>  #if defined(CONFIG_40x)
> -	mtspr(SPRN_PIT, val);
> +	mtspr(SPRN_PIT, (u32) val);

We seem to be moving from signed (int) to unsigned 64 (u64). Could
you check to see if that breaks anything?



>  #else
>  #ifndef CONFIG_BOOKE
>  	--val;
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 81b0900a39ee..0afaef6b5b6a 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -95,7 +95,8 @@ static struct clocksource clocksource_timebase = {
>  	.read         = timebase_read,
>  };
>  
> -#define DECREMENTER_MAX	0x7fffffff
> +#define DECREMENTER_DEFAULT_MAX 0x7FFFFFFF
> +u64 decrementer_max = DECREMENTER_DEFAULT_MAX;
>  
>  static int decrementer_set_next_event(unsigned long evt,
>  				      struct clock_event_device *dev);
> @@ -503,7 +504,7 @@ static void __timer_interrupt(void)
>  		__this_cpu_inc(irq_stat.timer_irqs_event);
>  	} else {
>  		now = *next_tb - now;
> -		if (now <= DECREMENTER_MAX)
> +		if (now <= decrementer_max)
>  			set_dec((int)now);


>  		/* We may have raced with new irq work */
>  		if (test_irq_work_pending())
> @@ -534,7 +535,7 @@ void timer_interrupt(struct pt_regs * regs)
>  	/* Ensure a positive value is written to the decrementer, or else
>  	 * some CPUs will continue to take decrementer exceptions.
>  	 */
> -	set_dec(DECREMENTER_MAX);
> +	set_dec(decrementer_max);
>  
>  	/* Some implementations of hotplug will get timer interrupts while
>  	 * offline, just ignore these and we also need to set
> @@ -562,6 +563,7 @@ void timer_interrupt(struct pt_regs * regs)
>  	irq_enter();
>  
>  	__timer_interrupt();
> +

blank space -- required?

>  	irq_exit();
>  	set_irq_regs(old_regs);
>  }
> @@ -582,9 +584,9 @@ static void generic_suspend_disable_irqs(void)
>  	 * with suspending.
>  	 */
>  
> -	set_dec(DECREMENTER_MAX);
> +	set_dec(decrementer_max);
>  	local_irq_disable();
> -	set_dec(DECREMENTER_MAX);
> +	set_dec(decrementer_max);
>  }
>  
>  static void generic_suspend_enable_irqs(void)
> @@ -865,7 +867,7 @@ static int decrementer_set_next_event(unsigned long evt,
>  
>  static int decrementer_shutdown(struct clock_event_device *dev)
>  {
> -	decrementer_set_next_event(DECREMENTER_MAX, dev);
> +	decrementer_set_next_event(decrementer_max, dev);
>  	return 0;
>  }
>  
> @@ -891,6 +893,72 @@ static void register_decrementer_clockevent(int cpu)
>  	clockevents_register_device(dec);
>  }
>  
> +static inline bool large_dec_on(void)
> +{
> +	return (mfspr(SPRN_LPCR) & LPCR_LD) == LPCR_LD;

Shouldn't this be !!(mfspr(SPRN_LPCR) & LPCR_LD)

> +}
> +
> +static bool large_decrementer_supported(void)
> +{
> +	return cpu_has_feature(CPU_FTR_ARCH_300);
> +}
> +

Lets be consistent if we use dec, lets call this large_dec_supp()?


> +/* enables the large decrementer for the current CPU */
> +static void enable_large_decrementer(void)
> +{
> +	/* do we have a large decrementer? */
> +	if (!large_decrementer_supported())
> +		return;
> +
> +	/* do we need a large decrementer? */
> +	if (decrementer_max <= DECREMENTER_DEFAULT_MAX)
> +		return;
> +
> +	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_LD);
> +
> +	if (!large_dec_on()) {
> +		decrementer_max = DECREMENTER_DEFAULT_MAX;
> +
> +		pr_debug("Failed to enable large dec on CPU %d, "
> +			"limiting to 32 bits", smp_processor_id());

pr_warn?

> +	}
> +}
> +
> +static void __init set_decrementer_max(void)
> +{
> +	struct device_node *cpu;
> +	const __be32 *fp;
> +	u64 bits = 32;
> +
> +	/* dt node exists? */
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	if(cpu)
> +		fp = of_get_property(cpu, "ibm,dec-bits", NULL);
> +
> +	if(cpu && fp) {
> +		bits = of_read_number(fp, 1);
> +
> +		/* clamp to sane values */
> +		if (bits > 64)
> +			bits = 64;
> +		if (bits < 32)
> +			bits = 32;
> +
> +		/* Firmware says we support large dec but this cpu doesn't we
> +		 * should warn about it. We can still limp along with default
> +		 * 32 bit dec, but something is broken. */
> +		if (!large_decrementer_supported()) {
> +			WARN_ON(bits > 32);
> +			bits = 32;
> +		}
> +
> +		decrementer_max = (1ul << (bits - 1)) - 1;
> +	}
> +
> +	pr_info("time_init: %llu bit decrementer (max: %llx)\n",
> +		bits, decrementer_max);
> +}
> +
>  static void __init init_decrementer_clockevent(void)
>  {
>  	int cpu = smp_processor_id();
> @@ -898,7 +966,7 @@ static void __init init_decrementer_clockevent(void)
>  	clockevents_calc_mult_shift(&decrementer_clockevent, ppc_tb_freq, 4);
>  
>  	decrementer_clockevent.max_delta_ns =
> -		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_clockevent);
> +		clockevent_delta2ns(decrementer_max, &decrementer_clockevent);
>  	decrementer_clockevent.min_delta_ns =
>  		clockevent_delta2ns(2, &decrementer_clockevent);
>  
> @@ -907,6 +975,9 @@ static void __init init_decrementer_clockevent(void)
>  
>  void secondary_cpu_time_init(void)
>  {
> +	/* Enable the large decrementer (if we need to) */
> +	enable_large_decrementer();
> +
>  	/* Start the decrementer on CPUs that have manual control
>  	 * such as BookE
>  	 */
> @@ -972,6 +1043,10 @@ void __init time_init(void)
>  	vdso_data->tb_update_count = 0;
>  	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
>  
> +	/* initialise and enable the large decrementer (if we have one) */
> +	set_decrementer_max();
> +	enable_large_decrementer();
> +
>  	/* Start the decrementer on CPUs that have manual control
>  	 * such as BookE
>  	 */
> 
