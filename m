Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BFAF31A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 05:42:17 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 9 Jul 2014 13:42:14 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 64FE83E40047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 13:42:12 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s69JgC9I4456826
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jul 2014 21:42:12 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s69JkFEp030388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jul 2014 13:46:15 -0600
Date: Wed, 9 Jul 2014 12:42:10 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powernv: Add OPAL tracepoints
Message-ID: <20140709194210.GX4603@linux.vnet.ibm.com>
References: <20140703172050.495b3f72@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140703172050.495b3f72@kryten>
Cc: mikey@neuling.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 03, 2014 at 05:20:50PM +1000, Anton Blanchard wrote:
> Knowing how long we spend in firmware calls is an important part of
> minimising OS jitter.
> 
> This patch adds tracepoints to each OPAL call. If tracepoints are
> enabled we branch out to a common routine that calls an entry and exit
> tracepoint.
> 
> This allows us to write tools that monitor the frequency and duration
> of OPAL calls, eg:
> 
> name                  count  total(ms)  min(ms)  max(ms)  avg(ms)  period(ms)
> OPAL_HANDLE_INTERRUPT     5      0.199    0.037    0.042    0.040   12547.545
> OPAL_POLL_EVENTS        204      2.590    0.012    0.036    0.013    2264.899
> OPAL_PCI_MSI_EOI       2830      3.066    0.001    0.005    0.001      81.166
> 
> We use jump labels if configured, which means we only add a single
> nop instruction to every OPAL call when the tracepoints are disabled.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

