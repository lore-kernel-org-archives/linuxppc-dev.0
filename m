Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ECA81DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 23:13:27 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix irq routing on some PowerMac 32 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1168419440.1704.16.camel@localhost.localdomain>
References: <1165806548.7260.0.camel@localhost.localdomain>
	<1168398002.571.3.camel@localhost.localdomain>
	<1168399012.22458.328.camel@localhost.localdomain>
	<1168400086.700.12.camel@localhost.localdomain>
	<1168401489.22458.332.camel@localhost.localdomain>
	<1168419440.1704.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 23:13:17 +1100
Message-Id: <1168431197.22458.336.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Thanks for all your suggestions. I had thought you could point out where
> was wrong :-). Now, I have to trace it myself. I do not have HW
> debugging tools, I only have printk().
> 
> I catch the bug. In your patch:
> 
> +       /* not a root bus, we need to get our parent */
> +       parent = scan_OF_for_pci_bus(bus->parent);
> +       if (parent == NULL)
> +               return NULL;
> +
> +       /* now iterate for children for a match */
> +       np = scan_OF_for_pci_dev(parent, bus->self->devfn);
> +       of_node_put(parent);
> +
> +       /* sanity check */
> +       if (strcmp(np->type, "pci") != 0)
> +               printk(KERN_WARNING "pci: wrong type \"%s\" for bridge %s\n",
> +                      np->type, np->full_name);
> 
> I think you should judge np != NULL before using it.  If np == NULL,
> np->type will cause memory access error. On CDS and some other Freescle
> board, such as 8641HPCN, there is pci bridge, np = NULL , this will
> cause error.
> If you agree, you or I will provide a patch to fix it:-).

While I agree that we should definitely test for NULL and properly fail
instead of crashing, there is still the question of why do you fail at
this point. Do you have PCI devices that don't have corresponding device
nodes ? That is not a problem per-se, I'm just wondering if you have a
device that is supposed to have a node but it's not matching due to a
problem with the "reg" property...

In any case, a patch is definitely needed to properly check for NULL and
should get into 2.6.20, so if you want to do it, it will be much
welcome !

Cheers,
Ben.
