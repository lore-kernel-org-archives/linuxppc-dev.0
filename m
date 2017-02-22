Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSnnR1TR6zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 17:40:58 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1M6dHmG079108
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 01:40:56 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28s2nx5ggq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 01:40:56 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 23:40:55 -0700
Subject: Re: [PATCH] powerpc/mm/hash: Always clear UPRT and Host Radix bits
 when setting up CPU
To: Balbir Singh <bsingharora@gmail.com>
References: <1487740322-17755-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170222062406.GD9967@balbir.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 12:10:42 +0530
MIME-Version: 1.0
In-Reply-To: <20170222062406.GD9967@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <b7e91d3c-d5d1-cc6e-c052-a6d764ced021@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 February 2017 11:54 AM, Balbir Singh wrote:
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
> My previous comment mentions GTSE, but really we should be clearing
> LPCR to 0 and setting it to sane values in __init_LPCR
>
>
IIUC we do want to inherit values from firmware/skiboot. Hence the
explicit usage of mfspr/or. What we want to clear here are values we 
updated/changed
based on translation mode.

-aneesh
