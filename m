Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA1CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:52:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A1E2173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A1E2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K5FD1XshzDqKH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 19:52:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=lvivier@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K5CZ5JBqzDq67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 19:50:50 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 161A944835;
 Wed, 13 Mar 2019 08:50:49 +0000 (UTC)
Received: from [10.36.116.28] (ovpn-116-28.ams2.redhat.com [10.36.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3E931B428;
 Wed, 13 Mar 2019 08:50:47 +0000 (UTC)
Subject: Re: [PATCH v2] powerpc/mm: move warning from resize_hpt_for_hotplug()
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org
References: <20190308105413.4302-1-lvivier@redhat.com>
 <3db6b64d-02d3-8aa7-80ca-3e469ea743ff@c-s.fr>
 <1dfe1a2e-f6f9-2d5d-a38e-ba4517794bad@redhat.com>
 <6f089371-29e6-6fa9-379d-76d3a87e2b8b@c-s.fr>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8a22d3a7-f574-19f1-46d0-a54a5343dec8@redhat.com>
Date: Wed, 13 Mar 2019 09:50:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6f089371-29e6-6fa9-379d-76d3a87e2b8b@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 13 Mar 2019 08:50:49 +0000 (UTC)
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

On 13/03/2019 09:28, Christophe Leroy wrote:
> 
> 
> Le 13/03/2019 à 09:01, Laurent Vivier a écrit :
>> On 13/03/2019 07:03, Christophe Leroy wrote:
>>>
>>>
>>> Le 08/03/2019 à 11:54, Laurent Vivier a écrit :
>>>> resize_hpt_for_hotplug() reports a warning when it cannot
>>>> resize the hash page table ("Unable to resize hash page
>>>> table to target order") but in some cases it's not a problem
>>>> and can make user thinks something has not worked properly.
>>>>
>>>> This patch moves the warning to arch_remove_memory() to
>>>> only report the problem when it is needed.
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>    arch/powerpc/include/asm/sparsemem.h  |  4 ++--
>>>>    arch/powerpc/mm/hash_utils_64.c       | 17 ++++++-----------
>>>>    arch/powerpc/mm/mem.c                 |  3 ++-
>>>>    arch/powerpc/platforms/pseries/lpar.c |  3 ++-
>>>>    4 files changed, 12 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/sparsemem.h
>>>> b/arch/powerpc/include/asm/sparsemem.h
>>>> index 68da49320592..3192d454a733 100644
>>>> --- a/arch/powerpc/include/asm/sparsemem.h
>>>> +++ b/arch/powerpc/include/asm/sparsemem.h
>>>> @@ -17,9 +17,9 @@ extern int create_section_mapping(unsigned long
>>>> start, unsigned long end, int ni
>>>>    extern int remove_section_mapping(unsigned long start, unsigned long
>>>> end);
>>>>      #ifdef CONFIG_PPC_BOOK3S_64
>>>> -extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
>>>> +extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
>>>>    #else
>>>> -static inline void resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>> { }
>>>> +static inline int resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>> { return 0; }
>>>>    #endif
>>>>      #ifdef CONFIG_NUMA
>>>> diff --git a/arch/powerpc/mm/hash_utils_64.c
>>>> b/arch/powerpc/mm/hash_utils_64.c
>>>> index 0cc7fbc3bd1c..40bb2a8326bb 100644
>>>> --- a/arch/powerpc/mm/hash_utils_64.c
>>>> +++ b/arch/powerpc/mm/hash_utils_64.c
>>>> @@ -755,12 +755,12 @@ static unsigned long __init
>>>> htab_get_table_size(void)
>>>>    }
>>>>      #ifdef CONFIG_MEMORY_HOTPLUG
>>>> -void resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>> +int resize_hpt_for_hotplug(unsigned long new_mem_size)
>>>>    {
>>>>        unsigned target_hpt_shift;
>>>>          if (!mmu_hash_ops.resize_hpt)
>>>> -        return;
>>>> +        return 0;
>>>>          target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
>>>>    @@ -773,15 +773,10 @@ void resize_hpt_for_hotplug(unsigned long
>>>> new_mem_size)
>>>>         * current shift
>>>>         */
>>>>        if ((target_hpt_shift > ppc64_pft_size)
>>>> -        || (target_hpt_shift < (ppc64_pft_size - 1))) {
>>>> -        int rc;
>>>> -
>>>> -        rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
>>>> -        if (rc && (rc != -ENODEV))
>>>> -            printk(KERN_WARNING
>>>> -                   "Unable to resize hash page table to target order
>>>> %d: %d\n",
>>>> -                   target_hpt_shift, rc);
>>>> -    }
>>>> +        || (target_hpt_shift < (ppc64_pft_size - 1)))
>>>
>>> The || should go on the line above and the two (target_hpt... should be
>>> aligned, and the () after the < are superflous.
>>>
>>> And indeed, we should (in another patch) rename 'target_hpt_shift' with
>>> a shorter name, this would avoid multiple lines.
>>>
>>> Ref
>>> https://www.kernel.org/doc/html/latest/process/coding-style.html#naming
>>> :
>>>
>>> LOCAL variable names should be short, and to the point. If you have some
>>> random integer loop counter, it should probably be called i. Calling it
>>> loop_counter is non-productive, if there is no chance of it being
>>> mis-understood. Similarly, tmp can be just about any type of variable
>>> that is used to hold a temporary value.
>>>
>>> If you are afraid to mix up your local variable names, you have another
>>> problem, which is called the function-growth-hormone-imbalance syndrome.
>>> See chapter 6 (Functions).
>>>
>>
>> I'm only removing a warning. Do we really need to rewrite all the code
>> around for that?
> 
> No, and that's the reason why I said it could be done in another
> (future) patch.
> 
> Anyway, your patch should be clean regarding checkpatch
> 
> See https://patchwork.ozlabs.org/patch/1052984/
> And
> https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/3298//artifact/linux/checkpatch.log
> 
> 
> CHECK:AVOID_EXTERNS: extern prototypes should be avoided in .h files
> #31: FILE: arch/powerpc/include/asm/sparsemem.h:20:
> +extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
> 
> CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
> previous line
> #70: FILE: arch/powerpc/mm/hash_utils_64.c:776:
>      if ((target_hpt_shift > ppc64_pft_size)
> +        || (target_hpt_shift < (ppc64_pft_size - 1)))
> 

It's really strange, from linux directory:

./scripts/checkpatch.pl 0001-powerpc-mm-move-warning-from-resize_hpt_for_hotplug.patch

doesn't output this error [1]. Why linux-ppc doesn't use the same script as in the kernel directory?

Anyway, I send a v3.

Thanks,
Laurent

[1] only:

WARNING: line over 80 characters
#34: FILE: arch/powerpc/include/asm/sparsemem.h:22:
+static inline int resize_hpt_for_hotplug(unsigned long new_mem_size) { return 0; }

total: 0 errors, 1 warnings, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-powerpc-mm-move-warning-from-resize_hpt_for_hotplug.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


But I think it's cleaner to keep the over 80 characters line for the inline.
