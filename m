Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xFZv0NkyzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:57:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Josef Bacik <jbacik@fb.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: Add support for function error injection
In-Reply-To: <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 31 May 2018 14:57:56 +1000
Message-ID: <87h8mozajv.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> ...

A change log is always nice even if it's short :)

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig                       | 1 +
>  arch/powerpc/include/asm/error-injection.h | 9 +++++++++
>  arch/powerpc/include/asm/ptrace.h          | 5 +++++
>  3 files changed, 15 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/error-injection.h

This looks fine to me, it's probably easiest if it goes in via tip along
with patch 1.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 23247fa551e7..ed1ab693f945 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -194,6 +194,7 @@ config PPC
>  	select HAVE_EBPF_JIT			if PPC64
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS	if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
>  	select HAVE_FTRACE_MCOUNT_RECORD
> +	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/powerpc/include/asm/error-injection.h b/arch/powerpc/include/asm/error-injection.h
> new file mode 100644
> index 000000000000..b596eca04ef9
> --- /dev/null
> +++ b/arch/powerpc/include/asm/error-injection.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ERROR_INJECTION_H
> +#define _ASM_ERROR_INJECTION_H
> +
> +#include <asm-generic/error-injection.h>
> +
> +#define ARCH_FUNC_RET	"blr"
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
> -- 
> 2.17.0
