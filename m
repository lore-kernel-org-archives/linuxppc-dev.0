Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33E8D14009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 14:33:34 +1100 (EST)
Date: Tue, 1 Apr 2014 11:14:10 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Subject: Re: [PATCH bisect 2/2] ASoC: fsl_sai: Separately enable interrupts
 for Tx and Rx streams
Message-ID: <20140401031409.GA26925@MrMyself>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
 <1396322227-482-3-git-send-email-Guangyu.Chen@freescale.com>
 <d00e324f09954dcbb509f8c135ad51af@BN1PR03MB188.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <d00e324f09954dcbb509f8c135ad51af@BN1PR03MB188.namprd03.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "timur@tabi.org" <timur@tabi.org>, Xiubo Li-B47053 <Li.Xiubo@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 01, 2014 at 11:25:02AM +0800, Wang Dongsheng-B40534 wrote:
> > Subject: [PATCH bisect 2/2] ASoC: fsl_sai: Separately enable interrupts for Tx
> > and Rx streams
> > 
> > We only enable one side interrupt for each stream since over/underrun
> > on the opposite stream would be resulted from what we previously did,
> > enabling TERE but remaining FRDE disabled, even though the xrun on the
> > opposite direction will not break the current stream.
> > 
> > Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> > Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 8 ++++++--
> >  sound/soc/fsl/fsl_sai.h | 1 +
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index bdfd497..d64c33f 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -397,4 +397,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream
> > *substream, int cmd,
> > 
> >  		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
> > +				   FSL_SAI_CSR_xIE_MASK, FSL_SAI_FLAGS);
> > +		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
> >  				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
> >  		break;
> > @@ -404,4 +406,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream
> > *substream, int cmd,
> >  		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
> >  				   FSL_SAI_CSR_FRDE, 0);
> > +		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
> > +				   FSL_SAI_CSR_xIE_MASK, 0);
> > 
> >  		if (!(tcsr & FSL_SAI_CSR_FRDE || rcsr & FSL_SAI_CSR_FRDE)) {
> > @@ -464,6 +468,6 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
> >  	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
> > 
> > -	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, FSL_SAI_FLAGS);
> > -	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, FSL_SAI_FLAGS);
> > +	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, 0x0);
> > +	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, 0x0);
> 
> Why are you remove this macro? Don't use magic number.

It's pretty clear that the so-called magic number is to clear the settings
in the registers for driver init as what this driver did at the first place
-- no offense but I don't think you would ask this if you check the git-log
of the driver.

Thank you,
Nicolin Chen
