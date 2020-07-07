Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E8C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 11:02:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1CBF206DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 11:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CBF206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1KJy4vTdzDqpq
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 21:02:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1KFd6R5PzDqWF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 20:59:33 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 067Aa9qk084031; Tue, 7 Jul 2020 06:59:28 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 322nuntncp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 06:59:27 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067AtIdl009966;
 Tue, 7 Jul 2020 10:59:26 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02dal.us.ibm.com with ESMTP id 322hd94utq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 10:59:26 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 067AxPPl7209258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2020 10:59:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8B98B205F;
 Tue,  7 Jul 2020 10:59:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80AEEB2064;
 Tue,  7 Jul 2020 10:59:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.118.59])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2020 10:59:23 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] powerpc/perf/hv-24x7: Add cpu hotplug support
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20200626102824.270923-1-kjain@linux.ibm.com>
 <20200626102824.270923-2-kjain@linux.ibm.com>
 <87zh8d5oab.fsf@mpe.ellerman.id.au>
From: kajoljain <kjain@linux.ibm.com>
Message-ID: <03a3af5c-5d04-8c55-5597-d231f0ab014b@linux.ibm.com>
Date: Tue, 7 Jul 2020 16:29:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87zh8d5oab.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-07_06:2020-07-07,
 2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0
 cotscore=-2147483648 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070077
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
Cc: nathanl@linux.ibm.com, ego@linux.vnet.ibm.com, suka@us.ibm.com,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 7/6/20 8:43 AM, Michael Ellerman wrote:
> Kajol Jain <kjain@linux.ibm.com> writes:
>> Patch here adds cpu hotplug functions to hv_24x7 pmu.
>> A new cpuhp_state "CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE" enum
>> is added.
>>
>> The online callback function updates the cpumask only if its
>> empty. As the primary intention of adding hotplug support
>> is to designate a CPU to make HCALL to collect the
>> counter data.
>>
>> The offline function test and clear corresponding cpu in a cpumask
>> and update cpumask to any other active cpu.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/perf/hv-24x7.c | 45 +++++++++++++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h  |  1 +
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
>> index db213eb7cb02..ce4739e2b407 100644
>> --- a/arch/powerpc/perf/hv-24x7.c
>> +++ b/arch/powerpc/perf/hv-24x7.c
>> @@ -31,6 +31,8 @@ static int interface_version;
>>  /* Whether we have to aggregate result data for some domains. */
>>  static bool aggregate_result_elements;
>>  
>> +static cpumask_t hv_24x7_cpumask;
>> +
>>  static bool domain_is_valid(unsigned domain)
>>  {
>>  	switch (domain) {
>> @@ -1641,6 +1643,44 @@ static struct pmu h_24x7_pmu = {
>>  	.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>>  };
>>  
>> +static int ppc_hv_24x7_cpu_online(unsigned int cpu)
>> +{
>> +	/* Make this CPU the designated target for counter collection */
> 
> The comment implies every newly onlined CPU will become the target, but
> actually it's only the first onlined CPU.
> 
> So I think the comment needs updating, or you could just drop the
> comment, I think the code is fairly clear by itself.

Hi Michael,
   Thanks for reviewing the patch. Sure I will update it accordingly.

> 
>> +	if (cpumask_empty(&hv_24x7_cpumask))
>> +		cpumask_set_cpu(cpu, &hv_24x7_cpumask);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ppc_hv_24x7_cpu_offline(unsigned int cpu)
>> +{
>> +	int target = -1;
> 
> No need to initialise target, you assign to it unconditionally below.

Ok Will change.

> 
>> +	/* Check if exiting cpu is used for collecting 24x7 events */
>> +	if (!cpumask_test_and_clear_cpu(cpu, &hv_24x7_cpumask))
>> +		return 0;
>> +
>> +	/* Find a new cpu to collect 24x7 events */
>> +	target = cpumask_last(cpu_active_mask);
> 
> Any reason to use cpumask_last() vs cpumask_first(), or a randomly
> chosen CPU?

Incase we sequentially offline multiple cpus, taking cpumask_first() may add some latency in
that scenario.

So, I was trying to test benchmark in power9 lpar with 16 cpu, by off-lining cpu 0-14

With cpumask_last: This is what I got.

real	0m2.812s
user	0m0.002s
sys	0m0.003s

With cpulast_any:
real	0m3.690s
user	0m0.002s
sys	0m0.062s

That's why I just went with cpumask_last thing. Please Let me know if any changes required.

> 
>> +	if (target < 0 || target >= nr_cpu_ids)
>> +		return -1;
>> +
>> +	/* Migrate 24x7 events to the new target */
>> +	cpumask_set_cpu(target, &hv_24x7_cpumask);
>> +	perf_pmu_migrate_context(&h_24x7_pmu, cpu, target);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hv_24x7_cpu_hotplug_init(void)
>> +{
>> +	return cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
>> +			  "perf/powerpc/hv_24x7:online",
>> +			  ppc_hv_24x7_cpu_online,
>> +			  ppc_hv_24x7_cpu_offline);
>> +}
>> +
>>  static int hv_24x7_init(void)
>>  {
>>  	int r;
>> @@ -1685,6 +1725,11 @@ static int hv_24x7_init(void)
>>  	if (r)
>>  		return r;
>>  
>> +	/* init cpuhotplug */
>> +	r = hv_24x7_cpu_hotplug_init();
>> +	if (r)
>> +		pr_err("hv_24x7: CPU hotplug init failed\n");
>> +
> 
> The hotplug initialisation shouldn't fail unless something is badly
> wrong. I think you should just fail initialisation of the entire PMU if
> that happens, which will make the error handling in the next patch much
> simpler.
> 

I will update it.

Thanks,
Kajol Jain
> cheers
> 
>>  	r = perf_pmu_register(&h_24x7_pmu, h_24x7_pmu.name, -1);
>>  	if (r)
>>  		return r;
