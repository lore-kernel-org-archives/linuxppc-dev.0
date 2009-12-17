Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH -tip tracing/kprobes] PPC: Powerpc port of the
	kprobe-based event tracer
In-reply-to: <20091216043933.GA9328@in.ibm.com>
References: <20091216043619.963539987@mars.in.ibm.com>
	<20091216043933.GA9328@in.ibm.com>
Date: Thu, 17 Dec 2009 13:22:55 +1100
Message-ID: <13884.1261016575@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <20091216043933.GA9328@in.ibm.com> you wrote:
> This patch ports the kprobe-based event tracer to powerpc. This patch
> is based in x86 port. This brings powerpc on par with x86.
> 
> Port the following API's to ppc for accessing registers and stack entries
> from pt_regs.
> 
> - regs_query_register_offset(const char *name)
>    Query the offset of "name" register.
> 
> - regs_query_register_name(unsigned int offset)
>    Query the name of register by its offset.
> 
> - regs_get_register(struct pt_regs *regs, unsigned int offset)
>    Get the value of a register by its offset.
> 
> - regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
>    Check the address is in the kernel stack.
> 
> - regs_get_kernel_stack_nth(struct pt_regs *reg, unsigned int nth)
>    Get Nth entry of the kernel stack. (N >= 0)
> 
> - regs_get_argument_nth(struct pt_regs *reg, unsigned int nth)
>    Get Nth argument at function call. (N >= 0)
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Acked-by: Masami Hiramatsu <mhiramat@redhat.com>
> ---
>  arch/powerpc/include/asm/ptrace.h |   64 +++++++++++++++++
>  arch/powerpc/kernel/ptrace.c      |  141 +++++++++++++++++++++++++++++++++++
+++
>  kernel/trace/Kconfig              |    2 
>  3 files changed, 206 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6-tip/arch/powerpc/include/asm/ptrace.h
> ===================================================================
> --- linux-2.6-tip.orig/arch/powerpc/include/asm/ptrace.h
> +++ linux-2.6-tip/arch/powerpc/include/asm/ptrace.h
> @@ -83,6 +83,7 @@ struct pt_regs {
>  
>  #define instruction_pointer(regs) ((regs)->nip)
>  #define user_stack_pointer(regs) ((regs)->gpr[1])
> +#define kernel_stack_pointer(regs) ((regs)->gpr[1])
>  #define regs_return_value(regs) ((regs)->gpr[3])
>  
>  #ifdef CONFIG_SMP
> @@ -131,6 +132,69 @@ do {						
			      \
>  } while (0)
>  #endif /* __powerpc64__ */
>  
> +/* Query offset/name of register from its name/offset */
> +#include <linux/stddef.h>
> +#include <linux/thread_info.h>

Includes should be at the start of the file

> +extern int regs_query_register_offset(const char *name);
> +extern const char *regs_query_register_name(unsigned int offset);
> +/* Get Nth argument at function call */
> +extern unsigned long regs_get_argument_nth(struct pt_regs *regs,
> +						unsigned int n);

> +#define MAX_REG_OFFSET (offsetof(struct pt_regs, result))
> +
> +/**
> + * regs_get_register() - get register value from its offset
> + * @regs:	   pt_regs from which register value is gotten
> + * @offset:    offset number of the register.
> + *
> + * regs_get_register returns the value of a register whose offset from @regs
.
> + * The @offset is the offset of the register in struct pt_regs.
> + * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
> + */
> +static inline unsigned long regs_get_register(struct pt_regs *regs,
> +						unsigned int offset)

Please put only function definitions in the .h file.  The rest of this
should be in .c

> +{
> +	if (unlikely(offset > MAX_REG_OFFSET))
> +		return 0;
> +	return *(unsigned long *)((unsigned long)regs + offset);
> +}
> +
> +/**
> + * regs_within_kernel_stack() - check the address in the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @addr:      address which is checked.
> + *
> + * regs_within_kernel_stack() checks @addr is within the kernel stack page(s
).
> + * If @addr is within the kernel stack, it returns true. If not, returns fal
se.
> + */
> +
> +static inline bool regs_within_kernel_stack(struct pt_regs *regs,
> +						unsigned long addr)
> +{
> +	return ((addr & ~(THREAD_SIZE - 1))  ==
> +		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1)));
> +}
> +
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
> +
>  /*
>   * These are defined as per linux/ptrace.h, which see.
>   */
> Index: linux-2.6-tip/arch/powerpc/kernel/ptrace.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/powerpc/kernel/ptrace.c
> +++ linux-2.6-tip/arch/powerpc/kernel/ptrace.c
> @@ -39,6 +39,147 @@
>  #include <asm/system.h>
>  
>  /*
> + * The parameter save area on the stack is used to store arguments being pas
sed
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
> +#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r
)}
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

Do we need to add something for FP and VMX registers here?

> +};
> +
> +/**
> + * regs_query_register_offset() - query register offset from its name
> + * @name:	the name of a register
> + *
> + * regs_query_register_offset() returns the offset of a register in struct
> + * pt_regs from its name. If the name is invalid, this returns -EINVAL;
> + */
> +int regs_query_register_offset(const char *name)
> +{
> +	const struct pt_regs_offset *roff;
> +	for (roff = regoffset_table; roff->name != NULL; roff++)
> +		if (!strcmp(roff->name, name))
> +			return roff->offset;
> +	return -EINVAL;
> +}
> +
> +/**
> + * regs_query_register_name() - query register name from its offset
> + * @offset:	the offset of a register in struct pt_regs.
> + *
> + * regs_query_register_name() returns the name of a register from its
> + * offset in struct pt_regs. If the @offset is invalid, this returns NULL;
> + */
> +const char *regs_query_register_name(unsigned int offset)
> +{
> +	const struct pt_regs_offset *roff;
> +	for (roff = regoffset_table; roff->name != NULL; roff++)
> +		if (roff->offset == offset)
> +			return roff->name;
> +	return NULL;
> +}
> +
> +static const int arg_offs_table[] = {
> +	[0] = offsetof(struct pt_regs, gpr[3]),
> +	[1] = offsetof(struct pt_regs, gpr[4]),
> +	[2] = offsetof(struct pt_regs, gpr[5]),
> +	[3] = offsetof(struct pt_regs, gpr[6]),
> +	[4] = offsetof(struct pt_regs, gpr[7]),
> +	[5] = offsetof(struct pt_regs, gpr[8]),
> +	[6] = offsetof(struct pt_regs, gpr[9]),
> +	[7] = offsetof(struct pt_regs, gpr[10])
> +};
> +
> +/**
> + * regs_get_argument_nth() - get Nth argument at function call
> + * @regs:	pt_regs which contains registers at function entry.
> + * @n:		argument number.
> + *
> + * regs_get_argument_nth() returns @n th argument of a function call.
> + * Since usually the kernel stack will be changed right after function entry
,
> + * you must use this at function entry. If the @n th entry is NOT in the
> + * kernel stack or pt_regs, this returns 0.
> + */
> +unsigned long regs_get_argument_nth(struct pt_regs *regs, unsigned int n)
> +{
> +	if (n < ARRAY_SIZE(arg_offs_table))
> +		return *(unsigned long *)((char *)regs + arg_offs_table[n]);
> +	else {
> +		/*
> +		 * If more arguments are passed that can be stored in
> +		 * registers, the remaining arguments are stored in the
> +		 * parameter save area located at fixed offset from stack
> +		 * pointer.
> +		 * Following the PowerPC ABI, the first few arguments are
> +		 * actually passed in registers (r3-r10), with equivalent space
> +		 * left unused in the parameter save area.
> +		 */
> +		n += (PARAMETER_SAVE_AREA_OFFSET / sizeof(unsigned long));
> +		return regs_get_kernel_stack_nth(regs, n);

How do we handle FP args?

> +	}
> +}
> +/*
>   * does not yet catch signals sent when the child dies.
>   * in exit.c or in signal.c.
>   */
> Index: linux-2.6-tip/kernel/trace/Kconfig
> ===================================================================
> --- linux-2.6-tip.orig/kernel/trace/Kconfig
> +++ linux-2.6-tip/kernel/trace/Kconfig
> @@ -464,7 +464,7 @@ config BLK_DEV_IO_TRACE
>  
>  config KPROBE_EVENT
>  	depends on KPROBES
> -	depends on X86
> +	depends on X86 || PPC
>  	bool "Enable kprobes-based dynamic events"
>  	select TRACING
>  	default y
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
