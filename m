Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSnNw5RyszDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 17:23:12 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1M6MacR092537
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 01:23:10 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rxkw4wd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 01:23:10 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 23:23:09 -0700
Subject: Re: [PATCH] powerpc/mm/hash: Always clear UPRT and Host Radix bits
 when setting up CPU
To: Balbir Singh <bsingharora@gmail.com>
References: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170222061650.GC9967@balbir.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 11:53:01 +0530
MIME-Version: 1.0
In-Reply-To: <20170222061650.GC9967@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3c5f2f33-f7fc-1dca-b28b-7ea20a72cf9e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 February 2017 11:46 AM, Balbir Singh wrote:
> On Wed, Feb 22, 2017 at 10:42:02AM +0530, Aneesh Kumar K.V wrote:
>> We will set LPCR with correct value for radix during int. This make sure we
>> start with a sanitized value of LPCR. In case of kexec, cpus can have LPCR
>> value based on the previous translation mode we were running.
>>
>> Fixes: fe036a0605d60 ("powerpc/64/kexec: Fix MMU cleanup on radix")
>> Cc: stable@vger.kernel.org # v4.9+
>> Acked-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/kernel/cpu_setup_power.S | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
>> index 917188615bf5..7fe8c79e6937 100644
>> --- a/arch/powerpc/kernel/cpu_setup_power.S
>> +++ b/arch/powerpc/kernel/cpu_setup_power.S
>> @@ -101,6 +101,8 @@ _GLOBAL(__setup_cpu_power9)
>>   	mfspr	r3,SPRN_LPCR
>>   	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
>>   	or	r3, r3, r4
>> +	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
>> +	andc	r3, r3, r4
>>   	bl	__init_LPCR
>>   	bl	__init_HFSCR
>>   	bl	__init_tlb_power9
>> @@ -122,6 +124,8 @@ _GLOBAL(__restore_cpu_power9)
>>   	mfspr   r3,SPRN_LPCR
>>   	LOAD_REG_IMMEDIATE(r4, LPCR_PECEDH | LPCR_PECE_HVEE | LPCR_HVICE)
>>   	or	r3, r3, r4
>> +	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT | LPCR_HR)
>> +	andc	r3, r3, r4
>>   	bl	__init_LPCR
>>   	bl	__init_HFSCR
>>   	bl	__init_tlb_power9
> What about LPCR_GTSE and other bits?
>
>

That is set by the hypervisor for guest. We don't set that and expect to 
inherit that from
a previous run for baremetal. Also setting that in the context of LPID 0 
shouldn't have
any impact.

-aneesh
