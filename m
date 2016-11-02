Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t84Z04g5QzDt1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 21:47:52 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA2AiFQI023689
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 06:47:49 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26f96cvqv7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 06:47:49 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 20:47:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A59B92CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 21:47:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA2AlhdH64487650
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 21:47:43 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA2Alg5j017898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 21:47:43 +1100
Date: Wed, 2 Nov 2016 16:00:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 lsorense@csclub.uwaterloo.ca, oohall@gmail.com, ast@kernel.org,
 chris@distroguy.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net
Subject: Re: [PATCH 3/3] powerpc: emulate_step test for load/store instructions
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478076783-2872-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <20161102103049.GH6949@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/02 02:23PM, Ravi Bangoria wrote:
> Add new selftest that test emulate_step for Normal, Floating Point,
> Vector and Vector Scalar - load/store instructions. Test should run
> at boot time if CONFIG_KPROBES_SANITY_TEST and CONFIG_PPC64 is set.
> 
> Sample log:
> 
>   [    0.762063] emulate_step smoke test: start.
>   [    0.762219] emulate_step smoke test: ld             : PASS
>   [    0.762434] emulate_step smoke test: lwz            : PASS
>   [    0.762653] emulate_step smoke test: lwzx           : PASS
>   [    0.762867] emulate_step smoke test: std            : PASS
>   [    0.763082] emulate_step smoke test: ldarx / stdcx. : PASS
>   [    0.763302] emulate_step smoke test: lfsx           : PASS
>   [    0.763514] emulate_step smoke test: stfsx          : PASS
>   [    0.763727] emulate_step smoke test: lfdx           : PASS
>   [    0.763942] emulate_step smoke test: stfdx          : PASS
>   [    0.764134] emulate_step smoke test: lvx            : PASS
>   [    0.764349] emulate_step smoke test: stvx           : PASS
>   [    0.764575] emulate_step smoke test: lxvd2x         : PASS
>   [    0.764788] emulate_step smoke test: stxvd2x        : PASS
>   [    0.764997] emulate_step smoke test: complete.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/sstep.h     |   8 +
>  arch/powerpc/kernel/kprobes.c        |   2 +
>  arch/powerpc/lib/Makefile            |   4 +
>  arch/powerpc/lib/test_emulate_step.c | 439 +++++++++++++++++++++++++++++++++++
>  4 files changed, 453 insertions(+)
>  create mode 100644 arch/powerpc/lib/test_emulate_step.c
> 
> diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
> index d3a42cc..d6d3630 100644
> --- a/arch/powerpc/include/asm/sstep.h
> +++ b/arch/powerpc/include/asm/sstep.h
> @@ -87,3 +87,11 @@ struct instruction_op {
> 
>  extern int analyse_instr(struct instruction_op *op, struct pt_regs *regs,
>  			 unsigned int instr);
> +
> +#if defined(CONFIG_KPROBES_SANITY_TEST) && defined(CONFIG_PPC64)
> +void test_emulate_step(void);
> +#else
> +static inline void test_emulate_step(void)
> +{
> +}
> +#endif
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index e785cc9..01d8002 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -544,6 +544,8 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
> 
>  int __init arch_init_kprobes(void)
>  {
> +	test_emulate_step();
> +
>  	return register_kprobe(&trampoline_p);
>  }
> 
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 309361e8..7d046ca 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -35,3 +35,7 @@ obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
>  CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
> 
>  obj-$(CONFIG_PPC64) += $(obj64-y)
> +
> +ifeq ($(CONFIG_PPC64), y)
> +obj-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
> +endif
> diff --git a/arch/powerpc/lib/test_emulate_step.c b/arch/powerpc/lib/test_emulate_step.c
> new file mode 100644
> index 0000000..887d1db
> --- /dev/null
> +++ b/arch/powerpc/lib/test_emulate_step.c
> @@ -0,0 +1,439 @@
> +/*
> + * test_emulate_step.c - simple sanity test for emulate_step load/store
> + *			 instructions
> + *
> + * Copyright IBM Corp. 2016
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> + * the GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) "emulate_step smoke test: " fmt
> +
> +#include <linux/ptrace.h>
> +#include <asm/sstep.h>
> +#include <asm/ppc-opcode.h>
> +
> +#define IMM_L(i)		((uintptr_t)(i) & 0xffff)
> +
> +/*
> + * Defined with TEST_ prefix so it does not conflict with other
> + * definitions.
> + */
> +#define TEST_LD(r, base, i)	(PPC_INST_LD | ___PPC_RT(r) |		\
> +					___PPC_RA(base) | IMM_L(i))
> +#define TEST_LWZ(r, base, i)	(PPC_INST_LWZ | ___PPC_RT(r) |		\
> +					___PPC_RA(base) | IMM_L(i))
> +#define TEST_LWZX(t, a, b)	(PPC_INST_LWZX | ___PPC_RT(t) |		\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_STD(r, base, i)	(PPC_INST_STD | ___PPC_RS(r) |		\
> +					___PPC_RA(base) | ((i) & 0xfffc))
> +#define TEST_LDARX(t, a, b, eh)	(PPC_INST_LDARX | ___PPC_RT(t) |	\
> +					___PPC_RA(a) | ___PPC_RB(b) |	\
> +					__PPC_EH(eh))
> +#define TEST_STDCX(s, a, b)	(PPC_INST_STDCX | ___PPC_RS(s) |	\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_LFSX(t, a, b)	(PPC_INST_LFSX | ___PPC_RT(t) |		\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_STFSX(s, a, b)	(PPC_INST_STFSX | ___PPC_RS(s) |	\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_LFDX(t, a, b)	(PPC_INST_LFDX | ___PPC_RT(t) |		\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_STFDX(s, a, b)	(PPC_INST_STFDX | ___PPC_RS(s) |	\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_LVX(t, a, b)	(PPC_INST_LVX | ___PPC_RT(t) |		\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_STVX(s, a, b)	(PPC_INST_STVX | ___PPC_RS(s) |		\
> +					___PPC_RA(a) | ___PPC_RB(b))
> +#define TEST_LXVD2X(s, a, b)	(PPC_INST_LXVD2X | VSX_XX1((s), R##a, 
> R##b))
> +#define TEST_STXVD2X(s, a, b)	(PPC_INST_STXVD2X | VSX_XX1((s), R##a, R##b))

It will be good to get some of these macros into some generic headers at 
some point...

> +
> +
> +static void init_pt_regs(struct pt_regs *regs)
> +{
> +	static unsigned long msr;
> +	static bool msr_cached;
> +
> +	memset(regs, 0, sizeof(struct pt_regs));
> +
> +	if (likely(msr_cached)) {

Why not just check 'msr' itself here?

- Naveen
