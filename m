Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1AEA1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 10:41:35 +1000 (EST)
Message-ID: <1403656857.2435.61.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] fsl-rio: add support for mapping inbound windows
From: Scott Wood <scottwood@freescale.com>
To: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Date: Tue, 24 Jun 2014 19:40:57 -0500
In-Reply-To: <1403532715-21389-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
References: <1403532715-21389-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Martijn de Gouw <martijn.de.gouw@prodrive.nl>, Barry.Wood@idt.com,
 Alexandre.Bounine@idt.com, Liu Gang <Gang.Liu@freescale.com>,
 stef.van.os@prodrive-technologies.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-23 at 16:11 +0200, Martijn de Gouw wrote:
> From: Martijn de Gouw <martijn.de.gouw@prodrive.nl>
> 
> Add support for mapping and unmapping of inbound rapidio windows.
> 
> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |   92 +++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/fsl_rio.h |   12 ++++++
>  2 files changed, 104 insertions(+)

Could you describe a bit more why this is needed?

Liu Gang, can you review this?


> +int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
> +	u64 rstart, u32 size, u32 flags)
> +{
> +	struct rio_priv *priv = mport->priv;
> +	u32 base_size;
> +	unsigned int base_size_log;
> +	u64 win_start, win_end;
> +	u32 riwar;
> +	int i;
> +
> +	base_size_log = __ilog2(size) + ((size & (size - 1)) != 0);

Why __ilog2() and not ilog2()?

> @@ -598,6 +687,8 @@ int fsl_rio_setup(struct platform_device *dev)
>  			RIO_ATMU_REGS_PORT2_OFFSET));
>  
>  		priv->maint_atmu_regs = priv->atmu_regs + 1;
> +		priv->inb_atmu_regs = (struct rio_inb_atmu_regs *)
> +			(priv->regs_win + RIO_INB_ATMU_REGS_OFFSET);

__iomem

-Scott
