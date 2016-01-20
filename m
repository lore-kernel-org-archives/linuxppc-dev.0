Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 096F61A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 21:40:27 +1100 (AEDT)
Message-ID: <1453286426.14751.19.camel@ellerman.id.au>
Subject: Re: [PATCH V10 2/4] perf/powerpc: add support for sampling intr
 machine state
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 20 Jan 2016 21:40:26 +1100
In-Reply-To: <1452508104-16507-3-git-send-email-anju@linux.vnet.ibm.com>
References: <1452508104-16507-1-git-send-email-anju@linux.vnet.ibm.com>
 <1452508104-16507-3-git-send-email-anju@linux.vnet.ibm.com>
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
> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
> new file mode 100644
> index 0000000..d32581763
> --- /dev/null
> +++ b/arch/powerpc/perf/perf_regs.c
...
> +
> +u64 perf_reg_abi(struct task_struct *task)
> +{
> +	return PERF_SAMPLE_REGS_ABI_64;

What is this value used for exactly?

It seems like on 32-bit kernels we should be returning PERF_SAMPLE_REGS_ABI_32.

> +}
> +
> +void perf_get_regs_user(struct perf_regs *regs_user,
> +			struct pt_regs *regs,
> +			struct pt_regs *regs_user_copy)
> +{
> +	regs_user->regs = task_pt_regs(current);
> +	regs_user->abi  = perf_reg_abi(current);
> +}

cheers
