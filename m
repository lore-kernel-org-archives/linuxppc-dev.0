Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xGw12WRdzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 15:57:51 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc/64: Fix build failure with GCC 8.1
To: Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geoff Levand <geoff@infradead.org>
References: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
 <CAMuHMdVSKigQPUQH=BVc2fRSRmuEThLaf+V9ghMPDT9_m1C6BA@mail.gmail.com>
 <1fa5b220-4d21-b4cd-33bf-8a3ce3178063@c-s.fr>
 <CAMuHMdXwO1_wrrTi40UmZC4o6KjvP0LF38m45n0ZNA2pDb_7Qg@mail.gmail.com>
 <3a438dd8-49c3-ad39-e2a1-040e0ce67279@c-s.fr>
 <87efhsz7xz.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fd687f6c-0846-07da-328d-dd01bb2d0fdb@c-s.fr>
Date: Thu, 31 May 2018 07:57:48 +0200
MIME-Version: 1.0
In-Reply-To: <87efhsz7xz.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 31/05/2018 à 07:54, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 29/05/2018 à 11:05, Geert Uytterhoeven a écrit :
>>> Hi Christophe,
>>> On Tue, May 29, 2018 at 10:56 AM, Christophe LEROY
>>> <christophe.leroy@c-s.fr> wrote:
>>>> Le 29/05/2018 à 09:47, Geert Uytterhoeven a écrit :
>>>>> On Tue, May 29, 2018 at 8:03 AM, Christophe Leroy
>>>>>> --- a/arch/powerpc/kernel/nvram_64.c
>>>>>> +++ b/arch/powerpc/kernel/nvram_64.c
>>>>>> @@ -1039,7 +1039,7 @@ loff_t __init nvram_create_partition(const char
>>>>>> *name, int sig,
>>>>>>            new_part->index = free_part->index;
>>>>>>            new_part->header.signature = sig;
>>>>>>            new_part->header.length = size;
>>>>>> -       strncpy(new_part->header.name, name, 12);
>>>>>> +       memcpy(new_part->header.name, name, strnlen(name,
>>>>>> sizeof(new_part->header.name)));
>>>>>
>>>>>
>>>>> The comment for nvram_header.lgnth says:
>>>>>
>>>>>            /* Terminating null required only for names < 12 chars. */
>>>>>
>>>>> This will not terminate the string with a zero (the struct is
>>>>> allocated with kmalloc).
>>>>> So the original code is correct, the new one isn't.
>>>>
>>>> Right, then I have to first zeroize the destination.
>>>
>>> Using kzalloc() instead of kmalloc() will do.
>>>
>>> Still, papering around these warnings seems to obscure things, IMHO.
>>> And it increases code size, as you had to add a call to strnlen().
> 
> 
> The right fix is to not try and mirror the on-device structure in the
> kernel struct. We should just use a proper NULL terminated string, which
> would avoid the need to explicitly do strncmp(.., .., 12) in the code
> and be less bug prone in general.
> 
> The only place where we should need to worry about the 12 byte buffer is
> in nvram_write_header().
> 
> Anyway that's a bigger change, so I'll take this for now with kzalloc().

Thanks. You take it as is and add the kzalloc() or you expect a v3 from 
me with the kzalloc()

Christophe
