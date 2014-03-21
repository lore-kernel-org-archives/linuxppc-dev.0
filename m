Return-Path: <viresh.linux@gmail.com>
Received: from mail-vc0-x234.google.com (mail-vc0-x234.google.com
 [IPv6:2607:f8b0:400c:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 420982C00C2
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 20:31:32 +1100 (EST)
Received: by mail-vc0-f180.google.com with SMTP id lf12so2325014vcb.11
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 02:31:29 -0700 (PDT)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 15:01:29 +0530
Message-ID: <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 5:41 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The current frequency of a cpu is reported through the sysfs file
> cpuinfo_cur_freq. This requires the driver to implement a
> "->get(unsigned int cpu)" method which will return the current
> operating frequency.
>
> Implement a function named powernv_cpufreq_get() which reads the local
> pstate from the PMSR and returns the corresponding frequency.
>
> Set the powernv_cpufreq_driver.get hook to powernv_cpufreq_get().
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Please merge these fixups with the first patch which is creating the driver.
I understand that a different guy has created this patch and so wanted
to have a patch on his name but its really difficult to review this way.
Better add your signed-off in the first patch instead. Sending such changes
once the driver is mainlined looks fine.

> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 46bee8a..ef6ed8c 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -206,6 +206,43 @@ static inline void set_pmspr(unsigned long sprn, unsigned long val)
>         BUG();
>  }
>
> +/*
> + * Computes the current frequency on this cpu
> + * and stores the result in *ret_freq.
> + */
> +static void powernv_read_cpu_freq(void *ret_freq)
> +{
> +       unsigned long pmspr_val;
> +       s8 local_pstate_id;
> +       int *cur_freq, freq, pstate_id;
> +
> +       cur_freq = (int *)ret_freq;

You don't need cur_freq variable at all..

> +       pmspr_val = get_pmspr(SPRN_PMSR);
> +
> +       /* The local pstate id corresponds bits 48..55 in the PMSR.
> +         * Note: Watch out for the sign! */
> +       local_pstate_id = (pmspr_val >> 48) & 0xFF;
> +       pstate_id = local_pstate_id;

similarly local_pstate_id

> +
> +       freq = pstate_id_to_freq(pstate_id);
> +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d \n",
> +               smp_processor_id(), pmspr_val, pstate_id, freq);
> +       *cur_freq = freq;

Move above print here after a blank line. Also remove freq variable as
well and use *cur_freq directly.. And then you can rename it to freq as well.

> +}
> +
> +/*
> + * Returns the cpu frequency as reported by the firmware for 'cpu'.
> + * This value is reported through the sysfs file cpuinfo_cur_freq.
> + */
> +unsigned int powernv_cpufreq_get(unsigned int cpu)
> +{
> +       int ret_freq;
> +
> +       smp_call_function_any(cpu_sibling_mask(cpu), powernv_read_cpu_freq,
> +                       &ret_freq, 1);
> +       return ret_freq;
> +}
> +
>  static void set_pstate(void *pstate)
>  {
>         unsigned long val;
> @@ -297,6 +334,7 @@ static int powernv_cpufreq_target(struct cpufreq_policy *policy,
>  static struct cpufreq_driver powernv_cpufreq_driver = {
>         .verify         = powernv_cpufreq_verify,
>         .target         = powernv_cpufreq_target,
> +       .get            = powernv_cpufreq_get,
>         .init           = powernv_cpufreq_cpu_init,
>         .exit           = powernv_cpufreq_cpu_exit,
>         .name           = "powernv-cpufreq",
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
