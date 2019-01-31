Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3533C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 22:23:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD79220869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 22:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD79220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rFB03vBTzDqdf
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 09:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rF8H6MVvzDqc4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 09:21:51 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0VMJ74N090577
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 17:21:49 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qc6g8ywmy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 17:21:48 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 31 Jan 2019 22:21:48 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 22:21:45 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0VMLi3913959196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 22:21:44 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34C8F124053;
 Thu, 31 Jan 2019 22:21:44 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4308124052;
 Thu, 31 Jan 2019 22:21:42 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.80.225.63])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 31 Jan 2019 22:21:42 +0000 (GMT)
Subject: Re: [PATCH v02] powerpc/pseries: Check for ceded CPU's during LPAR
 migration
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>,
 Gustavo Walbon <gwalbon@linux.vnet.ibm.com>,
 Pete Heyrman <heyrman@us.ibm.com>
References: <20190130212220.11315.76901.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
 <8736p9pes4.fsf@concordia.ellerman.id.au>
 <65daf21b-dd1d-c22d-4746-65f4ae5d824f@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 31 Jan 2019 14:21:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <65daf21b-dd1d-c22d-4746-65f4ae5d824f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19013122-0052-0000-0000-000003815186
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010512; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154528; UDB=6.00602042; IPR=6.00934960; 
 MB=3.00025380; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-31 22:21:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013122-0053-0000-0000-00005FAC5820
Message-Id: <1030033d-0cca-efa5-2833-ee8bbd7c4e8a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310162
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 01/31/2019 01:53 PM, Michael Bringmann wrote:
> On 1/30/19 11:38 PM, Michael Ellerman wrote:
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>> This patch is to check for cede'ed CPUs during LPM.  Some extreme
>>> tests encountered a problem ehere Linux has put some threads to
>>> sleep (possibly to save energy or something), LPM was attempted,
>>> and the Linux kernel didn't awaken the sleeping threads, but issued
>>> the H_JOIN for the active threads.  Since the sleeping threads
>>> are not awake, they can not issue the expected H_JOIN, and the
>>> partition would never suspend.  This patch wakes the sleeping
>>> threads back up.
>>
>> I'm don't think this is the right solution.
>>
>> Just after your for loop we do an on_each_cpu() call, which sends an IPI
>> to every CPU, and that should wake all CPUs up from CEDE.
>>
>> If that's not happening then there is a bug somewhere, and we need to
>> work out where.
> 
> Let me explain the scenario of the LPM case that Pete Heyrman found, and
> that Nathan F. was working upon, previously.
> 
> In the scenario, the partition has 5 dedicated processors each with 8 threads
> running.

Do we CEDE processors when running dedicated? I thought H_CEDE was part of the
Shared Processor LPAR option.

> 
> From the PHYP data we can see that on VP 0, threads 3, 4, 5, 6 and 7 issued
> a H_CEDE requesting to save energy by putting the requesting thread into
> sleep mode.  In this state, the thread will only be awakened by H_PROD from
> another running thread or from an external user action (power off, reboot
> and such).  Timers and external interrupts are disabled in this mode.

Not according to PAPR. A CEDE'd processor should awaken if signaled by external
interrupt such as decrementer or IPI as well.

-Tyrel

