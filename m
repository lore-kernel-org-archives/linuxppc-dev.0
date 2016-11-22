Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNNNc3r8QzDvpP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:22:24 +1100 (AEDT)
Subject: Re: [PATCH 1/2] powerpc: initial stack protector (-fstack-protector)
 support
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
 <55ab3b5e81cc63a130df787708144bfcd43d85f1.1475181427.git.christophe.leroy@c-s.fr>
 <878tsixt64.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nicolas Pitre <nicolas.pitre@linaro.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <823f6257-0071-a8af-1789-56749da71dc9@c-s.fr>
Date: Tue, 22 Nov 2016 11:51:33 +0100
MIME-Version: 1.0
In-Reply-To: <878tsixt64.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/11/2016 à 12:05, Michael Ellerman a écrit :

Hi Michael,

I took your comments into account in v2. Shame on me, I forgot to add 
the list of changes from v1 to v2 in the commit log.

Christophe

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
>> new file mode 100644
>> index 0000000..de00332
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/stackprotector.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * GCC stack protector support.
>> + *
>> + * Stack protector works by putting predefined pattern at the start of
>> + * the stack frame and verifying that it hasn't been overwritten when
>> + * returning from the function.  The pattern is called stack canary
>> + * and gcc expects it to be defined by a global variable called
>> + * "__stack_chk_guard" on ARM.  This unfortunately means that on SMP
>                              ^
>                              PPC
>
>> + * we cannot have a different canary value per task.
>> + */
>> +
>> +#ifndef _ASM_STACKPROTECTOR_H
>> +#define _ASM_STACKPROTECTOR_H 1
>
> We usually just define it, not define it to 1.
>
>> +
>> +#include <linux/random.h>
>> +#include <linux/version.h>
>> +
>> +extern unsigned long __stack_chk_guard;
>> +
>> +/*
>> + * Initialize the stackprotector canary value.
>> + *
>> + * NOTE: this must only be called from functions that never return,
>> + * and it must always be inlined.
>> + */
>> +static __always_inline void boot_init_stack_canary(void)
>> +{
>> +	unsigned long canary;
>> +
>> +	/* Try to get a semi random initial value. */
>> +	get_random_bytes(&canary, sizeof(canary));
>> +	canary ^= LINUX_VERSION_CODE;
>
> What about mixing in an mftb() as well ?
>
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index e59ed6a..4a62179 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -19,6 +19,11 @@ CFLAGS_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>>  CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>>  CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>>
>> +# -fstack-protector triggers protection checks in this code,
>> +# but it is being used too early to link to meaningful stack_chk logic.
>> +nossp_flags := $(call cc-option, -fno-stack-protector)
>> +CFLAGS_prom_init.o := $(nossp_flags)
>
> We've already assigned to CFLAGS_prom_init.o so I think you should be
> using += not := shouldn't you?
>
> Also it could just be a single line:
>
> CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)
>
>
> cheers
>
