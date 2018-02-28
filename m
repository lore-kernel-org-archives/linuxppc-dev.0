Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrt1Y2LmbzF1X4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 22:02:08 +1100 (AEDT)
Received: by mail-vk0-x244.google.com with SMTP id a63so1193210vkg.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 03:02:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87y3jd2xsl.fsf@concordia.ellerman.id.au>
References: <20171214011008.4388-1-bsingharora@gmail.com>
 <5227513.IOhi8YYFsi@new-mexico>
 <CAKTCnzkO+NWKDwj8RE_jX_N0uu-vY5HRf4AdkJyjsLvL1Loqhg@mail.gmail.com>
 <2478842.lxjFpUTe5s@new-mexico> <87y3jd2xsl.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 28 Feb 2018 22:02:05 +1100
Message-ID: <CAKTCnz=MYZae27JKffFp5XHVwCoXkU8HRbmckLZSoWeJRHPGZw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/npu: Cleanup MMIO ATSD flushing
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2018 at 9:50 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Alistair Popple <alistair@popple.id.au> writes:
>
>>> @aneesh can you please look at this? @mpe can we pick this up if there
>>> are no objections?
>>
>> @mpe any objections to picking this up for this release? Or do you want to wait
>> for the next one? (there are likely more bugfixes coming for ATS support).
>
> I can grab it for this release if it's fixing a bug, the subject makes
> it sound like a cleanup. Do we have a Fixes tag for it?
>
> I don't particularly like the potentially very long loop in
> pnv_npu2_invalidate_helper() which spends most of its time with
> interrupts off. I worry we're going to see soft lockups pointing there
> if we get a very large invalidate.
>
We have the same loop today in pnv_npu2_mn_invalidate_range(). The bug
fix is really the fix to invalidate the right page size. I agree we
can optimize this better, in fact if the mmu notifier is made blocking
then we can even do cond_resched(). I however agree, the right thing
to do is to figure out the right trade-off of invalidate range size to
flushing the entire PID

Balbir Singh.
