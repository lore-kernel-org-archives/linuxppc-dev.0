Return-Path: <B04825@freescale.com>
Message-ID: <4E5261A5.5050608@freescale.com>
Date: Mon, 22 Aug 2011 09:03:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] sound/soc/fsl/fsl_dma.c: add missing of_node_put
References: <1313825025-17590-1-git-send-email-julia@diku.dk>
In-Reply-To: <1313825025-17590-1-git-send-email-julia@diku.dk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	devicetree-discuss@lists.ozlabs.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
	Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Julia Lawall wrote:
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index 0efc04a..b33271b 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -880,10 +880,12 @@ static struct device_node *find_ssi_node(struct device_node *dma_channel_np)
>  		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
>  		if (np == dma_channel_np)
>  			return ssi_np;
> +		of_node_put(np);
>  
>  		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
>  		if (np == dma_channel_np)
>  			return ssi_np;
> +		of_node_put(np);
>  	}

Thanks for catching the problem, Julia, but the fix is not quite correct.  My
code assumes that of_parse_phandle() doesn't claim the node, but it doesn't
actually use the node pointer, either.  All I care about is whether 'np' is
equal to dma_channel_np.  I'm not going to use 'np'.  So I think the real fix is
this:

@@ -880,10 +880,12 @@ static struct device_node *find_ssi_node(struct
device_node *dma_channel_np)
 		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
+		of_node_put(np);
 		if (np == dma_channel_np)
 			return ssi_np;

 		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
+		of_node_put(np);
 		if (np == dma_channel_np)
 			return ssi_np;
 	}

 	return NULL;

-- 
Timur Tabi
Linux kernel developer at Freescale
