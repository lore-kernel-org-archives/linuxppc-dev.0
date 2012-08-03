Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0250E2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 02:28:06 +1000 (EST)
Message-ID: <501BFC0E.6070708@freescale.com>
Date: Fri, 3 Aug 2012 11:27:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
In-Reply-To: <1343988851-884-4-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2012 05:14 AM, Jia Hongtao wrote:
> -void __devinit fsl_pci_init(void)
> +/* Checkout if PCI contains ISA node */
> +static int of_pci_has_isa(struct device_node *pci_node)
> +{
> +	struct device_node *np;
> +	int ret = 0;
> +
> +	if (!pci_node)
> +		return 0;
> +
> +	read_lock(&devtree_lock);
> +	np = pci_node->allnext;
> +
> +	/* Only scan the children of PCI node */
> +	for (; np != pci_node->sibling; np = np->allnext) {
> +		if (np->type && (of_node_cmp(np->type, "isa") == 0)
> +		    && of_node_get(np)) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +
> +	of_node_put(pci_node);
> +	read_unlock(&devtree_lock);
> +
> +	return ret;
> +}

Why do you keep insisting on substituting your ISA search code here?
What advantages does it have over the code that is already there?  It
unnecessarily digs into the internals of the tree representation.

> +
> +static int __devinit fsl_pci_probe(struct platform_device *pdev)
>  {
>  	int ret;
> -	struct device_node *node;
>  	struct pci_controller *hose;
> -	dma_addr_t max = 0xffffffff;
> +	int is_primary = 0;
>  
> -	/* Callers can specify the primary bus using other means. */
>  	if (!fsl_pci_primary) {
> -		/* If a PCI host bridge contains an ISA node, it's primary. */
> -		node = of_find_node_by_type(NULL, "isa");
> -		while ((fsl_pci_primary = of_get_parent(node))) {
> -			of_node_put(node);
> -			node = fsl_pci_primary;
> -
> -			if (of_match_node(pci_ids, node))
> -				break;
> -		}
> +		is_primary = of_pci_has_isa(pdev->dev.of_node);
> +		if (is_primary)
> +			fsl_pci_primary = pdev->dev.of_node;
>  	}

As I explained before, this has to be done globally, not from the probe
function, so we can assign a default primary bus if there isn't any ISA.
 There are bugs in the Linux PPC PCI code relating to not having any
primary bus.

-Scott
