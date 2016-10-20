Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szw7J1XdxzDt08
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 14:59:56 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id r16so27800756pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 20:59:56 -0700 (PDT)
Date: Thu, 20 Oct 2016 09:29:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 rjw@rjwysocki.net, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, ego@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Use node ID in init_chip_info
Message-ID: <20161020035951.GH11766@vireshk-i7>
References: <CAJoAoZmfxs8wwy1XsfN9qzLyf-ifQK-qPE4jeBhnKKzjoHSXmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJoAoZmfxs8wwy1XsfN9qzLyf-ifQK-qPE4jeBhnKKzjoHSXmA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+ few IBM guys who have been working on this.

On 19-10-16, 15:02, Emily Shaffer wrote:
> Fixed assumption that node_id==chip_id in powernv-cpufreq.c:init_chip_info;
> explicitly use node ID where necessary.
> 
> Tested: All CPUs report in /sys/devices/system/cpu*/cpufreq/throttle_stats
> 
> Effort: platforms/arch-powerpc
> Google-Bug-Id: 26979978

Is this relevant upstream?

> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Change-Id: I22eb626b32fbb8053b3bbb9c75e677c700d0c2fb

Gerrit id isn't required for upstream..

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c
> b/drivers/cpufreq/powernv-cpufreq.c
> index d3ffde8..3750b58 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -911,32 +911,47 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
> 
>  static int init_chip_info(void)
>  {
> -       unsigned int chip[256];
> +       int rc = 0;
>         unsigned int cpu, i;
>         unsigned int prev_chip_id = UINT_MAX;
> +       unsigned int *chip, *node;
> +
> +       chip = kcalloc(num_possible_cpus(), sizeof(unsigned int), GFP_KERNEL);
> +       node = kcalloc(num_possible_cpus(), sizeof(unsigned int), GFP_KERNEL);
> +       if (!chip || !node) {
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> 
>         for_each_possible_cpu(cpu) {
>                 unsigned int id = cpu_to_chip_id(cpu);
> 
>                 if (prev_chip_id != id) {
>                         prev_chip_id = id;
> -                       chip[nr_chips++] = id;
> +                       node[nr_chips] = cpu_to_node(cpu);
> +                       chip[nr_chips] = id;
> +                       nr_chips++;
>                 }
>         }
> 
>         chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
> -       if (!chips)
> -               return -ENOMEM;
> +       if (!chips) {
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> 
>         for (i = 0; i < nr_chips; i++) {
>                 chips[i].id = chip[i];
> -               cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
> +               cpumask_copy(&chips[i].mask, cpumask_of_node(node[i]));
>                 INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
>                 for_each_cpu(cpu, &chips[i].mask)
>                         per_cpu(chip_info, cpu) =  &chips[i];
>         }
> 
> -       return 0;
> +out:
> +       kfree(node);
> +       kfree(chip);
> +       return rc;
>  }
> 
>  static inline void clean_chip_info(void)
> -- 
> 2.8.0.rc3.226.g39d4020

-- 
viresh
