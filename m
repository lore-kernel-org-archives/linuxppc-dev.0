Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swGlt3bsSzDt2c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 16:45:30 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i85so3073018pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:45:30 -0700 (PDT)
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
To: Nicholas Piggin <npiggin@gmail.com>
References: <20161013021714.6624-1-npiggin@gmail.com>
 <25f4c10b-c961-6ed4-f2e1-437bcfba5321@gmail.com>
 <20161014141610.418d0cc4@roar.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <e637b3ee-ffd1-97c0-9362-b163e74a0892@gmail.com>
Date: Fri, 14 Oct 2016 16:45:24 +1100
MIME-Version: 1.0
In-Reply-To: <20161014141610.418d0cc4@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/10/16 14:16, Nicholas Piggin wrote:
> Thanks Balbir and Gautham for testing and reviewing.
> 
> On Thu, 13 Oct 2016 22:54:32 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
>> On 13/10/16 13:17, Nicholas Piggin wrote:
>>> This patch does a couple of things. First of all, powernv immediately
>>> explodes when running a relocated kernel, because the system reset
>>> exception for handling sleeps does not do correct relocated branches.
>>>
>>> Secondly, the sleep handling code trashes the condition and cfar
>>> registers, which we would like to preserve for debugging purposes (for
>>> non-sleep case exception).  
>>
>> Agreed, that is a good side, we also save the PPR in r9 and set the
>> PPR to HMT_MEDIUM
>>
>>>
>>> This patch changes the exception to use the standard format that saves
>>> registers before any tests or branches are made. It adds the test for
>>> idle-wakeup as an "extra" to break out of the normal exception path.
>>> Then it branches to a relocated idle handler that calls the various
>>> idle handling functions.
>>>
>>> After this patch, POWER8 CPU simulator now boots powernv kernel that is
>>> running at non-zero.
>>>   
>>
>> Yep, a much required fixup. I had done a version before your changes
> 
> Yeah, I didn't mean to push ahead of your patch -- I was halfway through
> writing the register save patch when I realized yours did not get merged
> yet. Credit to you for originally finding and fixing it.
> 

No problems with that

>>
>>> Cc: Balbir Singh <bsingharora@gmail.com>
>>> Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>>> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>  arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++
>>>  arch/powerpc/kernel/exceptions-64s.S     | 50 ++++++++++++++++++--------------
>>>  2 files changed, 45 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
>>> index 2e4e7d8..84d49b1 100644
>>> --- a/arch/powerpc/include/asm/exception-64s.h
>>> +++ b/arch/powerpc/include/asm/exception-64s.h
>>> @@ -93,6 +93,10 @@
>>>  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
>>>  	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
>>>  
>>> +#define __LOAD_HANDLER(reg, label)					\  
>>
>> I wonder if it is a good idea to trap
>>
>> .if (reg == 13);
>> .error "Don't use r13";
>> .abort;
>> .endif;
> 
> Well... I guess checking is always nice, but r13 is taboo for anything but paca
> for virtually all assembly in the kernel. So I don't know if the benefit is very
> large.
> 

The thing with macros that take arguments is that there is no indication whats
OK and whats not. You are right r13 is taboo, but we could probably still use
r13 and do a GET_PACA() later, like we did earlier, so lets drop this

> Now a scripted test to check the objdump might be nice. You could whitelist the few
> places that set r13, and then give errors for any other code that sets it.
>  

Good idea

Balbir Singh
