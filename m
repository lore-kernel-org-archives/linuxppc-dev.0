Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E8FD1A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 15:21:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 20 Oct 2015 14:21:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2F9AA2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 15:21:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9K4LLCT29491400
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 15:21:30 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9K4L2IW005987
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 15:21:02 +1100
Subject: Re: [RFC][PATCH 3/3]perf/powerpc :add support for sampling intr
 machine state
To: linux-kernel@vger.kernel.org, Anju <anju@linux.vnet.ibm.com>
References: <1445257133-27646-1-git-send-email-anju@linux.vnet.ibm.com>
 <1445257133-27646-4-git-send-email-anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com, acme@redhat.com,
 mpe@ellerman.id.au, dsahern@gmail.com, jolsa@redhat.com,
 khandual@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <5625C119.90808@linux.vnet.ibm.com>
Date: Tue, 20 Oct 2015 09:50:41 +0530
MIME-Version: 1.0
In-Reply-To: <1445257133-27646-4-git-send-email-anju@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 19 October 2015 05:48 PM, Anju T wrote:
> From: Anju <anju@linux.vnet.ibm.com>
>
> The registers to sample are passed through the sample_regs_intr bitmask.
> The name and bit position for each register is defined in asm/perf_regs.h.
> This feature can be enabled by using -I option with perf  record command.
> To display the sampled register values use perf script -D.
> The kernel uses the "PERF" register ids to find offset of the register in 'struct pt_regs'.
> CONFIG_HAVE_PERF_REGS will enable sampling of the interrupted machine state.
>
> Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig          |  1 +
>  arch/powerpc/perf/Makefile    |  2 +-
>  arch/powerpc/perf/perf_regs.c | 85 +++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/config/Makefile    |  4 ++
>  4 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/perf/perf_regs.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9a7057e..c4ce60d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -119,6 +119,7 @@ config PPC
>  	select GENERIC_ATOMIC64 if PPC32
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select HAVE_PERF_EVENTS
> +	select HAVE_PERF_REGS
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>  	select ARCH_WANT_IPC_PARSE_VERSION
> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> index f9c083a..8e7f545 100644
> --- a/arch/powerpc/perf/Makefile
> +++ b/arch/powerpc/perf/Makefile
> @@ -7,7 +7,7 @@ obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
>  				   power5+-pmu.o power6-pmu.o power7-pmu.o \
>  				   power8-pmu.o
>  obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
> -
> +obj-$(CONFIG_PERF_EVENTS)      	+= perf_regs.o
>  obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
>  obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
>
> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
> new file mode 100644
> index 0000000..7a71de2
> --- /dev/null
> +++ b/arch/powerpc/perf/perf_regs.c
> @@ -0,0 +1,85 @@
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/perf_event.h>
> +#include <linux/bug.h>
> +#include <linux/stddef.h>
> +#include <asm/ptrace.h>
> +#include <asm/perf_regs.h>
> +
> +#define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
> +
> +#define REG_RESERVED (~((1ULL << PERF_REG_POWERPC_MAX) - 1))
> +
> +static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR0, gpr[0]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR1, gpr[1]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR2, gpr[2]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR3, gpr[3]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR4, gpr[4]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR5, gpr[5]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR6, gpr[6]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR7, gpr[7]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR8, gpr[8]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR9, gpr[9]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR10, gpr[10]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR11, gpr[11]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR12, gpr[12]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR13, gpr[13]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR14, gpr[14]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR15, gpr[15]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR16, gpr[16]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR17, gpr[17]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR18, gpr[18]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR19, gpr[19]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR20, gpr[20]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR21, gpr[21]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR22, gpr[22]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR23, gpr[23]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR24, gpr[24]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR25, gpr[25]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR26, gpr[26]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR27, gpr[27]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR28, gpr[28]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR29, gpr[29]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR30, gpr[30]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR31, gpr[31]),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_NIP, nip),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_MSR, msr),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_ORIG_R3, orig_gpr3),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_CTR, ctr),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_LNK, link),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_XER, xer),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_CCR, ccr),
> +#ifdef __powerpc64__
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_SOFTE, softe),
> +#else
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_MQ, mq),
> +#endif
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_RESULT, result),
> +};
> +u64 perf_reg_value(struct pt_regs *regs, int idx)
> +{
> +	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
> +		return 0;
> +	return regs_get_register(regs, pt_regs_offset[idx]);
> +}
> +int perf_reg_validate(u64 mask)
> +{
> +	if (!mask || mask & REG_RESERVED)
> +		return -EINVAL;
> +	return 0;
> +}
> +u64 perf_reg_abi(struct task_struct *task)
> +{
> +	return PERF_SAMPLE_REGS_ABI_64;
> +}
> +void perf_get_regs_user(struct perf_regs *regs_user,
> +			struct pt_regs *regs,
> +			struct pt_regs *regs_user_copy)
> +{

Kindly add comment to update the function when
enabling perf_sample_reg_user.

Maddy
> +	return;
> +}
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index 827557f..4da9190 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -22,6 +22,10 @@ include $(src-perf)/config/Makefile.arch
>  $(call detected_var,ARCH)
>
>  NO_PERF_REGS := 1
> +#Additional ARCH settings for ppc64
> +ifeq ($(ARCH),powerpc)
> +	NO_PERF_REGS :=0
> +endif
>
>  # Additional ARCH settings for x86
>  ifeq ($(ARCH),x86)
