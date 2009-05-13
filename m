Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC67FDDFF4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 07:21:19 +1000 (EST)
Message-Id: <B2706AD9-61E9-49E2-8EA4-6DB69B608658@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1242249131-25014-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] sata_fsl: Fix compile warnings
Date: Wed, 13 May 2009 16:20:11 -0500
References: <1242249131-25014-1-git-send-email-galak@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 13, 2009, at 4:12 PM, Kumar Gala wrote:

> We we build with dma_addr_t as a 64-bit quantity we get:
>
> drivers/ata/sata_fsl.c: In function 'sata_fsl_fill_sg':
> drivers/ata/sata_fsl.c:340: warning: format '%x' expects type  
> 'unsigned int', but argument 4 has type 'dma_addr_t'
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> drivers/ata/sata_fsl.c |    7 ++++---
> 1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index c2e90e1..c7ee52d 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -332,13 +332,14 @@ static unsigned int sata_fsl_fill_sg(struct  
> ata_queued_cmd *qc, void *cmd_desc,
> 		dma_addr_t sg_addr = sg_dma_address(sg);
> 		u32 sg_len = sg_dma_len(sg);
>
> -		VPRINTK("SATA FSL : fill_sg, sg_addr = 0x%x, sg_len = %d\n",
> -			sg_addr, sg_len);
> +		VPRINTK("SATA FSL : fill_sg, sg_addr = 0x%llx, sg_len = %d\n",
> +			(unsigned long long)sg_addr, sg_len);
>
> 		/* warn if each s/g element is not dword aligned */
> 		if (sg_addr & 0x03)
> 			ata_port_printk(qc->ap, KERN_ERR,
> -					"s/g addr unaligned : 0x%x\n", sg_addr);
> +					"s/g addr unaligned : 0x%llxx\n",

You have an extra "x" in there....

Cheers,
B
