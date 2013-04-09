Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 75C922C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 19:47:14 +1000 (EST)
Received: by mail-ob0-f175.google.com with SMTP id va7so6645380obc.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2013 02:47:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365496365-28450-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1365496365-28450-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Tue, 9 Apr 2013 15:17:11 +0530
Message-ID: <CAKohpokVf0hCokDL62WeaUdYEBycf+Kh_cRgWxTR--_12xjEBA@mail.gmail.com>
Subject: Re: [PATCH v4] cpufreq: powerpc: Add cpufreq driver for Freescale
 e500mc SoCs
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian.Tang@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 cpufreq@vger.kernel.org, rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mostly good now, V5 should be the final one.

On 9 April 2013 14:02,  <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c

> +static int corenet_cpufreq_target(struct cpufreq_policy *policy,
> +               unsigned int target_freq, unsigned int relation)
> +{
> +       struct cpufreq_freqs freqs;
> +       unsigned int new;
> +       struct clk *parent;
> +       int ret;
> +       struct cpu_data *data = per_cpu(cpu_data, policy->cpu);
> +
> +       cpufreq_frequency_table_target(policy, data->table,
> +                       target_freq, relation, &new);
> +
> +       if (policy->cur == data->table[new].frequency)
> +               return 0;
> +
> +       freqs.old = policy->cur;
> +       freqs.new = data->table[new].frequency;
> +       freqs.cpu = policy->cpu;

You don't need to set freqs.cpu..

> +       mutex_lock(&cpufreq_lock);
> +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
> +
> +       parent = of_clk_get(data->parent, new);
> +       ret = clk_set_parent(data->clk, parent);
> +       if (ret) {
> +               freqs.new = freqs.old;
> +               cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> +               mutex_unlock(&cpufreq_lock);
> +               return ret;
> +       }
> +
> +       cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
> +       mutex_unlock(&cpufreq_lock);

What about writing it as:

+       ret = clk_set_parent(data->clk, parent);
+       if (ret)
+               freqs.new = freqs.old;
+
+       cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
+       mutex_unlock(&cpufreq_lock);

return ret;

> +       return 0;
> +}
