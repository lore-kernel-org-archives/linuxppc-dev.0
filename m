Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x229.google.com (mail-ua0-x229.google.com
 [IPv6:2607:f8b0:400c:c08::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZNLj2Cc0zF262
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 21:57:01 +1000 (AEST)
Received: by mail-ua0-x229.google.com with SMTP id v4so5196221uaj.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 04:57:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874ljtrn42.fsf@concordia.ellerman.id.au>
References: <20180430083432.21546-1-bsingharora@gmail.com>
 <874ljtrn42.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 30 Apr 2018 21:56:56 +1000
Message-ID: <CAKTCnz=Eo7jDs0pY2WKNKdaO0xPP6F=0o8cNNc5Ky5d-HTNqoA@mail.gmail.com>
Subject: Re: [PATCH] Revert "powerpc/powernv: Increase memory block size to
 1GB on radix"
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@ozlabs.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2018 at 8:43 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>> This reverts commit 53ecde0b9126ff140abe3aefd7f0ec64d6fa36b0.
>
> Firstly everything here only applies to Radix, so we need to say that.

The subject mentions it :)

>
>> The commit above changed the memblock size to 1GiB, which did some
>> nice things like create fewer TLB entries for mapping memory at
>> the time of hotplug.
>
> You say TLB entry here and below, but I think that's misleading. We
> don't create TLB entries for mappings at the time of hotplug. We create
> entries in the page tables.

Agreed! I meant we'll end up with fewer TLB entries for the linear mapping.

>
> And is it true that changing the memory block size to 256MB necessarily
> means we'll never create a 1GiB mapping? It looks like if you call
> arch_add_memory() with a 1GiB block it will create 1GiB mappings.
>
> I agree if we add 256MB blocks individually then we won't use a 1GiB
> mapping.
>
> But I'm not sure any of the above is all that relevant, because we
> didn't make the change to 1GiB for any of those reasons, we did it to
> prevent the kernel crashing.
>
> If we *did* want to change the block size for 1GiB for performance
> reasons then we need a commit that justifies that.
>

I don't deny it, but I think it was a side-effect and we needed to document the
potential impact of the reversal

>> The downside is that it changes the granularity
>> at which memory can be hot-plugged and hot-unplugged. The implication
>> is that if we had less than a 1GiB to hot-plug/hot-unplug that
>> would not be possible.
>
> That 2nd sentence is not strong enough, it should say something more
> like: It forces hot(un)plug to operate at a 1GiB granularity.
>

OK, I think you mean anything modulo 1GiB would not work.

>> The reason we had this fix was to resolve an issue where we did not
>> split mappings on hot-unplug, leaving a TLB entry that spanned the
>> region that was unplugged. This is now fixed by 4dd5f8a99e79 which
>> splits the page table, removing the MMU mappings for the hot-unplugged
>> region correctly.
>
> I'd say:
>
> This commit was a stop-gap to prevent crashes on hotunplug, caused by
> the mismatch between the 1G mappings used for the linear mapping and the
> memory block size. Those issues are now resolved because we split the
> linear mapping at hotunplug time if necessary, as implemented in commit
> 4dd5f8a99e79 ("powerpc/mm/radix: Split linear mapping on hot-unplug").
>
> cheers

Looks good!
Cheers,
Balbir Singh.
