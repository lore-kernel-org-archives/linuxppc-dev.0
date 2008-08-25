Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 9B2CBDE1E2
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 21:43:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: [PATCH 2/4] Add cpufreq driver for the IBM PowerPC 750GX
Date: Mon, 25 Aug 2008 13:43:17 +0200
References: <48B28F23.1000906@hypersurf.com>
In-Reply-To: <48B28F23.1000906@hypersurf.com>
MIME-Version: 1.0
Message-Id: <200808251343.18027.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 25 August 2008, Kevin Diggs wrote:
> + * cf750gx.c - cpufreq driver for the dual PLLs in the 750gx

Thanks for posting this driver and for your attention for detail
and for documentation in particular. Few people bother to write
documentation at this level.

I don't understand enough of cpufreq or your hardware to comment
on that, but please let me give you a few hints on coding style.

> + * =A0Copyright (C) 2008 =A0 =A0 =A0 kevin Diggs

Most people list their email address here as well

> +#define cf750gxmChangingPll=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(0x800000=
00)
> +#define cf750gxmChangingPllBit=A0=A0=A0=A0=A0=A0=A0=A0=A0(31)
> +#define cf750gxmTurningIdlePllOff=A0=A0=A0=A0=A0=A0(0x40000000)
> +#define cf750gxmTurningIdlePllOffBit=A0=A0=A0(30)

constants should be ALL_CAPS, not sIllYCaPS.

> +struct pll_750fgx_t {
> +=A0=A0=A0=A0=A0=A0=A0unsigned short min_ratio;=A0=A0=A0=A0=A0=A0=A0/* mi=
n bus ratio */
> +=A0=A0=A0=A0=A0=A0=A0unsigned short max_ratio;=A0=A0=A0=A0=A0=A0=A0/* ma=
x bus ratio */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int min_core;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0/* min core frequency per spec (KHz) */
> +=A0=A0=A0=A0=A0=A0=A0unsigned int max_core;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0/* max core frequency per spec (KHz) */
> +};

please drop the _t at the end of the identifier.

> +MODULE_AUTHOR("Kevin Diggs");
> +MODULE_DESCRIPTION("750GX Dual PLL cpufreq driver");
> +MODULE_LICENSE("GPL");

Move this to the end.

> +struct cf750gx_t_call_data {
> +=A0=A0=A0=A0=A0=A0=A0struct cpufreq_freqs freqs;
> +=A0=A0=A0=A0=A0=A0=A0unsigned long current_pll;
> +=A0=A0=A0=A0=A0=A0=A0int idle_pll_off;
> +};

drop the _t here, or make explicit what is meant by it.

> +static const struct pll_750fgx_t __initdata pll_750fx =3D {
> +=A0=A0=A0=A0=A0=A0=A0.min_ratio =3D 2,
> +=A0=A0=A0=A0=A0=A0=A0.max_ratio =3D 20,
> +=A0=A0=A0=A0=A0=A0=A0.min_core =3D 400000,
> +=A0=A0=A0=A0=A0=A0=A0.max_core =3D 800000,
> +};
> +
> +static const struct pll_750fgx_t __initdata pll_750gx =3D {
> +=A0=A0=A0=A0=A0=A0=A0.min_ratio =3D 2,
> +=A0=A0=A0=A0=A0=A0=A0.max_ratio =3D 20,
> +=A0=A0=A0=A0=A0=A0=A0.min_core =3D 500000,
> +=A0=A0=A0=A0=A0=A0=A0.max_core =3D 1000000,
> +};

Are these correct on any board? If they can be different
depending on the board design, it would be better to get
this data from the device tree.

> +static DECLARE_COMPLETION(cf750gx_v_exit_completion);
> +
> +static unsigned int override_min_core =3D 0;
> +static unsigned int override_max_core =3D 0;
> +static unsigned int minmaxmode =3D 0;
> +
> +static unsigned int cf750gx_v_min_core =3D 0;
> +static unsigned int cf750gx_v_max_core =3D 0;
> +static int cf750gx_v_idle_pll_off =3D 0;
> +static int cf750gx_v_min_max_mode =3D 0;
> +static unsigned long cf750gx_v_state_bits =3D 0;

Is 0 a meaningful value for these? If it just means 'uninitialized',
then better don't initialize them in the first place, for clarity.

