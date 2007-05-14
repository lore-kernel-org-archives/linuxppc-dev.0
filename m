Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38704DDEC8
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 19:18:46 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070514075415.7999BDDEC8@ozlabs.org>
References: <20070514075415.7999BDDEC8@ozlabs.org>
Content-Type: text/plain
Date: Mon, 14 May 2007 19:18:40 +1000
Message-Id: <1179134321.32247.88.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +	/* If this not a PHB, we don't do anything on mapping */
> +	if (bus->self) {
> +		DBG("IO mapping for PCI-PCI bridge %s\n",
> +		    pci_name(bus->self));
> +		DBG("  virt=0x%016lx...0x%016lx\n",
> +		    bus->resource[0]->start + pci_io_base,
> +		    bus->resource[0]->end + pci_io_base);
> +		return 0;
>  	}

Hrm... the above is incorrect. Since I iounmap_at() when removing a P2P
bridge, I need to ioremap_at() when mapping it back in. I'll fix that
in the next iteration.

One of the cool thing is that mapping over a previous mapping is
harmless, so if the PHB is inserted and create a mapping for the full
PHB range, and later on, a P2P is added to this PHB, doing an
ioremap_at() will work fine wether that sub-range was part of the
initial PHB mapping or wether it was unmapped by a previous removal of a
bridge...

Ben.
