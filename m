Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqq4n4CXxzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 18:44:25 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6E8iLne111839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 04:44:23 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452yqnack-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 04:44:22 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 14 Jul 2016 02:43:53 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: bsingharora@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 12/12] powerpc/mm/radix: Add a kernel command line
 to disable radix
In-Reply-To: <20160714050259.GJ18277@balbir.ozlabs.ibm.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160714050259.GJ18277@balbir.ozlabs.ibm.com>
Date: Thu, 14 Jul 2016 14:13:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h9bsmwxr.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On Wed, Jul 13, 2016 at 03:05:31PM +0530, Aneesh Kumar K.V wrote:
>> This patch adds the kernel command line disable_radix which disable
>> the radix MMU mode even if firmware indicates radix support via
>> ibm,pa-features device tree node.
>> 
>> This helps in testing different MMU mode easily.
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  Documentation/kernel-parameters.txt |  3 +++
>>  arch/powerpc/kernel/prom.c          | 13 +++++++++++++
>>  2 files changed, 16 insertions(+)
>> 
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 738bae4a5958..bba7ef30d74e 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -929,6 +929,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>  	disable=	[IPV6]
>>  			See Documentation/networking/ipv6.txt.
>>  
>> +	disable_radix	[PPC]
>> +			Disable RADIX MMU mode on POWER9
>> +
>>  	disable_cpu_apicid= [X86,APIC,SMP]
>>  			Format: <int>
>>  			The number of initial APIC ID for the
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 946e34ffeae9..022540b9366d 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -645,6 +645,14 @@ static void __init early_reserve_mem(void)
>>  #endif
>>  }
>>  
>> +static bool disable_radix;
>
> __read_mostly?

We actually read it only once.

>
>> +static int __init parse_disable_radix(char *p)
>> +{
>> +	disable_radix = true;
>> +	return 0;
>> +}
>> +early_param("disable_radix", parse_disable_radix);
>> +
>>  void __init early_init_devtree(void *params)
>>  {
>>  	phys_addr_t limit;
>> @@ -739,6 +747,11 @@ void __init early_init_devtree(void *params)
>>  	/* Scan and build the list of machine check recoverable ranges */
>>  	of_scan_flat_dt(early_init_dt_scan_recoverable_ranges, NULL);
>>  #endif
>> +	/*
>> +	 * now fixup radix MMU mode based on kernel command line
>> +	 */
>> +	if (disable_radix)
>> +		cur_cpu_spec->mmu_features &= ~MMU_FTR_RADIX;
>
> Shouldn't this happen before prom_init() and exchanging capabilities?

Didn't get that. We actually set the FTR_RADIX in
check_cpu_pa_features(node) which is called via
of_scan_flat_dt(early_init_dt_scan_cpus, NULL); We clear that
immediately after if the feature is disabled via kernel command line.

-aneesh