> 
> About 3 seconds later, as part of the LPM operation, the other 35 threads
> have all issued a H_JOIN request.  Join is part of the LPM process where
> the threads suspend themselves as part of the LPM operation so the partition
> can be migrated to the target server.
> 
> So, the current state is the the OS has suspended the execution of all the
> threads in the partition without successfully suspending all threads as part
> of LPM.
> 
> Net, OS has an issue where they suspended every processor thread so nothing
> can run.
> 
> This appears to be slightly different than the previous LPM stalls we have
> seen where the migration stalls because of cpus being taken offline and not
> making the H_JOIN call.
> 
> In this scenario we appear to have CPUs that have done an H_CEDE prior to
> the LPM. For these CPUs we would need to do a H_PROD to wake them back up
> so they can do a H_JOIN and allow the LPM to continue.
> 
> The problem is that Linux has some threads that they put to sleep (probably
> to save energy or something), LPM was attempted, Linux didn't awaken the
> sleeping threads but issued the H_JOIN for the active threads.  Since the
> sleeping threads don't issue the H_JOIN the partition will never suspend.
> 
> I am checking again with Pete regarding your concerns.
> 
> Thanks.
> 
>>
>>
>>> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
>>> index cff5a41..8292eff 100644
>>> --- a/arch/powerpc/include/asm/plpar_wrappers.h
>>> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
>>> @@ -26,10 +26,8 @@ static inline void set_cede_latency_hint(u8 latency_hint)
>>>  	get_lppaca()->cede_latency_hint = latency_hint;
>>>  }
>>>  
>>> -static inline long cede_processor(void)
>>> -{
>>> -	return plpar_hcall_norets(H_CEDE);
>>> -}
>>> +int cpu_is_ceded(int cpu);
>>> +long cede_processor(void);
>>>  
>>>  static inline long extended_cede_processor(unsigned long latency_hint)
>>>  {
>>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>>> index de35bd8f..fea3d21 100644
>>> --- a/arch/powerpc/kernel/rtas.c
>>> +++ b/arch/powerpc/kernel/rtas.c
>>> @@ -44,6 +44,7 @@
>>>  #include <asm/time.h>
>>>  #include <asm/mmu.h>
>>>  #include <asm/topology.h>
>>> +#include <asm/plpar_wrappers.h>
>>>  
>>>  /* This is here deliberately so it's only used in this file */
>>>  void enter_rtas(unsigned long);
>>> @@ -942,7 +943,7 @@ int rtas_ibm_suspend_me(u64 handle)
>>>  	struct rtas_suspend_me_data data;
>>>  	DECLARE_COMPLETION_ONSTACK(done);
>>>  	cpumask_var_t offline_mask;
>>> -	int cpuret;
>>> +	int cpuret, cpu;
>>>  
>>>  	if (!rtas_service_present("ibm,suspend-me"))
>>>  		return -ENOSYS;
>>> @@ -991,6 +992,11 @@ int rtas_ibm_suspend_me(u64 handle)
>>>  		goto out_hotplug_enable;
>>>  	}
>>>  
>>> +	for_each_present_cpu(cpu) {
>>> +		if (cpu_is_ceded(cpu))
>>> +			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
>>> +	}
>>
>> There's a race condition here, there's nothing to prevent the CPUs you
>> just PROD'ed from going back into CEDE before you do the on_each_cpu()
>> call below> 
>>>  	/* Call function on all CPUs.  One of us will make the
>>>  	 * rtas call
>>>  	 */
>>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>>> index 41f62ca2..48ae6d4 100644
>>> --- a/arch/powerpc/platforms/pseries/setup.c
>>> +++ b/arch/powerpc/platforms/pseries/setup.c
>>> @@ -331,6 +331,24 @@ static int alloc_dispatch_log_kmem_cache(void)
>>>  }
>>>  machine_early_initcall(pseries, alloc_dispatch_log_kmem_cache);
>>>  
>>> +static DEFINE_PER_CPU(int, cpu_ceded);
>>> +
>>> +int cpu_is_ceded(int cpu)
>>> +{
>>> +	return per_cpu(cpu_ceded, cpu);
>>> +}
>>> +
>>> +long cede_processor(void)
>>> +{
>>> +	long rc;
>>> +
>>> +	per_cpu(cpu_ceded, raw_smp_processor_id()) = 1;
>>
>> And there's also a race condition here. From the other CPU's perspective
>> the store to cpu_ceded is not necessarily ordered vs the hcall below.
>> Which means the other CPU can see cpu_ceded = 0, and therefore not prod
>> us, but this CPU has already called H_CEDE.
>>
>>> +	rc = plpar_hcall_norets(H_CEDE);
>>> +	per_cpu(cpu_ceded, raw_smp_processor_id()) = 0;
>>> +
>>> +	return rc;
>>> +}
>>> +
>>>  static void pseries_lpar_idle(void)
>>>  {
>>>  	/*
>>
>> cheers
>>
>>
> 

