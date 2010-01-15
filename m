Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F598B7CB9
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 14:12:54 +1100 (EST)
Subject: Re: [PATCH -tip tracing/kprobes v2] Powerpc port of the
	kprobe-based event tracer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
In-Reply-To: <20100111130210.GA31980@in.ibm.com>
References: <20100111125952.604518521@mars.in.ibm.com>
	<20100111130210.GA31980@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jan 2010 14:12:21 +1100
Message-ID: <1263525141.724.393.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, systemtap@sources.redhat.com,
	Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mahesh !

> +/**
> + * regs_within_kernel_stack() - check the address in the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @addr:      address which is checked.
> + *
> + * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
> + * If @addr is within the kernel stack, it returns true. If not, returns false.
> + */
> +
> +static inline bool regs_within_kernel_stack(struct pt_regs *regs,
> +						unsigned long addr)
> +{
> +	return ((addr & ~(THREAD_SIZE - 1))  ==
> +		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
> +}

Out of curiosity, what is the above meant for ? I'm trying to understand
because it will not work with such things as interrupt or softirq
stack...

> +/**
> + * regs_get_kernel_stack_nth() - get Nth entry of the stack
> + * @regs:	pt_regs which contains kernel stack pointer.
> + * @n:		stack entry number.
> + *
> + * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
> + * is specified by @regs. If the @n th entry is NOT in the kernel stack,
> + * this returns 0.
> + */
> +static inline unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
> +						      unsigned int n)
> +{
> +	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
> +	addr += n;
> +	if (regs_within_kernel_stack(regs, (unsigned long)addr))
> +		return *addr;
> +	else
> +		return 0;
> +}

Is this meant to fetch stack based arguments or do backtraces or similar
or does this have a different purpose ?

>  /*
>   * These are defined as per linux/ptrace.h, which see.
>   */
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index ef14988..e816aba 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -39,6 +39,108 @@
>  #include <asm/system.h>
>  
>  /*
> + * The parameter save area on the stack is used to store arguments being passed
> + * to callee function and is located at fixed offset from stack pointer.
> + */
> +#ifdef CONFIG_PPC32
> +#define PARAMETER_SAVE_AREA_OFFSET	24  /* bytes */
> +#else /* CONFIG_PPC32 */
> +#define PARAMETER_SAVE_AREA_OFFSET	48  /* bytes */
> +#endif
> +
> +struct pt_regs_offset {
> +	const char *name;
> +	int offset;
> +};
> +
> +#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
> +
> +static const struct pt_regs_offset regoffset_table[] = {
> +	REG_OFFSET_NAME(gpr[0]),
> +	REG_OFFSET_NAME(gpr[1]),
> +	REG_OFFSET_NAME(gpr[2]),
> +	REG_OFFSET_NAME(gpr[3]),
> +	REG_OFFSET_NAME(gpr[4]),
> +	REG_OFFSET_NAME(gpr[5]),
> +	REG_OFFSET_NAME(gpr[6]),
> +	REG_OFFSET_NAME(gpr[7]),
> +	REG_OFFSET_NAME(gpr[8]),
> +	REG_OFFSET_NAME(gpr[9]),
> +	REG_OFFSET_NAME(gpr[10]),
> +	REG_OFFSET_NAME(gpr[11]),
> +	REG_OFFSET_NAME(gpr[12]),
> +	REG_OFFSET_NAME(gpr[13]),
> +	REG_OFFSET_NAME(gpr[14]),
> +	REG_OFFSET_NAME(gpr[15]),
> +	REG_OFFSET_NAME(gpr[16]),
> +	REG_OFFSET_NAME(gpr[17]),
> +	REG_OFFSET_NAME(gpr[18]),
> +	REG_OFFSET_NAME(gpr[19]),
> +	REG_OFFSET_NAME(gpr[20]),
> +	REG_OFFSET_NAME(gpr[21]),
> +	REG_OFFSET_NAME(gpr[22]),
> +	REG_OFFSET_NAME(gpr[23]),
> +	REG_OFFSET_NAME(gpr[24]),
> +	REG_OFFSET_NAME(gpr[25]),
> +	REG_OFFSET_NAME(gpr[26]),
> +	REG_OFFSET_NAME(gpr[27]),
> +	REG_OFFSET_NAME(gpr[28]),
> +	REG_OFFSET_NAME(gpr[29]),
> +	REG_OFFSET_NAME(gpr[30]),
> +	REG_OFFSET_NAME(gpr[31]),

I find it weird that you have the [ an ] in the name ... We usually name
these guys gpr0...gpr31 or even r0...r31. Is that name user visible ?
Maybe you should use a different macro GPR_OFFSET_NAME(num) that
generates both gpr[num] for the offsetof and r##num for the register
name.

> +	REG_OFFSET_NAME(nip),
> +	REG_OFFSET_NAME(msr),
> +	REG_OFFSET_NAME(orig_gpr3),
> +	REG_OFFSET_NAME(ctr),
> +	REG_OFFSET_NAME(link),
> +	REG_OFFSET_NAME(xer),
> +	REG_OFFSET_NAME(ccr),
> +#ifdef CONFIG_PPC64
> +	REG_OFFSET_NAME(softe),
> +#else
> +	REG_OFFSET_NAME(mq),
> +#endif
> +	REG_OFFSET_NAME(trap),
> +	REG_OFFSET_NAME(dar),
> +	REG_OFFSET_NAME(dsisr),
> +	REG_OFFSET_NAME(result),
> +	REG_OFFSET_END,
> +};

Do you need to expose orig_gpr3 and result there ?

Cheers,
Ben.
