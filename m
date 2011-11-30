Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F0F66B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 16:46:26 +1100 (EST)
Message-ID: <1322631973.21641.42.camel@pasglop>
Subject: Re: [PATCH 1/6] 44x/pci: Continue pci setup even if there is no
 sdr-base in the device-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 30 Nov 2011 16:46:13 +1100
In-Reply-To: <1322630640-13708-2-git-send-email-tony@bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-2-git-send-email-tony@bakeyournoodle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-11-30 at 16:23 +1100, Tony Breeds wrote:
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
>  arch/powerpc/sysdev/ppc4xx_pci.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index 16f5eba..d3fa380 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -1974,11 +1974,11 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
>  	port->node = of_node_get(np);
>  	pval = of_get_property(np, "sdr-base", NULL);
>  	if (pval == NULL) {
> -		printk(KERN_ERR "PCIE: missing sdr-base for %s\n",
> +		printk(KERN_INFO "PCIE: missing sdr-base for %s\n",
>  		       np->full_name);

If you don't expect an sdr-base as part of the normal operations of that
bridge, don't bring a message that makes me think something is wrong :-)

Just changing the severity isn't enough. you should just remove the
message and later on, print/warn/error out if you decide you actually
need an sdr-base (such as in the backend).

Cheers,
Ben.

> -		return;
> +	} else {
> +		port->sdr_base = *pval;
>  	}
> -	port->sdr_base = *pval;
>  
>  	/* Check if device_type property is set to "pci" or "pci-endpoint".
>  	 * Resulting from this setup this PCIe port will be configured
