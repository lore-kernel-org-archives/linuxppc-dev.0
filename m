Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F36DFB6F5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 03:48:38 +1000 (EST)
Date: Thu, 2 Jun 2011 12:48:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
Message-ID: <20110602124823.3b814b3f@schlenkerla.am.freescale.net>
In-Reply-To: <1307017502-3965-1-git-send-email-dbaryshkov@gmail.com>
References: <20110601114823.2e57c691@schlenkerla.am.freescale.net>
	<1307017502-3965-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Jun 2011 16:25:02 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> As a device for pci node isn't created, create a special platform_device
> for PCI EDAC device on MPC85xx.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/powerpc/sysdev/fsl_pci.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 68ca929..0e37259 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -381,6 +381,39 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
>  	return 0;
>  }
>  
> +int __init fsl_add_pci_err(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_node_by_type(np, "pci") {
> +		/* Only PCI, not PCI Express! */
> +		if (of_device_is_compatible(np, "fsl,mpc8540-pci")) {
> +			struct resource r[2];
> +
> +			r[0].parent = NULL;
> +			r[1].parent = NULL;
> +
> +			if (of_address_to_resource(np, 0, &r[0])) {
> +				printk(KERN_WARNING
> +						"Can't get register base for PCI EDAC!\n");
> +				continue;
> +			}
> +			r[0].start += 0xe00;
> +
> +			if (of_irq_to_resource(np, 0, &r[1]) == NO_IRQ) {
> +				printk(KERN_WARNING
> +						"Can't get irq for PCI EDAC!\n");
> +				continue;
> +			}
> +			platform_device_register_simple("mpc85xx_pci_err", -1,
> +					r, ARRAY_SIZE(r));
> +		}
> +	}

This use of device_type is deprecated -- use for_each_compatible_node().

-Scott
