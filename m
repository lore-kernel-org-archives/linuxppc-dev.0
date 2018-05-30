Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wkbw5QXlzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 18:42:01 +1000 (AEST)
Date: Wed, 30 May 2018 17:41:56 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Josef Bacik <jbacik@fb.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] error-injection: Simplify arch specific helpers
Message-Id: <20180530174156.cb1799687fb834f26fe570a9@kernel.org>
In-Reply-To: <8f4883f08feaf6e040255015af2da7bbc7741e41.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <8f4883f08feaf6e040255015af2da7bbc7741e41.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 May 2018 18:06:02 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We already have an arch-independent way to set the instruction pointer
> with instruction_pointer_set(). Using this allows us to get rid of the
> need for override_function_with_return() that each architecture has to
> implement.
> 
> Furthermore, just_return_func() only has to encode arch-specific
> assembly instructions to return from a function. Introduce a macro
> ARCH_FUNC_RET to provide the arch-specific instruction and move over
> just_return_func() to generic code.
> 
> With these changes, architectures that already support kprobes, only
> just need to ensure they provide regs_set_return_value(), GET_IP() (for
> instruction_pointer_set()), and ARCH_FUNC_RET to support error
> injection.

Nice! the code basically good to me. Just one comment, ARCH_FUNC_RET sounds
like a function. Maybe ARCH_RETURN_INSTRUCTION will be better name, isn't it? :)

Thank you,

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/x86/include/asm/error-injection.h |  6 +-----
>  arch/x86/lib/Makefile                  |  1 -
>  arch/x86/lib/error-inject.c            | 20 --------------------
>  include/asm-generic/error-injection.h  |  6 ++++++
>  include/linux/error-injection.h        |  1 +
>  kernel/fail_function.c                 |  2 +-
>  kernel/trace/bpf_trace.c               |  2 +-
>  lib/error-inject.c                     |  8 ++++++++
>  8 files changed, 18 insertions(+), 28 deletions(-)
>  delete mode 100644 arch/x86/lib/error-inject.c
> 
> diff --git a/arch/x86/include/asm/error-injection.h b/arch/x86/include/asm/error-injection.h
> index 47b7a1296245..f3f22e237b86 100644
> --- a/arch/x86/include/asm/error-injection.h
> +++ b/arch/x86/include/asm/error-injection.h
> @@ -2,12 +2,8 @@
>  #ifndef _ASM_ERROR_INJECTION_H
>  #define _ASM_ERROR_INJECTION_H
>  
> -#include <linux/compiler.h>
> -#include <linux/linkage.h>
> -#include <asm/ptrace.h>
>  #include <asm-generic/error-injection.h>
>  
> -asmlinkage void just_return_func(void);
> -void override_function_with_return(struct pt_regs *regs);
> +#define ARCH_FUNC_RET	"ret"
>  
>  #endif /* _ASM_ERROR_INJECTION_H */
> diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
> index 25a972c61b0a..f23934bbaf4e 100644
> --- a/arch/x86/lib/Makefile
> +++ b/arch/x86/lib/Makefile
> @@ -26,7 +26,6 @@ lib-y += memcpy_$(BITS).o
>  lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
>  lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
>  lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
> -lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
>  lib-$(CONFIG_RETPOLINE) += retpoline.o
>  
>  obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
> diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
> deleted file mode 100644
> index 3cdf06128d13..000000000000
> --- a/arch/x86/lib/error-inject.c
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -#include <linux/error-injection.h>
> -#include <linux/kprobes.h>
> -
> -asmlinkage void just_return_func(void);
> -
> -asm(
> -	".type just_return_func, @function\n"
> -	".globl just_return_func\n"
> -	"just_return_func:\n"
> -	"	ret\n"
> -	".size just_return_func, .-just_return_func\n"
> -);
> -
> -void override_function_with_return(struct pt_regs *regs)
> -{
> -	regs->ip = (unsigned long)&just_return_func;
> -}
> -NOKPROBE_SYMBOL(override_function_with_return);
> diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
> index 296c65442f00..8ac152cc204a 100644
> --- a/include/asm-generic/error-injection.h
> +++ b/include/asm-generic/error-injection.h
> @@ -3,6 +3,9 @@
>  #define _ASM_GENERIC_ERROR_INJECTION_H
>  
>  #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
> +#include <linux/compiler.h>
> +#include <linux/linkage.h>
> +
>  enum {
>  	EI_ETYPE_NONE,		/* Dummy value for undefined case */
>  	EI_ETYPE_NULL,		/* Return NULL if failure */
> @@ -27,6 +30,9 @@ static struct error_injection_entry __used				\
>  		.addr = (unsigned long)fname,				\
>  		.etype = EI_ETYPE_##_etype,				\
>  	};
> +
> +asmlinkage void just_return_func(void);
> +
>  #else
>  #define ALLOW_ERROR_INJECTION(fname, _etype)
>  #endif
> diff --git a/include/linux/error-injection.h b/include/linux/error-injection.h
> index 280c61ecbf20..f4a0b23423d2 100644
> --- a/include/linux/error-injection.h
> +++ b/include/linux/error-injection.h
> @@ -4,6 +4,7 @@
>  
>  #ifdef CONFIG_FUNCTION_ERROR_INJECTION
>  
> +#include <linux/types.h>
>  #include <asm/error-injection.h>
>  
>  extern bool within_error_injection_list(unsigned long addr);
> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> index 1d5632d8bbcc..0ae2ca4a29e8 100644
> --- a/kernel/fail_function.c
> +++ b/kernel/fail_function.c
> @@ -183,7 +183,7 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
>  
>  	if (should_fail(&fei_fault_attr, 1)) {
>  		regs_set_return_value(regs, attr->retval);
> -		override_function_with_return(regs);
> +		instruction_pointer_set(regs, (unsigned long)&just_return_func);
>  		/* Kprobe specific fixup */
>  		reset_current_kprobe();
>  		preempt_enable_no_resched();
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 56ba0f2a01db..23f1f4ffda6c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -84,7 +84,7 @@ EXPORT_SYMBOL_GPL(trace_call_bpf);
>  BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
>  {
>  	regs_set_return_value(regs, rc);
> -	override_function_with_return(regs);
> +	instruction_pointer_set(regs, (unsigned long)&just_return_func);
>  	return 0;
>  }
>  
> diff --git a/lib/error-inject.c b/lib/error-inject.c
> index c0d4600f4896..7fdc92b5babc 100644
> --- a/lib/error-inject.c
> +++ b/lib/error-inject.c
> @@ -20,6 +20,14 @@ struct ei_entry {
>  	void *priv;
>  };
>  
> +asm(
> +	".type just_return_func, @function\n"
> +	".globl just_return_func\n"
> +	"just_return_func:\n"
> +	ARCH_FUNC_RET "\n"
> +	".size just_return_func, .-just_return_func\n"
> +);
> +
>  bool within_error_injection_list(unsigned long addr)
>  {
>  	struct ei_entry *ent;
> -- 
> 2.17.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
