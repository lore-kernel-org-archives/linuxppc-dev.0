Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A7EFB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 14:33:20 +1100 (EST)
Message-ID: <1331955189.3105.177.camel@pasglop>
Subject: Re: [PATCH v2 4/7] powerpc/PCI: convert devtree bus addresses to
 resource
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 17 Mar 2012 14:33:09 +1100
In-Reply-To: <20120316234814.6649.47469.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
 <20120316234814.6649.47469.stgit@bhelgaas.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-16 at 17:48 -0600, Bjorn Helgaas wrote:
> Normal PCI enumeration via PCI config space uses __pci_read_base(), where
> the PCI core applies any bus-to-resource offset.  But powerpc doesn't use
> that path when enumerating via the device tree.
> 
> In 6c5705fec63d, I converted powerpc to use the PCI core bus-to-resource
> conversion, but I missed these powerpc-specific paths.  Some powerpc
> platforms fail to boot ("Cannot allocate resource region," "device not
> available," etc.) between that commit and this one.
> 
> This adds the corresponding bus-to-resource conversion in the paths that
> read BAR values from the OF device tree.
> 
> CC: Anton Blanchard <anton@samba.org>

Acked-By: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> CC: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/kernel/pci_of_scan.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index b37d0b5..89dde17 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -75,6 +75,7 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
>  {
>  	u64 base, size;
>  	unsigned int flags;
> +	struct pci_bus_region region;
>  	struct resource *res;
>  	const u32 *addrs;
>  	u32 i;
> @@ -106,10 +107,11 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
>  			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
>  			continue;
>  		}
> -		res->start = base;
> -		res->end = base + size - 1;
>  		res->flags = flags;
>  		res->name = pci_name(dev);
> +		region.start = base;
> +		region.end = base + size - 1;
> +		pcibios_bus_to_resource(dev, res, &region);
>  	}
>  }
>  
> @@ -209,6 +211,7 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
>  	struct pci_bus *bus;
>  	const u32 *busrange, *ranges;
>  	int len, i, mode;
> +	struct pci_bus_region region;
>  	struct resource *res;
>  	unsigned int flags;
>  	u64 size;
> @@ -270,9 +273,10 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
>  			res = bus->resource[i];
>  			++i;
>  		}
> -		res->start = of_read_number(&ranges[1], 2);
> -		res->end = res->start + size - 1;
>  		res->flags = flags;
> +		region.start = of_read_number(&ranges[1], 2);
> +		region.end = region.start + size - 1;
> +		pcibios_bus_to_resource(dev, res, &region);
>  	}
>  	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
>  		bus->number);
