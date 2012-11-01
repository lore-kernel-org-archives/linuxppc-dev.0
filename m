Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 98D3F2C0168
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2012 00:26:07 +1100 (EST)
Message-ID: <50927862.9080909@freescale.com>
Date: Thu, 1 Nov 2012 08:25:54 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [linuxppc-release] [PATCH] powerpc/fsl-pci: Add PCI controller
 ATMU PM support
References: <1351736348-26754-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1351736348-26754-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jia Hongtao wrote:

> +#ifdef CONFIG_SUSPEND
> +static int fsl_pci_resume(struct platform_device *pdev)
> +{
> +	struct pci_controller *hose;
> +	struct resource pci_rsrc;
> +
> +	hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
> +	of_address_to_resource(pdev->dev.of_node, 0, &pci_rsrc);
> +	setup_pci_atmu(hose, &pci_rsrc);
> +
> +	return 0;
> +}

Some of these functions can fail, so they should return an error code if
they do.

> +#endif
> +
>  static struct platform_driver fsl_pci_driver = {
>  	.driver = {
>  		.name = "fsl-pci",
>  		.of_match_table = pci_ids,
>  	},
>  	.probe = fsl_pci_probe,
> +#ifdef CONFIG_SUSPEND
> +	.resume	= fsl_pci_resume,
> +#endif

Do this instead:

#ifdef CONFIG_SUSPEND
static int fsl_pci_resume(struct platform_device *pdev)
...
#else
#define fsl_pci_resume NULL
#endif

-- 
Timur Tabi
Linux kernel developer at Freescale
