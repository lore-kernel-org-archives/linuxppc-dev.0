Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A3CD2C008B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 08:04:17 +1000 (EST)
Message-ID: <5032B455.3080607@freescale.com>
Date: Mon, 20 Aug 2012 17:04:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1345457161-4731-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1345457161-4731-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Bradley Hughes <bhughes@silicontkx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2012 05:06 AM, Jia Hongtao wrote:
> We unified the Freescale pci/pcie initialization by changing the fsl_pci
> to a platform driver. In previous PCI code architecture the initialization
> routine is called at board_setup_arch stage. Now the initialization is done
> in probe function which is architectural better. Also It's convenient for
> adding PM support for PCI controller in later patch.
> 
> Now we registered pci controllers as platform devices. So we combine two
> initialization code as one platform driver.
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> Changes for V8:
> * Use previous primary determination. Based on the point that there are
>   bugs on primary-less system.
> * Add exceptional support on ge_imp3a in which the primary bus is not the
>   first pci bus detected.

The exceptional thing about ge_imp3a is that it has no isa node, but
we're not sure if it actually has isa or not.  We should not be relying
on probe order in any case.  Device tree nodes are not ordered.

Another interesting case is stxssa8555.dts, which has an i8259 node but
no ISA node (are there any other instances of this?).  However, I can't
tell if stx_gp3.c is the platform file that goes with this device tree,
or if the platform code for stxssa8555 is out-of-tree (or some other
file that I'm not seeing).

> -void __devinit fsl_pci_init(void)
> +void fsl_pci_assign_primary(void)
>  {
> -	int ret;
>  	struct device_node *node;
> -	struct pci_controller *hose;
> -	dma_addr_t max = 0xffffffff;
>  
>  	/* Callers can specify the primary bus using other means. */
>  	if (!fsl_pci_primary) {

Since the whole point of this function is now to find the primary, just
return if it's already set, instead of indenting the rest of the function.

> @@ -842,38 +839,60 @@ void __devinit fsl_pci_init(void)
>  			node = fsl_pci_primary;
>  
>  			if (of_match_node(pci_ids, node))
> -				break;
> +				return;
>  		}
> -	}
>  
> -	node = NULL;
> -	for_each_node_by_type(node, "pci") {
> -		if (of_match_node(pci_ids, node)) {
> +		node = of_find_node_by_type(NULL, "pci");
> +		if (of_match_node(pci_ids, node))
>

What if the node returned doesn't match?  If you're checking for this,
handle the else-case (even if just with an error message).

-Scott
