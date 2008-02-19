Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C99CDDE42
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 17:28:59 +1100 (EST)
Subject: Re: [patch 2/4] ppc: make pcibios_enable_device() use
	pcibios_enable_resources()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20080219044307.479128872@ldl.fc.hp.com>
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219044307.479128872@ldl.fc.hp.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 17:26:54 +1100
Message-Id: <1203402414.6740.88.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-02-18 at 21:39 -0700, Bjorn Helgaas wrote:
> plain text document attachment (ppc-pcibios_enable_resources)
> pcibios_enable_device() has an almost verbatim copy of
> pcibios_enable_resources(), (the only difference is that
> pcibios_enable_resources() turns on PCI_COMMAND_MEMORY if
> there's a ROM resource).
> 
> The duplication might be intentional, but I don't see any callers
> of pcibios_enable_resources() on ppc, so I think it's more
> likely a historical accident.
> 
> This patch removes the duplication, making pcibios_enable_device()
> simply call pcibios_enable_resources() as x86 does.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Ack. arch/ppc is being phased out soon anyway.

Ben.

> 
> Index: work6/arch/ppc/kernel/pci.c
> ===================================================================
> --- work6.orig/arch/ppc/kernel/pci.c	2008-02-18 10:43:50.000000000 -0700
> +++ work6/arch/ppc/kernel/pci.c	2008-02-18 11:31:23.000000000 -0700
> @@ -785,33 +785,11 @@
>  
>  int pcibios_enable_device(struct pci_dev *dev, int mask)
>  {
> -	u16 cmd, old_cmd;
> -	int idx;
> -	struct resource *r;
> -
>  	if (ppc_md.pcibios_enable_device_hook)
>  		if (ppc_md.pcibios_enable_device_hook(dev, 0))
>  			return -EINVAL;
> -		
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	old_cmd = cmd;
> -	for (idx=0; idx<6; idx++) {
> -		r = &dev->resource[idx];
> -		if (r->flags & IORESOURCE_UNSET) {
> -			printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", pci_name(dev));
> -			return -EINVAL;
> -		}
> -		if (r->flags & IORESOURCE_IO)
> -			cmd |= PCI_COMMAND_IO;
> -		if (r->flags & IORESOURCE_MEM)
> -			cmd |= PCI_COMMAND_MEMORY;
> -	}
> -	if (cmd != old_cmd) {
> -		printk("PCI: Enabling device %s (%04x -> %04x)\n",
> -		       pci_name(dev), old_cmd, cmd);
> -		pci_write_config_word(dev, PCI_COMMAND, cmd);
> -	}
> -	return 0;
> +
> +	return pcibios_enable_resources(dev, mask);
>  }
>  
>  struct pci_controller*
> 
