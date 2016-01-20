Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1784D1A0E06
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 21:46:17 +1100 (AEDT)
Message-ID: <1453286775.14751.21.camel@ellerman.id.au>
Subject: Re: [PATCH v10 3/4] tools/perf: Map the ID values with register names
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 20 Jan 2016 21:46:15 +1100
In-Reply-To: <1452508104-16507-4-git-send-email-anju@linux.vnet.ibm.com>
References: <1452508104-16507-1-git-send-email-anju@linux.vnet.ibm.com>
 <1452508104-16507-4-git-send-email-anju@linux.vnet.ibm.com>
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

On Mon, 2016-01-11 at 15:58 +0530, Anju T wrote:
> diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
> new file mode 100644
> index 0000000..93080f5
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/include/perf_regs.h
> @@ -0,0 +1,64 @@
> +#ifndef ARCH_PERF_REGS_H
> +#define ARCH_PERF_REGS_H
> +
> +#include <stdlib.h>
> +#include <linux/types.h>
> +#include <asm/perf_regs.h>
> +
> +#define PERF_REGS_MASK  ((1ULL << PERF_REG_POWERPC_MAX) - 1)
> +#define PERF_REGS_MAX   PERF_REG_POWERPC_MAX
> +#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_64

That looks wrong if perf is built 32-bit ?

> +#define PERF_REG_IP     PERF_REG_POWERPC_NIP
> +#define PERF_REG_SP     PERF_REG_POWERPC_GPR1
> +
> +static const char *reg_names[] = {
> +	[PERF_REG_POWERPC_GPR0] = "gpr0",

Can you instead call them "r0" etc.

That is much more common on powerpc than "gpr0".

> +	[PERF_REG_POWERPC_GPR1] = "gpr1",
> +	[PERF_REG_POWERPC_GPR2] = "gpr2",
> +	[PERF_REG_POWERPC_GPR3] = "gpr3",
> +	[PERF_REG_POWERPC_GPR4] = "gpr4",
> +	[PERF_REG_POWERPC_GPR5] = "gpr5",
> +	[PERF_REG_POWERPC_GPR6] = "gpr6",
> +	[PERF_REG_POWERPC_GPR7] = "gpr7",
> +	[PERF_REG_POWERPC_GPR8] = "gpr8",
> +	[PERF_REG_POWERPC_GPR9] = "gpr9",
> +	[PERF_REG_POWERPC_GPR10] = "gpr10",
> +	[PERF_REG_POWERPC_GPR11] = "gpr11",
> +	[PERF_REG_POWERPC_GPR12] = "gpr12",
> +	[PERF_REG_POWERPC_GPR13] = "gpr13",
> +	[PERF_REG_POWERPC_GPR14] = "gpr14",
> +	[PERF_REG_POWERPC_GPR15] = "gpr15",
> +	[PERF_REG_POWERPC_GPR16] = "gpr16",
> +	[PERF_REG_POWERPC_GPR17] = "gpr17",
> +	[PERF_REG_POWERPC_GPR18] = "gpr18",
> +	[PERF_REG_POWERPC_GPR19] = "gpr19",
> +	[PERF_REG_POWERPC_GPR20] = "gpr20",
> +	[PERF_REG_POWERPC_GPR21] = "gpr21",
> +	[PERF_REG_POWERPC_GPR22] = "gpr22",
> +	[PERF_REG_POWERPC_GPR23] = "gpr23",
> +	[PERF_REG_POWERPC_GPR24] = "gpr24",
> +	[PERF_REG_POWERPC_GPR25] = "gpr25",
> +	[PERF_REG_POWERPC_GPR26] = "gpr26",
> +	[PERF_REG_POWERPC_GPR27] = "gpr27",
> +	[PERF_REG_POWERPC_GPR28] = "gpr28",
> +	[PERF_REG_POWERPC_GPR29] = "gpr29",
> +	[PERF_REG_POWERPC_GPR30] = "gpr30",
> +	[PERF_REG_POWERPC_GPR31] = "gpr31",
> +	[PERF_REG_POWERPC_NIP] = "nip",
> +	[PERF_REG_POWERPC_MSR] = "msr",
> +	[PERF_REG_POWERPC_ORIG_R3] = "orig_r3",
> +	[PERF_REG_POWERPC_CTR] = "ctr",
> +	[PERF_REG_POWERPC_LNK] = "link",
> +	[PERF_REG_POWERPC_XER] = "xer",
> +	[PERF_REG_POWERPC_CCR] = "ccr",
> +	[PERF_REG_POWERPC_TRAP] = "trap",
> +	[PERF_REG_POWERPC_DAR] = "dar",
> +	[PERF_REG_POWERPC_DSISR] = "dsisr"
> +};
> +
> +static inline const char *perf_reg_name(int id)
> +{
> +	return reg_names[id];
> +}
> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
> index 38a0853..62a2f2d 100644
> --- a/tools/perf/config/Makefile
> +++ b/tools/perf/config/Makefile
> @@ -23,6 +23,11 @@ $(call detected_var,ARCH)
>  
>  NO_PERF_REGS := 1
>  
> +# Additional ARCH settings for ppc64
> +ifeq ($(ARCH),powerpc)

powerpc also includes ppc, ie. 32-bit, so the comment is wrong.

> +  NO_PERF_REGS := 0
> +endif
> +
>  # Additional ARCH settings for x86
>  ifeq ($(ARCH),x86)
>    $(call detected,CONFIG_X86)
