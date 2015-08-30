Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1EBC1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:33:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 30 Aug 2015 18:03:40 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C5481125801E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 18:02:51 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7UCXaK630933200
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 18:03:37 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7UCXZ0D031498
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 18:03:36 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 02/10] kasan: MODULE_VADDR is not available on all archs
In-Reply-To: <CAPAsAGw9xx36H5vKmfsunQRZ2qhuLUUTupVK=_v=eztBzDsqAQ@mail.gmail.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGw9xx36H5vKmfsunQRZ2qhuLUUTupVK=_v=eztBzDsqAQ@mail.gmail.com>
Date: Sun, 30 Aug 2015 18:03:28 +0530
Message-ID: <87d1y5q7l3.fsf@linux.vnet.ibm.com>
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
>> Conditionalize the check using #ifdef
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  mm/kasan/report.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index e07c94fbd0ac..71ce7548d914 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -85,9 +85,14 @@ static void print_error_description(struct kasan_access_info *info)
>>
>>  static inline bool kernel_or_module_addr(const void *addr)
>>  {
>> -       return (addr >= (void *)_stext && addr < (void *)_end)
>> -               || (addr >= (void *)MODULES_VADDR
>> -                       && addr < (void *)MODULES_END);
>> +       if (addr >= (void *)_stext && addr < (void *)_end)
>> +               return true;
>> +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>> +       if (addr >= (void *)MODULES_VADDR
>> +                       && addr < (void *)MODULES_END)
>> +               return true;
>> +#endif
>
> I don't think that this is correct change.
> On ppc64 modules are in VMALLOC, so you should check for this.
> Yes, we don't handle VMALLOC now, but we will at some point.
>
> So I think we should use is_module_address() here.
> It will be slower, but we don't care about performance in error reporting route.

Will fix in the next update.

-aneesh
