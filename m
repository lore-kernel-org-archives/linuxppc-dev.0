Return-Path: <bp@alien8.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWcpf3KvCzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 01:06:18 +1000 (AEST)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by ozlabs.org (Postfix) with ESMTP id 3sWcpd6B2Qz9rxv
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2016 01:06:17 +1000 (AEST)
Date: Sat, 10 Sep 2016 16:53:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: dougthompson@xmission.com, mchehab@kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, arnd@arndb.de
Subject: Re: [PATCH] drivers/edac: NO_IRQ removal from powerpc-only drivers
Message-ID: <20160910145320.bg6s6wo5ya7zzw2n@pd.tnic>
References: <1473501428-8217-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1473501428-8217-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 10, 2016 at 07:57:08PM +1000, Michael Ellerman wrote:
> We'd like to eventually remove NO_IRQ on powerpc, so remove usages of it
> from powerpc-only drivers.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  drivers/edac/mpc85xx_edac.c | 6 +++---
>  drivers/edac/mv64x60_edac.c | 8 ++++----
>  drivers/edac/ppc4xx_edac.c  | 6 +++---
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index ca63d0da8889..e12b8e166a53 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -267,7 +267,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
>  
>  	pdata = pci->pvt_info;
>  	pdata->name = "mpc85xx_pci_err";
> -	pdata->irq = NO_IRQ;
> +	pdata->irq = 0;
>  
>  	plat_data = op->dev.platform_data;
>  	if (!plat_data) {

So all of those pdata structs come from kzalloc() so you don't really
have to assign to 0 - simply kill the line.

> @@ -588,7 +588,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
>  
>  	pdata = edac_dev->pvt_info;
>  	pdata->name = "mpc85xx_l2_err";
> -	pdata->irq = NO_IRQ;
> +	pdata->irq = 0;
>  	edac_dev->dev = &op->dev;
>  	dev_set_drvdata(edac_dev->dev, edac_dev);
>  	edac_dev->ctl_name = pdata->name;
> @@ -1058,7 +1058,7 @@ static int mpc85xx_mc_err_probe(struct platform_device *op)
>  
>  	pdata = mci->pvt_info;
>  	pdata->name = "mpc85xx_mc_err";
> -	pdata->irq = NO_IRQ;
> +	pdata->irq = 0;
>  	mci->pdev = &op->dev;
>  	pdata->edac_idx = edac_mc_idx++;
>  	dev_set_drvdata(mci->pdev, mci);

That part went into drivers/edac/fsl_ddr_edac.c which is only the
freescale memory controller being shared between ARM and PPC, see

http://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=for-next

But that shouldn't change the issue wrt ->irq as now it is implicitly 0.

IOW, you can drop this hunk.

Please send v2 against the above branch or linux-next.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
