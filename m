Return-Path: <sshtylyov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E08C5B7135
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 19:29:52 +1000 (EST)
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 90C83DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 19:29:51 +1000 (EST)
Message-ID: <4A30CE85.40508@ru.mvista.com>
Date: Thu, 11 Jun 2009 13:29:41 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] sata_fsl: Add power mgmt support
References: <1244692417-18484-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1244692417-18484-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, jeff@garzik.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

Kumar Gala wrote:

> From: Dave Liu <daveliu@freescale.com>
>
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  drivers/ata/sata_fsl.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 36b8629..94eaa43 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1378,6 +1378,37 @@ static int sata_fsl_remove(struct of_device *ofdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int sata_fsl_suspend(struct of_device *op, pm_message_t state)
> +{
> +	struct ata_host *host = dev_get_drvdata(&op->dev);
> +	return ata_host_suspend(host, state);
> +}
> +
> +static int sata_fsl_resume(struct of_device *op)
> +{
> +	struct ata_host *host = dev_get_drvdata(&op->dev);
> +	struct sata_fsl_host_priv *host_priv = host->private_data;
> +	int ret;
> +	void __iomem *hcr_base = host_priv->hcr_base;
> +	struct ata_port *ap = host->ports[0];
> +	struct sata_fsl_port_priv *pp = ap->private_data;
> +
> +	ret = sata_fsl_init_controller(host);
> +	if (ret) {
> +		dev_printk(KERN_ERR, &op->dev,
> +			"Error initialize hardware\n");
>   

   May be "initializing"?

> +		return ret;
> +	}
> +
> +	/* Recovery the CHBA register in host controller cmd register set */
>   

   Maybe "Recover"?

> +	iowrite32(pp->cmdslot_paddr & 0xffffffff, hcr_base + CHBA);
> +
> +	ata_host_resume(host);
> +	return 0;
> +}
> +#endif
>   

MBR, Sergei
