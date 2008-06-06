Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E8ED1DDF3D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:06:09 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] 4xx: PCIe driver now detects if a port is
	disabled via the dev-tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1212675749-29861-1-git-send-email-sr@denx.de>
References: <1212675749-29861-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:05:55 +1000
Message-Id: <1212725155.12464.2.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-05 at 16:22 +0200, Stefan Roese wrote:
> This patch add a check to the PPC4xx PCIe driver to detect if the port
> is disabled via the device-tree. This is needed for the AMCC Canyonlands
> board which has an option to either select 2 PCIe ports or 1 PCIe port
> and one SATA port. The SATA port and the 1st PCIe port pins are multiplexed
> so we can't start both drivers.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/sysdev/ppc4xx_pci.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index b4a54c5..76886cf 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -1634,6 +1634,15 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
>  	}
>  	port = &ppc4xx_pciex_ports[portno];
>  	port->index = portno;
> +
> +	/*
> +	 * Check if device is enabled
> +	 */
> +	if (!of_device_is_available(np)) {
> +		printk(KERN_INFO "PCIE%d: Port disabled via device-tree\n", port->index);
> +		return;
> +	}
> +
>  	port->node = of_node_get(np);
>  	pval = of_get_property(np, "sdr-base", NULL);
>  	if (pval == NULL) {
