Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74AC667B32
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 05:05:35 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDmBd-0006k7-Co
	for linuxppc-dev@ozlabs.org; Thu, 17 Aug 2006 20:01:45 +0200
Received: from rchp4.rochester.ibm.com ([129.42.161.36])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 20:01:45 +0200
Received: from drfickle by rchp4.rochester.ibm.com with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 20:01:45 +0200
To: linuxppc-dev@ozlabs.org
From: "Steve Fox" <drfickle@us.ibm.com>
Subject: Re: [PATCH] Fix irq radix tree remapping typo
Date: Thu, 17 Aug 2006 18:01:25 +0000 (UTC)
Message-ID: <ec2atk$f9m$1@sea.gmane.org>
References: <1155779967.11312.143.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@sea.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Aug 2006 03:59:27 +0200, Benjamin Herrenschmidt wrote:

> The code for using the radix tree for reverse mapping of interrupts has
> a typo that causes it to create incorrect mappings if the software and
> hardware numbers happen to be different. This would, among others, cause
> the IDE interrupt to fail on js20's. This fixes it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Please apply to 2.6.18
> 
> Index: linux-work/arch/powerpc/kernel/irq.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/irq.c	2006-08-17 09:26:19.000000000 +1000
> +++ linux-work/arch/powerpc/kernel/irq.c	2006-08-17 11:27:30.000000000 +1000
> @@ -693,7 +693,7 @@ unsigned int irq_radix_revmap(struct irq
>  	/* If not there, try to insert it */
>  	virq = irq_find_mapping(host, hwirq);
>  	if (virq != NO_IRQ)
> -		radix_tree_insert(tree, virq, &irq_map[virq]);
> +		radix_tree_insert(tree, hwirq, &irq_map[virq]);
>   bail:
>  	spin_unlock_irqrestore(&irq_big_lock, flags);
>  	return virq;

This patch has fixed booting on the machine I originally reported the
issue with. Thanks much.

Acked-by: Steve Fox <drfickle@us.ibm.com>

-- 

Steve Fox
IBM Linux Technology Center
