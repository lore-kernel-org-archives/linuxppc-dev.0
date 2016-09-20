Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdS3v2GMPzDsfg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 12:52:59 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8K2mLR5019854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:52:56 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25jnxb74hx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 22:52:56 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 19 Sep 2016 20:52:55 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Update the FORCE_MAX_ZONEORDER range to
 enable hugetlb
In-Reply-To: <2d14a740-2345-99d0-4d7e-ae052d416f6d@gmail.com>
References: <1474306293-15390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <2d14a740-2345-99d0-4d7e-ae052d416f6d@gmail.com>
Date: Tue, 20 Sep 2016 08:22:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871t0fxoxr.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 20/09/16 03:31, Aneesh Kumar K.V wrote:
>> For hugetlb to work with 4K page size, we need the MAX_ORDER to be more
>> than 13. When switching from a 64K page size to 4K linux page size using
>> make nconfig, we endup with a CONFIG_FORCE_MAX_ZONEORDER value of 9.
>> This results in 16M hugepage to be considered as a gigantic huge page
>> which inturn can result in failure to setup hugepages if gigantic
>> hugepage support is not enabled.
>> 
>> This also results in kernel crash with 4K radix configuration. We
>> hit the below BUG_ON on radix
>> 
>>  kernel BUG at mm/huge_memory.c:364!
>>  Oops: Exception in kernel mode, sig: 5 [#1]
>>  SMP NR_CPUS=2048 NUMA PowerNV
>>  Modules linked in:
>>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc1-00006-gbae9cc6 #1
>>  task: c0000000f1af8000 task.stack: c0000000f1aec000
>>  NIP: c000000000c5fa0c LR: c000000000c5f9d8 CTR: c000000000c5f9a4
>>  REGS: c0000000f1aef920 TRAP: 0700   Not tainted (4.8.0-rc1-00006-gbae9cc6)
>>  MSR: 9000000102029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE,TM[E]>  CR: 24000844  XER: 00000000
>>  CFAR: c000000000c5f9e0 SOFTE: 1
>> .....
>>  NIP [c000000000c5fa0c] hugepage_init+0x68/0x238
>>  LR [c000000000c5f9d8] hugepage_init+0x34/0x238
>> 
>> Fixes: a7ee539584acf ("powerpc/Kconfig: Update config option based on page size")
>> 
>> Reported-by: Santhosh <santhog4@linux.vnet.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 927d2ab2ce08..792cb1768c8f 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -637,7 +637,7 @@ config FORCE_MAX_ZONEORDER
>>  	int "Maximum zone order"
>>  	range 8 9 if PPC64 && PPC_64K_PAGES
>>  	default "9" if PPC64 && PPC_64K_PAGES
>> -	range 9 13 if PPC64 && !PPC_64K_PAGES
>> +	range 13 13 if PPC64 && !PPC_64K_PAGES
>
> Do we need the range to be 12 13?

static inline bool hstate_is_gigantic(struct hstate *h)
{
	return huge_page_order(h) >= MAX_ORDER;
}

We consider hstate gigantic if it also == MAX_ORDER. Hence it should
be > 12 .

>
>>  	default "13" if PPC64 && !PPC_64K_PAGES
>>  	range 9 64 if PPC32 && PPC_16K_PAGES
>>  	default "9" if PPC32 && PPC_16K_PAGES
>> 
>
> Otherwise
>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
