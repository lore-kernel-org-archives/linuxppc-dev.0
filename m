Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41G5yC08rZzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 01:13:05 +1000 (AEST)
Date: Wed, 27 Jun 2018 16:13:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Russell King <linux@armlinux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
 James Morris <jmorris@namei.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v9 3/6] module: use relative references for __ksymtab
 entries
Message-ID: <20180627151339.GD30631@arm.com>
References: <20180626182802.19932-1-ard.biesheuvel@linaro.org>
 <20180626182802.19932-4-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180626182802.19932-4-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ard,

On Tue, Jun 26, 2018 at 08:27:58PM +0200, Ard Biesheuvel wrote:
> An ordinary arm64 defconfig build has ~64 KB worth of __ksymtab
> entries, each consisting of two 64-bit fields containing absolute
> references, to the symbol itself and to a char array containing
> its name, respectively.

[...]

> diff --git a/include/linux/export.h b/include/linux/export.h
> index ea7df303d68d..ae072bc5aacf 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -18,12 +18,6 @@
>  #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
>  
>  #ifndef __ASSEMBLY__
> -struct kernel_symbol
> -{
> -	unsigned long value;
> -	const char *name;
> -};
> -
>  #ifdef MODULE
>  extern struct module __this_module;
>  #define THIS_MODULE (&__this_module)
> @@ -54,17 +48,47 @@ extern struct module __this_module;
>  #define __CRC_SYMBOL(sym, sec)
>  #endif
>  
> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> +#include <linux/compiler.h>
> +/*
> + * Emit the ksymtab entry as a pair of relative references: this reduces
> + * the size by half on 64-bit architectures, and eliminates the need for
> + * absolute relocations that require runtime processing on relocatable
> + * kernels.
> + */
> +#define __KSYMTAB_ENTRY(sym, sec)					\
> +	__ADDRESSABLE(sym)						\
> +	asm("	.section \"___ksymtab" sec "+" #sym "\", \"a\"	\n"	\
> +	    "	.balign	8					\n"	\

Can we use KSYM_ALIGN here instead of 8, or do we need the 8-byte alignment
even on 32-bit architectures?

Will
