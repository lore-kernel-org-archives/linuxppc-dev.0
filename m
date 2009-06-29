Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0843B7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 00:55:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18485DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 00:55:06 +1000 (EST)
Message-Id: <B3839C1C-20F2-44D2-9BB5-E608D3CFD1E4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: ashish kalra <ashish.kalra@freescale.com>
In-Reply-To: <Pine.WNT.4.64.0906291846100.2640@B00888-02.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] sata_fsl: Add asynchronous notification support 
Date: Mon, 29 Jun 2009 09:52:59 -0500
References: <Pine.WNT.4.64.0906291846100.2640@B00888-02.fsl.freescale.net>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 29, 2009, at 8:22 AM, ashish kalra wrote:

> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
> ---
> drivers/ata/sata_fsl.c |   10 ++++++++--
> 1 files changed, 8 insertions(+), 2 deletions(-)

Can you provide more detail in the commit message about why this patch  
is needed or what 'asynchronous notification' gets us.

- k

>
>
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 94eaa43..5751145 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -34,7 +34,7 @@ enum {
>
> 	SATA_FSL_HOST_FLAGS	= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
> 				ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> -				ATA_FLAG_PMP | ATA_FLAG_NCQ),
> + 				ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),
>
> 	SATA_FSL_MAX_CMDS	= SATA_FSL_QUEUE_DEPTH,
> 	SATA_FSL_CMD_HDR_SIZE	= 16,	/* 4 DWORDS */
> @@ -132,7 +132,7 @@ enum {
> 	INT_ON_SINGL_DEVICE_ERR = (1 << 1),
> 	INT_ON_CMD_COMPLETE = 1,
>
> -	INT_ON_ERROR = INT_ON_FATAL_ERR |
> +	INT_ON_ERROR = INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |
> 	    INT_ON_PHYRDY_CHG | INT_ON_SINGL_DEVICE_ERR,
>
> 	/*
> @@ -154,6 +154,7 @@ enum {
>
> 	DEFAULT_PORT_IRQ_ENABLE_MASK = IE_ON_FATAL_ERR | IE_ON_PHYRDY_CHG |
> 	    IE_ON_SIGNATURE_UPDATE |
> +	    IE_ON_SNOTIFY_UPDATE |
> 	    IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
>
> 	EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
> @@ -1003,6 +1004,11 @@ static void sata_fsl_error_intr(struct  
> ata_port *ap)
> 		freeze = 1;
> 	}
>
> +	/* Handle SDB FIS receive & notify update */
> +	if (hstatus & INT_ON_SNOTIFY_UPDATE) {
> +		sata_async_notification(ap);
> +	}
> +
> 	/* Handle PHYRDY change notification */
> 	if (hstatus & INT_ON_PHYRDY_CHG) {
> 		DPRINTK("SATA FSL: PHYRDY change indication\n");
> -- 
> 1.6.0
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
