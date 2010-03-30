Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7EB6B7C8E
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Mar 2010 07:48:27 +1100 (EST)
Subject: Re: [PATCH] fix the problem where pcix node is probed again as pci
	node.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Feng Kan <fkan@amcc.com>
In-Reply-To: <1269970878-5080-1-git-send-email-fkan@amcc.com>
References: <1269970878-5080-1-git-send-email-fkan@amcc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 31 Mar 2010 07:48:17 +1100
Message-ID: <1269982097.7101.52.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Tirumala R Marri <tmarri@appliedmicro.com>,
	Feng Kan <fkan@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-03-30 at 10:41 -0700, Feng Kan wrote:
> From: Feng Kan <fkan@appliedmicro.com>
> 
> The current matching scheme make the pci node match to pcix or pciex node.
> To avoid the match, change the method so only one type of initialization
> is called per node.

No, your patch is not right. The problem was introduced by a patch from
Grant that incorrectly made of_device_is_compatible do a substring
match. Grant should have fixed that now. Grant ? Is your fix upstream
yet ? If not, can you send that ASAP ?

Cheers,
Ben.


> Signed-off-by: Feng Kan <fkan@appliedmicro.com>
> Signed-off-by: Tirumala R Marri <tmarri@appliedmicro.com>
> ---
>  arch/powerpc/sysdev/ppc4xx_pci.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index 8aa3302..1e67c74 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -1842,14 +1842,16 @@ static int __init ppc4xx_pci_find_bridges(void)
>  
>  	ppc_pci_flags |= PPC_PCI_ENABLE_PROC_DOMAINS | PPC_PCI_COMPAT_DOMAIN_0;
>  
> +	for_each_compatible_node(np, NULL, "ibm,plb-pci") {
> +		if (of_device_is_compatible(np, "ibm,plb-pcix"))
> +			ppc4xx_probe_pcix_bridge(np);
>  #ifdef CONFIG_PPC4xx_PCI_EXPRESS
> -	for_each_compatible_node(np, NULL, "ibm,plb-pciex")
> -		ppc4xx_probe_pciex_bridge(np);
> +		else if (of_device_is_compatible(np, "ibm,plb-pciex"))
> +			ppc4xx_probe_pciex_bridge(np);
>  #endif
> -	for_each_compatible_node(np, NULL, "ibm,plb-pcix")
> -		ppc4xx_probe_pcix_bridge(np);
> -	for_each_compatible_node(np, NULL, "ibm,plb-pci")
> -		ppc4xx_probe_pci_bridge(np);
> +		else
> +			ppc4xx_probe_pci_bridge(np);
> +	}
>  
>  	return 0;
>  }
