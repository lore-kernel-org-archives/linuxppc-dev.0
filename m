Return-Path: <vinod.koul@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 04AE22C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 16:58:19 +1100 (EST)
Date: Tue, 12 Nov 2013 10:32:26 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Xiubo Li-B47053 <B47053@freescale.com>
Subject: Re: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
Message-ID: <20131112050226.GK8834@intel.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
 <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F8286A385@039-SN2MPN1-013.039d.mgd.msft.net>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Wang Huan-B18965 <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Guo Shawn-R65073 <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Chen Guangyu-B42378 <B42378@freescale.com>,
 "oskar@scara.com" <oskar@scara.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "rob@landley.net" <rob@landley.net>, "djbw@fb.com" <djbw@fb.com>,
 Jin Zhengxiong-R64188 <R64188@freescale.com>,
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

On Mon, Oct 28, 2013 at 05:58:42AM +0000, Xiubo Li-B47053 wrote:
> Hi Dan, Vinod,
> 
> 
> > > +static int fsl_sai_probe(struct platform_device *pdev) {
> > [...]
> > > +
> > > +	sai->dma_params_rx.addr = res->start + SAI_RDR;
> > > +	sai->dma_params_rx.maxburst = 6;
> > > +	index = of_property_match_string(np, "dma-names", "rx");
> > > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > > +				&dma_args);
> > > +	if (ret)
> > > +		return ret;
> > > +	sai->dma_params_rx.slave_id = dma_args.args[1];
> > > +
> > > +	sai->dma_params_tx.addr = res->start + SAI_TDR;
> > > +	sai->dma_params_tx.maxburst = 6;
> > > +	index = of_property_match_string(np, "dma-names", "tx");
> > > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > > +				&dma_args);
> > > +	if (ret)
> > > +		return ret;
> > > +	sai->dma_params_tx.slave_id = dma_args.args[1];
> > 
> > The driver should not have to manually parse the dma devicetree
> > properties, this is something that should be handled by the dma engine
> > driver.
> > 
> 
> What do you think about the DMA slave_id ?
> I have been noticed by one colleague that this should be parsed here, which
> is from your opinions ?
Sure slave_id can be parsed here, but IMO it should be programmed via the
dma_slave_confog into the respective channel

--
~Vinod
> 
> 
> > > +
> > > +	ret = snd_soc_register_component(&pdev->dev, &fsl_component,
> > > +			&fsl_sai_dai, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = fsl_pcm_dma_init(pdev);
> > > +	if (ret)
> > > +		goto out;
> 
> 

-- 
