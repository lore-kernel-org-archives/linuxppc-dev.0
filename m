Return-Path: <lrg@ti.com>
Message-ID: <4E52B692.2030601@ti.com>
Date: Mon, 22 Aug 2011 21:05:38 +0100
From: Liam Girdwood <lrg@ti.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] sound/soc/fsl/fsl_dma.c: add missing of_node_put
References: <1314022961-27513-1-git-send-email-timur@freescale.com>
In-Reply-To: <1314022961-27513-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"tiwai@suse.de" <tiwai@suse.de>, "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"broonie@opensource.wolfsonmicro.com"
	<broonie@opensource.wolfsonmicro.com>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "julia@diku.dk" <julia@diku.dk>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/08/11 15:22, Timur Tabi wrote:
> of_parse_phandle increments the reference count of np, so this should be
> decremented before trying the next possibility.
> 
> Since we don't actually use np, we can decrement the reference count
> immediately.
> 
> Reported-by: Julia Lawall <julia@diku.dk>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  sound/soc/fsl/fsl_dma.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
> index 6680c0b..b300f4b 100644
> --- a/sound/soc/fsl/fsl_dma.c
> +++ b/sound/soc/fsl/fsl_dma.c
> @@ -877,10 +877,12 @@ static struct device_node *find_ssi_node(struct device_node *dma_channel_np)
>  		 * assume that device_node pointers are a valid comparison.
>  		 */
>  		np = of_parse_phandle(ssi_np, "fsl,playback-dma", 0);
> +		of_node_put(np);
>  		if (np == dma_channel_np)
>  			return ssi_np;
>  
>  		np = of_parse_phandle(ssi_np, "fsl,capture-dma", 0);
> +		of_node_put(np);
>  		if (np == dma_channel_np)
>  			return ssi_np;
>  	}
