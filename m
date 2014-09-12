Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F6CD1A019F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 20:41:18 +1000 (EST)
Date: Fri, 12 Sep 2014 18:40:55 +0800
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140912104054.GA6420@audiosh1>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
 <20140911225737.GA13926@Alpha> <20140912020110.GA414@audiosh1>
 <20140912061706.GA10680@pengutronix.de> <20140912071426.GA30261@audiosh1>
 <20140912085446.GA8844@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140912085446.GA8844@pengutronix.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2014 at 10:54:46AM +0200, Markus Pargmann wrote:
> On Fri, Sep 12, 2014 at 03:14:28PM +0800, Shengjiu Wang wrote:
> > On Fri, Sep 12, 2014 at 08:17:06AM +0200, Markus Pargmann wrote:
> > > Hi,
> > > 
> > > On Fri, Sep 12, 2014 at 10:01:12AM +0800, Shengjiu Wang wrote:
> > > > On Thu, Sep 11, 2014 at 03:57:37PM -0700, Nicolin Chen wrote:
> > > > > On Thu, Sep 11, 2014 at 01:38:29PM +0800, Shengjiu Wang wrote:
> > > > > > Move the ipg clock enable and disable operation to startup and shutdown,
> > > > > > that is only enable ipg clock when ssi is working. Keep clock is disabled
> > > > > > when ssi is in idle.
> > > > > > otherwise, _fsl_ssi_set_dai_fmt function need to be called in probe,
> > > > > > so add ipg clock control for it.
> > > > > 
> > > > > It seems to be no objection so far against my last suggestion to
> > > > > use regmap's mmio_clk() for named ipg clk only. So you may still
> > > > > consider about that.
> > > > >
> > > > I think mmio_clk() can be put to another patch. and this patch only for clk_enable()
> > > > and clk_disable() operation.
> > > 
> > > I would also prefer Nicolin's suggestion using regmap's mmio clk. I
> > > think it may be better to not add this particular patch at all and just
> > > go with the mmio_clk patch. It should be easy enough to just add the
> > > clock names to the devicetrees. That way we can avoid all those clock
> > > enable/disable function calls.
> > >
> > I considered if use Nicolin's suggestion, I still need ot add those
> > enable/disable function calls, because I want to remove the enable/disable
> > function call in fsl_ssi_imx_probe, then I need to add enable/disable 
> > function call in _fsl_ssi_set_dai_fmt(), which is called in fsl_ssi_probe().
> > _fsl_ssi_set_dai_fmt() need to access the registers.
> 
> I think Nicolin's suggestion was to check for a clock named "ipg". If it
> exists, you can simply use devm_regmap_init_mmio_clk(). Otherwise you
> could fallback to the old behaviour and get the first clock and enable
> it without disabling it after the probe function.
> 
> After that, you could add the clock-names property to the devicetrees
> and have the same result.
>
Ok, I have sent V3 for review. please check.

wang shengjiu 
> > 
> > > >  
> > > > > Anyway, I'd like to do thing in parallel. So I just simply tested
> > > > > it on my side and its works fine, it may still need to be tested
> > > > > by others though.
> > > > > 
> > > > > Nicolina
> > > > 
> > > > Hi Markus
> > > > 
> > > > could you please review it, and share your comments?
> > > 
> > > I think the clock enabling for AC97 is missing in your patch.
> > > 
> > I add clock enable in fsl_ssi_startup(), I think it is enough for AC97, does it?
> 
> No. We export ac97 read/write ops for the whole AC97 stuff. These may be
> used outside of the usual startup/shutdown which is done for substreams.
> It may work to have the ipg clock enabled in
> fsl_ssi_ac97_read/fsl_ssi_ac97_write.
> 
> Best regards,
> 
> Markus
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
