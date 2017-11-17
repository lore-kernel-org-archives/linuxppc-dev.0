Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydPld1CtBzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 15:10:04 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id l24so999660pfj.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 20:10:04 -0800 (PST)
Date: Thu, 16 Nov 2017 20:09:57 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl_asrc: constify some arrays
Message-ID: <20171117040956.GA3153@Asurada-CZ80>
References: <cover.1510849466.git.joe@perches.com>
 <b8a2684d6615ab36fa28f67606e5560c8097c8ef.1510849466.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8a2684d6615ab36fa28f67606e5560c8097c8ef.1510849466.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2017 at 08:25:47AM -0800, Joe Perches wrote:
> Using const reduces data.
> 
> $ size sound/soc/fsl/fsl_asrc.o*
>    text	   data	    bss	    dec	    hex	filename
>   21691	   5872	    192	  27755	   6c6b	sound/soc/fsl/fsl_asrc.o.new
>   21435	   6128	    192	  27755	   6c6b	sound/soc/fsl/fsl_asrc.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index ed683fe8b94a..641724c9b3f8 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -49,12 +49,12 @@ static const u8 process_option[][12][2] = {
>  };
>  
>  /* Corresponding to process_option */
> -static int supported_input_rate[] = {
> +static const int supported_input_rate[] = {
>  	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
>  	96000, 176400, 192000,
>  };
>  
> -static int supported_asrc_rate[] = {
> +static const int supported_asrc_rate[] = {
>  	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
>  };
>  
> @@ -62,26 +62,26 @@ static int supported_asrc_rate[] = {
>   * The following tables map the relationship between asrc_inclk/asrc_outclk in
>   * fsl_asrc.h and the registers of ASRCSR
>   */
> -static unsigned char input_clk_map_imx35[] = {
> +static const unsigned char input_clk_map_imx35[] = {
>  	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf,
>  };
>  
> -static unsigned char output_clk_map_imx35[] = {
> +static const unsigned char output_clk_map_imx35[] = {
>  	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf,
>  };
>  
>  /* i.MX53 uses the same map for input and output */
> -static unsigned char input_clk_map_imx53[] = {
> +static const unsigned char input_clk_map_imx53[] = {
>  /*	0x0  0x1  0x2  0x3  0x4  0x5  0x6  0x7  0x8  0x9  0xa  0xb  0xc  0xd  0xe  0xf */
>  	0x0, 0x1, 0x2, 0x7, 0x4, 0x5, 0x6, 0x3, 0x8, 0x9, 0xa, 0xb, 0xc, 0xf, 0xe, 0xd,
>  };
>  
> -static unsigned char output_clk_map_imx53[] = {
> +static const unsigned char output_clk_map_imx53[] = {
>  /*	0x0  0x1  0x2  0x3  0x4  0x5  0x6  0x7  0x8  0x9  0xa  0xb  0xc  0xd  0xe  0xf */
>  	0x8, 0x9, 0xa, 0x7, 0xc, 0x5, 0x6, 0xb, 0x0, 0x1, 0x2, 0x3, 0x4, 0xf, 0xe, 0xd,
>  };
>  
> -static unsigned char *clk_map[2];
> +static const unsigned char *clk_map[2];
>  
>  /**
>   * Request ASRC pair
> -- 
> 2.15.0
> 
