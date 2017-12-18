Return-Path: <dianders@google.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0nqK6mnKzDrnG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 04:20:29 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id i20so11151896uak.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 09:20:29 -0800 (PST)
MIME-Version: 1.0
Sender: dianders@google.com
In-Reply-To: <CA+7wUszdpmbScwEkAKSLjDFV5ufJToECxuoJ1tPyA15hG+H+kw@mail.gmail.com>
References: <CA+7wUszecRH7p5iHNXNqmb956PnhZa=4zCx+E4c2ur8Jzf6c4w@mail.gmail.com>
 <CA+7wUsxuhWXn8raBsp29umpHhVO7BnX_B3CALTddBx5gJeLoCA@mail.gmail.com>
 <CA+7wUsw-BrxyAmYsj5tmUSLJWsJ1OUOEK0zx98RD1+YsQ8MRJA@mail.gmail.com>
 <CA+7wUszdpmbScwEkAKSLjDFV5ufJToECxuoJ1tPyA15hG+H+kw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2017 09:20:25 -0800
Message-ID: <CAD=FV=WHsRYJA3KxxMwY9-vUh12W+zC7qepvL+ErEOpppcwvAA@mail.gmail.com>
Subject: Re: Mac Mini G4 defconfig ?
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Sun, Dec 17, 2017 at 2:54 AM, Mathieu Malaterre <malat@debian.org> wrote:
> On Fri, Dec 15, 2017 at 10:01 PM, Mathieu Malaterre <malat@debian.org> wrote:
>> On Fri, Dec 15, 2017 at 9:52 PM, Mathieu Malaterre <malat@debian.org> wrote:
>>> On Fri, Dec 15, 2017 at 8:50 PM, Mathieu Malaterre <malat@debian.org> wrote:
>>>> Hi there,
>>>>
>>>> Does anyone has working defconfig for a Mac Mini G4 ?
>>>>
>>>> Here is what I tried:
>>>>
>>>> $ cat ./arch/powerpc/configs/g4_defconfig
>>>> CONFIG_PPC_FPU=y
>>>> CONFIG_ALTIVEC=y
>>>> $ make ARCH=powerpc g4_defconfig
>>>> $ make -j8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- V=1
>>>> set -e; : '  CHK     include/config/kernel.release'; mkdir -p
>>>
>>> That is odd. Doing a quick git bisect:
>>>
>>> $ git checkout 3298b690b21cdbe6b2ae8076d9147027f396f2b1
>>> $ make -n ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -f ./Makefile
>>> silentoldconfig V=1
>>> + make -n ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- -f ./Makefile
>>> silentoldconfig V=1
>>> /bin/sh: line 0: [: -ge: unary operator expected
>>> make -f ./scripts/Makefile.build obj=scripts/basic
>>>
>>> I cannot make sense of this shell error, maybe this is unrelated but
>>> things start breaking around this commit.
>>
>> Even if I discard this shell error, the next error comes with:
>>
>> 433dc2ebe7d17dd21cba7ad5c362d37323592236 is the first bad commit
>>
>> With:
>>
>> $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- V=1
>> [...]
>>   powerpc-linux-gnu-gcc -Wp,-MD,kernel/.bounds.s.d  -nostdinc -isystem
>>  -I./arch/powerpc/include -I./arch/powerpc/include/generated
>> -I./include -I./arch/powerpc/include/uapi
>> -I./arch/powerpc/include/generated/uapi -I./include/uapi
>> -I./include/generated/uapi -include ./include/linux/kconfig.h
>> -D__KERNEL__ -Iarch/powerpc -Wall -Wundef -Wstrict-prototypes
>> -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar
>> -Werror-implicit-function-declaration -Wno-format-security -std=gnu89
>> -pipe -Iarch/powerpc -ffixed-r2 -mmultiple -mcpu=powerpc -Wa,-maltivec
>> -mbig-endian -fno-delete-null-pointer-checks -Wno-frame-address -O2
>> -Wno-maybe-uninitialized --param=allow-store-data-races=0
>> -DCC_HAVE_ASM_GOTO -Wframe-larger-than=1024 -fno-stack-protector
>> -Wno-unused-but-set-variable -Wno-unused-const-variable
>> -fomit-frame-pointer -fno-var-tracking-assignments
>> -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow
>> -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes
>> -Werror=date-time -Werror=incompatible-pointer-types
>> -Werror=designated-init    -DKBUILD_BASENAME='"bounds"'
>> -DKBUILD_MODNAME='"bounds"'  -fverbose-asm -S -o kernel/bounds.s
>> kernel/bounds.c
>> In file included from ./include/linux/page-flags.h:9:0,
>>                  from kernel/bounds.c:9:
>> ./include/linux/bug.h:4:21: fatal error: asm/bug.h: No such file or directory
>>  #include <asm/bug.h>
>>                      ^
>> compilation terminated.
>> Kbuild:20: recipe for target 'kernel/bounds.s' failed
>> make[1]: *** [kernel/bounds.s] Error 1
>> Makefile:1051: recipe for target 'prepare0' failed
>> make: *** [prepare0] Error 2
>>
>>
>> Comments ?
>
> Solution is:
>
> $ rm .cache.mk
>
> I guess the cache was not cleared in between my different kernel compilations.
>
> Sorry for the noise

Looks like others are hitting this too and it seems like we'll need to
come up with a solution that avoids this (or at least makes it somehow
clear that a make clean will fix it).  See the thread at
<https://lkml.org/lkml/2017/12/16/315>.

-Doug
