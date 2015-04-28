Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B48A11A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 18:19:46 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4298114012C
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 18:19:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 18:19:45 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D31F12CE8040
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 18:19:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3S8JYMD40435830
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 18:19:42 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3S8J8Dk030594
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2015 18:19:09 +1000
Message-ID: <553F426B.3050601@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 13:48:51 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Register for OCC related
 opal_message notification
References: <1430202214-13807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430202214-13807-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohpomaOvpdOYqAsOyPn0nRG0Mb68JscXhgBPDa6grqRAE8zA@mail.gmail.com>
In-Reply-To: <CAKohpomaOvpdOYqAsOyPn0nRG0Mb68JscXhgBPDa6grqRAE8zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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

Hi Viresh,

On 04/28/2015 12:18 PM, Viresh Kumar wrote:
> On 28 April 2015 at 11:53, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
> 
>> Changes from v1:
>> - Add macros to define OCC_RESET, OCC_LOAD and OCC_THROTTLE
>> - Define a structure to store chip id, chip mask which has bits set
>>   for cpus present in the chip, throttled state and a work_struct.
>> - Modify powernv_cpufreq_throttle_check() to be called via smp_call()
> 
> Why ? I might have missed it but there should be some reasoning behind
> what you are changing.

My bad I haven't added explicit comment to state reason behind this change.

I modified the definition of *throttle_check() to match the function definition
to be called via smp_call() instead of adding an additional wrapper around
*throttle_check().

OCC is a chip entity and any local throttle state changes should be associated
to cpus belonging to that chip. The *throttle_check() will read the core
register PMSR to verify throttling. All the cores in a chip will have the same
throttled state as they are managed by a the same OCC in that chip.

smp_call() is required to ensure *throttle_check() is called on a cpu belonging
to the chip for which we have received throttled/unthrottled notification. We
could be handling throttled/unthrottled notification of 'chip1' in 'chip2' so do
an smp_call() on 'chip1'.

We are irq_disabled in powernv_cpufreq_occ_msg() the notification handler.
Thus the use of kworker to do an smp_call and restore policy->cur.

OCC_RESET is global event it affects frequency of all chips. Pmax capping is
local event, it affects the frequency of a chip.

> 
>> - On Pmax throttling/unthrottling update 'chip.throttled' and not the
>>   global 'throttled' as Pmax capping is local to the chip.
>> - Remove the condition which checks if local pstate is less than Pmin
>>   while checking for Psafe frequency. When OCC becomes active after
>>   reset we update 'thottled' to false and when the cpufreq governor
>>   initiates a pstate change, the local pstate will be in Psafe and we
>>   will be reporting a false positive when we are not throttled.
>> - Schedule a kworker on receiving throttling/unthrottling OCC message
>>   for that chip and schedule on all chips after receiving active.
>> - After an OCC reset all the cpus will be in Psafe frequency. So call
>>   target() and restore the frequency to policy->cur after OCC_ACTIVE
>>   and Pmax unthrottling
>> - Taken care of Viresh and Preeti's comments.
> 
> That's a lot. I am not an expert here and so really can't comment on
> the internals of ppc. But, is it patch solving a single problem ? I don't
> know, I somehow got the impression that it can be split into multiple
> (smaller & review-able) patches. Only if it makes sense. Your call.

All the changes introduced in this patch is centered around opal_message
notification handler powernv_cpufreq_occ_msg(). I can split it into multiple
patches but it all will be relevant only to solve the above problem.

> 
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> 
>> +void powernv_cpufreq_work_fn(struct work_struct *work)
>> +{
>> +       struct chip *c = container_of(work, struct chip, throttle);
>> +       unsigned int cpu;
>> +
>> +       smp_call_function_any(&c->mask,
>> +                             powernv_cpufreq_throttle_check, NULL, 0);
>> +
>> +       for_each_cpu(cpu, &c->mask) {
> 
> for_each_online_cpu ?

I want to iterate on all the cpus in a chip stored in 'struct chip.mask'.
If you were intending me to avoid 'if(!cpu_online(cpu))' then will the following do:

for_each_cpu_and(cpu, &c->mask, cpu_online_mask)

> 
>> +               int index;
>> +               struct cpufreq_frequency_table *freq_table;
>> +               struct cpufreq_policy cpu_policy;
> 
> Name it policy.

Okay.

> 
>> +
>> +               if (!cpu_online(cpu))
>> +                       continue;
> 
> And you can kill this..
> 
>> +               cpufreq_get_policy(&cpu_policy, cpu);
>> +               freq_table = cpufreq_frequency_get_table(cpu_policy.cpu);
> 
> Just do, policy->freq_table.

Okay.

> 
> 
>> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>> +                                  unsigned long msg_type, void *msg)
>> +{
> 
>> +               if (reason && reason <= 5)
>> +                       pr_info("OCC: Chip %d Pmax reduced due to %s\n",
>> +                               (int)chip_id, throttle_reason[reason]);
>> +               else
>> +                       pr_info("OCC: Chip %d %s\n", (int)chip_id,
>> +                               throttle_reason[reason]);
> 
> Blank line here. They are better for readability after blocks and loops.

Yes will do.

> 
>> +               for (i = 0; i < nr_chips; i++)
>> +                       if (chips[i].id == (int)chip_id)
> 
> Why isn't .id 64 bit ?

I guess 6 bits are sufficient to store chip id given that max number of chips
can be 256. I don't have good reason for defining .id 32 bit.

Yeah 64-bit .id will avoid the typecast.

> 
>> +                               schedule_work(&chips[i].throttle);
>> +       }
>> +       return 0;
>> +}
>> +
>> +static struct notifier_block powernv_cpufreq_opal_nb = {
>> +       .notifier_call  = powernv_cpufreq_occ_msg,
>> +       .next           = NULL,
>> +       .priority       = 0,
>> +};
>> +
>>  static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>>  {
>>         struct powernv_smp_call_data freq_data;
>> @@ -414,6 +530,35 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>>         .attr           = powernv_cpu_freq_attr,
>>  };
>>
>> +static int init_chip_info(void)
>> +{
>> +       int chip[256], i = 0, cpu;
>> +       int prev_chip_id = INT_MAX;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               int c = cpu_to_chip_id(cpu);
> 
> Does 'c' refer to id here ? Name it so then.

Okay.

> 
>> +
>> +               if (prev_chip_id != c) {
>> +                       prev_chip_id = c;
>> +                       chip[nr_chips++] = c;
>> +               }
>> +       }
>> +
>> +       chips = kmalloc_array(nr_chips, sizeof(struct chip), GFP_KERNEL);
>> +
> 
> A blank line isn't preferred much here :). Sorry about these blank lines.

Okay.

Thanks and Regards,
Shilpa