That is what I call invoking tracepoints the hard way -- from assembly!
Just one question -- can these tracepoints be invoked from the idle
loop?  If so, you need to use the _rcuidle suffix, for example, as
in trace_opal_entry_rcuidle().  If not:

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
> 
> Index: b/arch/powerpc/include/asm/trace.h
> ===================================================================
> --- a/arch/powerpc/include/asm/trace.h
> +++ b/arch/powerpc/include/asm/trace.h
> @@ -99,6 +99,51 @@ TRACE_EVENT_FN(hcall_exit,
>  );
>  #endif
> 
> +#ifdef CONFIG_PPC_POWERNV
> +extern void opal_tracepoint_regfunc(void);
> +extern void opal_tracepoint_unregfunc(void);
> +
> +TRACE_EVENT_FN(opal_entry,
> +
> +	TP_PROTO(unsigned long opcode, unsigned long *args),
> +
> +	TP_ARGS(opcode, args),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, opcode)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->opcode = opcode;
> +	),
> +
> +	TP_printk("opcode=%lu", __entry->opcode),
> +
> +	opal_tracepoint_regfunc, opal_tracepoint_unregfunc
> +);
> +
> +TRACE_EVENT_FN(opal_exit,
> +
> +	TP_PROTO(unsigned long opcode, unsigned long retval),
> +
> +	TP_ARGS(opcode, retval),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, opcode)
> +		__field(unsigned long, retval)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->opcode = opcode;
> +		__entry->retval = retval;
> +	),
> +
> +	TP_printk("opcode=%lu retval=%lu", __entry->opcode, __entry->retval),
> +
> +	opal_tracepoint_regfunc, opal_tracepoint_unregfunc
> +);
> +#endif
> +
>  #endif /* _TRACE_POWERPC_H */
> 
>  #undef TRACE_INCLUDE_PATH
> Index: b/arch/powerpc/platforms/powernv/Makefile
> ===================================================================
> --- a/arch/powerpc/platforms/powernv/Makefile
> +++ b/arch/powerpc/platforms/powernv/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o
>  obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
>  obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
>  obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
> +obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
> Index: b/arch/powerpc/platforms/powernv/opal-wrappers.S
> ===================================================================
> --- a/arch/powerpc/platforms/powernv/opal-wrappers.S
> +++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
> @@ -13,30 +13,69 @@
>  #include <asm/hvcall.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/opal.h>
> +#include <asm/jump_label.h>
> +
> +	.section	".text"
> +
> +#ifdef CONFIG_TRACEPOINTS
> +#ifdef CONFIG_JUMP_LABEL
> +#define OPAL_BRANCH(LABEL)					\
> +	ARCH_STATIC_BRANCH(LABEL, opal_tracepoint_key)
> +#else
> +
> +	.section	".toc","aw"
> +
> +	.globl opal_tracepoint_refcount
> +opal_tracepoint_refcount:
> +	.llong	0
> +
> +	.section	".text"
> +
> +/*
> + * We branch around this in early init by using an unconditional cpu
> + * feature.
> + */
> +#define OPAL_BRANCH(LABEL)					\
> +BEGIN_FTR_SECTION;						\
> +	b	1f;						\
> +END_FTR_SECTION(0, 1);						\
> +	ld	r12,opal_tracepoint_refcount@toc(r2);		\
> +	std	r12,32(r1);					\
> +	cmpdi	r12,0;						\
> +	bne-	LABEL;						\
> +1:
> +
> +#endif
> +
> +#else
> +#define OPAL_BRANCH(LABEL)
> +#endif
> 
>  /* TODO:
>   *
>   * - Trace irqs in/off (needs saving/restoring all args, argh...)
>   * - Get r11 feed up by Dave so I can have better register usage
>   */
> +
>  #define OPAL_CALL(name, token)		\
>   _GLOBAL(name);				\
>  	mflr	r0;			\
> -	mfcr	r12;			\
>  	std	r0,16(r1);		\
> +	li	r0,token;		\
> +	OPAL_BRANCH(opal_tracepoint_entry) \
> +	mfcr	r12;			\
>  	stw	r12,8(r1);		\
>  	std	r1,PACAR1(r13);		\
> -	li	r0,0;			\
> +	li	r11,0;			\
>  	mfmsr	r12;			\
> -	ori	r0,r0,MSR_EE;		\
> +	ori	r11,r11,MSR_EE;		\
>  	std	r12,PACASAVEDMSR(r13);	\
> -	andc	r12,r12,r0;		\
> +	andc	r12,r12,r11;		\
>  	mtmsrd	r12,1;			\
> -	LOAD_REG_ADDR(r0,opal_return);	\
> -	mtlr	r0;			\
> -	li	r0,MSR_DR|MSR_IR|MSR_LE;\
> -	andc	r12,r12,r0;		\
> -	li	r0,token;		\
> +	LOAD_REG_ADDR(r11,opal_return);	\
> +	mtlr	r11;			\
> +	li	r11,MSR_DR|MSR_IR|MSR_LE;\
> +	andc	r12,r12,r11;		\
>  	mtspr	SPRN_HSRR1,r12;		\
>  	LOAD_REG_ADDR(r11,opal);	\
>  	ld	r12,8(r11);		\
> @@ -61,6 +100,64 @@ opal_return:
>  	mtcr	r4;
>  	rfid
> 
> +#ifdef CONFIG_TRACEPOINTS
> +opal_tracepoint_entry:
> +	stdu	r1,-STACKFRAMESIZE(r1)
> +	std	r0,STK_REG(R23)(r1)
> +	std	r3,STK_REG(R24)(r1)
> +	std	r4,STK_REG(R25)(r1)
> +	std	r5,STK_REG(R26)(r1)
> +	std	r6,STK_REG(R27)(r1)
> +	std	r7,STK_REG(R28)(r1)
> +	std	r8,STK_REG(R29)(r1)
> +	std	r9,STK_REG(R30)(r1)
> +	std	r10,STK_REG(R31)(r1)
> +	mr	r3,r0
> +	addi	r4,r1,STK_REG(R24)
> +	bl	__trace_opal_entry
> +	ld	r0,STK_REG(R23)(r1)
> +	ld	r3,STK_REG(R24)(r1)
> +	ld	r4,STK_REG(R25)(r1)
> +	ld	r5,STK_REG(R26)(r1)
> +	ld	r6,STK_REG(R27)(r1)
> +	ld	r7,STK_REG(R28)(r1)
> +	ld	r8,STK_REG(R29)(r1)
> +	ld	r9,STK_REG(R30)(r1)
> +	ld	r10,STK_REG(R31)(r1)
> +	LOAD_REG_ADDR(r11,opal_tracepoint_return)
> +	mfcr	r12
> +	std	r11,16(r1)
> +	stw	r12,8(r1)
> +	std	r1,PACAR1(r13)
> +	li	r11,0
> +	mfmsr	r12
> +	ori	r11,r11,MSR_EE
> +	std	r12,PACASAVEDMSR(r13)
> +	andc	r12,r12,r11
> +	mtmsrd	r12,1
> +	LOAD_REG_ADDR(r11,opal_return)
> +	mtlr	r11
> +	li	r11,MSR_DR|MSR_IR|MSR_LE
> +	andc	r12,r12,r11
> +	mtspr	SPRN_HSRR1,r12
> +	LOAD_REG_ADDR(r11,opal)
> +	ld	r12,8(r11)
> +	ld	r2,0(r11)
> +	mtspr	SPRN_HSRR0,r12
> +	hrfid
> +
> +opal_tracepoint_return:
> +	std	r3,STK_REG(R31)(r1)
> +	mr	r4,r3
> +	ld	r0,STK_REG(R23)(r1)
> +	bl	__trace_opal_exit
> +	ld	r3,STK_REG(R31)(r1)
> +	addi	r1,r1,STACKFRAMESIZE
> +	ld	r0,16(r1)
> +	mtlr	r0
> +	blr
> +#endif
> +
>  OPAL_CALL(opal_invalid_call,			OPAL_INVALID_CALL);
>  OPAL_CALL(opal_console_write,			OPAL_CONSOLE_WRITE);
>  OPAL_CALL(opal_console_read,			OPAL_CONSOLE_READ);
> Index: b/arch/powerpc/platforms/powernv/opal-tracepoints.c
> ===================================================================
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-tracepoints.c
> @@ -0,0 +1,84 @@
> +#include <linux/percpu.h>
> +#include <linux/jump_label.h>
> +#include <asm/trace.h>
> +
> +#ifdef CONFIG_JUMP_LABEL
> +struct static_key opal_tracepoint_key = STATIC_KEY_INIT;
> +
> +void opal_tracepoint_regfunc(void)
> +{
> +	static_key_slow_inc(&opal_tracepoint_key);
> +}
> +
> +void opal_tracepoint_unregfunc(void)
> +{
> +	static_key_slow_dec(&opal_tracepoint_key);
> +}
> +#else
> +/*
> + * We optimise OPAL calls by placing opal_tracepoint_refcount
> + * directly in the TOC so we can check if the opal tracepoints are
> + * enabled via a single load.
> + */
> +
> +/* NB: reg/unreg are called while guarded with the tracepoints_mutex */
> +extern long opal_tracepoint_refcount;
> +
> +void opal_tracepoint_regfunc(void)
> +{
> +	opal_tracepoint_refcount++;
> +}
> +
> +void opal_tracepoint_unregfunc(void)
> +{
> +	opal_tracepoint_refcount--;
> +}
> +#endif
> +
> +/*
> + * Since the tracing code might execute OPAL calls we need to guard against
> + * recursion.
> + */
> +static DEFINE_PER_CPU(unsigned int, opal_trace_depth);
> +
> +void __trace_opal_entry(unsigned long opcode, unsigned long *args)
> +{
> +	unsigned long flags;
> +	unsigned int *depth;
> +
> +	local_irq_save(flags);
> +
> +	depth = &__get_cpu_var(opal_trace_depth);
> +
> +	if (*depth)
> +		goto out;
> +
> +	(*depth)++;
> +	preempt_disable();
> +	trace_opal_entry(opcode, args);
> +	(*depth)--;
> +
> +out:
> +	local_irq_restore(flags);
> +}
> +
> +void __trace_opal_exit(long opcode, unsigned long retval)
> +{
> +	unsigned long flags;
> +	unsigned int *depth;
> +
> +	local_irq_save(flags);
> +
> +	depth = &__get_cpu_var(opal_trace_depth);
> +
> +	if (*depth)
> +		goto out;
> +
> +	(*depth)++;
> +	trace_opal_exit(opcode, retval);
> +	preempt_enable();
> +	(*depth)--;
> +
> +out:
> +	local_irq_restore(flags);
> +}
> 
