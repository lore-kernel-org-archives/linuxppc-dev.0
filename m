Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJBkK3sDYzDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 14:54:16 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id k123so12924964qke.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 20:54:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <70ae7de4-9ab9-502b-8cdf-da793cc50eac@c-s.fr>
References: <20171019071355.15324-1-oohall@gmail.com>
 <70ae7de4-9ab9-502b-8cdf-da793cc50eac@c-s.fr>
From: Oliver <oohall@gmail.com>
Date: Fri, 20 Oct 2017 14:54:13 +1100
Message-ID: <CAOSf1CGWzv-wNioUVNzaorhhYPi=9bmJ0vypk8bcPf-B05VJ_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/lib: Implement PMEM API
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 10:13 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 19/10/2017 =C3=A0 09:13, Oliver O'Halloran a =C3=A9crit :
>>
>> Implement the architecture specific cache maintence functions that make
>> up the "PMEM API". Currently the writeback and invalidate functions
>> are the same since the function of the DCBST (data cache block store)
>> instruction is typically interpreted as "writeback to the point of
>> coherency" rather than to memory. As a result implementing the API
>> requires a full cache flush rather than just a cache write back. This
>> will probably change in the not-too-distant future.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> ---
>>   arch/powerpc/Kconfig      |  1 +
>>   arch/powerpc/lib/Makefile |  2 +-
>>   arch/powerpc/lib/pmem.c   | 34 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 36 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/powerpc/lib/pmem.c
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 809c468edab1..0996add8a572 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -138,6 +138,7 @@ config PPC
>>         select ARCH_HAS_ELF_RANDOMIZE
>>         select ARCH_HAS_FORTIFY_SOURCE
>>         select ARCH_HAS_GCOV_PROFILE_ALL
>> +       select ARCH_HAS_PMEM_API                if PPC64
>
>
> Why restrict that to PPC64 ?

Currently I'm only developing and testing on PPC64 and I'd rather not
be enabling features for platforms that I haven't tested them on.

>
>
>>         select ARCH_HAS_SCALED_CPUTIME          if
>> VIRT_CPU_ACCOUNTING_NATIVE
>>         select ARCH_HAS_SG_CHAIN
>>         select ARCH_HAS_TICK_BROADCAST          if
>> GENERIC_CLOCKEVENTS_BROADCAST
>> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>> index 50d5bf954cff..7aa237d10546 100644
>> --- a/arch/powerpc/lib/Makefile
>> +++ b/arch/powerpc/lib/Makefile
>> @@ -23,7 +23,7 @@ endif
>>     obj64-y     +=3D copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
>>            copyuser_power7.o string_64.o copypage_power7.o memcpy_power7=
.o
>> \
>> -          memcpy_64.o memcmp_64.o
>> +          memcpy_64.o memcmp_64.o pmem.o
>>     obj64-$(CONFIG_SMP) +=3D locks.o
>>   obj64-$(CONFIG_ALTIVEC)       +=3D vmx-helper.o
>> diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
>> new file mode 100644
>> index 000000000000..0fa09262ca13
>> --- /dev/null
>> +++ b/arch/powerpc/lib/pmem.c
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Copyright(c) 2017 IBM Corporation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of version 2 of the GNU General Public License as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#include <linux/string.h>
>> +#include <linux/export.h>
>> +
>> +#include <asm/cacheflush.h>
>> +
>> +/*
>> + * CONFIG_ARCH_HAS_PMEM_API symbols
>> + */
>> +void arch_wb_cache_pmem(void *addr, size_t size)
>> +{
>> +       unsigned long start =3D (unsigned long) addr;
>> +       flush_inval_dcache_range(start, start + size);
>
>
> That function seems to only exist in PPC64, however a quite similar one,
> called flush_dcache_range() does the same on PPC32 (defined in
> arch/powerpc/include/asm/cacheflush.h)
>
> In the meantime, I see that PPC64 also has a function called
> flush_dcache_range(), which does the same as PPC32 function
> clean_dcache_range()
>
> Maybe she should re-unify the names ?

It wouldn't hurt. The problem is that there are a few drivers using
the two though so
we would need to go through those and fix them as needed.

>
> Christophe
>
>
>> +}
>> +EXPORT_SYMBOL(arch_wb_cache_pmem);
>> +
>> +void arch_invalidate_pmem(void *addr, size_t size)
>> +{
>> +       unsigned long start =3D (unsigned long) addr;
>> +       flush_inval_dcache_range(start, start + size);
>> +}
>> +EXPORT_SYMBOL(arch_invalidate_pmem);
>>
>
