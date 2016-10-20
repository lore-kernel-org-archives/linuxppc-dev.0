Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t00D75JSnzDvWD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 18:04:23 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9K74HTf031790
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 03:04:21 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 266mej2s19-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 03:04:20 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 20 Oct 2016 17:04:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4A00D2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 18:04:07 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9K747JJ19857452
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 18:04:07 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9K7468N000474
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 18:04:07 +1100
Subject: Re: [PATCH] cpufreq: powernv: Use node ID in init_chip_info
To: Emily Shaffer <emilyshaffer@google.com>
References: <CAJoAoZmfxs8wwy1XsfN9qzLyf-ifQK-qPE4jeBhnKKzjoHSXmA@mail.gmail.com>
 <20161020035951.GH11766@vireshk-i7>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, rjw@rjwysocki.net,
 linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
 akshay.adiga@linux.vnet.ibm.com, ego@linux.vnet.ibm.com
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 20 Oct 2016 12:33:56 +0530
MIME-Version: 1.0
In-Reply-To: <20161020035951.GH11766@vireshk-i7>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c113a5cb-6043-e1d0-ccfd-81871d65a1ab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 10/20/2016 09:29 AM, Viresh Kumar wrote:
> + few IBM guys who have been working on this.
> 
> On 19-10-16, 15:02, Emily Shaffer wrote:
>> Fixed assumption that node_id==chip_id in powernv-cpufreq.c:init_chip_info;
>> explicitly use node ID where necessary.

Thanks for the bug fix. I agree that the node-ids should not be assumed to be
always be equal to chip-ids. But I think it would be better to get rid of
cpumask_of_node() as it has problems when the powernv-cpufreq driver is
initialized with offline cpus, like reported in the post below.
https://patchwork.kernel.org/patch/8887591/
(^^ This should also solve the node_id=chip_id problem)

Since throttle stats are common for all cpus in the chip, so we are better of
not using cpumask_of_node() instead define something like cpumask_of_chip()
where the driver doesn't have to compute chip cpumask.

Thanks and Regards,
Shilpa

>>
>> Tested: All CPUs report in /sys/devices/system/cpu*/cpufreq/throttle_stats
>>
>> Effort: platforms/arch-powerpc
>> Google-Bug-Id: 26979978
> 
> Is this relevant upstream?
> 
>>
>> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
>> Change-Id: I22eb626b32fbb8053b3bbb9c75e677c700d0c2fb
> 
> Gerrit id isn't required for upstream..
> 
>> ---
>>  drivers/cpufreq/powernv-cpufreq.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c
>> b/drivers/cpufreq/powernv-cpufreq.c
>> index d3ffde8..3750b58 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -911,32 +911,47 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>>
>>  static int init_chip_info(void)
>>  {
>> -       unsigned int chip[256];
>> +       int rc = 0;
>>         unsigned int cpu, i;
>>         unsigned int prev_chip_id = UINT_MAX;
>> +       unsigned int *chip, *node;
>> +
>> +       chip = kcalloc(num_possible_cpus(), sizeof(unsigned int), GFP_KERNEL);
>> +       node = kcalloc(num_possible_cpus(), sizeof(unsigned int), GFP_KERNEL);
>> +       if (!chip || !node) {
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>>
>>         for_each_possible_cpu(cpu) {
>>                 unsigned int id = cpu_to_chip_id(cpu);
>>
>>                 if (prev_chip_id != id) {
>>                         prev_chip_id = id;
>> -                       chip[nr_chips++] = id;
>> +                       node[nr_chips] = cpu_to_node(cpu);
>> +                       chip[nr_chips] = id;
>> +                       nr_chips++;
>>                 }
>>         }
>>
>>         chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
>> -       if (!chips)
>> -               return -ENOMEM;
>> +       if (!chips) {
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>>
>>         for (i = 0; i < nr_chips; i++) {
>>                 chips[i].id = chip[i];
>> -               cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
>> +               cpumask_copy(&chips[i].mask, cpumask_of_node(node[i]));
>>                 INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
>>                 for_each_cpu(cpu, &chips[i].mask)
>>                         per_cpu(chip_info, cpu) =  &chips[i];
>>         }
>>
>> -       return 0;
>> +out:
>> +       kfree(node);
>> +       kfree(chip);
>> +       return rc;
>>  }
>>
>>  static inline void clean_chip_info(void)
>> -- 
>> 2.8.0.rc3.226.g39d4020
> 
