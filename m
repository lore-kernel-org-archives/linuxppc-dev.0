Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydMyN0Lg1zDrDk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 13:49:15 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id z43so518897uac.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 18:49:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wp2qhhbd.fsf@linux.vnet.ibm.com>
References: <20171113081611.27374-1-bsingharora@gmail.com>
 <87wp2qhhbd.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 17 Nov 2017 13:49:11 +1100
Message-ID: <CAKTCnzmnOzGppZf3euCN=B9uwotC5u4YySYdi5bg4ZdYVA708w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/npu: Cleanup MMIO ATSD flushing
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Alistair Popple <alistair@popple.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2017 at 5:24 PM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>  +      address = start;
>> +     do {
>> +             local_irq_disable();
>> +             find_linux_pte(mm->pgd, address, &is_thp, &hshift);
>> +             if (!is_thp)
>> +                     shift = PAGE_SHIFT;
>
> It can still be hugetlb if is_thp is false.
>

Yep, the hshift check needs to be upfront, the version below makes sense.

>> +             else if (hshift && !is_thp)
>> +                     shift = hshift;
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +             else
>> +                     shift = HPAGE_PMD_SIZE;
>
> That is wrong. I guess it should be shift = HPAGE_PMD_SHIFT. But i am
> not sure we need to make it this complex at all. See below.
>
>> +#else
>> +             else {
>> +                     shift = PAGE_SHIFT;
>> +                     pr_warn_once("unsupport page size for mm %p,addr %lx\n",
>> +                                     mm, start);
>> +             }
>> +#endif
>
> I am still not sure this is correct from a pure page table walking
> point. Why not
>
>        if (hshift)
>           shift = hshift;
>        else
>           shift = PAGE_SHIFT;
>

I don't think I care about THP at this point

I'll respin

Balbir
