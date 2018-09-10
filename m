Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4283QD2PZBzF3Cc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 19:58:11 +1000 (AEST)
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
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <061b3056-1a9a-af6b-de2a-49fea394320d@c-s.fr>
Date: Mon, 10 Sep 2018 09:56:33 +0000
MIME-Version: 1.0
In-Reply-To: <20180910092835.v5nex5nzfgtl475m@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/10/2018 09:28 AM, Luc Van Oostenryck wrote:
> On Mon, Sep 10, 2018 at 08:49:07AM +0200, Christophe LEROY wrote:
>> Le 07/09/2018 à 20:19, Nick Desaulniers a écrit :
>>> On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck wrote:
>>>>
>>>> Sparse expand these macros to the same version than the compiler used
>>>> to compile GCC. I find a bit strange though to have sparse v0.5.2 but
>>>> using an old compiler.
>>>
>>> So Christophe must have a version of gcc < 4.6 installed somewhere?
>>> Does sparse use `cc`? If so, Christophe, does your `ls -l $(which cc)`
>>> point to an old version of gcc maybe?
>>
>> Indeed it looks like sparse expand these macros to the version of
>> the compiler it was compiled with.
>>
>> I'm building kernels for a powerpc platforms, with CROSS_COMPILE set
>> to ppc-linux- and ppc-linux-gcc being version 5.4
>>
>> However my build machine is a CentOS6 and the native gcc has version
>> 4.4.7, so sparse expands that version.
> 
> OK, I see.
>   
>> Is there a way to get sparse in line with my cross compiler version
>> and not with the local native version ?
> 
> When cross-compiling, there is also things like the machine word-size
> and the endianness to take in account (they also default to the
> native compiler used to compile sparse itself) as well as a few
> defines (like __PPC64__). To be in line with your cross-compiler
> you can use to the wrapper 'cgcc' (installed with sparse) and call
> it, for example, like this:
> 	$ export REAL_CC=ppc-linux-gcc
> 	$ cgcc -target=ppcc64 -D_CALL_ELF=2 -D__GCC__=5 -D__GCC_MINOR__=4 ...
> or, since this is for the kernel:
> 	$ export REAL_CC=ppc-linux-gcc
> 	$ make CHECK='cgcc -target=ppcc64 ...
> 
> 
> I think this should solve it. Do not hesitate to report any
> difficulties you may encounter.

# export REAL_CC=ppc-linux-gcc
# make CHECK="cgcc -target=ppc -D_CALL_ELF=2 -D__GCC__=5 
-D__GCC_MINOR__=4" C=2 arch/powerpc/kernel/process.o
scripts/kconfig/conf  --syncconfig Kconfig
#
# configuration written to .config
#
   UPD     include/config/kernel.release
   UPD     include/generated/utsrelease.h
   CC      kernel/bounds.s
   CC      arch/powerpc/kernel/asm-offsets.s
   CALL    scripts/checksyscalls.sh
   CHECK   scripts/mod/empty.c
Can't exec "/bin/sh": Argument list too long at /usr/local/bin/cgcc line 86.
make[2]: *** [scripts/mod/empty.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2

Christophe

> 
> -- Luc
> 
