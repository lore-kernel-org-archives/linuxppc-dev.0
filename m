Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnbMR0Y0wzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:50:27 +1000 (AEST)
Date: Wed, 14 Jun 2017 14:50:21 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kernel/kprobes: Add test to validate pt_regs
Message-Id: <20170614145021.c03516140569a1302969e0ec@kernel.org>
In-Reply-To: <20170614114008.f9f4caffcb971751f2d00066@kernel.org>
References: <20170608192308.22278-1-naveen.n.rao@linux.vnet.ibm.com>
 <20170614114008.f9f4caffcb971751f2d00066@kernel.org>
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

On Wed, 14 Jun 2017 11:40:08 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri,  9 Jun 2017 00:53:08 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Add a test to verify that the registers passed in pt_regs on kprobe
> > (trap), optprobe (jump) and kprobe_on_ftrace (ftrace_caller) are
> > accurate. The tests are exercized if KPROBES_SANITY_TEST is enabled.
> 
> Great!
> 
> > 
> > Implemented for powerpc64. Other architectures will have to implement
> > the relevant arch_* helpers and define HAVE_KPROBES_REGS_SANITY_TEST.
> 
> Hmm, why don't you define that in arch/powerpc/Kconfig ?
> Also, could you split this into 3 patches for each case ?
> 
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/kprobes.h  |   4 +
> >  arch/powerpc/lib/Makefile           |   3 +-
> >  arch/powerpc/lib/test_kprobe_regs.S |  62 ++++++++++++
> >  arch/powerpc/lib/test_kprobes.c     | 115 ++++++++++++++++++++++
> >  include/linux/kprobes.h             |  11 +++
> >  kernel/test_kprobes.c               | 183 ++++++++++++++++++++++++++++++++++++
> >  6 files changed, 377 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/powerpc/lib/test_kprobe_regs.S
> >  create mode 100644 arch/powerpc/lib/test_kprobes.c
> > 
> > diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
> > index 566da372e02b..10c91d3132a1 100644
> > --- a/arch/powerpc/include/asm/kprobes.h
> > +++ b/arch/powerpc/include/asm/kprobes.h
> > @@ -124,6 +124,10 @@ static inline int skip_singlestep(struct kprobe *p, struct pt_regs *regs,
> >  	return 0;
> >  }
> >  #endif
> > +#if defined(CONFIG_KPROBES_SANITY_TEST) && defined(CONFIG_PPC64)
> > +#define HAVE_KPROBES_REGS_SANITY_TEST
> > +void arch_kprobe_regs_set_ptregs(struct pt_regs *regs);
> > +#endif
> >  #else
> >  static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
> >  static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
> > diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> > index 3c3146ba62da..8a0bb8e20179 100644
> > --- a/arch/powerpc/lib/Makefile
> > +++ b/arch/powerpc/lib/Makefile
> > @@ -27,7 +27,8 @@ obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
> >  
> >  obj64-$(CONFIG_SMP)	+= locks.o
> >  obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
> > -obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
> > +obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o test_kprobe_regs.o \
> > +				       test_kprobes.o
> >  
> >  obj-y			+= checksum_$(BITS).o checksum_wrappers.o
> >  
> > diff --git a/arch/powerpc/lib/test_kprobe_regs.S b/arch/powerpc/lib/test_kprobe_regs.S
> > new file mode 100644
> > index 000000000000..4e95eca6dcd3
> > --- /dev/null
> > +++ b/arch/powerpc/lib/test_kprobe_regs.S
> > @@ -0,0 +1,62 @@
> > +/*
> > + * test_kprobe_regs: architectural helpers for validating pt_regs
> > + *		     received on a kprobe.
> > + *
> > + * Copyright 2017 Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > + *		  IBM Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2
> > + * of the License.
> > + */
> > +
> > +#include <asm/ppc_asm.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/ptrace.h>
> > +
> > +_GLOBAL(arch_kprobe_regs_function)
> > +	mflr	r0
> > +	std	r0, LRSAVE(r1)
> > +	stdu	r1, -SWITCH_FRAME_SIZE(r1)
> > +
> > +	/* Tell pre handler about our pt_regs location */
> > +	addi	r3, r1, STACK_FRAME_OVERHEAD
> > +	bl	arch_kprobe_regs_set_ptregs
> > +
> > +	/* Load back our true LR */
> > +	ld	r0, (SWITCH_FRAME_SIZE + LRSAVE)(r1)
> > +	mtlr	r0
> > +
> > +	/* Save all SPRs that we care about */
> > +	mfctr	r0
> > +	std	r0, _CTR(r1)
> > +	mflr	r0
> > +	std	r0, _LINK(r1)
> > +	mfspr	r0, SPRN_XER
> > +	std	r0, _XER(r1)
> > +	mfcr	r0
> > +	std	r0, _CCR(r1)
> > +
> > +	/* Now, save all GPRs */
> > +	SAVE_2GPRS(0, r1)
> > +	SAVE_10GPRS(2, r1)
> > +	SAVE_10GPRS(12, r1)
> > +	SAVE_10GPRS(22, r1)
> > +
> > +	/* We're now ready to be probed */
> > +.global arch_kprobe_regs_probepoint
> > +arch_kprobe_regs_probepoint:
> > +	nop
> > +
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +	/* Let's also test KPROBES_ON_FTRACE */
> > +	bl	kprobe_regs_kp_on_ftrace_target
> > +	nop
> > +#endif
> > +
> > +	/* All done */
> > +	addi	r1, r1, SWITCH_FRAME_SIZE
> > +	ld	r0, LRSAVE(r1)
> > +	mtlr	r0
> > +	blr
> > diff --git a/arch/powerpc/lib/test_kprobes.c b/arch/powerpc/lib/test_kprobes.c
> > new file mode 100644
> > index 000000000000..23f7a7ffcdd6
> > --- /dev/null
> > +++ b/arch/powerpc/lib/test_kprobes.c
> > @@ -0,0 +1,115 @@
> > +/*
> > + * test_kprobes: architectural helpers for validating pt_regs
> > + *		 received on a kprobe.
> > + *
> > + * Copyright 2017 Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > + *		  IBM Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; version 2
> > + * of the License.
> > + */
> > +
> > +#define pr_fmt(fmt) "Kprobe smoke test (regs): " fmt
> > +
> > +#include <asm/ptrace.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kprobes.h>
> > +
> > +static struct pt_regs *r;
> > +
> > +void arch_kprobe_regs_set_ptregs(struct pt_regs *regs)
> > +{
> > +	r = regs;
> > +}
> > +
> > +static int validate_regs(struct kprobe *p, struct pt_regs *regs,
> > +					int kp_on_ftrace, int post_handler)
> > +{
> > +	int i, ret = 1;
> > +
> > +	if (!r) {
> > +		pr_err("pt_regs not setup!\n");
> > +		return 0;
> > +	}
> > +
> > +	if (regs->gpr[1] + STACK_FRAME_OVERHEAD != (unsigned long)r) {
> > +		/* We'll continue since this may just indicate an incorrect r1 */
> > +		pr_err("pt_regs pointer/r1 doesn't point where we expect!\n");
> > +		ret = 0;
> > +	}
> > +
> > +	for (i = 0; i < 32; i++) {
> > +		/* KPROBES_ON_FTRACE may have stomped r0 in the prologue */
> > +		if (r->gpr[i] != regs->gpr[i] && (!kp_on_ftrace || i != 0)) {
> > +			pr_err("gpr[%d] expected: 0x%lx, received: 0x%lx\n",
> > +						i, r->gpr[i], regs->gpr[i]);
> > +			ret = 0;
> > +		}
> > +	}

Hmm, is this check really needed? See below(*)

> > +
> > +	if (r->ctr != regs->ctr) {
> > +		pr_err("ctr expected: 0x%lx, received: 0x%lx\n",
> > +					r->ctr, regs->ctr);
> > +		ret = 0;
> > +	}
> > +
> > +	if (r->link != regs->link && !kp_on_ftrace) {
> > +		pr_err("link expected: 0x%lx, received: 0x%lx\n",
> > +					r->link, regs->link);
> > +		ret = 0;
> > +	}
> > +
> > +	/* KPROBES_ON_FTRACE *must* have clobbered link */
> > +	if (r->link == regs->link && kp_on_ftrace) {
> > +		pr_err("link register not clobbered for KPROBES_ON_FTRACE!\n");
> > +		ret = 0;
> > +	}
> > +
> > +	if (r->xer != regs->xer) {
> > +		pr_err("xer expected: 0x%lx, received: 0x%lx\n",
> > +					r->xer, regs->xer);
> > +		ret = 0;
> > +	}
> > +
> > +	if (r->ccr != regs->ccr) {
> > +		pr_err("ccr expected: 0x%lx, received: 0x%lx\n",
> > +					r->ccr, regs->ccr);
> > +		ret = 0;
> > +	}
> > +
> > +	if (!post_handler && regs->nip != (unsigned long)p->addr) {
> > +		pr_err("nip expected: 0x%lx, received: 0x%lx\n",
> > +					(unsigned long)p->addr, regs->nip);
> > +		ret = 0;
> > +	}
> > +
> > +	if (post_handler &&
> > +		regs->nip != (unsigned long)p->addr + sizeof(kprobe_opcode_t)) {
> > +		pr_err("post_handler: nip expected: 0x%lx, received: 0x%lx\n",
> > +				(unsigned long)p->addr + sizeof(kprobe_opcode_t),
> > +				regs->nip);
> > +		ret = 0;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +int arch_kprobe_regs_pre_handler(struct kprobe *p, struct pt_regs *regs)
> > +{
> > +	return validate_regs(p, regs, 0, 0);
> > +}
> > +
> > +int arch_kprobe_regs_post_handler(struct kprobe *p, struct pt_regs *regs,
> > +							unsigned long flags)
> > +{
> > +	return validate_regs(p, regs, 0, 1);
> > +}
> > +
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +int arch_kp_on_ftrace_pre_handler(struct kprobe *p, struct pt_regs *regs)
> > +{
> > +	return validate_regs(p, regs, 1, 0);
> > +}
> > +#endif
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index 541df0b5b815..adfbb5b27acd 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -253,6 +253,17 @@ static inline void kretprobe_assert(struct kretprobe_instance *ri,
> >  
> >  #ifdef CONFIG_KPROBES_SANITY_TEST
> >  extern int init_test_probes(void);
> > +#ifdef HAVE_KPROBES_REGS_SANITY_TEST
> > +extern void arch_kprobe_regs_function(void);
> > +extern void arch_kprobe_regs_probepoint(void);
> > +extern int arch_kprobe_regs_pre_handler(struct kprobe *p, struct pt_regs *regs);
> > +extern int arch_kprobe_regs_post_handler(struct kprobe *p, struct pt_regs *regs,
> > +						unsigned long flags);
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +extern void kprobe_regs_kp_on_ftrace_target(void);
> > +extern int arch_kp_on_ftrace_pre_handler(struct kprobe *p, struct pt_regs *regs);
> > +#endif
> > +#endif
> >  #else
> >  static inline int init_test_probes(void)
> >  {
> > diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
> > index 0dbab6d1acb4..92011726cc69 100644
> > --- a/kernel/test_kprobes.c
> > +++ b/kernel/test_kprobes.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/kprobes.h>
> >  #include <linux/random.h>
> > +#include <linux/workqueue.h>
> >  
> >  #define div_factor 3
> >  
> > @@ -334,6 +335,166 @@ static int test_kretprobes(void)
> >  }
> >  #endif /* CONFIG_KRETPROBES */
> >  
> > +#ifdef HAVE_KPROBES_REGS_SANITY_TEST
> > +static int kprobe_regs_pre_handler(struct kprobe *p, struct pt_regs *regs)
> > +{
> > +	/* architectural helper returns 0 if validation fails */
> > +	preh_val = arch_kprobe_regs_pre_handler(p, regs);
> > +	return 0;
> > +}
> > +
> > +static void kprobe_regs_post_handler(struct kprobe *p, struct pt_regs *regs,
> > +						unsigned long flags)
> > +{
> > +	posth_val = arch_kprobe_regs_post_handler(p, regs, flags);
> > +}
> > +
> > +static struct kprobe kpr = {
> > +	.symbol_name = "arch_kprobe_regs_probepoint",
> > +	.pre_handler = kprobe_regs_pre_handler,
> > +	.post_handler = kprobe_regs_post_handler,
> > +};
> > +


> > +static int test_kprobe_regs(void)
> > +{
> > +	int ret;
> > +	kprobe_opcode_t *addr;
> > +
> > +	preh_val = 0;
> > +	posth_val = 0;
> > +
> > +	ret = register_kprobe(&kpr);
> > +	if (ret < 0) {
> > +		pr_err("register_kprobe returned %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Let's see if this probe was optimized */
> > +	addr = kprobe_lookup_name(kpr.symbol_name, 0);

What happen if addr == NULL?
Since this already done in register_kprobe, you'd better use
kpr.addr.

> > +	if (addr && *addr != BREAKPOINT_INSTRUCTION) {
> > +		pr_err("kprobe with post_handler optimized\n");

Hmm, this message is not appropriate if the arch doesn't support
optprobe. Moreover, using BREAKPOINT_INSTRUCTION or not depends
on each arch. So, I suggest this as;

if (kprobe_optimized(&kpr)) {
	pr_err("kprobe with post_handler optimized\n");
	goto error;

And if you would like to check the instruction, please use 
probe_kernel_read(), and introduce arch-depend helper as
below;

} else if (arch_kprobe_validate_insn(&kpr)) {
	pr_err("kprobe breakpoint is not armed\n");
	goto error;
}

Where (typical case, like ppc), 

int arch_kprobe_validate_insn(struct kprobe *kp)
{
	kprobe_opcode_t buf;
	int ret;

	ret = probe_kernel_read(&buf, kp->addr, sizeof(buf));
	if (ret)
		return ret;
	if (buf != BREAKPOINT_INSTRUCTION)
		return -EINVAL;
	return 0;
}

> > +		unregister_kprobe(&kpr);
> > +		return -1;
> > +	}
> > +
> > +	arch_kprobe_regs_function();
> > +	unregister_kprobe(&kpr);
> > +
> > +	if (preh_val == 0) {
> > +		pr_err("kprobe pre_handler regs validation failed\n");
> > +		handler_errors++;
> > +	}
> > +
> > +	if (posth_val == 0) {
> > +		pr_err("kprobe post_handler not called\n");
> > +		handler_errors++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +

> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +void kprobe_regs_kp_on_ftrace_target(void)
> > +{
> > +	posth_val = preh_val + div_factor;
> > +}
> > +
> > +static int kp_on_ftrace_pre_handler(struct kprobe *p, struct pt_regs *regs)
> > +{
> > +	/* architectural helper returns 0 if validation fails */
> > +	preh_val = arch_kp_on_ftrace_pre_handler(p, regs);

Here, I think you'd better to call arch_kprobe_regs_pre_handler(p, regs);
so that user can sure the handler's behavior has no difference.

(*) If you would like to check the kprobe_on_ftrace arch inplementation,
it should be a separated function, like

arch_validate_kprobe_on_ftrace(p, regs);

> > +	return 0;
> > +}
> > +
> > +static struct kprobe kprf = {
> > +	.symbol_name = "kprobe_regs_kp_on_ftrace_target",
> > +	.pre_handler = kp_on_ftrace_pre_handler,

Also, we'd better add post_handler here so that it is able to check
compatibilty.

> > +};
> > +
> > +static int test_kp_on_ftrace_regs(void)
> > +{
> > +	int ret;
> > +
> > +	preh_val = 0;
> > +
> > +	ret = register_kprobe(&kprf);
> > +	if (ret < 0) {
> > +		pr_err("register_kprobe returned %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	arch_kprobe_regs_function();
> > +	unregister_kprobe(&kprf);
> > +
> > +	if (preh_val == 0) {
> > +		pr_err("kp_on_ftrace pre_handler regs validation failed\n");
> > +		handler_errors++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +#ifdef CONFIG_OPTPROBES
> > +static void test_optprobe_regs(struct work_struct *work);
> > +static DECLARE_DELAYED_WORK(test_optprobe_regs_work, test_optprobe_regs);
> > +int kprobe_registered;
> > +
> > +static struct kprobe kpor = {
> > +	.symbol_name = "arch_kprobe_regs_probepoint",
> > +	.pre_handler = kprobe_regs_pre_handler,
> > +};
> > +
> > +static void test_optprobe_regs_setup(void)
> > +{
> > +	int ret;
> > +
> > +	ret = register_kprobe(&kpor);
> > +	if (ret < 0) {
> > +		pr_err("register_kprobe returned %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	kprobe_registered = 1;
> > +}
> > +
> > +static void test_optprobe_regs(struct work_struct *work)
> > +{
> > +	kprobe_opcode_t *addr;
> > +
> > +	if (!kprobe_registered) {
> > +		errors++;
> > +		goto summary;
> > +	}
> > +
> > +	/* Let's see if this probe was optimized */
> > +	addr = kprobe_lookup_name(kpor.symbol_name, 0);
> > +	if (addr && *addr == BREAKPOINT_INSTRUCTION) {

Here, same as above, we need arch_optprobe_validate_insn(kp).

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
