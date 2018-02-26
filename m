Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqYrQ6qq3zDqqN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 18:49:42 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id e25so1404102uam.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 23:49:42 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-6-malat@debian.org>
 <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 26 Feb 2018 08:49:20 +0100
Message-ID: <CA+7wUszvNAD-j5PkA3wYBF7oYfu3+L7vCXtyyhiOBdwyVnH9cQ@mail.gmail.com>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 26, 2018 at 7:32 AM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 25/02/2018 =C3=A0 18:22, Mathieu Malaterre a =C3=A9crit :
>>
>> Rewrite comparison since all values compared are of type `unsigned long`=
.
>>
>> Fix a warning (treated as error in W=3D1):
>>
>>    CC      arch/powerpc/kernel/irq.o
>> In file included from ./include/linux/bug.h:5:0,
>>                   from ./include/linux/cpumask.h:13,
>>                   from ./include/linux/smp.h:13,
>>                   from ./include/linux/kernel_stat.h:5,
>>                   from arch/powerpc/kernel/irq.c:35:
>> ./include/linux/dma-mapping.h: In function =E2=80=98dma_map_resource=E2=
=80=99:
>> ./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned
>> expression >=3D 0 is always true [-Werror=3Dtype-limits]
>>   #define pfn_valid(pfn)  ((pfn) >=3D ARCH_PFN_OFFSET && (pfn) < max_map=
nr)
>>                                  ^
>> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/include/asm/page.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/page.h
>> b/arch/powerpc/include/asm/page.h
>> index 8da5d4c1cab2..19dea64e7ed2 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -126,7 +126,8 @@ extern long long virt_phys_offset;
>>     #ifdef CONFIG_FLATMEM
>>   #define ARCH_PFN_OFFSET               ((unsigned long)(MEMORY_START >>
>> PAGE_SHIFT))
>> -#define pfn_valid(pfn)         ((pfn) >=3D ARCH_PFN_OFFSET && (pfn) <
>> max_mapnr)
>> +#define pfn_valid(pfn) \
>> +               (((pfn) - ARCH_PFN_OFFSET) < (max_mapnr -
>> ARCH_PFN_OFFSET))
>
>
> What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than
> ARCH_PFN_OFFSET ?

I assumed that normal unsigned integers modulo would make the test
fail. But for some particular value of max_mapnr the two are indeed
not equivalent.

> Christophe
>
>
>>   #endif
>>     #define virt_to_pfn(kaddr)  (__pa(kaddr) >> PAGE_SHIFT)
>>
>
