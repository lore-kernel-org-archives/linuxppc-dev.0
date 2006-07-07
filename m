Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2277267B32
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:23:42 +1000 (EST)
Date: Fri, 7 Jul 2006 01:23:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: G5 troubles booting powerpc-git (July 6)
Message-Id: <20060707012330.f1dea5ac.akpm@osdl.org>
In-Reply-To: <1152226587.9862.19.camel@localhost.localdomain>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
	<1152226587.9862.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 07 Jul 2006 08:56:27 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> If you look at arch/powerpc/kernel/irq.c from line 479:
> 
> 	/* Check if mapping already exist, if it does, call
> 	 * host->ops->map() to update the flags
> 	 */
> 	virq = irq_find_mapping(host, hwirq);
> 	if (virq != IRQ_NONE) {
> 		pr_debug("irq: -> existing mapping on virq %d\n", virq);
> 		host->ops->map(host, virq, hwirq, flags);
> 		return virq;
> 	}
> 
> What if you comment out the host->ops->map(...) call in there ? Does it
> help ?

No, there's no change in behaviour.
