Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C989F1A028B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:42:18 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 30 Aug 2015 22:42:15 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B03C33578047
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:42:12 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7UCg6uO41222174
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:42:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7UCfeX7016949
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:41:40 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 05/10] kasan: Enable arch to hook into kasan callbacks.
In-Reply-To: <CAPAsAGyN-yGEXmVFXSEs=tQ1We6MNS89omm=DOPGogfXWqn_qg@mail.gmail.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyN-yGEXmVFXSEs=tQ1We6MNS89omm=DOPGogfXWqn_qg@mail.gmail.com>
Date: Sun, 30 Aug 2015 18:11:07 +0530
Message-ID: <878u8tq78c.fsf@linux.vnet.ibm.com>
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

Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:

> 2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>> We add enable/disable callbacks in this patch which architecture
>> can implemement. We will use this in the later patches for architecture
>> like ppc64, that cannot have early zero page kasan shadow region for the
>> entire virtual address space. Such architectures also cannot use
>> inline kasan support.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  mm/kasan/kasan.c |  9 +++++++++
>>  mm/kasan/kasan.h | 15 +++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
>> index 7b28e9cdf1c7..e4d33afd0eaf 100644
>> --- a/mm/kasan/kasan.c
>> +++ b/mm/kasan/kasan.c
>> @@ -43,6 +43,9 @@ static void kasan_poison_shadow(const void *address, size_t size, u8 value)
>>  {
>>         void *shadow_start, *shadow_end;
>>
>> +       if (!kasan_enabled())
>> +               return;
>> +
>
> By the time this function called we already should have shadow,
> so it should be safe to remove this check.
>

I remember hitting that call before enabling kasan completely. Will
check that again. 

>
>>         shadow_start = kasan_mem_to_shadow(address);
>>         shadow_end = kasan_mem_to_shadow(address + size);
>>
>> @@ -51,6 +54,9 @@ static void kasan_poison_shadow(const void *address, size_t size, u8 value)
>>
>>  void kasan_unpoison_shadow(const void *address, size_t size)
>>  {
>> +       if (!kasan_enabled())
>> +               return;
>> +
>
> Ditto.
>
>>         kasan_poison_shadow(address, size, 0);
>>
>>         if (size & KASAN_SHADOW_MASK) {
>> @@ -238,6 +244,9 @@ static __always_inline void check_memory_region(unsigned long addr,
>>  {
>>         struct kasan_access_info info;
>>
>> +       if (!kasan_enabled())
>> +               return;
>> +
>>         if (unlikely(size == 0))
>>                 return;
>>
>> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> index a6b46cc94907..deb547d5a916 100644
>> --- a/mm/kasan/kasan.h
>> +++ b/mm/kasan/kasan.h
>> @@ -68,6 +68,21 @@ static inline bool kasan_report_enabled(void)
>>         return !current->kasan_depth;
>>  }
>>
>> +#ifndef kasan_enabled
>> +/*
>> + * Some archs may want to disable kasan callbacks.
>> + */
>> +static inline bool kasan_enabled(void)
>> +{
>> +       return true;
>> +}
>> +#define kasan_enabled kasan_enabled
>
> Why we need this define?


That is to make sure that we don't endup with different definition of
kasan_enabled due to header include errors. Once we select a
particular definition of the overloaded function, it is always good to mark
the function as defined, so that checks like #ifndef kasan_enabled will
always fail. 

>
>> +#else
>> +#ifdef CONFIG_KASAN_INLINE
>> +#error "Kasan inline support cannot work with KASAN arch hooks"
>> +#endif
>> +#endif
>> +
>>  void kasan_report(unsigned long addr, size_t size,
>>                 bool is_write, unsigned long ip);
>>
>> --
>> 2.5.0
>>

-aneesh
