Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4288vk5rNTzF36y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 00:05:38 +1000 (AEST)
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, joe@perches.com,
 Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-sparse@vger.kernel.org, sparse@chrisli.org,
 linuxppc-dev@lists.ozlabs.org
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
 <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
 <20180907181337.peyfq7yvhahduvmq@ltop.local>
 <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
 <e6db84f1-ee8d-9377-5f1c-6a0e7972ba50@c-s.fr>
 <20180910092835.v5nex5nzfgtl475m@ltop.local>
 <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
 <20180910113448.dxnfvznyimtj3tkv@ltop.local>
 <9409138a-dc14-2b12-edc0-cfa0b471da6e@c-s.fr>
 <20180910135604.j2phe7r3k5vs6cik@ltop.local>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6191f6dc-1819-60e4-d4e8-f815f04325f0@c-s.fr>
Date: Mon, 10 Sep 2018 16:05:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180910135604.j2phe7r3k5vs6cik@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/09/2018 à 15:56, Luc Van Oostenryck a écrit :
> On Mon, Sep 10, 2018 at 01:19:07PM +0000, Christophe Leroy wrote:
>>
>>
>> On 09/10/2018 11:34 AM, Luc Van Oostenryck wrote:
>>> On Mon, Sep 10, 2018 at 09:56:33AM +0000, Christophe Leroy wrote:
>>>>
>>>> # export REAL_CC=ppc-linux-gcc
>>>> # make CHECK="cgcc -target=ppc -D_CALL_ELF=2 -D__GCC__=5
>>>> -D__GCC_MINOR__=4" C=2 arch/powerpc/kernel/process.o
>>>> scripts/kconfig/conf  --syncconfig Kconfig
>>>> #
>>>> # configuration written to .config
>>>> #
>>>>     UPD     include/config/kernel.release
>>>>     UPD     include/generated/utsrelease.h
>>>>     CC      kernel/bounds.s
>>>>     CC      arch/powerpc/kernel/asm-offsets.s
>>>>     CALL    scripts/checksyscalls.sh
>>>>     CHECK   scripts/mod/empty.c
>>>> Can't exec "/bin/sh": Argument list too long at /usr/local/bin/cgcc line 86.
>>>> make[2]: *** [scripts/mod/empty.o] Error 1
>>>> make[1]: *** [scripts/mod] Error 2
>>>> make: *** [scripts] Error 2
>>>
>>> OK. Clearly nobody has ever used it so :(
>>> There is an infinite loop because cgcc use the env var CHECK
>>> to call sparse while kbuild use CHECK to call cgcc here.
>>>
>>> The following seems to work here.
>>> $ export REAL_CC=ppc-linux-gcc
>>> $ make CHECK="CHECK=sparse cgcc -target=ppc ...
>>
>> Not yet ...
>>
>> [root@pc16082vm linux-powerpc]# export REAL_CC=ppc-linux-gcc
>> [root@pc16082vm linux-powerpc]# make CHECK="CHECK=sparse cgcc
>> -target=ppc -D_CALL_ELF=2 -D__GNUC__=5 -D__GNUC_MINOR__=4" C=2
>> arch/powerpc/kernel/process.o
>>    CALL    scripts/checksyscalls.sh
>>    CHECK   scripts/mod/empty.c
>> <command-line>:0:0: warning: "__STDC__" redefined
>> <built-in>: note: this is the location of the previous definition
>> /opt/cldk-1.4.0/lib/gcc/ppc-linux/5.4.0/../../../../ppc-linux/lib/crt1.o:(.rodata+0x4):
>> undefined reference to `main'
>> collect2: error: ld returned 1 exit status
>> make[2]: *** [scripts/mod/empty.o] Error 1
>> make[1]: *** [scripts/mod] Error 2
>> make: *** [scripts] Error 2
> 
> OK. Using cgcc creates more problems that it solves and this file
> scripts/mod/empty.c is weird.
> Dropping cgcc and simply giving the GCC version to sparse works for
> me here (the needed defines are given by arch/powerpc/Makefile) but
> for sure I don't have the same environment as you have:
>    $ make CHECK="sparse -D__GNUC__=5 -D__GNUC_MINOR__=4" ...

This time it works, thanks for your help.

Should we find a may to automate that in the Makefile when CROSS_COMPILE 
is defined ?

> 
> Bonne chance,

Merci

Christophe
