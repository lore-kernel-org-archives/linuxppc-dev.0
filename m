Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC3C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:12:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903F42183F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="GSc5AOH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903F42183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K5hG0ZSxzDqK3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="GSc5AOH+"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K5fV2KvQzDq6Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 20:10:42 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44K5fP37Q5z9v0NH;
 Wed, 13 Mar 2019 10:10:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=GSc5AOH+; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id J42xVLdnR4Pk; Wed, 13 Mar 2019 10:10:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44K5fP1spKz9v0N6;
 Wed, 13 Mar 2019 10:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552468237; bh=AwOtVJKRSmLCc/uOSmPUkXnjvWBp1GwuwYrRyp7BnVA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GSc5AOH+BF/r7BNN24RBbS0YJzNOZzKJItd5GTD0Y3Z9X3ebPKOp0N42Ze4+RAk/V
 n64jzCduUW4O9EjPvivu8l+d9eA0yhH3AaJ1rYds+Zdz/KrpUnB3id5x4EB6Nq1p9+
 5hyXmy5ozLl8aise2tAWzLTCO6aZ6tNZvNvhWwro=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4C2528B8FA;
 Wed, 13 Mar 2019 10:10:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id oBeo66qug2fX; Wed, 13 Mar 2019 10:10:38 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C1D8E8B8EE;
 Wed, 13 Mar 2019 10:10:37 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/mm: move warning from resize_hpt_for_hotplug()
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
References: <20190308105413.4302-1-lvivier@redhat.com>
 <3db6b64d-02d3-8aa7-80ca-3e469ea743ff@c-s.fr>
 <1dfe1a2e-f6f9-2d5d-a38e-ba4517794bad@redhat.com>
 <6f089371-29e6-6fa9-379d-76d3a87e2b8b@c-s.fr>
 <8a22d3a7-f574-19f1-46d0-a54a5343dec8@redhat.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <86c23a4a-2545-2025-cd61-51f77f1c4393@c-s.fr>
