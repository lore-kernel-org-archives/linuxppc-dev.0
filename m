Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQv3p5H7nzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:32:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Brown <matthew.brown.dev@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3] powerpc/powernv: Use darn instr for random_seed on p9
In-Reply-To: <87o9rsory2.fsf@concordia.ellerman.id.au>
References: <20170804011218.10489-1-matthew.brown.dev@gmail.com>
 <ff133efb-7cd5-1c50-ee71-e8bb941ea492@linux.vnet.ibm.com>
 <CAPoR37Ykavb9_V2a9abJ9vTPMqXTMLMp4LxvRmCHiCKm51g5xw@mail.gmail.com>
 <87o9rsory2.fsf@concordia.ellerman.id.au>
Date: Mon, 07 Aug 2017 20:32:18 +1000
Message-ID: <874ltjpt1p.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> Matt Brown <matthew.brown.dev@gmail.com> writes:
>> On Sat, Aug 5, 2017 at 3:06 AM, Tyrel Datwyler <tyreld@linux.vnet.ibm.com> wrote:
>>> On 08/03/2017 06:12 PM, Matt Brown wrote:
>>>> @@ -135,8 +152,9 @@ static __init int rng_create(struct device_node *dn)
>>>> @@ -150,6 +168,21 @@ static __init int rng_init(void)
>>>>               of_platform_device_create(dn, NULL, NULL);
>>>>       }
>>>>
>>>> +     if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>>>> +             for (i = 0; i < 10; i++) {
>>>> +                     if (powernv_get_random_darn(&darn_test)) {
>>>> +                             ppc_md.get_random_seed =
>>>> +                                     powernv_get_random_darn;
>>>> +                             break;
>>>
>>> If you return directly here you can avoid the (i == 9) conditional every iteration of the
>>> loop by moving the pr_warn to just outside the loop.
>>
>> That's true, although it is very unlikely for the
>> powernv_get_random_darn to fail. So in practice we should never reach
>> the (i == 9) conditional.
>> The loop is more of a backup in the rare case that it does fail.
>
> All true, the runtime overhead is really not an issue. It's more that
> testing for loop almost-termination in the loop is a bit gross :)
>
> I think the best solution is to just pull it out into a separate
> function, it also avoids adding sometimes unused variables to the outer
> function, eg:
>
> static int initialise_darn(void)
> ...

I decided this patch had reached my bike-shedding threshold, so I just
unilaterally changed it to the way I liked it and applied it :)

All the bugs are mine.

cheers
