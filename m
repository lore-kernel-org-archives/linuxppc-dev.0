Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z9VhM3VPrzDqvc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jan 2018 08:29:37 +1100 (AEDT)
Subject: Re: [PATCH v1 03/15] ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <1513702819-42310-4-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <7509f512-1c7f-2fd2-e127-510106e2d9d5@maciej.szmigiero.name>
Date: Mon, 1 Jan 2018 22:29:24 +0100
MIME-Version: 1.0
In-Reply-To: <1513702819-42310-4-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.12.2017 18:00, Nicolin Chen wrote:
> The define of fsl_ssi_disable_val is not so clear as it mixes two
> steps of calculations together. And those parameter names are also
> a bit long to read.
> 
> Since it just tries to exclude the shared bits from the regvals of
> current stream while the opposite stream is active, it's better to
> use something like ssi_excl_shared_bits.
> 
> This patch also bisects fsl_ssi_disable_val into two macros of two
> corresponding steps and then shortens its parameter names. It also
> updates callers in the fsl_ssi_config() accordingly.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 54 ++++++++++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index f05f78d..6dda2e0 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c

> @@ -445,16 +445,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
>  	bool tx = &ssi->regvals[TX] == vals;
>  	struct regmap *regs = ssi->regs;
>  	struct fsl_ssi_regvals *avals;
> -	int nr_active_streams;
> -	int keep_active;
> -
> -	nr_active_streams = !!(ssi->streams & BIT(TX)) +
> -			    !!(ssi->streams & BIT(RX));
> +	bool aactive;
>  
> -	if (nr_active_streams - 1 > 0)
> -		keep_active = 1;
> -	else
> -		keep_active = 0;
> +	/* Check if the opposite stream is active */
> +	aactive = ssi->streams & BIT(!tx);

I don't think that hardcoding an implicit assumption here that RX == 0,
TX == 1 is a good thing.
If in the future, for any reason, somebody changes values of these macros
this code will silently break.

I would instead change this line into something like
"aactive = ssi->streams & (tx ? BIT(RX) : BIT(TX));" or similar.

Maciej
