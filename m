Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 677F4B7BA9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 17:03:25 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix potential compile error irqs_disabled_flags
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <6797.1256191115@neuling.org>
Date: Thu, 22 Oct 2009 01:03:19 -0500
Message-Id: <58391C58-B57E-47A8-ACE3-0272C3CF223F@freescale.com>
References: <6797.1256191115@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 22, 2009, at 12:58 AM, Michael Neuling wrote:

> irqs_disabled_flags is #defined in linux/irqflags.h when
> CONFIG_TRACE_IRQFLAGS_SUPPORT is enabled.
>
> This fixes the case when someone needs to include both linux/ 
> irqflags.h
> and asm/hw_irq.h.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> I'm not sure if this is the right fix.  We could just remove
> irqs_disabled_flags but I think that has the possibility of breaking
> 32bit.
>
> arch/powerpc/include/asm/hw_irq.h |    2 ++
> 1 file changed, 2 insertions(+)
>
> Index: linux-2.6-ozlabs/arch/powerpc/include/asm/hw_irq.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/hw_irq.h
> +++ linux-2.6-ozlabs/arch/powerpc/include/asm/hw_irq.h
> @@ -64,10 +64,12 @@ extern void iseries_handle_interrupts(vo
> 		get_paca()->hard_enabled = 0;	\
> 	} while(0)
>
> +#ifndef CONFIG_TRACE_IRQFLAGS_SUPPORT
> static inline int irqs_disabled_flags(unsigned long flags)
> {
> 	return flags == 0;
> }
> +#endif

I think you can just remove irqs_disabled_flags as we always have  
CONFIG_TRACE_IRQFLAGS_SUPPORT (for both 32 and 64).

- k
