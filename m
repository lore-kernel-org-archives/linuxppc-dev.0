Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW24c1ZWDzDqh5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 14:02:23 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7E3wnEj098470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 00:02:19 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ca0q6dju6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 00:02:18 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 14 Aug 2017 14:02:16 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7E40oU435061818
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 14:00:58 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7E40Qhb032038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 14:00:26 +1000
Subject: Re: [PATCH] powerpc/perf: double unlock bug in
 imc_common_cpuhp_mem_free()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
References: <20170811200541.qlxcpp3og33sdki3@mwanda>
 <87bmnisu5a.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 09:30:00 +0530
MIME-Version: 1.0
In-Reply-To: <87bmnisu5a.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e2f2122b-87b8-6b01-607b-d00da4fc6b09@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 14 August 2017 09:00 AM, Michael Ellerman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
>
>> There is a typo so we call unlock instead of lock.
>>
>> Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> I also don't understand how the &nest_imc_refc[node_id].lock works.  Why
>> can't we use ref->lock everywhere?  They seem equivalent, and my static
>> checker complains if we call the same lock different names.
> That looks like a bug to me, ie. we should always use ref.

ok. will send a fix.

Thanks
Maddy

>
> Maddy?
>
> cheers
>
>> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
>> index 46cd912af060..52017f6eafd9 100644
>> --- a/arch/powerpc/perf/imc-pmu.c
>> +++ b/arch/powerpc/perf/imc-pmu.c
>> @@ -1124,7 +1124,7 @@ static void cleanup_all_thread_imc_memory(void)
>>   static void imc_common_cpuhp_mem_free(struct imc_pmu *pmu_ptr)
>>   {
>>   	if (pmu_ptr->domain == IMC_DOMAIN_NEST) {
>> -		mutex_unlock(&nest_init_lock);
>> +		mutex_lock(&nest_init_lock);
>>   		if (nest_pmus == 1) {
>>   			cpuhp_remove_state(CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE);
>>   			kfree(nest_imc_refc);
