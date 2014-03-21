Return-Path: <viresh.linux@gmail.com>
Received: from mail-vc0-x232.google.com (mail-vc0-x232.google.com
 [IPv6:2607:f8b0:400c:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB30A2C00B1
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 19:47:33 +1100 (EST)
Received: by mail-vc0-f178.google.com with SMTP id im17so2224127vcb.23
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 01:47:29 -0700 (PDT)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1395317460-14811-5-git-send-email-ego@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-5-git-send-email-ego@linux.vnet.ibm.com>
Date: Fri, 21 Mar 2014 14:17:28 +0530
Message-ID: <CAOh2x=kLwDGFtHR5sBKhE-9L=3=npV4_i+B+BVm+yBocmmMvzQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] powernv:cpufreq: Export nominal frequency via
 sysfs.
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

On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> Create a driver attribute named cpuinfo_nominal_freq which
> creates a sysfs read-only file named cpuinfo_nominal_freq. Export
> the frequency corresponding to the nominal_pstate through this
> interface.
>
> Nominal frequency is the highest non-turbo frequency for the
> platform.  This is generally used for setting governor policies from
> user space for optimal energy efficiency.
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index e7b0292..46bee8a 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -142,8 +142,30 @@ static unsigned int pstate_id_to_freq(int pstate_id)
>         return powernv_freqs[i].frequency;
>  }
>
> +/**
> + * show_cpuinfo_nominal_freq - Show the nominal CPU frequency as indicated by
> + * the firmware
> + */
> +static ssize_t show_cpuinfo_nominal_freq(struct cpufreq_policy *policy,
> +                                       char *buf)
> +{
> +       int nominal_freq;
> +       nominal_freq = pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id);
> +       return sprintf(buf, "%u\n", nominal_freq);

return sprintf(buf, "%u\n",
pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id));

??

> +}
> +
> +

remove extra blank line.

> +struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq = {
> +       .attr = { .name = "cpuinfo_nominal_freq",
> +                 .mode = 0444,
> +               },

Align {}

> +       .show = show_cpuinfo_nominal_freq,
> +};
> +
> +
>  static struct freq_attr *powernv_cpu_freq_attr[] = {
>         &cpufreq_freq_attr_scaling_available_freqs,
> +       &cpufreq_freq_attr_cpuinfo_nominal_freq,
>         NULL,
>  };
