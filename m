Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jp2R2hH4zF3DQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 01:26:23 +1000 (AEST)
Subject: Re: How to define some additional KBUILD_CFLAGS after building
 include/generated/asm-offsets.h ?
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kbuild@vger.kernel.org, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr>
 <87mus75c5m.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <56227965-464a-d972-1c25-d6a4d190e1a1@c-s.fr>
Date: Mon, 24 Sep 2018 17:26:18 +0200
MIME-Version: 1.0
In-Reply-To: <87mus75c5m.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/09/2018 à 14:10, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> I'm trying to implement TLS based stack protector in the Linux Kernel.
>> For that I need to give to GCC the offset at which it will find the
>> canary (register r2 is pointing to the current task struct).
>>
>> I have been able to do it with the below patch, but it only works when
>> include/generated/asm-offsets.h already exists from the start of the build.
>>
>> Is there a way to evaluate CANARY_OFFSET and add the stack-protector
>> flags to KBUILD_FLAGS only after include/generated/asm-offsets.h is built ?
>>
>> Or another way of add -mstack-protector-guard-offset=offsetof(struct
>> task_struct, stack_canary) ?
> 
> This seems to work, at least I see the value in CFLAGS:
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 07d9dce..39ee113 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -404,6 +394,11 @@ archclean:
>   
>   archprepare: checkbin
>   
> +prepare: stack_protector_prepare
> +
> +stack_protector_prepare: prepare0
> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' include/generated/asm-offsets.h))
> +

Great, it works !
Thanks, I have sent v3 of the patches.

Christophe

>   # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
>   # to stdout and these checks are run even on install targets.
>   TOUT	:= .tmp_gas_check
> 
> 
> cheers
> 
