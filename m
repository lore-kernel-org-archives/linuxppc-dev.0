Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYhYj4bgdzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 05:01:45 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 04:01:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C4A6B3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 05:01:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2SI1XoS9240942
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 05:01:41 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2SI18La004136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 05:01:09 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
In-Reply-To: <8737rau3b7.fsf@linux.vnet.ibm.com>
References: <3qWf364wYxz9sDG@ozlabs.org> <8737rau3b7.fsf@linux.vnet.ibm.com>
Date: Mon, 28 Mar 2016 23:30:49 +0530
Message-ID: <87poueo52m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> [ text/plain ]
> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> [ text/plain ]
>> On Fri, 2016-18-03 at 04:01:21 UTC, Andrew Donnellan wrote:
>>> When handling page faults, cxl_handle_page_fault() checks whether the page
>>> should be accessible by userspace and have its _PAGE_USER access bit set.
>>> _PAGE_USER should be set if the context's kernel flag isn't set, or if the
>>> page falls outside of kernel memory.
>>> 
>>> However, the check currently uses the wrong operator, causing it to always
>>> evalute to true. As such, we always set the _PAGE_USER bit, even when it
>>> should be restricted to the kernel.
>>> 
>>> Fix the check so that the _PAGE_USER bit is set only as intended.
>>> 
>> ..
>>> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
>>> index 9a8650b..a76cb8a 100644
>>> --- a/drivers/misc/cxl/fault.c
>>> +++ b/drivers/misc/cxl/fault.c
>>> @@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>>>  	access = _PAGE_PRESENT;
>>>  	if (dsisr & CXL_PSL_DSISR_An_S)
>>>  		access |= _PAGE_RW;
>>> -	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
>>> +	if ((!ctx->kernel) || !(dar & (1ULL << 63)))
>>>  		access |= _PAGE_USER;
>>
>> I think you can (should) use is_kernel_addr() for the DAR check.
>>
>> I'm also slightly worried by that logic in the case of a non-kernel context.
>>
>> ie. if ctx->kernel is false, we get:
>>
>> 	if (true || !is_kernel_addr(dar))
>>  		access |= _PAGE_USER;
>>
>> Which means we just add _PAGE_USER for any address. What am I missing here?
>
> I noticed this when doing radix support and have a variant posted at
>
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-March/141036.html
>

My change also keep it similar to __hash_page.

	/*
	 * We need to set the _PAGE_USER bit if MSR_PR is set or if we are
	 * accessing a userspace segment (even from the kernel). We assume
	 * kernel addresses always have the high bit set.
	 */
	if ((msr & MSR_PR) || (REGION_ID(ea) == USER_REGION_ID))

If we need this change to go in this merge window i can respin my patch.

-aneesh
