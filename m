Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLmsb03gZzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 10:39:46 +1100 (AEDT)
Subject: Re: [PATCH v4 16/17] ASoC: fsl_ssi: Move DT related code to a
 separate probe()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
 <1516058192-65519-17-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <a5eb81e1-8e04-0dfc-724f-578141c860f4@maciej.szmigiero.name>
Date: Wed, 17 Jan 2018 00:39:38 +0100
MIME-Version: 1.0
In-Reply-To: <1516058192-65519-17-git-send-email-nicoleotsuka@gmail.com>
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
> This patch cleans up probe() function by moving all Device Tree
> related code into a separate function. It allows the probe() to
> be Device Tree independent. This will be very useful for future
> integration of imx-ssi driver which has similar functionalities
> while exists only because it supports non-DT cases.
> 
> This patch also moves symmetric_channels of AC97 from the probe
> to the structure snd_soc_dai_driver for simplification.
> 
> Additionally, since PowerPC and AC97 use the same pdev pointer
> to register a platform device, this patch also unifies related
> code.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
> Changelog
> v4
>  * Made bool synchronous exclusive with AC97 mode in PATCH-16
> 
>  sound/soc/fsl/fsl_ssi.c | 209 ++++++++++++++++++++++++++----------------------
>  1 file changed, 114 insertions(+), 95 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index dfeca43..07ec47d 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1529,50 +1581,17 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto error_asoc_register;
>  
> -	/* Bypass it if using newer DT bindings of ASoC machine drivers */
> -	if (!of_get_property(np, "codec-handle", NULL))
> -		goto done;
> -
> -	/*
> -	 * Backward compatible for older bindings by manually triggering the
> -	 * machine driver's probe(). Use /compatible property, including the
> -	 * address of CPU DAI driver structure, as the name of machine driver.
> -	 */
> -	sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);
> -	/* Sometimes the compatible name has a "fsl," prefix, so we strip it. */
> -	p = strrchr(sprop, ',');
> -	if (p)
> -		sprop = p + 1;
> -	snprintf(name, sizeof(name), "snd-soc-%s", sprop);
> -	make_lowercase(name);
> -
> -	ssi->pdev = platform_device_register_data(dev, name, 0, NULL, 0);
> -	if (IS_ERR(ssi->pdev)) {
> -		ret = PTR_ERR(ssi->pdev);
> -		dev_err(dev, "failed to register platform: %d\n", ret);
> -		goto error_sound_card;
> -	}
> -
> -done:
>  	/* Initially configures SSI registers */
>  	fsl_ssi_hw_init(ssi);
>  
> -	if (fsl_ssi_is_ac97(ssi)) {
> -		u32 ssi_idx;
> -
> -		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
> -		if (ret) {
> -			dev_err(dev, "failed to get SSI index property\n");
> -			goto error_sound_card;
> -		}
> -
> -		ssi->pdev = platform_device_register_data(NULL, "ac97-codec",
> -							  ssi_idx, NULL, 0);
> -		if (IS_ERR(ssi->pdev)) {
> -			ret = PTR_ERR(ssi->pdev);
> -			dev_err(dev,
> -				"failed to register AC97 codec platform: %d\n",
> -				ret);
> +	/* Register a platform device for older bindings or AC97 */
> +	if (ssi->card_name[0]) {
> +		ssi->card_pdev = platform_device_register_data(dev,
							       ^
Here we need to pass NULL as the parent in the AC'97 mode as the original
code did, because otherwise snd_soc_find_dai() will assume that the AC'97
CODEC platform device has the same DT node as the SSI (the CODEC isn't
present in the DT on its own) and so when asked for SSI by its DT node
will return the CODEC instead.

The end result is a NULL pointer dereference when starting a playback.

Maciej
