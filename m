Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 144722C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 14:32:21 +1000 (EST)
Message-ID: <1370061135.3766.14.camel@pasglop>
Subject: Re: [PATCH 22/23] powerpc/eeh: Connect EEH error interrupt handle
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:32:15 +1000
In-Reply-To: <1369902245-5886-23-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1369902245-5886-23-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 16:24 +0800, Gavin Shan wrote:
> The EEH error interrupts should have been exported by firmware
> through device tree. The OS already installed the interrupt
> handler (opal_interrupt()) for them. The patch checks if we have
> any existing EEH errors and wakes the kernel thread up to process
> that if possible.

Instead, please create a new notifier that opal interrupt calls whenever
the return even state changes and have PCI "register" with it.

Additionally, we want any caller of opal_poll_events() to instead call
a wrapper that will also check for event changes and signal "clients".

Finally, we need a way to disable/enable that notifying via something
like an atomic counter (no need to hard synchronize with pending calls)
and use it for something like xmon to avoid calling all over the place
when xmon polls for console input via udbg for example.

This is a bit of work, I can give you a hand with it next week.

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 628c564..cca78c9 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -18,6 +18,8 @@
>  #include <linux/slab.h>
>  #include <asm/opal.h>
>  #include <asm/firmware.h>
> +#include <asm/io.h>
> +#include <asm/eeh.h>
>  
>  #include "powernv.h"
>  
> @@ -296,6 +298,10 @@ static irqreturn_t opal_interrupt(int irq, void *data)
>  	uint64_t events;
>  
>  	opal_handle_interrupt(virq_to_hw(irq), &events);
> +#ifdef CONFIG_EEH
> +	if (events & OPAL_EVENT_PCI_ERROR)
> +		pci_err_event();
> +#endif
>  
>  	/* XXX TODO: Do something with the events */
>  