> +static struct cpufreq_frequency_table *cf750gx_v_f_table;
> +static struct cpufreq_frequency_table *cf750gx_v_freq_table;
> +static struct cpufreq_frequency_table *cf750gx_v_min_max_freq_table;
> +
> +static struct cf750gx_t_call_data cf750gx_v_switch_call_data;
> +static struct cf750gx_t_call_data cf750gx_v_lock_call_data;
> +static struct notifier_block cf750gx_v_pll_switch_nb;
> +static struct notifier_block cf750gx_v_pll_lock_nb;

Also, in general, try to avoid global variables here, even=20
in file scope (static), but rather put all device specific
data into a per-device data structure.

> +static int cf750gx_pll_switch_cb(struct notifier_block *nb, unsigned long
> +=A0=A0=A0=A0=A0=A0=A0action, void *data)
> +{
> +struct cf750gx_t_call_data *cd;
> +unsigned int idle_pll;
> +unsigned int pll_off_cmd;
> +unsigned int new_pll;

The whitespace appears damaged here.

> +=A0=A0=A0=A0=A0=A0=A0cd =3D (struct cf750gx_t_call_data *)data;

data is a void pointer, so you don't need the cast, and shouldn't
have it therefore.
> +static int cf750gx_pll_lock_cb(struct notifier_block *nb, unsigned long =
action,
> +=A0=A0=A0=A0=A0=A0=A0void *data)
> +{
> +struct cf750gx_t_call_data *cd;
> +
> +=A0=A0=A0=A0=A0=A0=A0cd =3D (struct cf750gx_t_call_data *)data;

same here.

> +static int cf750gx_target(struct cpufreq_policy *policy,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 =A0 unsigned int target_freq, unsigned int relation)
> +{
> +unsigned int next_index =3D 0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Index =
into freq_table */
> +unsigned int next_freq =3D 0;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* next=
 frequency from perf table */
> +unsigned int next_perf_state =3D 0;=A0=A0=A0=A0=A0=A0/* Index from perf =
table */
> +int result =3D 0;

Don't initialize local variables in the declaration, as that will prevent
the compiler from warning about uninitialized use.

> +unsigned int pll;
> +unsigned int new_pll;
> +unsigned int active_pll;
> +struct cpufreq_freqs freqs;
> +struct cpufreq_frequency_table *ft =3D cf750gx_v_f_table;

more whitespace damage. Maybe there is something wrong with your
text editor.

> +=A0=A0=A0=A0=A0=A0=A0dprintk(__FILE__">%s(, %u KHz, relation %u)-%d: =A0=
on cpu %d\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__func__, target_freq, rela=
tion, __LINE__, policy->cpu);
> +
> +=A0=A0=A0=A0=A0=A0=A0if (test_and_set_bit(cf750gxmChangingPllBit, &cf750=
gx_v_state_bits))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EAGAIN;
> +
> +=A0=A0=A0=A0=A0=A0=A0INIT_COMPLETION(cf750gx_v_exit_completion);
> +
> +=A0=A0=A0=A0=A0=A0=A0result =3D cpufreq_frequency_table_target(policy,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ft,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0target=
_freq,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0relati=
on, &next_index);
> +
> +=A0=A0=A0=A0=A0=A0=A0if (unlikely(result))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto cf750gxTargetNoFreq;

The unlikely() here looks like overoptimization, drop it in favor of
readability unless you can measure a real-world difference.

> +=A0=A0=A0=A0=A0=A0=A0if (active_pll) {
> +=A0=A0=A0=A0=A0=A0=A0unsigned int current_state;

whitespace damage.

> +=A0=A0=A0=A0=A0=A0=A0dprintk(__FILE__">%s()-%d: =A0Modifying PLL: =A00x%=
x\n", __func__, __LINE__,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0new_pll);

Please go through all your dprintk and see if you really really need all of=
 them.
Usually they are useful while you are doing the initial code, but only get =
in the
way as soon as it starts working.

> +cf750gxTargetOut:
> +=A0=A0=A0=A0=A0=A0=A0return result;
> +
> +cf750gxTargetNoFreq:
> +=A0=A0=A0=A0=A0=A0=A0result =3D -ENODEV;
> +
> +=A0=A0=A0=A0=A0=A0=A0goto cf750gxTargetUnlock;
> +cf750gxTargetFreqSet:
> +=A0=A0=A0=A0=A0=A0=A0result =3D 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0goto cf750gxTargetUnlock;
> +cf750gxTargetUnlock:
> +=A0=A0=A0=A0=A0=A0=A0clear_bit(cf750gxmChangingPllBit, &cf750gx_v_state_=
bits);
> +=A0=A0=A0=A0=A0=A0=A0complete(&cf750gx_v_exit_completion);
> +
> +=A0=A0=A0=A0=A0=A0=A0goto cf750gxTargetOut;

The conventional way to write this would be:

	result =3D -ENODEV;
	if (foo)
		goto out_unlock;

	result =3D 0;
	if (bar)
		goto out_unlock;

	return 0;

out_unlock:
	clear_bit(cf750gxmChangingPllBit, &cf750gx_v_state_bits);
	complete(&cf750gx_v_exit_completion);
out:
	return result;

> +/*=A0=A0=A0=A0=A0policy->cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;=
 */
> +=A0=A0=A0=A0=A0=A0=A0policy->cpuinfo.transition_latency =3D pllif_get_la=
tency();

The comment does not really explain anything. If you just want to disable
code, use #if 0, but better drop it right away and add a comment about
what might need changing.

> +=A0=A0=A0=A0=A0=A0=A0result =3D cpufreq_frequency_table_cpuinfo(policy, =
cf750gx_v_f_table);
> +=A0=A0=A0=A0=A0=A0=A0if (result)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto err_freqfree;
> +
> +=A0=A0=A0=A0=A0=A0=A0cpufreq_frequency_table_get_attr(cf750gx_v_f_table,=
 policy->cpu);
> +
> +=A0=A0=A0=A0=A0=A0=A0cf750gx_v_pll_switch_nb.notifier_call =3D cf750gx_p=
ll_switch_cb;
> +=A0=A0=A0=A0=A0=A0=A0cf750gx_v_pll_switch_nb.next =3D (struct notifier_b=
lock *)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&cf750gx_v_switch_call_data;
> +=A0=A0=A0=A0=A0=A0=A0cf750gx_v_pll_switch_nb.priority =3D 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0result =3D pllif_register_pll_switch_cb(&cf750gx_v_=
pll_switch_nb);
> +
> +=A0=A0=A0=A0=A0=A0=A0cf750gx_v_pll_lock_nb.notifier_call =3D cf750gx_pll=
_lock_cb;
> +=A0=A0=A0=A0=A0=A0=A0cf750gx_v_pll_lock_nb.next =3D
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(struct notifier_block *)&c=
f750gx_v_lock_call_data;

These casts look wrong, cf750gx_v_lock_call_data is not a notifier_block.
What are you trying to do here?

> +=A0=A0=A0=A0=A0=A0=A0cf750gx_v_pll_lock_nb.priority =3D 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0result =3D pllif_register_pll_lock_cb(&cf750gx_v_pl=
l_lock_nb);
> +
> +=A0=A0=A0=A0=A0=A0=A0return result;
> +
> +err_freqfree:
> +=A0=A0=A0=A0=A0=A0=A0return result;
> +}

The first 'return result' is redundant, drop it.

> +
> +static int cf750gx_cpu_exit(struct cpufreq_policy *policy)
> +{
> +=A0=A0=A0=A0=A0=A0=A0dprintk("%s()\n", __func__);
> +
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 * Wait for any active requests to ripple through b=
efore exiting
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0wait_for_completion(&cf750gx_v_exit_completion);

This "wait for anything" use of wait_for_completion looks wrong,=20
because once any other function has done the 'complete', you won't
wait here any more.

What exactly are you trying to accomplish with this?

> +static int __init cf750gx_init(void)
> +{
> +int ret;
> +unsigned int freq, i, j, rng, bus_clock;
> +unsigned short min_ratio, max_ratio;
> +struct cpufreq_frequency_table *tbp;
> +const struct pll_750fgx_t *pll_defaults;

whitespace.

> +=A0=A0=A0=A0=A0=A0=A0dprintk("%s()\n", __func__);
> +
> +=A0=A0=A0=A0=A0=A0=A0if (!cpu_has_feature(CPU_FTR_DUAL_PLL_750FX))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;

Is this purely a feature of the CPU or does it need logic
in the board design? If you need external hardware for it,
you need to check the device tree for the presence of that
hardware.

> +=A0=A0=A0=A0=A0=A0=A0if (cf750gx_v_freq_table =3D=3D NULL) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D -ENOMEM;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto ErrSimple;
> +=A0=A0=A0=A0=A0=A0=A0}

ret =3D -ENOMEM;
if (!cf750gx_freq_table)
	goto err_simple;


	Arnd <><
