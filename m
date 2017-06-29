Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyykn5tTszDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:54:41 +1000 (AEST)
Received: by mail-qk0-x22b.google.com with SMTP id d78so73495589qkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 04:54:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87mv8r9m5l.fsf@concordia.ellerman.id.au>
References: <20170629082734.4195-1-bsingharora@gmail.com>
 <87mv8r9m5l.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 29 Jun 2017 21:54:38 +1000
Message-ID: <CAKTCnzmNBw9jeC10ZaToNgi+-iscc4B55xWqOeK81eQif0QsLA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kexec: Fix radix to hash kexec
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2017 at 7:29 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> This patch fixes a crash seen while doing a kexec from
>> radix mode to hash mode. Key 0 is special in hash and
>> used in the RPN by default, we set the key values to 0
>> today. In radix mode key 0 is used to control
>> supervisor<->user access. In hash key 0 is used by default,
>> so the first instruction after the switch causes a crash on
>> kexec.
>>
>> This patch fixes
>> (3b10d00 powerpc/mm/radix: Prevent kernel execution of user space)
>> The commit above introduced setting of IAMR and AMOR values to
>> prevent execution of user mode instructions from supervisor mode.
>> We need to clean up these SPR's on kexec.
>>
>> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>
>> NOTES:
>>  This patch can be made power9 specific, but I've chosen not
>>  to do so, I could add it in a feature section if recommended.
>
> Well neither register existed in the architecture prior to Power8.
> Possibly they were defined in BookIV or they were nops, but most likely
> it will just explode on old CPUs.
>
> And probably Book3E as well.
>
> So it should be in a CPU_FTR_ARCH_207S section at a minimum.
>

Thanks for the review, I'll do a v2, I've put it under CPU_FTR_ARCH_300

> But maybe it should just be done in C earlier in the call chain.

I thought about it, but felt that kexec_sequence would be our last let
off and might be a good place to reset the AMR's just before turning
the MMU off

Balbir Singh.
