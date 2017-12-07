Return-Path: <rjwysocki@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yt7mv13TfzDsQ0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 08:25:18 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id e74so7589278ote.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Dec 2017 13:25:18 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1512626365-22845-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1512626365-22845-1-git-send-email-ego@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 7 Dec 2017 22:25:15 +0100
Message-ID: <CAJZ5v0jzh1B_8FYciWhpJZVPZNzm3n30NEE25LO_YJ17Wi+h+w@mail.gmail.com>
Subject: Re: [v2 PATCH] cpufreq: powernv: Correctly parse the sign of pstates
 on POWER8 vs POWER9
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 7, 2017 at 6:59 AM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> On POWERNV platform, Pstates are 8-bit values. On POWER8 they are
> negatively numbered while on POWER9 they are positively
> numbered. Thus, on POWER9, the maximum number of pstates could be as
> high as 256.
>
> The current code interprets pstates as a signed 8-bit value. This
> causes a problem on POWER9 platforms which have more than 128 pstates.
> On such systems, on a CPU that is in a lower pstate whose number is
> greater than 128, querying the current pstate returns a "pstate X is
> out of bound" error message and the current pstate is reported as the
> nominal pstate.
>
> This patch fixes the aforementioned issue by correctly differentiating
> the sign whenever a pstate value read, depending on whether the
> pstates are positively numbered or negatively numbered.
>
> Fixes: commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
> Cc: <stable@vger.kernel.org> #v4.8
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Tested-and-reviewed-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm going to apply this, or please let me know if you want to route it
differently.

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 43 ++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index b6d7c4c..bb7586e 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -41,11 +41,14 @@
>  #define POWERNV_MAX_PSTATES    256
>  #define PMSR_PSAFE_ENABLE      (1UL << 30)
>  #define PMSR_SPR_EM_DISABLE    (1UL << 31)
> -#define PMSR_MAX(x)            ((x >> 32) & 0xFF)
> +#define EXTRACT_BYTE(x, shift) (((x) >> shift) & 0xFF)
> +#define MAX_SHIFT              32
>  #define LPSTATE_SHIFT          48
>  #define GPSTATE_SHIFT          56
> -#define GET_LPSTATE(x)         (((x) >> LPSTATE_SHIFT) & 0xFF)
> -#define GET_GPSTATE(x)         (((x) >> GPSTATE_SHIFT) & 0xFF)
> +#define GET_PMSR_MAX(x)                EXTRACT_BYTE(x, MAX_SHIFT)
> +#define GET_LPSTATE(x)         EXTRACT_BYTE(x, LPSTATE_SHIFT)
> +#define GET_GPSTATE(x)         EXTRACT_BYTE(x, GPSTATE_SHIFT)
> +
>
>  #define MAX_RAMP_DOWN_TIME                             5120
>  /*
> @@ -64,6 +67,12 @@
>
>  /* Interval after which the timer is queued to bring down global pstate */
>  #define GPSTATE_TIMER_INTERVAL                         2000
> +/*
> + * On POWER8 the pstates are negatively numbered. On POWER9, they are
> + * positively numbered.  Use this flag to track whether we have
> + * positive or negative numbered pstates.
> + */
> +static bool pos_pstates;
>
>  /**
>   * struct global_pstate_info - Per policy data structure to maintain history of
> @@ -164,7 +173,7 @@ static inline unsigned int pstate_to_idx(int pstate)
>         int min = powernv_freqs[powernv_pstate_info.min].driver_data;
>         int max = powernv_freqs[powernv_pstate_info.max].driver_data;
>
> -       if (min > 0) {
> +       if (pos_pstates) {
>                 if (unlikely((pstate < max) || (pstate > min))) {
>                         pr_warn_once("pstate %d is out of bound\n", pstate);
>                         return powernv_pstate_info.nominal;
> @@ -301,6 +310,9 @@ static int init_powernv_pstates(void)
>                 }
>         }
>
> +       if ((int)pstate_min > 0)
> +               pos_pstates = true;
> +
>         /* End of list marker entry */
>         powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
>         return 0;
> @@ -438,7 +450,6 @@ struct powernv_smp_call_data {
>  static void powernv_read_cpu_freq(void *arg)
>  {
>         unsigned long pmspr_val;
> -       s8 local_pstate_id;
>         struct powernv_smp_call_data *freq_data = arg;
>
>         pmspr_val = get_pmspr(SPRN_PMSR);
> @@ -447,8 +458,11 @@ static void powernv_read_cpu_freq(void *arg)
>          * The local pstate id corresponds bits 48..55 in the PMSR.
>          * Note: Watch out for the sign!
>          */
> -       local_pstate_id = (pmspr_val >> 48) & 0xFF;
> -       freq_data->pstate_id = local_pstate_id;
> +       if (pos_pstates)
> +               freq_data->pstate_id = (u8)GET_LPSTATE(pmspr_val);
> +       else
> +               freq_data->pstate_id = (s8)GET_LPSTATE(pmspr_val);
> +
>         freq_data->freq = pstate_id_to_freq(freq_data->pstate_id);
>
>         pr_debug("cpu %d pmsr %016lX pstate_id %d frequency %d kHz\n",
> @@ -522,7 +536,10 @@ static void powernv_cpufreq_throttle_check(void *data)
>         chip = this_cpu_read(chip_info);
>
>         /* Check for Pmax Capping */
> -       pmsr_pmax = (s8)PMSR_MAX(pmsr);
> +       if (pos_pstates)
> +               pmsr_pmax = (u8)GET_PMSR_MAX(pmsr);
> +       else
> +               pmsr_pmax = (s8)GET_PMSR_MAX(pmsr);
>         pmsr_pmax_idx = pstate_to_idx(pmsr_pmax);
>         if (pmsr_pmax_idx != powernv_pstate_info.max) {
>                 if (chip->throttled)
> @@ -645,8 +662,14 @@ void gpstate_timer_handler(struct timer_list *t)
>          * value. Hence, read from PMCR to get correct data.
>          */
>         val = get_pmspr(SPRN_PMCR);
> -       freq_data.gpstate_id = (s8)GET_GPSTATE(val);
> -       freq_data.pstate_id = (s8)GET_LPSTATE(val);
> +       if (pos_pstates) {
> +               freq_data.gpstate_id = (u8)GET_GPSTATE(val);
> +               freq_data.pstate_id = (u8)GET_LPSTATE(val);
> +       } else {
> +               freq_data.gpstate_id = (s8)GET_GPSTATE(val);
> +               freq_data.pstate_id = (s8)GET_LPSTATE(val);
> +       }
> +
>         if (freq_data.gpstate_id  == freq_data.pstate_id) {
>                 reset_gpstates(policy);
>                 spin_unlock(&gpstates->gpstate_lock);
> --
> 1.8.3.1
>