Date: Wed, 13 Mar 2019 10:10:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <8a22d3a7-f574-19f1-46d0-a54a5343dec8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 13/03/2019 à 09:50, Laurent Vivier a écrit :
> On 13/03/2019 09:28, Christophe Leroy wrote:
>>
>>
>> Le 13/03/2019 à 09:01, Laurent Vivier a écrit :
>>> On 13/03/2019 07:03, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 08/03/2019 à 11:54, Laurent Vivier a écrit :
>>>>> resize_hpt_for_hotplug() reports a warning when it cannot
>>>>> resize the hash page table ("Unable to resize hash page
>>>>> table to target order") but in some cases it's not a problem
>>>>> and can make user thinks something has not worked properly.
>>>>>
>>>>> This patch moves the warning to arch_remove_memory() to
>>>>> only report the problem when it is needed.
>>>>>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>> ---
>>>>>     arch/powerpc/include/asm/sparsemem.h  |  4 ++--
>>>>>     arch/powerpc/mm/hash_utils_64.c       | 17 ++++++-----------
>>>>>     arch/powerpc/mm/mem.c                 |  3 ++-
>>>>>     arch/powerpc/platforms/pseries/lpar.c |  3 ++-
>>>>>     4 files changed, 12 insertions(+), 15 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/sparsemem.h
>>>>> b/arch/powerpc/include/asm/sparsemem.h
>>>>> index 68da49320592..3192d454a733 100644
>>>>> --- a/arch/powerpc/include/asm/sparsemem.h
>>>>> +++ b/arch/powerpc/include/asm/sparsemem.h
>>>>> @@ -17,9 +17,9 @@ extern int create_section_mapping(unsigned long
>>>>> start, unsigned long end, int ni
>>>>>     extern int remove_section_mapping(unsigned long start, unsigned long
>>>>> end);
>>>>>       #ifdef CONFIG_PPC_BOOK3S_64
>>>>> -extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
>>>>> +extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
>>>>>     #else
>>>>> -static inline void resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>>> { }
>>>>> +static inline int resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>>> { return 0; }
>>>>>     #endif
>>>>>       #ifdef CONFIG_NUMA
>>>>> diff --git a/arch/powerpc/mm/hash_utils_64.c
>>>>> b/arch/powerpc/mm/hash_utils_64.c
>>>>> index 0cc7fbc3bd1c..40bb2a8326bb 100644
>>>>> --- a/arch/powerpc/mm/hash_utils_64.c
>>>>> +++ b/arch/powerpc/mm/hash_utils_64.c
>>>>> @@ -755,12 +755,12 @@ static unsigned long __init
>>>>> htab_get_table_size(void)
>>>>>     }
>>>>>       #ifdef CONFIG_MEMORY_HOTPLUG
>>>>> -void resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>>> +int resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>>>     {
>>>>>         unsigned target_hpt_shift;
>>>>>           if (!mmu_hash_ops.resize_hpt)
>>>>> -        return;
>>>>> +        return 0;
>>>>>           target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
>>>>>     @@ -773,15 +773,10 @@ void resize_hpt_for_hotplug(unsigned long
>>>>> new_mem_size)
>>>>>          * current shift
>>>>>          */
>>>>>         if ((target_hpt_shift > ppc64_pft_size)
>>>>> -        || (target_hpt_shift < (ppc64_pft_size - 1))) {
>>>>> -        int rc;
>>>>> -
>>>>> -        rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
>>>>> -        if (rc && (rc != -ENODEV))
>>>>> -            printk(KERN_WARNING
>>>>> -                   "Unable to resize hash page table to target order
>>>>> %d: %d\n",
>>>>> -                   target_hpt_shift, rc);
>>>>> -    }
>>>>> +        || (target_hpt_shift < (ppc64_pft_size - 1)))
>>>>
>>>> The || should go on the line above and the two (target_hpt... should be
>>>> aligned, and the () after the < are superflous.
>>>>
>>>> And indeed, we should (in another patch) rename 'target_hpt_shift' with
>>>> a shorter name, this would avoid multiple lines.
>>>>
>>>> Ref
>>>> https://www.kernel.org/doc/html/latest/process/coding-style.html#naming
>>>> :
>>>>
>>>> LOCAL variable names should be short, and to the point. If you have some
>>>> random integer loop counter, it should probably be called i. Calling it
>>>> loop_counter is non-productive, if there is no chance of it being
>>>> mis-understood. Similarly, tmp can be just about any type of variable
>>>> that is used to hold a temporary value.
>>>>
>>>> If you are afraid to mix up your local variable names, you have another
>>>> problem, which is called the function-growth-hormone-imbalance syndrome.
>>>> See chapter 6 (Functions).
>>>>
>>>
>>> I'm only removing a warning. Do we really need to rewrite all the code
>>> around for that?
>>
>> No, and that's the reason why I said it could be done in another
>> (future) patch.
>>
>> Anyway, your patch should be clean regarding checkpatch
>>
>> See https://patchwork.ozlabs.org/patch/1052984/
>> And
>> https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/3298//artifact/linux/checkpatch.log
>>
>>
>> CHECK:AVOID_EXTERNS: extern prototypes should be avoided in .h files
>> #31: FILE: arch/powerpc/include/asm/sparsemem.h:20:
>> +extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
>>
>> CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
>> previous line
>> #70: FILE: arch/powerpc/mm/hash_utils_64.c:776:
>>       if ((target_hpt_shift > ppc64_pft_size)
>> +        || (target_hpt_shift < (ppc64_pft_size - 1)))
>>
> 
> It's really strange, from linux directory:
> 
> ./scripts/checkpatch.pl 0001-powerpc-mm-move-warning-from-resize_hpt_for_hotplug.patch

Try with --strict

> 
> doesn't output this error [1]. Why linux-ppc doesn't use the same script as in the kernel directory?

linux-ppc used it but with dedicated options, see 
arch/powerpc/tools/checkpatch.sh

> 
> Anyway, I send a v3.
> 
> Thanks,
> Laurent
> 
> [1] only:
> 
> WARNING: line over 80 characters
> #34: FILE: arch/powerpc/include/asm/sparsemem.h:22:
> +static inline int resize_hpt_for_hotplug(unsigned long new_mem_size) { return 0; }

linux-ppc allows 90 characters.

> 
> total: 0 errors, 1 warnings, 70 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>        mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-powerpc-mm-move-warning-from-resize_hpt_for_hotplug.patch has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>        them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> But I think it's cleaner to keep the over 80 characters line for the inline.
> 

Christophe
