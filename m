Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFnCw2cHRzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:38:04 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id n22so8903300uaj.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 22:38:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgkblkn1.fsf@concordia.ellerman.id.au>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-4-bsingharora@gmail.com>
 <87lgkblkn1.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:38:01 +1100
Message-ID: <CAKTCnz=xoNoehRQNLduNKQe7tF_FL5aLZoA4jrY4w4c_wzr4zw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] powerpc/mce: Hookup derror (load/store) UE errors
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
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

On Mon, Oct 16, 2017 at 4:36 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
>> index b76ca19..0e584d5 100644
>> --- a/arch/powerpc/kernel/mce_power.c
>> +++ b/arch/powerpc/kernel/mce_power.c
>> @@ -27,6 +27,36 @@
>>  #include <asm/mmu.h>
>>  #include <asm/mce.h>
>>  #include <asm/machdep.h>
>> +#include <asm/pgtable.h>
>> +#include <asm/pte-walk.h>
>> +#include <asm/sstep.h>
>> +#include <asm/exception-64s.h>
>> +
>> +/*
>> + * Convert an address related to an mm to a PFN. NOTE: we are in real
>> + * mode, we could potentially race with page table updates.
>> + */
>
> That will blow some serious chunks if we're on pseries.
>
> It seems it can't be triggered on pseries at the moment, but only
> because of the feature section around the call to
> machine_check_handle_early().
>
> We should maybe move the powernv only code in here inside an #ifdef
> POWERNV, just for documentation purposes. But we can do that later.
>

Will do that as a follow up thanks! I think the entire mce_power.c and mce.c
can move to pseries, will validate with Mahesh and Nick as well.

Balbir
