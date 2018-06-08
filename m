Return-Path: <sam@mendozajonas.com>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412Cm45s2GzF36C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 16:53:08 +1000 (AEST)
Message-ID: <d6ee639cb8375739b6206acd82b57010fca9f982.camel@mendozajonas.com>
Subject: Re: [PATCH v3] powerpc: Add support for function error injection
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 08 Jun 2018 16:52:55 +1000
In-Reply-To: <20180607095202.29189-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20180607095202.29189-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-07 at 15:22 +0530, Naveen N. Rao wrote:
> We implement regs_set_return_value() and override_function_with_return()
> for this purpose.
> 
> On powerpc, a return from a function (blr) just branches to the location
> contained in the link register. So, we can just update pt_regs rather
> than redirecting execution to a dummy function that returns.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> The only change is to add a comment in override_function_with_return() 
> to clarify that we don't need to worry about 32-bit userspace while 
> emulating 'blr'.

Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

> 
> - Naveen
> 
>  arch/powerpc/Kconfig                       |  1 +
>  arch/powerpc/include/asm/error-injection.h | 13 +++++++++++++
>  arch/powerpc/include/asm/ptrace.h          |  5 +++++
>  arch/powerpc/lib/Makefile                  |  2 ++
>  arch/powerpc/lib/error-inject.c            | 16 ++++++++++++++++
>  5 files changed, 37 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/error-injection.h
>  create mode 100644 arch/powerpc/lib/error-inject.c
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 076fe3094856..00dad3c759a0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -187,6 +187,7 @@ config PPC
>  	select HAVE_EBPF_JIT			if PPC64
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
>  	select HAVE_FTRACE_MCOUNT_RECORD
> +	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/powerpc/include/asm/error-injection.h b/arch/powerpc/include/asm/error-injection.h
> new file mode 100644
> index 000000000000..740c3075bdf4
> --- /dev/null
> +++ b/arch/powerpc/include/asm/error-injection.h
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#ifndef _ASM_ERROR_INJECTION_H
> +#define _ASM_ERROR_INJECTION_H
> +
> +#include <linux/compiler.h>
> +#include <linux/linkage.h>
> +#include <asm/ptrace.h>
> +#include <asm-generic/error-injection.h>
> +
> +void override_function_with_return(struct pt_regs *regs);
> +
> +#endif /* _ASM_ERROR_INJECTION_H */
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index e4923686e43a..c0705296c2f0 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -101,6 +101,11 @@ static inline long regs_return_value(struct pt_regs *regs)
>  		return -regs->gpr[3];
>  }
>  
> +static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> +{
> +	regs->gpr[3] = rc;
> +}
> +
>  #ifdef __powerpc64__
>  #define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
>  #else
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index d0ca13ad8231..dd43c5a53396 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -14,6 +14,8 @@ obj-y += string.o alloc.o code-patching.o feature-fixups.o
>  
>  obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
>  
> +obj-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
> +
>  # See corresponding test in arch/powerpc/Makefile
>  # 64-bit linker creates .sfpr on demand for final link (vmlinux),
>  # so it is only needed for modules, and only for older linkers which
> diff --git a/arch/powerpc/lib/error-inject.c b/arch/powerpc/lib/error-inject.c
> new file mode 100644
> index 000000000000..407b992fb02f
> --- /dev/null
> +++ b/arch/powerpc/lib/error-inject.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/error-injection.h>
> +#include <linux/kprobes.h>
> +#include <linux/uaccess.h>
> +
> +void override_function_with_return(struct pt_regs *regs)
> +{
> +	/*
> +	 * Emulate 'blr'. 'regs' represents the state on entry of a predefined
> +	 * function in the kernel/module, captured on a kprobe. We don't need
> +	 * to worry about 32-bit userspace on a 64-bit kernel.
> +	 */
> +	regs->nip = regs->link;
> +}
> +NOKPROBE_SYMBOL(override_function_with_return);
