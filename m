Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3DD821A0100
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 20:16:36 +1100 (AEDT)
Message-ID: <1446542195.23081.5.camel@ellerman.id.au>
Subject: Re: [PATCH V3 2/3] perf/powerpc :add support for sampling intr
 machine state
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T <anju@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: maddy@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, acme@redhat.com, dsahern@gmail.com,
 jolsa@redhat.com,  hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
Date: Tue, 03 Nov 2015 20:16:35 +1100
In-Reply-To: <1446531002-16582-3-git-send-email-anju@linux.vnet.ibm.com>
References: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
 <1446531002-16582-3-git-send-email-anju@linux.vnet.ibm.com>
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

On Tue, 2015-11-03 at 11:40 +0530, Anju T wrote:

> The perf infrastructure uses a bit mask to find out
> valid registers to display. Define a register mask
> for supported registers defined in asm/perf_regs.h.
> The bit positions also correspond to register IDs
> which is used by perf infrastructure to fetch the register
> values.CONFIG_HAVE_PERF_REGS enables
> sampling of the interrupted machine state.

> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
> new file mode 100644
> index 0000000..0520492
> --- /dev/null
> +++ b/arch/powerpc/perf/perf_regs.c
> @@ -0,0 +1,92 @@
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

<snip>

I realise you're following the example of other architectures, but we have
almost this exact same structure in ptrace.c, see regoffset_table.

It would be really nice if we could share them between ptrace and perf.

cheers
