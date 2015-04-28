Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90D031A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 16:48:56 +1000 (AEST)
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D4813140142
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 16:48:55 +1000 (AEST)
Received: by oift201 with SMTP id t201so108805894oif.3
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 23:48:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1430202214-13807-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430202214-13807-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 12:18:54 +0530
Message-ID: <CAKohpomaOvpdOYqAsOyPn0nRG0Mb68JscXhgBPDa6grqRAE8zA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Register for OCC related
 opal_message notification
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28 April 2015 at 11:53, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:

> Changes from v1:
> - Add macros to define OCC_RESET, OCC_LOAD and OCC_THROTTLE
> - Define a structure to store chip id, chip mask which has bits set
>   for cpus present in the chip, throttled state and a work_struct.
> - Modify powernv_cpufreq_throttle_check() to be called via smp_call()

Why ? I might have missed it but there should be some reasoning behind
what you are changing.

> - On Pmax throttling/unthrottling update 'chip.throttled' and not the
>   global 'throttled' as Pmax capping is local to the chip.
> - Remove the condition which checks if local pstate is less than Pmin
>   while checking for Psafe frequency. When OCC becomes active after
>   reset we update 'thottled' to false and when the cpufreq governor
>   initiates a pstate change, the local pstate will be in Psafe and we
>   will be reporting a false positive when we are not throttled.
> - Schedule a kworker on receiving throttling/unthrottling OCC message
>   for that chip and schedule on all chips after receiving active.
> - After an OCC reset all the cpus will be in Psafe frequency. So call
>   target() and restore the frequency to policy->cur after OCC_ACTIVE
>   and Pmax unthrottling
> - Taken care of Viresh and Preeti's comments.

That's a lot. I am not an expert here and so really can't comment on
the internals of ppc. But, is it patch solving a single problem ? I don't
know, I somehow got the impression that it can be split into multiple
(smaller & review-able) patches. Only if it makes sense. Your call.

> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c

> +void powernv_cpufreq_work_fn(struct work_struct *work)
> +{
> +       struct chip *c = container_of(work, struct chip, throttle);
> +       unsigned int cpu;
> +
> +       smp_call_function_any(&c->mask,
> +                             powernv_cpufreq_throttle_check, NULL, 0);
> +
> +       for_each_cpu(cpu, &c->mask) {

for_each_online_cpu ?

> +               int index;
> +               struct cpufreq_frequency_table *freq_table;
> +               struct cpufreq_policy cpu_policy;

Name it policy.

> +
> +               if (!cpu_online(cpu))
> +                       continue;

And you can kill this..

> +               cpufreq_get_policy(&cpu_policy, cpu);
> +               freq_table = cpufreq_frequency_get_table(cpu_policy.cpu);

Just do, policy->freq_table.


> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
> +                                  unsigned long msg_type, void *msg)
> +{

> +               if (reason && reason <= 5)
> +                       pr_info("OCC: Chip %d Pmax reduced due to %s\n",
> +                               (int)chip_id, throttle_reason[reason]);
> +               else
> +                       pr_info("OCC: Chip %d %s\n", (int)chip_id,
> +                               throttle_reason[reason]);

Blank line here. They are better for readability after blocks and loops.

> +               for (i = 0; i < nr_chips; i++)
> +                       if (chips[i].id == (int)chip_id)

Why isn't .id 64 bit ?

> +                               schedule_work(&chips[i].throttle);
> +       }
> +       return 0;
> +}
> +
> +static struct notifier_block powernv_cpufreq_opal_nb = {
> +       .notifier_call  = powernv_cpufreq_occ_msg,
> +       .next           = NULL,
> +       .priority       = 0,
> +};
> +
>  static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>  {
>         struct powernv_smp_call_data freq_data;
> @@ -414,6 +530,35 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>         .attr           = powernv_cpu_freq_attr,
>  };
>
> +static int init_chip_info(void)
> +{
> +       int chip[256], i = 0, cpu;
> +       int prev_chip_id = INT_MAX;
> +
> +       for_each_possible_cpu(cpu) {
> +               int c = cpu_to_chip_id(cpu);

Does 'c' refer to id here ? Name it so then.

> +
> +               if (prev_chip_id != c) {
> +                       prev_chip_id = c;
> +                       chip[nr_chips++] = c;
> +               }
> +       }
> +
> +       chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
> +

A blank line isn't preferred much here :). Sorry about these blank lines.

> +       if (!chips)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < nr_chips; i++) {
> +               chips[i].id = chip[i];
> +               cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
> +               chips[i].throttled = false;
> +               INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
> +       }
> +
> +       return 0;
> +}
> +
>  static int __init powernv_cpufreq_init(void)
>  {
>         int rc = 0;
> @@ -429,7 +574,13 @@ static int __init powernv_cpufreq_init(void)
>                 return rc;
>         }
>
> +       /* Populate chip info */
> +       rc = init_chip_info();
> +       if (rc)
> +               return rc;
> +
>         register_reboot_notifier(&powernv_cpufreq_reboot_nb);
> +       opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
>         return cpufreq_register_driver(&powernv_cpufreq_driver);
>  }
>  module_init(powernv_cpufreq_init);
> --
> 1.9.3
>
