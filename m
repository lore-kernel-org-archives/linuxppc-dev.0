Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0BB41A0512
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 11:08:39 +1100 (AEDT)
Message-ID: <1424045319.3018.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: re-enable dynticks
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Clarke <pc@us.ibm.com>
Date: Mon, 16 Feb 2015 11:08:39 +1100
In-Reply-To: <54DE52BC.3020303@us.ibm.com>
References: <54DE52BC.3020303@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2015-02-13 at 13:38 -0600, Paul Clarke wrote:
> implement arch_irq_work_has_interrupt() for powerpc
> 
> Commit 9b01f5bf3 introduced a dependency on "IRQ work self-IPIs" for 
> full dynamic ticks to be enabled, by expecting architectures to 
> implement a suitable arch_irq_work_has_interrupt() routine.
> 
> Several arches have implemented this routine, including x86 (3010279f) 
> and arm (09f6edd4), but powerpc was omitted.
> 
> This patch implements this routine for powerpc.
> 
> The symptom, at boot (on powerpc arch systems) with "nohz_full=<CPU 
> list>" is displayed:
>      NO_HZ: Can't run full dynticks because arch doesn't support irq 
> work self-IPIs
> 
> after this patch:
>      NO_HZ: Full dynticks CPUs: <CPU list>.
> 
> Tested against 3.19.

It makes the message change, but is that correct? ie. do we actually implement
"IRQ work self-IPIs"?

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

Should be "true";

> +}

cheers
