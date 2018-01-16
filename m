Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLmrs6HsnzF0jn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 10:39:09 +1100 (AEDT)
Subject: Re: [PATCH v4 13/17] ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
 <1516058192-65519-14-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <6e774872-0fd1-e791-6004-e3ddf11c4841@maciej.szmigiero.name>
Date: Wed, 17 Jan 2018 00:39:02 +0100
MIME-Version: 1.0
In-Reply-To: <1516058192-65519-14-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16.01.2018 00:16, Nicolin Chen wrote:
> AC97 configures most of registers earlier to start a communication
> with CODECs in order to successfully initialize CODEC. Currently,
> _fsl_ssi_set_dai_fmt() and fsl_ssi_setup_ac97() are called to get
> all SSI registers properly set.
> 
> Since now the driver has a fsl_ssi_hw_init() to handle all register
> initial settings, this patch moves those register settings of AC97
> to the fsl_ssi_hw_init() as well.
> 
> Meanwhile it applies _fsl_ssi_set_dai_fmt() call to AC97 only since
> other formats would be configured via normal set_dai_fmt() directly.
> 
> This patch also adds fsl_ssi_hw_clean() to cleanup control bits for
> AC97 in the platform remote() function.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
> Changelog
> v2
>  * Moved all to fsl_ssi_hw_init() in platform probe()
>  * Added fsl_ssi_hw_clean() instead of dai remove()
> 
>  sound/soc/fsl/fsl_ssi.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 50648f5..ebb3eb9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1255,10 +1252,28 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
>  		regmap_update_bits(ssi->regs, REG_SSI_SCR,
>  				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
>  
> +	/* AC97 should start earlier to communicate with CODECs */
> +	if (fsl_ssi_is_ac97(ssi)) {
> +		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
> +		fsl_ssi_setup_ac97(ssi);
> +	}
> +
>  	return 0;
>  }
>  
>  /**
> + * Clear SSI registers
> + */
> +static void fsl_ssi_hw_clean(struct fsl_ssi *ssi)
> +{
> +	/* Disable registers for AC97 */
> +	if (fsl_ssi_is_ac97(ssi)) {
> +		regmap_write(ssi->regs, REG_SSI_SCR, 0);
> +		regmap_write(ssi->regs, REG_SSI_SACNT, 0);
> +		regmap_write(ssi->regs, REG_SSI_SOR, 0);

These writes cause a hard SoC lockup when unloading the driver.

The following replacement order seems to be tolerated by the SSI:
regmap_update_bits(ssi->regs, REG_SSI_SCR, SSI_SCR_TE | SSI_SCR_RE, 0);
regmap_write(ssi->regs, REG_SSI_SACNT, 0);
regmap_write(ssi->regs, REG_SSI_SOR, 0);
regmap_update_bits(ssi->regs, REG_SSI_SCR, SSI_SCR_SSIEN, 0);

BTW: I've also tried disabling SSIEN before writing to SACNT and SOR
(both together with (TR | RE) and also as a separate step) but this
still caused a lockup.

> @@ -1587,6 +1599,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
>  {
>  	struct fsl_ssi *ssi = dev_get_drvdata(&pdev->dev);
>  
> +	fsl_ssi_hw_clean(ssi);
> +

We need to move this call...

>  	fsl_ssi_debugfs_remove(&ssi->dbg_stats);
>  
>  	if (ssi->pdev)
> 		platform_device_unregister(ssi->card_pdev);

...here, after the AC'97 CODEC platform device is unregistered, since the
CODEC shutdown may need a working AC'97 register communication.

Maciej
