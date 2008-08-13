Return-Path: <mohan@in.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A9C4DE0A3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 04:22:28 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7DIMNYm002003
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 14:22:23 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7DIMNw9181584
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 12:22:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7DIMMdP018402
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 12:22:23 -0600
Message-ID: <48A3265A.4070008@in.ibm.com>
Date: Wed, 13 Aug 2008 23:52:18 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Relocation support
References: <20080811201120.GA25283@in.ibm.com>
	<20080811201644.GD26566@in.ibm.com>
	<20080812081103.GD19619@in.ibm.com>
	<18594.28433.827798.249177@cargo.ozlabs.ibm.com>
In-Reply-To: <18594.28433.827798.249177@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Mohan Kumar M writes:
>
Hi Paul,

Thanks for your comments.

I will update the patches as per your comment and will give a detailed 
description for each patch.

Regards,
Mohan.


> 
>>  static inline int in_kernel_text(unsigned long addr)
>>  {
>> -	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
>> +	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end
>> +								+ kernel_base)
> 
> Your patch adds kernel_base to some addresses but not to all of them,
> so your patch description should have told us why you added it in the
> those places and not others.  If you tell us the general principle
> you're following (even if it seems obvious to you) it will be useful
> to people chasing bugs or adding new code later on, or even just
> trying to understand what the code does.
> 
>> -	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
>> +#ifndef CONFIG_RELOCATABLE_PPC64
>> + 	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000);
>> +#else
>> +	RELOC(alloc_bottom) = PAGE_ALIGN((unsigned long)&RELOC(_end) + 0x4000 +
>> +							RELOC(reloc_delta));
>> +#endif
> 
> Ifdefs in code inside a function are frowned upon in the Linux
> kernel.  Try to find an alternative way to do this, such as ensuring
> that reloc_delta is 0 when CONFIG_RELOCATABLE_PPC64 is not set.
> Also it's not clear (to me at least) why you need to add reloc_data in
> the relocatable case.
> 
>> +#ifndef CONFIG_RELOCATABLE_PPC64
>>  	unsigned long *spinloop
>>  		= (void *) LOW_ADDR(__secondary_hold_spinloop);
>>  	unsigned long *acknowledge
>>  		= (void *) LOW_ADDR(__secondary_hold_acknowledge);
>> +#else
>> +	unsigned long *spinloop
>> +		= (void *) &__secondary_hold_spinloop;
>> +	unsigned long *acknowledge
>> +		= (void *) &__secondary_hold_acknowledge;
>> +#endif
> 
> This also needs some explanation.  (Put it in the patch description or
> in a comment in the code, not in a reply to this mail. :)
> 
>> +#ifndef CONFIG_RELOCATABLE_PPC64
>>  	ld	r4,htab_hash_mask@got(2)
>> +#else
>> +	LOAD_REG_IMMEDIATE(r4,htab_hash_mask)
>> +#endif
>>  	ld	r27,0(r4)	/* htab_hash_mask -> r27 */
> 
> Here and in the other similar places, I would prefer you just changed
> it to LOAD_REG_ADDR and not have any ifdef.
> 
> Paul.
