Return-Path: <chengang@emindsoft.com.cn>
Received: from out1134-234.mail.aliyun.com (out1134-234.mail.aliyun.com
 [42.120.134.234])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rpp0y4XC2zDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 02:52:34 +1000 (AEST)
Message-ID: <57852093.1090909@emindsoft.com.cn>
Date: Wed, 13 Jul 2016 00:53:39 +0800
From: Chen Gang <chengang@emindsoft.com.cn>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org
CC: tglx@linutronix.de, mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] include: mman: Use bool instead of int for the return
 value of arch_validate_prot
References: <1468081751-9468-1-git-send-email-chengang@emindsoft.com.cn>
 <5782DEA5.600@linux.intel.com> <5783ED17.9010805@emindsoft.com.cn>
 <878tx7cwsn.fsf@@concordia.ellerman.id.au>
In-Reply-To: <878tx7cwsn.fsf@@concordia.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/12/16 12:20, Michael Ellerman wrote:
> Chen Gang <chengang@emindsoft.com.cn> writes:
> 
>> On 7/11/16 07:47, Dave Hansen wrote:
>>> On 07/09/2016 09:29 AM, chengang@emindsoft.com.cn wrote:
>>>> -static inline int arch_validate_prot(unsigned long prot)
>>>> +static inline bool arch_validate_prot(unsigned long prot)
>>>>  {
>>>>  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
>>>> -		return 0;
>>>> -	if ((prot & PROT_SAO) && !cpu_has_feature(CPU_FTR_SAO))
>>>> -		return 0;
>>>> -	return 1;
>>>> +		return false;
>>>> +	return (prot & PROT_SAO) == 0 || cpu_has_feature(CPU_FTR_SAO);
>>>>  }
>>>>  #define arch_validate_prot(prot) arch_validate_prot(prot)
>>>
>>> Please don't do things like this.  They're not obviously correct and
>>> also have no obvious benefit.  You also don't mention why you bothered
>>> to alter the logical structure of these checks.
>>>
>>
>> For all cases, bool is equal or a little better than int, and they are
>> equal in our case (2 final outputs are same). So for me, it may belong
>> to trivial patch, which can be skipped by the normal patch maintainers.
>>
>> As a 'trivial' patch:
>>
>>  - For a pure Boolean function, bool return value is more readable than
>>    int.
> 
> Agreed.
> 
> Please send a patch that does that and only that.
> 

OK, thanks.

After check the assembly output, for some cases, merging 3 lines to 1
line may be a little more readable, but compiler will generate a little
bad output code.

I shall send patch v2 for it within this weekend.

Thanks.
-- 
Chen Gang (陈刚)

Managing Natural Environments is the Duty of Human Beings.
