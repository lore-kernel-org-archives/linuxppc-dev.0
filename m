Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFxrt0GvKzDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 23:07:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 5/5] powerpc/mce: hookup memory_failure for UE errors
In-Reply-To: <CAKTCnzkH=5i23F9v2t-VLZET2HV86NP8u=rx9gEswG5COTJ1kw@mail.gmail.com>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-6-bsingharora@gmail.com>
 <87infflkjm.fsf@concordia.ellerman.id.au>
 <CAKTCnzkH=5i23F9v2t-VLZET2HV86NP8u=rx9gEswG5COTJ1kw@mail.gmail.com>
Date: Mon, 16 Oct 2017 23:07:08 +1100
Message-ID: <874lqzl2j7.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Mon, Oct 16, 2017 at 4:38 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Balbir Singh <bsingharora@gmail.com> writes:
>>
>>> If we are in user space and hit a UE error, we now have the
>>> basic infrastructure to walk the page tables and find out
>>> the effective address that was accessed, since the DAR
>>> is not valid.
>>>
>>> We use a work_queue content to hookup the bad pfn, any
>>> other context causes problems, since memory_failure itself
>>> can call into schedule() via lru_drain_ bits.
>>>
>>> We could probably poison the struct page to avoid a race
>>> between detection and taking corrective action.
>>>
>>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>  arch/powerpc/kernel/mce.c | 70 +++++++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 67 insertions(+), 3 deletions(-)
>>
>> I'm not sure why this is in mce.c but the rest was in mce_power.c ?
>
> The way the code is organized is that save_mce_event is implemented here
> and called from mce_power.c. save_mce_event() does the processing
> of the event.

save_mce_event() is only called from mce_power.c :/

I'd be happy if it was mce_real_mode.c and mce.c, that would be a good
distinction to make.

Though even then, most of the code is Book3s64 specific I think so maybe
it shouldn't be in just mce.c.

Anyway I'll merge this and we can improve things later.

cheers
