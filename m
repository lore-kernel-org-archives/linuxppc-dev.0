Return-Path: <ckeepax@opensource.wolfsonmicro.com>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsm784KNszDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 20:38:57 +1100 (AEDT)
Date: Tue, 28 Mar 2017 10:21:03 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
CC: <nicoleotsuka@gmail.com>, <broonie@kernel.org>,
 <alsa-devel@alsa-project.org>, <timur@tabi.org>, <Xiubo.Lee@gmail.com>,
 <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
 <tiwai@suse.com>, <fabio.estevam@nxp.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
Message-ID: <20170328092103.GQ6986@localhost.localdomain>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 28, 2017 at 11:58:52AM +0300, Daniel Baluta wrote:
> Resource managed devm_clk_get only works with platform's device dev.
> 

I feel like this could use an explaination of why not using devm
is the correct fix, rather than just using the platform device
for the call. Its not obvious to me, that using the platform
device would be an issue.

Thanks,
Charles

> Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/imx-wm8962.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
> index 3d894d9..52659fa 100644
> --- a/sound/soc/fsl/imx-wm8962.c
> +++ b/sound/soc/fsl/imx-wm8962.c
> @@ -231,7 +231,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> +	codec_clk = clk_get(&codec_dev->dev, NULL);
>  	if (IS_ERR(codec_clk)) {
>  		ret = PTR_ERR(codec_clk);
>  		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
> @@ -239,6 +239,7 @@ static int imx_wm8962_probe(struct platform_device *pdev)
>  	}
>  
>  	data->clk_frequency = clk_get_rate(codec_clk);
> +	clk_put(codec_clk);
>  
>  	data->dai.name = "HiFi";
>  	data->dai.stream_name = "HiFi";
> -- 
> 2.7.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
