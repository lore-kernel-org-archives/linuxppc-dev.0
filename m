Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKJFw15RpzDvQC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 22:05:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] powerpc: initial stack protector (-fstack-protector)
 support
In-Reply-To: <55ab3b5e81cc63a130df787708144bfcd43d85f1.1475181427.git.christophe.leroy@c-s.fr>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
 <55ab3b5e81cc63a130df787708144bfcd43d85f1.1475181427.git.christophe.leroy@c-s.fr>
Date: Thu, 17 Nov 2016 22:05:55 +1100
Message-ID: <878tsixt64.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/include/asm/stackprotector.h b/arch/powerpc/include/asm/stackprotector.h
> new file mode 100644
> index 0000000..de00332
> --- /dev/null
> +++ b/arch/powerpc/include/asm/stackprotector.h
> @@ -0,0 +1,38 @@
> +/*
> + * GCC stack protector support.
> + *
> + * Stack protector works by putting predefined pattern at the start of
> + * the stack frame and verifying that it hasn't been overwritten when
> + * returning from the function.  The pattern is called stack canary
> + * and gcc expects it to be defined by a global variable called
> + * "__stack_chk_guard" on ARM.  This unfortunately means that on SMP
                             ^
                             PPC
                             
> + * we cannot have a different canary value per task.
> + */
> +
> +#ifndef _ASM_STACKPROTECTOR_H
> +#define _ASM_STACKPROTECTOR_H 1

We usually just define it, not define it to 1.

> +
> +#include <linux/random.h>
> +#include <linux/version.h>
> +
> +extern unsigned long __stack_chk_guard;
> +
> +/*
> + * Initialize the stackprotector canary value.
> + *
> + * NOTE: this must only be called from functions that never return,
> + * and it must always be inlined.
> + */
> +static __always_inline void boot_init_stack_canary(void)
> +{
> +	unsigned long canary;
> +
> +	/* Try to get a semi random initial value. */
> +	get_random_bytes(&canary, sizeof(canary));
> +	canary ^= LINUX_VERSION_CODE;

What about mixing in an mftb() as well ?

> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index e59ed6a..4a62179 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -19,6 +19,11 @@ CFLAGS_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>  CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>  CFLAGS_prom.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>  
> +# -fstack-protector triggers protection checks in this code,
> +# but it is being used too early to link to meaningful stack_chk logic.
> +nossp_flags := $(call cc-option, -fno-stack-protector)
> +CFLAGS_prom_init.o := $(nossp_flags)

We've already assigned to CFLAGS_prom_init.o so I think you should be
using += not := shouldn't you?

Also it could just be a single line:

CFLAGS_prom_init.o += $(call cc-option, -fno-stack-protector)


cheers
