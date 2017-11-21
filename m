Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygml03ZT5zDrMg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 11:32:44 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i15so8551523pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Nov 2017 16:32:44 -0800 (PST)
Date: Mon, 20 Nov 2017 16:32:40 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 alsa-devel@alsa-project.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: fsl_ssi: AC'97 ops need regmap,
 clock and cleaning up on failure
Message-ID: <20171121003239.GC14136@Asurada-Nvidia>
References: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ecfcedaa-f0e9-ec1f-82c5-f0d319068a5d@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 20, 2017 at 11:14:55PM +0100, Maciej S. Szmigiero wrote:
> AC'97 ops (register read / write) need SSI regmap and clock, so they have
> to be set after them.
> 
> We also need to set these ops back to NULL if we fail the probe.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_ssi.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index dad80b4b0cfc..a71bb8391f61 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1460,12 +1460,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  				sizeof(fsl_ssi_ac97_dai));
>  
>  		fsl_ac97_data = ssi_private;

By the way, is there any better way to register the ops for AC97
while we could pass the ssi_private so as to remove the global
fsl_ac97_data?
