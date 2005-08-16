Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 797F067F33
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Aug 2005 23:36:39 +1000 (EST)
Message-ID: <4301EBE5.8030003@ru.mvista.com>
Date: Tue, 16 Aug 2005 17:36:37 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42FCCEA4.2030409@ru.mvista.com>
	<725685C1-2B6B-4B19-A1E9-D68AB21AFEAF@freescale.com>
In-Reply-To: <725685C1-2B6B-4B19-A1E9-D68AB21AFEAF@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] identify_ppc_sys_by_name_and_id function implementation
 final
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Aug 12, 2005, at 11:30 AM, Vitaly Bordug wrote:
> 
>> Kumar Gala wrote:
>>
>>> Can you do a sizeof instead?
>>>
>>> #define num_ele sizeof(ppc_sys_specs[])/sizeof(struct ppc_sys_spec)
>>>
>>> Something like matchted[num_ele] ??
>>>
>>>
>>
>> That's what the first I tried actually :)
>> gcc is not happy with it:
>>
>> arch/ppc/syslib/ppc_sys.c: In function `find_chip_by_name_and_id':
>> arch/ppc/syslib/ppc_sys.c:54: error: parse error before ']' token
>>
>> and if I remove [] from the ppc_sys_specs, it outputs:
>>
>> arch/ppc/syslib/ppc_sys.c: In function `find_chip_by_name_and_id':
>> arch/ppc/syslib/ppc_sys.c:54: error: invalid application of  `sizeof' to
>> incomplete type `({anonymous})'
>>
>> So I cannot use sizeof this case, I think...
> 
> 
> Realized the same thing.  I'm thinking that your original method is  the 
> best solution to just do this on the stack.  In general the  number or 
> processors (array size) is going to be less than 100.  So  at most this 
> array is going to end up being 100 bytes on the stack.   I dont think 
> that's a big deal at the point we are calling this
> 
Thus, are there any modifications needed for the original approach?
Or maybe it's simpler to add say MAX_PPC_SPECS to ppc_sys.h since this 
list will be limited anyway? We could have the simple array with static 
size then, and additional ppc_sys_specs sanity check (whether it has 
"default" element with both 0 id and "" name) could be easily 
implemented as well.


-- 
Sincerely,
Vitaly
