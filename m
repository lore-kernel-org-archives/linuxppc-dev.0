Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5302167B5F
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 06:28:04 +1100 (EST)
Message-ID: <457325A1.2060309@ru.mvista.com>
Date: Sun, 03 Dec 2006 22:29:37 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix debug printks for 32-bit resources in the PCI code
References: <200612032052.27519.sshtylyov@ru.mvista.com>
In-Reply-To: <200612032052.27519.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

    Argh, forgot the signoff line again...

> Cure the damage done by the former PCI debug printks fix for the case of 64-bit
> resources (commit 685143ac1f7a579a3fac9c7f2ac8f82e95af6864) which broke it for
> the plain vanilla 32-bit resources...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>  arch/powerpc/kernel/pci_32.c |   24 +++++++++++-------------
>  1 files changed, 11 insertions(+), 13 deletions(-)

> Index: powerpc/arch/powerpc/kernel/pci_32.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/pci_32.c
> +++ powerpc/arch/powerpc/kernel/pci_32.c
> @@ -100,7 +100,7 @@ pcibios_fixup_resources(struct pci_dev *
>  			continue;
>  		if (res->end == 0xffffffff) {
>  			DBG("PCI:%s Resource %d [%016llx-%016llx] is unassigned\n",
> -			    pci_name(dev), i, res->start, res->end);
> +			    pci_name(dev), i, (u64)res->start, (u64)res->end);
>  			res->end -= res->start;
>  			res->start = 0;
>  			res->flags |= IORESOURCE_UNSET;
> @@ -116,11 +116,9 @@ pcibios_fixup_resources(struct pci_dev *
>  		if (offset != 0) {
>  			res->start += offset;
>  			res->end += offset;
> -#ifdef DEBUG
> -			printk("Fixup res %d (%lx) of dev %s: %llx -> %llx\n",
> -			       i, res->flags, pci_name(dev),
> -			       res->start - offset, res->start);
> -#endif
> +			DBG("Fixup res %d (%lx) of dev %s: %llx -> %llx\n",
> +			    i, res->flags, pci_name(dev),
> +			    (u64)res->start - offset, (u64)res->start);
>  		}
>  	}
>  
> @@ -256,7 +254,7 @@ pcibios_allocate_bus_resources(struct li
>  			}
>  
>  			DBG("PCI: bridge rsrc %llx..%llx (%lx), parent %p\n",
> -				res->start, res->end, res->flags, pr);
> +			    (u64)res->start, (u64)res->end, res->flags, pr);
>  			if (pr) {
>  				if (request_resource(pr, res) == 0)
>  					continue;
> @@ -307,7 +305,7 @@ reparent_resources(struct resource *pare
>  	for (p = res->child; p != NULL; p = p->sibling) {
>  		p->parent = res;
>  		DBG(KERN_INFO "PCI: reparented %s [%llx..%llx] under %s\n",
> -		    p->name, p->start, p->end, res->name);
> +		    p->name, (u64)p->start, (u64)p->end, res->name);
>  	}
>  	return 0;
>  }
> @@ -363,7 +361,7 @@ pci_relocate_bridge_resource(struct pci_
>  	}
>  	if (request_resource(pr, res)) {
>  		DBG(KERN_ERR "PCI: huh? couldn't move to %llx..%llx\n",
> -		    res->start, res->end);
> +		    (u64)res->start, (u64)res->end);
>  		return -1;		/* "can't happen" */
>  	}
>  	update_bridge_base(bus, i);
> @@ -481,14 +479,14 @@ static inline void alloc_resource(struct
>  	struct resource *pr, *r = &dev->resource[idx];
>  
>  	DBG("PCI:%s: Resource %d: %016llx-%016llx (f=%lx)\n",
> -	    pci_name(dev), idx, r->start, r->end, r->flags);
> +	    pci_name(dev), idx, (u64)r->start, (u64)r->end, r->flags);
>  	pr = pci_find_parent_resource(dev, r);
>  	if (!pr || request_resource(pr, r) < 0) {
>  		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
>  		       " of device %s\n", idx, pci_name(dev));
>  		if (pr)
>  			DBG("PCI:  parent is %p: %016llx-%016llx (f=%lx)\n",
> -			    pr, pr->start, pr->end, pr->flags);
> +			    pr, (u64)pr->start, (u64)pr->end, pr->flags);
>  		/* We'll assign a new address later */
>  		r->flags |= IORESOURCE_UNSET;
>  		r->end -= r->start;
> @@ -961,7 +959,7 @@ pci_process_bridge_OF_ranges(struct pci_
>  			res->flags = IORESOURCE_IO;
>  			res->start = ranges[2];
>  			DBG("PCI: IO 0x%llx -> 0x%llx\n",
> -				    res->start, res->start + size - 1);
> +			    (u64)res->start, (u64)res->start + size - 1);
>  			break;
>  		case 2:		/* memory space */
>  			memno = 0;
> @@ -983,7 +981,7 @@ pci_process_bridge_OF_ranges(struct pci_
>  					res->flags |= IORESOURCE_PREFETCH;
>  				res->start = ranges[na+2];
>  				DBG("PCI: MEM[%d] 0x%llx -> 0x%llx\n", memno,
> -					    res->start, res->start + size - 1);
> +				    (u64)res->start, (u64)res->start + size - 1);
>  			}
>  			break;
>  		}
> 

WBR, Sergei
