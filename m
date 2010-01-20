Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DB95B7BF3
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jan 2010 07:52:05 +1100 (EST)
Subject: Re: [PATCH] powerpc/4xx: Add pcix type 1 transactions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef van Os <stef.van.os@Prodrive.nl>
In-Reply-To: <1263995979-10954-1-git-send-email-stef.van.os@prodrive.nl>
References: <1263995979-10954-1-git-send-email-stef.van.os@prodrive.nl>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Jan 2010 07:51:36 +1100
Message-ID: <1264020696.724.546.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, felix@embedded-sol.com, sr@denx.de, fkan@amcc.com,
	Stef van Os <stef.van.os@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-01-20 at 14:59 +0100, Stef van Os wrote:
> Some of the newer 4xx pci cores don't send PCI type 1 transactions.
> This patch enables type 1 transations for pcix nodes, thus enabling
> devices behind PCI bridges.
> 
> Signed-off-by: Stef van Os <stef.van.os@gmail.com>
> ---

Thanks, I'll send that to Linus after LCA.

Cheers,
Ben.

>  arch/powerpc/sysdev/ppc4xx_pci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index 6ff9d71..8aa3302 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -569,7 +569,8 @@ static void __init ppc4xx_probe_pcix_bridge(struct device_node *np)
>  	hose->last_busno = bus_range ? bus_range[1] : 0xff;
>  
>  	/* Setup config space */
> -	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4, 0);
> +	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 0x4,
> +					PPC_INDIRECT_TYPE_SET_CFG_TYPE);
>  
>  	/* Disable all windows */
>  	writel(0, reg + PCIX0_POM0SA);
> -- 
> 1.6.6.267.g5b159
> 
> 
> Disclaimer: The information contained in this email, including any attachments is 
> confidential and is for the sole use of the intended recipient(s). Any unauthorized 
> review, use, disclosure or distribution is prohibited. If you are not the intended 
> recipient, please notify the sender immediately by replying to this message and 
> destroy all copies of this message and any attachments.
