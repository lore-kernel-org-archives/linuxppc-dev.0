Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4273E67BF6
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 22:40:36 +1000 (EST)
Subject: Re: [PATCH][2/2] RTAS MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1154509462.26242.9.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154024834.29826.240.camel@goblue>
	<1154320382.19883.26.camel@localhost.localdomain>
	<1154379714.29826.396.camel@goblue>
	<1154509462.26242.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 11:50:03 +0200
Message-Id: <1155117003.4040.69.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, PaulMackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm only just starting to get benh's new irq code, but I think
> irq_find_host(dn) isn't doing what we want here. It's probably harmless,
> but AFAICT irq_find_host() is only meant to be called when you have the
> node of the irq controller, not for an arbitrary dn. The doco's a bit
> ambiguous:
> 
>  * irq_find_host - Locates a host for a given device node
>  * @node: device-tree node of the interrupt controller
> 
> But looking at the implementation, it doesn't do a search up the tree or
> anything, it just checks node against each host.

For pSeries, passing NULL is fine for host anyway as there is only one
domain that is relevant for MSIs (there might be a 8259 legacy domain
too but it's not relevant) and that domain is set to be the default
host.

> Also, since's benh's latest patch went in we'll have to split this into
> two calls, I think we want:
> 
> virq = irq_create_mapping(NULL ???, ret[0]);
> set_irq_type(virq, ret[1] ? IRQ_TYPE_EDGE_RISING : IRQ_TYPE_LEVEL_LOW);

MSIs are always edge (though there might be an issue with some P5IOC
errata lurking here...). The xics code doesn't care much at this point
though.

Ben.
