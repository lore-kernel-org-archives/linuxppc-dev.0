Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LWrd499fzF1QP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 05:53:34 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id j3-v6so3362767pfh.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 12:53:34 -0700 (PDT)
Date: Wed, 4 Jul 2018 12:53:26 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_spdif: Use 64-bit arithmetic
 instead of 32-bit
Message-ID: <20180704195325.GA7800@Asurada>
References: <20180704141833.GA6702@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180704141833.GA6702@embeddedor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 04, 2018 at 09:18:33AM -0500, Gustavo A. R. Silva wrote:
> Add suffix ULL to constant 64 in order to give the compiler complete
> information about the proper arithmetic to use.
> 
> Notice that such constant is used in a context that expects an
> expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit arithmetic:
> 
> rate[index] * txclk_df * 64
> 
> Addresses-Coverity-ID: 1222129 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks.

> ---
>  sound/soc/fsl/fsl_spdif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 9b59d87..740b90d 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1118,7 +1118,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  
>  	for (sysclk_df = sysclk_dfmin; sysclk_df <= sysclk_dfmax; sysclk_df++) {
>  		for (txclk_df = 1; txclk_df <= 128; txclk_df++) {
> -			rate_ideal = rate[index] * txclk_df * 64;
> +			rate_ideal = rate[index] * txclk_df * 64ULL;
>  			if (round)
>  				rate_actual = clk_round_rate(clk, rate_ideal);
>  			else
> -- 
> 2.7.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
