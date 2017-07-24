Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGKdB4K2WzDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 21:58:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 07/24] powerpc/mm: Move out definition of CPU specific
 is_write bits
In-Reply-To: <20170722184058.Horde.Y2X8hGdhXLwnxJXZApQEhQ1@messagerie.c-s.fr>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-7-benh@kernel.crashing.org>
 <20170722184058.Horde.Y2X8hGdhXLwnxJXZApQEhQ1@messagerie.c-s.fr>
Date: Mon, 24 Jul 2017 21:58:05 +1000
Message-ID: <87mv7ujbci.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> a =C3=A9crit=C2=A0:
>
>> Define a common page_fault_is_write() helper and use it
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>>  arch/powerpc/mm/fault.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index f257965b54b5..26ec0dd4f419 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -183,6 +183,16 @@ static int mm_fault_error(struct pt_regs *regs,=20=
=20
>> unsigned long addr, int fault)
>>  }
>>
>>  /*
>> + * Define the correct "is_write" bit in error_code based
>> + * on the processor family
>> + */
>> +#if (defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>> +#define page_fault_is_write(__err)	((__err) & ESR_DST)
>> +#else
>> +#define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
>> +#endif
>
> Doesn't linux kernel codying style make preference to static inline=20=20
> functions instead of macros ?

In general yes. Especially for things that look like functions.

Ben was worried the code gen would be worse if it was a static inline
returning bool, I'll apply it and have a look.

cheers
