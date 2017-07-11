Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x67ht0J3qzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 14:02:54 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id q66so4355950qki.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 21:02:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8737a4v7dd.fsf@concordia.ellerman.id.au>
References: <20170706084643.22425-1-oohall@gmail.com>
 <8737a4v7dd.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Tue, 11 Jul 2017 14:02:51 +1000
Message-ID: <CAOSf1CE6dpSO2WA8WmE=gXEoRfKg2OgQwDnhnWt_68NaHTXTdQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/asm: Mark cr0 as clobbered in mftb()
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 10, 2017 at 9:50 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
>
>> The workaround for the CELL timebase bug does not correctly mark cr0 as
>> being clobbered. This can result in GCC making some poor^W completely
>> broken optimisations.
>
> Fruit 'n oats, how did we never notice that? Luck I guess. Or subtle
> breakage that no one could pin down :E

Dumb luck probably.  The workaround is inside a feature section which
depends on CPU_FTR_CELL_TB_BUG so you would only ever see a problem
when actually running on Cell (can't be that many people...). CR0
being volatile across function calls probably helped mask it too.

> I'll tag it for stable.
Good idea.

> Your change log is not entirely fair, it's not GCC's fault, we changed
> register state without telling it, so it's on us :)  I'll reword it a
> bit here.

Yeah that was probably a bit harsh.

>
> cheers
>
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index 7e50e47375d6..a3b6575c7842 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -1303,7 +1303,7 @@ static inline void msr_check_and_clear(unsigned long bits)
>>                               "       .llong 0\n"                     \
>>                               ".previous"                             \
>>                       : "=r" (rval) \
>> -                     : "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL)); \
>> +                     : "i" (CPU_FTR_CELL_TB_BUG), "i" (SPRN_TBRL) : "cr0"); \
>>                       rval;})
>>  #else
>>  #define mftb()               ({unsigned long rval;   \
>> --
>> 2.9.4
