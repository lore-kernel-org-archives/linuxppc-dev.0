Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF8E9679E7
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 08:56:39 +1000 (EST)
Subject: Re: G5 troubles booting powerpc-git (July 6)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 08:56:27 +1000
Message-Id: <1152226587.9862.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you look at arch/powerpc/kernel/irq.c from line 479:

	/* Check if mapping already exist, if it does, call
	 * host->ops->map() to update the flags
	 */
	virq = irq_find_mapping(host, hwirq);
	if (virq != IRQ_NONE) {
		pr_debug("irq: -> existing mapping on virq %d\n", virq);
		host->ops->map(host, virq, hwirq, flags);
		return virq;
	}

What if you comment out the host->ops->map(...) call in there ? Does it
help ?

I think I have a little misdesign in my new powerpc irq handling
regarding the mixing up of mapping and setting of triggers. I'm working
on a solution, hopefully patches early next week.

Ben.
