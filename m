Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54DE91A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:37:15 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 244A714007D
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:37:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 15:37:12 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D9EF42BB004D
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:37:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3S5axRB25952336
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:37:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S5aY41000522
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 15:36:34 +1000
Message-ID: <553F1C51.4060901@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 11:06:17 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Register for OCC related
 opal_message notification
References: <1429722265-2953-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1429722265-2953-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohpo=8m=PAof-AF2AQ+rMu-0bF8CvGywb-YaN=u3sJXjLvnw@mail.gmail.com>
In-Reply-To: <CAKohpo=8m=PAof-AF2AQ+rMu-0bF8CvGywb-YaN=u3sJXjLvnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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

Hi Viresh,

On 04/27/2015 10:02 AM, Viresh Kumar wrote:
> On 22 April 2015 at 22:34, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> 
>> +static char throttle_reason[6][50] = { "No throttling",
> 
> Don't need to mention 6 here.
> 
> And the max length you need right now is 27, so maybe s/50/30 ?
> 
> Also, start 'No Throttling' in a new line, like below.

Will do.
> 
>> +                                       "Power Cap",
>> +                                       "Processor Over Temperature",
>> +                                       "Power Supply Failure",
>> +                                       "OverCurrent",
> 
> s/OverCurrent/Over Current/ ?

Okay.
> 
>> +                                       "OCC Reset"
>> +                                    };
>> +
>> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>> +               unsigned long msg_type, void *msg)
>> +{
>> +       struct opal_msg *occ_msg = msg;
>> +       uint64_t token;
>> +       uint64_t chip_id, reason;
>> +
>> +       if (msg_type != OPAL_MSG_OCC)
>> +               return 0;
> 
> Blank line here.

Okay
> 
>> +       token = be64_to_cpu(occ_msg->params[0]);
> 
> Here as well..
> 
>> +       switch (token) {
>> +       case 0:
>> +               occ_reset = true;
>> +               /*
>> +                * powernv_cpufreq_throttle_check() is called in
>> +                * target() callback which can detect the throttle state
>> +                * for governors like ondemand.
>> +                * But static governors will not call target() often thus
>> +                * report throttling here.
>> +                */
> 
> Now, do I understand correctly that this notifier will be called as
> soon as we switch throttling state ?
> 
> If yes, then do we still need the throttle_check() routine you added
> earlier ? Maybe not.

We cannot remove throttle_check() routine for the following reasons:
1) To report old firmware bugs which do not restore frequency control to host
after an OCC reset.
2) In BMC based boxes if OCC crashes currently firmware will not send 'reset'
and 'load' messages, in such cases throttle_check() will be sufficient to
monitor a throttled state caused by 'reset'.
3) Throttle reporting in old firmwares which do not have this notification.

> 
>> +               if (!throttled) {
>> +                       throttled = true;
>> +                       pr_crit("CPU Frequency is throttled\n");
>> +               }
>> +               pr_info("OCC in Reset\n");
>> +               break;
>> +       case 1:
>> +               pr_info("OCC is Loaded\n");
>> +               break;
>> +       case 2:
>> +               chip_id = be64_to_cpu(occ_msg->params[1]);
>> +               reason = be64_to_cpu(occ_msg->params[2]);
> 
> Blank line here.

Okay
> 
>> +               if (occ_reset) {
>> +                       occ_reset = false;
>> +                       throttled = false;
>> +                       pr_info("OCC is Active\n");
>> +                       /* Sanity check for static governors */
>> +                       powernv_cpufreq_throttle_check(smp_processor_id());
>> +               } else if (reason) {
>> +                       throttled = true;
>> +                       pr_info("Pmax reduced due to %s on chip %x\n",
>> +                                       throttle_reason[reason], (int)chip_id);
>> +               } else {
>> +                       throttled = false;
>> +                       pr_info("%s on chip %x\n",
>> +                                       throttle_reason[reason], (int)chip_id);
>> +               }
> 
> Run checkpatch with --strict option, and you will see some warnings.

Okay will do.

Thanks and Regards,
Shilpa
