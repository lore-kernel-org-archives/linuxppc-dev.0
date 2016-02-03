Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F7171A0226
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 19:42:38 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D2BE14032F
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 19:42:37 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 14:12:34 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u138gURY22938036
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 14:12:30 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13ECFtv006946
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 19:42:18 +0530
Message-ID: <56B1BD71.2050403@linux.vnet.ibm.com>
Date: Wed, 03 Feb 2016 14:12:25 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160203082700.GZ31828@vireshk>
In-Reply-To: <20160203082700.GZ31828@vireshk>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 02/03/2016 01:57 PM, Viresh Kumar wrote:
> On 03-02-16, 01:11, Shilpasri G Bhat wrote:
>>  static int init_chip_info(void)
>>  {
>>  	unsigned int chip[256];
>> -	unsigned int cpu, i;
>> +	unsigned int cpu;
>>  	unsigned int prev_chip_id = UINT_MAX;
>>  	cpumask_t cpu_mask;
>> -	int ret = -ENOMEM;
>> +	int i, j, ret = -ENOMEM;
>>  
>>  	core_to_chip_map = kcalloc(cpu_nr_cores(), sizeof(unsigned int),
>>  				   GFP_KERNEL);
>> @@ -583,12 +711,51 @@ static int init_chip_info(void)
>>  		goto free_chip_map;
>>  
>>  	for (i = 0; i < nr_chips; i++) {
>> +		char name[10];
>> +
>>  		chips[i].id = chip[i];
>>  		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
>>  		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
>> +
>> +		for (j = 0; j <= OCC_MAX_THROTTLE_STATUS; j++) {
>> +			chips[i].reason[j] =
>> +			     kcalloc(powernv_pstate_info.nr_pstates,
>> +				     sizeof(int), GFP_KERNEL);
>> +			if (!chips[i].reason[j]) {
>> +				ret = -ENOMEM;
>> +				goto free_chip;
>> +			}
>> +		}
>> +
>> +		snprintf(name, sizeof(name), "chip%d", chips[i].id);
>> +		ret = kobject_init_and_add(&chips[i].kobj,
>> +					   get_ktype(cpufreq_global_kobject),
> 
> Sorry but why do you need to create a kobject here ? A simple
> sysfs_create_group() can create groups (directories) for you.

I need the chip-id in the <attr>_show(). With just sysfs_create_group() I will
get the cpufreq_global_kobject in the <attr>_show() and I will not be able to
figure out the chip-id.

Thanks and Regards,
Shilpa
> 
>> +					   cpufreq_global_kobject, name);
>> +		if (ret)
>> +			goto free_chip;
>> +
>> +		ret = sysfs_create_group(&chips[i].kobj, &throttle_stat_group);
>> +		if (ret) {
>> +			pr_info("Chip %d failed to create throttle sysfs group\n",
>> +				chips[i].id);
>> +			goto free_kobject;
>> +		}
>>  	}
> 
