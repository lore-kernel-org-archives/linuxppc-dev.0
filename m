Return-Path: <sachinp@in.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D920DDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 15:14:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4N5Ev2W000699
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 01:14:57 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4N5DuOX475790
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 01:13:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4N5DuV1027688
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 01:13:56 -0400
Message-ID: <4653CDAB.2060407@in.ibm.com>
Date: Wed, 23 May 2007 10:44:19 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [Patch 2/2] Kexec/Kdump support POWER6
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
In-Reply-To: <20070522153419.GA22047@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, ellerman@au1.ibm.com,
	Milton Miller II <miltonm@us.ibm.com>
Reply-To: sachinp@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olof, thanks for the review. 

>> +	if (have_vrma)
>> +		pSeries_find_hpte_vrma();
>> +
>>     
>
> This will break kexec builds on non-pseries. It's referring to platform
> code that might not be built.
>
>   
Ok. Will call this function from lpar.c instead of
default_machine_kexec().

> Does this function find the vrma, or save it away? Seems like the name
> is misleading.
>
>   
Well it finds a vrma entry and saves it. I thought of
pSeries_find_save_hpte_vrma(), but decided against it. I could
change it to pSeries_save_hpte_vrma().

> Is ppc64_vrma_page_size really the size, or the shift? Above would
> indicate that it's really a shift value.
>
>   
It is a shift. I will change it to ppc64_vrma_page_shift.

> Why is 16M hardcoded here, when you're taking such great care to read
> out the pagesize earlier?
>
>   
Hrmm. Ok will use the vrma_page_shift value.

>> +			((dword0 & HPTE_V_MASK) == MAGIC_SKIP_HPTE)) {
>>     
> Indentation
>   
Done.

>> +				/* store the hpte */
>> +				hpte_vrma_slots[num_hpte_vrma_slots++] = slot;
>>     
>
> Here you rely on global exported state (num_hpte_vrma_slots), increasing it without
> checking for limits. What happens if this function is ever called twice? Should you
> set it to 0 in the beginning of the function and check it against the size of the
> hpte_vrma_slots array instead?
>   
Will add proper checks for num_hpte_vrma_slots variable value.

>> +extern void pSeries_find_hpte_vrma(void);
>>
>>     
> Same comment as above: This isn't a kexec function as much as a pseries function, so
> it should be defined in some other header instead.
>   
>>  
>> +#define HPTE_V_RMA_VPN         ASM_CONST(0x001FFFFFF0000000)
>> +#define HPTE_V_MASK            ASM_CONST(0xc000000000000000)
>> +#define MAGIC_SKIP_HPTE        ASM_CONST(0x4000000000000000)
>> +#define HPTE_V_RMA_NUM         16
>>     
>
> "MAGIC_SKIP_HPTE"? I'm sure there's a proper name for this field in the
> PAPR, isn't there? Also, HPTE_V_RMA_NUM isn't a HPTE_V field, it shouldn't
> have that prefix. It's not a property of the mmu in the first place.
>
> These should maybe be local defines in the pseries lpar code instead, since it's
> more of a lpar<->phyp interface than mmu programming interface.
>   
Will move them to pseries lpar code.
Updated patch on its way.

Thanks
-Sachin
