Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x232.google.com (mail-ua0-x232.google.com
 [IPv6:2607:f8b0:400c:c08::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsWsf5MFwzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:27:02 +1000 (AEST)
Received: by mail-ua0-x232.google.com with SMTP id l24so17731440uaa.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 23:27:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170913162113.49e80b39@roar.ozlabs.ibm.com>
References: <20170913061049.13256-1-bsingharora@gmail.com>
 <20170913061049.13256-4-bsingharora@gmail.com>
 <20170913162113.49e80b39@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 13 Sep 2017 16:26:59 +1000
Message-ID: <CAKTCnz=+sY0+dkw8gA2oRMG9g9CqNRqdVrcRU-01qXys9+7O3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] powerpc/mce: Hookup derror (load/store) UE errors
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
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

On Wed, Sep 13, 2017 at 4:21 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Wed, 13 Sep 2017 16:10:47 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> Extract physical_address for UE errors by walking the page
>> tables for the mm and address at the NIP, to extract the
>> instruction. Then use the instruction to find the effective
>> address via analyse_instr().
>>
>> We might have page table walking races, but we expect them to
>> be rare, the physical address extraction is best effort. The idea
>> is to then hook up this infrastructure to memory failure eventually.
>
> This all looks pretty good to me, you can probably update these
> changelogs now because you are hooking it into memory failure.

Yep, the eventually can probably go, I meant in the next patch.
The following patch then hooks this up into memory_failure

>
> I wonder if it would be worth skipping the instruction analysis and
> page table walk if we've recursed up to the maximum MCE depth, just
> in case we're hitting MCEs in part of that code or data.

Yep, good idea. Would you be OK if we did this after this small series
got merged? Since that would mean that we got a UE error
while processing the our third machine check exception, I think the
probability of us running into that is low, but I'd definitely like to do that
once these changes are merged.

Balbir Singh.
