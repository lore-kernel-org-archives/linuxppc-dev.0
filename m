Return-Path: <brking@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF06ADDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 07:25:09 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9LKP5EB023711
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 16:25:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9LKP0al137562
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 16:25:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9LKP0k1019537
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 16:25:00 -0400
Message-ID: <48FE3A84.2070207@linux.vnet.ibm.com>
Date: Tue, 21 Oct 2008 15:24:36 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [1/1] powerpc: Update page in counter for CMM
References: <200810210436.m9L4aepT056796@sullivan.realtime.net>
In-Reply-To: <200810210436.m9L4aepT056796@sullivan.realtime.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> X-Patchwork-Id: 5144
>> diff -puN arch/powerpc/mm/fault.c~powerpc_vrm_mm_pressure arch/powerpc/mm/fault.c
>> --- linux-2.6/arch/powerpc/mm/fault.c~powerpc_vrm_mm_pressure	2008-10-20 17:13:25.000000000 -0500
>> +++ linux-2.6-bjking1/arch/powerpc/mm/fault.c	2008-10-20 17:13:25.000000000 -0500
> ..
>> @@ -318,9 +320,11 @@ good_area:
>>  			goto do_sigbus;
>>  		BUG();
>>  	}
>> -	if (ret & VM_FAULT_MAJOR)
>> +	if (ret & VM_FAULT_MAJOR) {
>>  		current->maj_flt++;
>> -	else
>> +		if (firmware_has_feature(FW_FEATURE_CMO))
>> +			atomic_inc((atomic_t *)(&(get_lppaca()->page_ins)));
>> +	} else
>>  		current->min_flt++;
>>  	up_read(&mm->mmap_sem);
>>  	return 0;
> 
> (1) why do we need atomic_inc and the hundreds or thousands of cycles to
> do the atomic inc in a per-cpu area?

We don't. I've now removed it.

> (2) assuming we make this a normal increment, should we keep the
> feature test or just do it unconditionally (ie is the additional load
> and branch worse that just doing the load and store of the counter --
> the address was previously reserved, right?  (no question if
> it has to be atomic).

Simplified patch on the way...

> <Ramble things one might consider>
> 
> Ben asked if we need to worry about the hypervisor clearing the
> count.  If they treat it as a only-incrementing then we don't need
> to worry.  And since its only an indicator, then we may not care
> about a big count by them interrupting between the load and store

This is a read only field from the hypervisor's perspective. They
shouldn't be clearing it.

> If we are worried about linux preemption, then we need to disable
> it to avoid crossing cpu variables or  getting to this point multiple
> times.  (I have not looked at the context to see if we are already
> disabled).

Looks to me like linux preemption is a possibility in this code, so
I've added the code to disable preemption around the increment.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
