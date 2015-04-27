Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8196D1A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 14:32:16 +1000 (AEST)
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF945140077
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 14:32:15 +1000 (AEST)
Received: by oblw8 with SMTP id w8so75061002obl.0
 for <linuxppc-dev@ozlabs.org>; Sun, 26 Apr 2015 21:32:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Mon, 27 Apr 2015 10:02:13 +0530
Message-ID: <CAKohpo=8m=PAof-AF2AQ+rMu-0bF8CvGywb-YaN=u3sJXjLvnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Register for OCC related
 opal_message notification
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

On 22 April 2015 at 22:34, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c

> +static char throttle_reason[6][50] = { "No throttling",

Don't need to mention 6 here.

And the max length you need right now is 27, so maybe s/50/30 ?

Also, start 'No Throttling' in a new line, like below.

> +                                       "Power Cap",
> +                                       "Processor Over Temperature",
> +                                       "Power Supply Failure",
> +                                       "OverCurrent",

s/OverCurrent/Over Current/ ?

> +                                       "OCC Reset"
> +                                    };
> +
> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
> +               unsigned long msg_type, void *msg)
> +{
> +       struct opal_msg *occ_msg = msg;
> +       uint64_t token;
> +       uint64_t chip_id, reason;
> +
> +       if (msg_type != OPAL_MSG_OCC)
> +               return 0;

Blank line here.

> +       token = be64_to_cpu(occ_msg->params[0]);

Here as well..

> +       switch (token) {
> +       case 0:
> +               occ_reset = true;
> +               /*
> +                * powernv_cpufreq_throttle_check() is called in
> +                * target() callback which can detect the throttle state
> +                * for governors like ondemand.
> +                * But static governors will not call target() often thus
> +                * report throttling here.
> +                */

Now, do I understand correctly that this notifier will be called as
soon as we switch throttling state ?

If yes, then do we still need the throttle_check() routine you added
earlier ? Maybe not.

> +               if (!throttled) {
> +                       throttled = true;
> +                       pr_crit("CPU Frequency is throttled\n");
> +               }
> +               pr_info("OCC in Reset\n");
> +               break;
> +       case 1:
> +               pr_info("OCC is Loaded\n");
> +               break;
> +       case 2:
> +               chip_id = be64_to_cpu(occ_msg->params[1]);
> +               reason = be64_to_cpu(occ_msg->params[2]);

Blank line here.

> +               if (occ_reset) {
> +                       occ_reset = false;
> +                       throttled = false;
> +                       pr_info("OCC is Active\n");
> +                       /* Sanity check for static governors */
> +                       powernv_cpufreq_throttle_check(smp_processor_id());
> +               } else if (reason) {
> +                       throttled = true;
> +                       pr_info("Pmax reduced due to %s on chip %x\n",
> +                                       throttle_reason[reason], (int)chip_id);
> +               } else {
> +                       throttled = false;
> +                       pr_info("%s on chip %x\n",
> +                                       throttle_reason[reason], (int)chip_id);
> +               }

Run checkpatch with --strict option, and you will see some warnings.

> +               break;
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
> @@ -430,6 +497,7 @@ static int __init powernv_cpufreq_init(void)
>         }
>
>         register_reboot_notifier(&powernv_cpufreq_reboot_nb);
> +       opal_message_notifier_register(OPAL_MSG_OCC, &powernv_cpufreq_opal_nb);
>         return cpufreq_register_driver(&powernv_cpufreq_driver);
>  }
>  module_init(powernv_cpufreq_init);
> --
> 1.9.3
>
