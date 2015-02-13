Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 947981A0CC8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Feb 2015 07:42:41 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 13 Feb 2015 13:42:39 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3279A19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:33:46 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1DKgaqs50462774
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:42:36 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1DKgawd025273
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Feb 2015 13:42:36 -0700
Date: Fri, 13 Feb 2015 12:42:35 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH] powerpc: re-enable dynticks
Message-ID: <20150213204234.GA8884@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <54DE52BC.3020303@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54DE52BC.3020303@us.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 13, 2015 at 01:38:36PM -0600, Paul Clarke wrote:
> implement arch_irq_work_has_interrupt() for powerpc
> 
> Commit 9b01f5bf3 introduced a dependency on "IRQ work self-IPIs" for
> full dynamic ticks to be enabled, by expecting architectures to
> implement a suitable arch_irq_work_has_interrupt() routine.
> 
> Several arches have implemented this routine, including x86
> (3010279f) and arm (09f6edd4), but powerpc was omitted.
> 
> This patch implements this routine for powerpc.
> 
> The symptom, at boot (on powerpc arch systems) with "nohz_full=<CPU
> list>" is displayed:
>     NO_HZ: Can't run full dynticks because arch doesn't support irq
> work self-IPIs
> 
> after this patch:
>     NO_HZ: Full dynticks CPUs: <CPU list>.
> 
> Tested against 3.19.
> 
> CC: Frederic Weisbecker <fweisbec@gmail.com>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> diff --git a/arch/powerpc/include/asm/irq_work.h
> b/arch/powerpc/include/asm/irq_work.h
> new file mode 100644
> index 0000000..18365ec
> --- /dev/null
> +++ b/arch/powerpc/include/asm/irq_work.h
> @@ -0,0 +1,11 @@
> +#ifndef _ASM_IRQ_WORK_H
> +#define _ASM_IRQ_WORK_H
> +
> +#include <asm/processor.h>
> +
> +static inline bool arch_irq_work_has_interrupt(void)
> +{
> +	return 1;
> +}
> +
> +#endif /* _ASM_IRQ_WORK_H */
> 
> --
> Regards,
> Paul Clarke, IBM
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
