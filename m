Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-yw0-x22f.google.com (mail-yw0-x22f.google.com
 [IPv6:2607:f8b0:4002:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzBFQ63HvzDqKd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 15:33:14 +1000 (AEST)
Received: by mail-yw0-x22f.google.com with SMTP id v76so15542840ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Apr 2017 22:33:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87efx9kkiv.fsf@possimpible.ozlabs.ibm.com>
References: <20170330051313.31358-1-matthew.brown.dev@gmail.com>
 <877f31n2mn.fsf@possimpible.ozlabs.ibm.com>
 <87wpb1kvy7.fsf@possimpible.ozlabs.ibm.com>
 <CAPoR37YvxSKnerVMPEVE1FzjjT6O6z8sNVsHw_PrWdsVtyEaMA@mail.gmail.com>
 <87efx9kkiv.fsf@possimpible.ozlabs.ibm.com>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Thu, 6 Apr 2017 15:33:12 +1000
Message-ID: <CAPoR37aZ=VihOBiVJUgj0ToJjYWoipTfnfDOe=wxa1LPwyZ2mw@mail.gmail.com>
Subject: Re: [PATCH] raid6/altivec: adding vpermxor implementation for raid6 Q
 syndrome
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

Just to respond to your comments,

The inline asm line cannot be formatted over multiple lines due to the
unrolling process, but we can take out the volatile.

The pagefault_disable() also seems to be an old method of disabling
preemption, but no longer actually works to disable preemption.
Preempt_disable should be used instead now. So the use of
pagefault_disable() in crc32d-vpmsum_glue.c is actually a bug.

Thanks,
Matt

On Tue, Apr 4, 2017 at 11:51 AM, Daniel Axtens <dja@axtens.net> wrote:
> Hi Matt,
>
>> Woops, totally missed that big chunk of makefile in the commit.
>> I had a chat with Oliver last week about the backwards compatibility stuff.
>> This will work for all versions >= 207S.
>>
>> From what I can tell there is almost no difference between
>> pagefault_disable() and preempt_disable(), but I'll follow that up
>> when I'm in the office next.
>
> Cool, good to know.
>
> See you when you're next in!
>
> Regards,
> Daniel
>
>>
>> Thanks for the review,
>>
>> Matt
>>
>> On Tue, Apr 4, 2017 at 7:44 AM, Daniel Axtens <dja@axtens.net> wrote:
>>>> In that function, the flow is:
>>>>  pagefault_disable();
>>>>  enable_kernel_altivec();
>>>>  <vectorised function>
>>>>  pagefault_enable();
>>>>
>>>> There are a few things that it would be nice (but by no means essential)
>>>> to find out:
>>>>  - what is the difference between pagefault and prempt enable/disable
>>>>  - is it required to disable altivec after the end of the function or
>>>>    can we leave that enabled?
>>>
>>> Answering my own question here, dc4fbba11e46 ("powerpc: Create
>>> disable_kernel_{fp,altivec,vsx,spe}()") adds the disable_ function, and
>>> it's a no-op except under debug conditions. So it should stay.
>>>
>>> Regards,
>>> Daniel
>>>
>>>
>>>>
>>>>> +
>>>>> +int raid6_have_altivec_vpermxor(void);
>>>>> +#if $# == 1
>>>>> +int raid6_have_altivec_vpermxor(void)
>>>>> +{
>>>>> +    /* Check if CPU has both altivec and the vpermxor instruction*/
>>>> Please add a space: s|ion*/|ion */|
>>>>> +# ifdef __KERNEL__
>>>>> +    return (cpu_has_feature(CONFIG_ALTIVEC) &&
>>>>> +            cpu_has_feature(CPU_FTR_ARCH_207S));
>>>> I assume this is future-proof - an ISA 3.00 cpu will advertise 2.07S
>>>> compat?
>>>>
>>>>> +# else
>>>>> +    return 1;
>>>>> +#endif
>>>>> +
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> +const struct raid6_calls raid6_vpermxor$# = {
>>>>> +    raid6_vpermxor$#_gen_syndrome,
>>>>> +    NULL,
>>>>> +    raid6_have_altivec_vpermxor,
>>>>> +    "vpermxor$#",
>>>>> +    0
>>>>> +};
>>>>> +#endif
>>>>> --
>>>>> 2.9.3
>>>>
>>>> Apart from that this patch looks good and I expect I will be able to
>>>> formally Review v2.
>>>>
>>>> Regards,
>>>> Daniel
