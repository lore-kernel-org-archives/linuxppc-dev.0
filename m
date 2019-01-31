Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FCCC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:55:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3842087F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 21:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3842087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rDYK0czWzDq8t
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 08:55:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rDWL6QnwzDqbv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 08:53:18 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0VLnHPt107174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:53:16 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qc982r6yf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 16:53:16 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 31 Jan 2019 21:53:15 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 21:53:12 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0VLrARG23855256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 21:53:10 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9077BAE066;
 Thu, 31 Jan 2019 21:53:10 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D963FAE05F;
 Thu, 31 Jan 2019 21:53:09 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 31 Jan 2019 21:53:09 +0000 (GMT)
Subject: Re: [PATCH v02] powerpc/pseries: Check for ceded CPU's during LPAR
 migration
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Juliet Kim <minkim@us.ibm.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>,
 Gustavo Walbon <gwalbon@linux.vnet.ibm.com>,
 Pete Heyrman <heyrman@us.ibm.com>
References: <20190130212220.11315.76901.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
 <8736p9pes4.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 mQENBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAG0LU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPokBOAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/UrkBDQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABiQEfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Thu, 31 Jan 2019 15:53:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8736p9pes4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19013121-2213-0000-0000-00000348719E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010511; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154518; UDB=6.00602036; IPR=6.00934950; 
 MB=3.00025380; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-31 21:53:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013121-2214-0000-0000-00005D2FE501
Message-Id: <65daf21b-dd1d-c22d-4746-65f4ae5d824f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310158
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

On 1/30/19 11:38 PM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>> This patch is to check for cede'ed CPUs during LPM.  Some extreme
>> tests encountered a problem ehere Linux has put some threads to
>> sleep (possibly to save energy or something), LPM was attempted,
>> and the Linux kernel didn't awaken the sleeping threads, but issued
>> the H_JOIN for the active threads.  Since the sleeping threads
>> are not awake, they can not issue the expected H_JOIN, and the
>> partition would never suspend.  This patch wakes the sleeping
>> threads back up.
> 
> I'm don't think this is the right solution.
> 
> Just after your for loop we do an on_each_cpu() call, which sends an IPI
> to every CPU, and that should wake all CPUs up from CEDE.
> 
> If that's not happening then there is a bug somewhere, and we need to
> work out where.

Let me explain the scenario of the LPM case that Pete Heyrman found, and
that Nathan F. was working upon, previously.

In the scenario, the partition has 5 dedicated processors each with 8 threads
running.

From the PHYP data we can see that on VP 0, threads 3, 4, 5, 6 and 7 issued
a H_CEDE requesting to save energy by putting the requesting thread into
sleep mode.  In this state, the thread will only be awakened by H_PROD from
another running thread or from an external user action (power off, reboot
and such).  Timers and external interrupts are disabled in this mode.

About 3 seconds later, as part of the LPM operation, the other 35 threads
have all issued a H_JOIN request.  Join is part of the LPM process where
the threads suspend themselves as part of the LPM operation so the partition
can be migrated to the target server.

So, the current state is the the OS has suspended the execution of all the
threads in the partition without successfully suspending all threads as part
of LPM.

Net, OS has an issue where they suspended every processor thread so nothing
can run.

This appears to be slightly different than the previous LPM stalls we have
seen where the migration stalls because of cpus being taken offline and not
making the H_JOIN call.

In this scenario we appear to have CPUs that have done an H_CEDE prior to
the LPM. For these CPUs we would need to do a H_PROD to wake them back up
so they can do a H_JOIN and allow the LPM to continue.

The problem is that Linux has some threads that they put to sleep (probably
to save energy or something), LPM was attempted, Linux didn't awaken the
sleeping threads but issued the H_JOIN for the active threads.  Since the
sleeping threads don't issue the H_JOIN the partition will never suspend.

I am checking again with Pete regarding your concerns.

Thanks.

> 
> 
>> diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
>> index cff5a41..8292eff 100644
>> --- a/arch/powerpc/include/asm/plpar_wrappers.h
>> +++ b/arch/powerpc/include/asm/plpar_wrappers.h
>> @@ -26,10 +26,8 @@ static inline void set_cede_latency_hint(u8 latency_hint)
>>  	get_lppaca()->cede_latency_hint = latency_hint;
>>  }
>>  
>> -static inline long cede_processor(void)
>> -{
>> -	return plpar_hcall_norets(H_CEDE);
>> -}
>> +int cpu_is_ceded(int cpu);
>> +long cede_processor(void);
>>  
>>  static inline long extended_cede_processor(unsigned long latency_hint)
>>  {
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index de35bd8f..fea3d21 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -44,6 +44,7 @@
>>  #include <asm/time.h>
>>  #include <asm/mmu.h>
>>  #include <asm/topology.h>
>> +#include <asm/plpar_wrappers.h>
>>  
>>  /* This is here deliberately so it's only used in this file */
>>  void enter_rtas(unsigned long);
>> @@ -942,7 +943,7 @@ int rtas_ibm_suspend_me(u64 handle)
>>  	struct rtas_suspend_me_data data;
>>  	DECLARE_COMPLETION_ONSTACK(done);
>>  	cpumask_var_t offline_mask;
>> -	int cpuret;
>> +	int cpuret, cpu;
>>  
>>  	if (!rtas_service_present("ibm,suspend-me"))
>>  		return -ENOSYS;
>> @@ -991,6 +992,11 @@ int rtas_ibm_suspend_me(u64 handle)
>>  		goto out_hotplug_enable;
>>  	}
>>  
>> +	for_each_present_cpu(cpu) {
>> +		if (cpu_is_ceded(cpu))
>> +			plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
>> +	}
> 
> There's a race condition here, there's nothing to prevent the CPUs you
> just PROD'ed from going back into CEDE before you do the on_each_cpu()
> call below> 
>>  	/* Call function on all CPUs.  One of us will make the
>>  	 * rtas call
>>  	 */
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 41f62ca2..48ae6d4 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -331,6 +331,24 @@ static int alloc_dispatch_log_kmem_cache(void)
>>  }
>>  machine_early_initcall(pseries, alloc_dispatch_log_kmem_cache);
>>  
>> +static DEFINE_PER_CPU(int, cpu_ceded);
>> +
>> +int cpu_is_ceded(int cpu)
>> +{
>> +	return per_cpu(cpu_ceded, cpu);
>> +}
>> +
>> +long cede_processor(void)
>> +{
>> +	long rc;
>> +
>> +	per_cpu(cpu_ceded, raw_smp_processor_id()) = 1;
> 
> And there's also a race condition here. From the other CPU's perspective
> the store to cpu_ceded is not necessarily ordered vs the hcall below.
> Which means the other CPU can see cpu_ceded = 0, and therefore not prod
> us, but this CPU has already called H_CEDE.
> 
>> +	rc = plpar_hcall_norets(H_CEDE);
>> +	per_cpu(cpu_ceded, raw_smp_processor_id()) = 0;
>> +
>> +	return rc;
>> +}
>> +
>>  static void pseries_lpar_idle(void)
>>  {
>>  	/*
> 
> cheers
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

