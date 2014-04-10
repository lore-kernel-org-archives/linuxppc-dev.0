Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E080A14009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 17:56:19 +1000 (EST)
Date: Thu, 10 Apr 2014 15:46:36 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Subject: Re: [PATCH v4] ASoC: fsl_sai: Add clock controls for SAI
Message-ID: <20140410074635.GA14658@MrMyself>
References: <1397041577-9580-1-git-send-email-Guangyu.Chen@freescale.com>
 <fe26bf436e1846fca85415fc4c8bb67e@BY2PR03MB505.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <fe26bf436e1846fca85415fc4c8bb67e@BY2PR03MB505.namprd03.prod.outlook.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "timur@tabi.org" <timur@tabi.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "rob@landley.net" <rob@landley.net>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2014 at 03:39:51PM +0800, Xiubo Li-B47053 wrote:
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index db9f75e..7cd4af9 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -401,7 +401,23 @@ static int fsl_sai_startup(struct snd_pcm_substream
> > *substream,
> >  		struct snd_soc_dai *cpu_dai)
> >  {
> >  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> > -	u32 reg;
> > +	struct device *dev = &sai->pdev->dev;
> > +	u32 reg, i;
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(sai->bus_clk);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable bus clock\n");
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
> > +		ret = clk_prepare_enable(sai->mclk_clk[i]);
> > +		if (ret) {
> > +			dev_err(dev, "failed to enable mclk%d clock\n", i + 1);
> > +			goto err;
> > +		}
> > +	}
> > 
> 
> Why prepare and enable all the mclks here ?
> And at last only one of 'bus', 'mclk1', 'mclk2' and 'mclk3' will be selected
> To generate the bit clock. How about just prepare and enable the selected
> one ?
 
That's a fair suggestion. I'll do the revise.

But in this way. We can provisionally drop the clock enabling part and add
them later after my clock dividing patch is ready.

Thank you,
Nicolin
