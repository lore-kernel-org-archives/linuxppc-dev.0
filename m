Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id F3B62B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Apr 2011 17:49:35 +1000 (EST)
Date: Mon, 04 Apr 2011 00:48:56 -0700 (PDT)
Message-Id: <20110404.004856.55863268.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] of: Match PCI devices to OF nodes generically
From: David Miller <davem@davemloft.net>
In-Reply-To: <1301887630.2549.71.camel@pasglop>
References: <1301882694.2549.53.camel@pasglop>
	<1301887630.2549.71.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Apr 2011 13:27:10 +1000

> +struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
> +{
> +	/* This should only be called for PHBs */
> +	if (WARN_ON(bus->self || bus->parent))
> +		return NULL;

This WARN_ON() will always trigger on sparc, because we use the OF
device tree object at the "parent" of the PCI bus devices we create
for the PCI controller domains.

I'm really surprised you don't link the PCI bus roots into the rest of
the global device hierarchy on powerpc.
