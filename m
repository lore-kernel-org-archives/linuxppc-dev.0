Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 593561A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 21:38:54 +1100 (AEDT)
Message-ID: <1453286327.14751.17.camel@ellerman.id.au>
Subject: Re: [PATCH V10 1/4] perf/powerpc: assign an id to each powerpc
 register
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 20 Jan 2016 21:38:47 +1100
In-Reply-To: <1452508104-16507-2-git-send-email-anju@linux.vnet.ibm.com>
References: <1452508104-16507-1-git-send-email-anju@linux.vnet.ibm.com>
 <1452508104-16507-2-git-send-email-anju@linux.vnet.ibm.com>
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

Hi Anju,

On Mon, 2016-01-11 at 15:58 +0530, Anju T wrote:

> The enum definition assigns an 'id' to each register in "struct pt_regs"
> of arch/powerpc. The order of these values in the enum definition are
> based on the corresponding macros in arch/powerpc/include/uapi/asm/ptrace.h.

Sorry one thing ...

> diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..cfbd068
> --- /dev/null
> +++ b/arch/powerpc/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,49 @@
> +#ifndef _ASM_POWERPC_PERF_REGS_H
> +#define _ASM_POWERPC_PERF_REGS_H
> +
> +enum perf_event_powerpc_regs {
> +	PERF_REG_POWERPC_GPR0,
> +	PERF_REG_POWERPC_GPR1,
> +	PERF_REG_POWERPC_GPR2,
> +	PERF_REG_POWERPC_GPR3,
> +	PERF_REG_POWERPC_GPR4,
> +	PERF_REG_POWERPC_GPR5,
> +	PERF_REG_POWERPC_GPR6,
> +	PERF_REG_POWERPC_GPR7,
> +	PERF_REG_POWERPC_GPR8,
> +	PERF_REG_POWERPC_GPR9,
> +	PERF_REG_POWERPC_GPR10,
> +	PERF_REG_POWERPC_GPR11,
> +	PERF_REG_POWERPC_GPR12,
> +	PERF_REG_POWERPC_GPR13,
> +	PERF_REG_POWERPC_GPR14,
> +	PERF_REG_POWERPC_GPR15,
> +	PERF_REG_POWERPC_GPR16,
> +	PERF_REG_POWERPC_GPR17,
> +	PERF_REG_POWERPC_GPR18,
> +	PERF_REG_POWERPC_GPR19,
> +	PERF_REG_POWERPC_GPR20,
> +	PERF_REG_POWERPC_GPR21,
> +	PERF_REG_POWERPC_GPR22,
> +	PERF_REG_POWERPC_GPR23,
> +	PERF_REG_POWERPC_GPR24,
> +	PERF_REG_POWERPC_GPR25,
> +	PERF_REG_POWERPC_GPR26,
> +	PERF_REG_POWERPC_GPR27,
> +	PERF_REG_POWERPC_GPR28,
> +	PERF_REG_POWERPC_GPR29,
> +	PERF_REG_POWERPC_GPR30,
> +	PERF_REG_POWERPC_GPR31,
> +	PERF_REG_POWERPC_NIP,
> +	PERF_REG_POWERPC_MSR,
> +	PERF_REG_POWERPC_ORIG_R3,
> +	PERF_REG_POWERPC_CTR,
> +	PERF_REG_POWERPC_LNK,
> +	PERF_REG_POWERPC_XER,
> +	PERF_REG_POWERPC_CCR,

You skipped SOFTE here at my suggestion, because it's called MQ on 32-bit.

But I've changed my mind, I think we *should* define SOFTE, and ignore MQ,
because MQ is unused. So just add:

  +	PERF_REG_POWERPC_SOFTE,


> +	PERF_REG_POWERPC_TRAP,
> +	PERF_REG_POWERPC_DAR,
> +	PERF_REG_POWERPC_DSISR,
> +	PERF_REG_POWERPC_MAX,
> +};
> +#endif /* _ASM_POWERPC_PERF_REGS_H */

cheers
