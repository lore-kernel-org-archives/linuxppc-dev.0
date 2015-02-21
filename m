Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A36EA1A0F56
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 16:18:52 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 20 Feb 2015 22:18:49 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6E6E51FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 22:09:59 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1L5IlO635455110
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 22:18:47 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1L5IlIQ003214
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 22:18:47 -0700
Date: Fri, 20 Feb 2015 21:18:45 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH v2] powerpc: re-enable dynticks
Message-ID: <20150221051845.GS5745@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <54DE52BC.3020303@us.ibm.com>
 <1424045319.3018.2.camel@ellerman.id.au>
 <54E76B3D.1010909@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54E76B3D.1010909@us.ibm.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 20, 2015 at 11:13:33AM -0600, Paul Clarke wrote:
> 
> implement arch_irq_work_has_interrupt() for powerpc
> 
> (resending because I messed up the e-mail addresses)
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
> v2: changed "return 1" to "return true", per Michael Ellerman
> 
> CC: Frederic Weisbecker <fweisbec@gmail.com>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> diff --git a/arch/powerpc/include/asm/irq_work.h
> b/arch/powerpc/include/asm/irq_work.h
> new file mode 100644
> index 0000000..99cc0aa
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
> +    return true;
> +}
> +
> +#endif /* _ASM_IRQ_WORK_H */
