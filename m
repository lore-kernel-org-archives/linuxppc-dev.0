Return-Path: <lrg@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailhost.ti.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A81FB6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Aug 2011 20:30:06 +1000 (EST)
Message-ID: <4E522D02.9020809@ti.com>
Date: Mon, 22 Aug 2011 11:18:42 +0100
From: Liam Girdwood <lrg@ti.com>
MIME-Version: 1.0
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH] sound/soc/fsl/fsl_dma.c: add missing of_node_put
References: <1313825025-17590-1-git-send-email-julia@diku.dk>
In-Reply-To: <1313825025-17590-1-git-send-email-julia@diku.dk>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	Takashi Iwai <tiwai@suse.de>, "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/08/11 08:23, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> of_parse_phandle increments the reference count of np, so this should be
> decremented before trying the next possibility.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e,e1,e2;
> @@
> 
> *e = of_parse_phandle(...)
> ... when != of_node_put(e)
>     when != true e == NULL
>     when != e2 = e
> e = e1
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  sound/soc/fsl/fsl_dma.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
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
>  
>  	return NULL;
> 

Acked-by: Liam Girdwood <lrg@ti.com>
