Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yJBzd0jjHzDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 15:05:47 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id h4so17039047qtk.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 21:05:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9a12e8d-5cc4-1e20-b11a-4e8ee79c5e93@c-s.fr>
References: <20171019071355.15324-1-oohall@gmail.com>
 <20171019071355.15324-2-oohall@gmail.com>
 <d9a12e8d-5cc4-1e20-b11a-4e8ee79c5e93@c-s.fr>
From: Oliver <oohall@gmail.com>
Date: Fri, 20 Oct 2017 15:05:44 +1100
Message-ID: <CAOSf1CEtuTYLXFuJfv_DmmoHuYGWcCFJapaLQt-2=tfR1Lctzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/lib: Implement UACCESS_FLUSHCACHE API
To: Christophe LEROY <christophe.leroy@c-s.fr>
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

On Thu, Oct 19, 2017 at 10:14 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 19/10/2017 =C3=A0 09:13, Oliver O'Halloran a =C3=A9crit :
>>
>> Implement the architecture specific portitions of the UACCESS_FLUSHCACHE
>> API. This provides functions for the copy_user_flushcache iterator that
>> ensure that when the copy is finished the destination buffer contains
>> a copy of the original and that the destination buffer is clean in the
>> processor caches.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> ---
>>   arch/powerpc/Kconfig               |  1 +
>>   arch/powerpc/include/asm/string.h  |  2 ++
>>   arch/powerpc/include/asm/uaccess.h |  5 +++++
>>   arch/powerpc/lib/pmem.c            | 33
>> +++++++++++++++++++++++++++++++++
>>   4 files changed, 41 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 0996add8a572..09a207468f8b 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -142,6 +142,7 @@ config PPC
>>         select ARCH_HAS_SCALED_CPUTIME          if
>> VIRT_CPU_ACCOUNTING_NATIVE
>>         select ARCH_HAS_SG_CHAIN
>>         select ARCH_HAS_TICK_BROADCAST          if
>> GENERIC_CLOCKEVENTS_BROADCAST
>> +       select ARCH_HAS_UACCESS_FLUSHCACHE      if PPC64
>
>
> Same as previous patch in the serye, why restrict it to PPC64 ?

It's not highmem aware and as I said  in the previous reply I'd rather
not enable it on platforms where no one has tested it.


Oliver
