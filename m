Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3C4F1007D4
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2010 10:19:08 +1100 (EST)
Subject: Re: [PATCH] powerpc/4xx: Add support for type 1 pci transactions
	on 4xx boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef van Os <stef.van.os@Prodrive.nl>
In-Reply-To: <4CD35CD1F8085945B597F80EEC89421303B8AD11@exc01.bk.prodrive.nl>
References: <4CD35CD1F8085945B597F80EEC89421303B8AD11@exc01.bk.prodrive.nl>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Jan 2010 10:18:46 +1100
Message-ID: <1263338326.724.216.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>,
	Stefan Roese <sr@denx.de>, Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-01-12 at 15:09 +0100, Stef van Os wrote:
> This patch adds type 1 PCI transactions to 4xx PCI code, enabling the
> discovery of
> devices behind a PCI bridge.

Your patch appears word wrapped and whitespace damaged...

I'll fix it up manually this time around but please check your mailer
setup :-)

Cheers,
Ben.
 
> Signed-off-by: Stef van Os <stef.van.os@gmail.com>
> ---
>  arch/powerpc/sysdev/ppc4xx_pci.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c
> b/arch/powerpc/sysdev/ppc4xx_pci.c
> index 6ff9d71..370cc1c 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -363,7 +363,8 @@ static void __init ppc4xx_probe_pci_bridge(struct
> device_node *np)
>         hose->last_busno = bus_range ? bus_range[1] : 0xff;
> 
>         /* Setup config space */
> -       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
> 0);
> +       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
> +                                       PPC_INDIRECT_TYPE_SET_CFG_TYPE);
> 
>         /* Disable all windows */
>         writel(0, reg + PCIL0_PMM0MA);
> @@ -569,7 +570,8 @@ static void __init ppc4xx_probe_pcix_bridge(struct
> device_node *np)
>         hose->last_busno = bus_range ? bus_range[1] : 0xff;
> 
>         /* Setup config space */
> -       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
> 0);
> +       setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
> +                                       PPC_INDIRECT_TYPE_SET_CFG_TYPE);
> 
>         /* Disable all windows */
>         writel(0, reg + PCIX0_POM0SA);
> 
> 
> Disclaimer: The information contained in this email, including any attachments is 
> confidential and is for the sole use of the intended recipient(s). Any unauthorized 
> review, use, disclosure or distribution is prohibited. If you are not the intended 
> recipient, please notify the sender immediately by replying to this message and 
> destroy all copies of this message and any attachments.
