Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B1202DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:36:07 +1000 (EST)
In-Reply-To: <11840492523488-git-send-email-wei.zhang@freescale.com>
References: <11840492523488-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <601ADDAA-D5E0-4215-A9F2-A28BB53B4B92@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Fix the PCI-Ex link training bug on MPC8641HPCN board.
Date: Tue, 10 Jul 2007 09:36:14 -0500
To: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 10, 2007, at 1:34 AM, Zhang Wei wrote:

> If the PCI-Ex hose link training is failed, the kernel will halt at  
> the
> PCI scan process on MPC8641HPCN board.
>
> This patch will remove and free the hose from PCI host list if the
> PCI hose link training is failed.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>

Thanks.  Going to roll this into the work Roy's been doing to make  
PCI code work across 85xx/86xx.

- k

> ---
>  arch/powerpc/platforms/86xx/pci.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/ 
> platforms/86xx/pci.c
> index 73cd5b0..0b7835c 100644
> --- a/arch/powerpc/platforms/86xx/pci.c
> +++ b/arch/powerpc/platforms/86xx/pci.c
> @@ -210,8 +210,10 @@ int __init mpc86xx_add_bridge(struct  
> device_node *dev)
>
>  	/* Probe the hose link training status */
>  	early_read_config_word(hose, 0, 0, PCIE_LTSSM, &val);
> -	if (val < PCIE_LTSSM_L0)
> +	if (val < PCIE_LTSSM_L0) {
> +		pcibios_free_controller(hose);
>  		return -ENXIO;
> +	}
>
>  	/* Setup the PCIE host controller. */
>  	mpc86xx_setup_pcie(hose, rsrc.start, rsrc.end - rsrc.start + 1);
> -- 
> 1.5.1
