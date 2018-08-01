Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gWVk5nF9zF10S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 21:37:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/opal: Use standard interrupts property
 when available
In-Reply-To: <1523344570.11062.65.camel@kernel.crashing.org>
References: <1523344570.11062.65.camel@kernel.crashing.org>
Date: Wed, 01 Aug 2018 21:37:00 +1000
Message-ID: <87o9emfhcz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
> index 9d1b8c0aaf93..46785eaf625d 100644
> --- a/arch/powerpc/platforms/powernv/opal-irqchip.c
> +++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
> @@ -216,67 +214,91 @@ int __init opal_event_init(void)
...
>  
>  	/* Install interrupt handlers */
>  	for (i = 0; i < opal_irq_count; i++) {
> -		unsigned int virq;
> -		char *name;
> +		struct resource *r = &opal_irqs[i];
> +		const char *name;
>  
> -		/* Get hardware and virtual IRQ */
> -		virq = irq_create_mapping(NULL, irqs[i]);
> -		if (!virq) {
> -			pr_warn("Failed to map irq 0x%x\n", irqs[i]);
> -			continue;
> -		}
> -
> -		if (names[i] && strlen(names[i]))
> -			name = kasprintf(GFP_KERNEL, "opal-%s", names[i]);
> +		/* Prefix name */
> +		if (r->name)
> +			name = kasprintf(GFP_KERNEL, "opal-%s", r->name);
>  		else
>  			name = kasprintf(GFP_KERNEL, "opal");

I'm getting:

root@p85:/proc/irq# find . -name '*opal*'
...
./63/opal-ipmi
./227/opal-
./228/opal-
./231/opal-
./232/opal-
./247/opal-
./248/opal-
./483/opal-
./484/opal-
./487/opal-
./488/opal-
./500/opal-
./510/opal-
./511/opal-
./512/opal-


I fixed it with:

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 41c3303157f7..a2d067925140 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -275,7 +275,7 @@ int __init opal_event_init(void)
 		const char *name;
 
 		/* Prefix name */
-		if (r->name)
+		if (r->name && strlen(r->name))
 			name = kasprintf(GFP_KERNEL, "opal-%s", r->name);
 		else
 			name = kasprintf(GFP_KERNEL, "opal");


cheers
