Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com
 [IPv6:2607:f8b0:400e:c02::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D33C11A043B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 16:42:29 +1000 (EST)
Received: by mail-pd0-f171.google.com with SMTP id p10so7648246pdj.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 23:42:26 -0700 (PDT)
Date: Tue, 9 Sep 2014 23:42:12 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in
 this module
Message-ID: <20140910064211.GA7652@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada>
 <20140910062118.GA26348@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140910062118.GA26348@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, timur@tabi.org,
 alsa-devel@alsa-project.org, tiwai@suse.de, Li.Xiubo@freescale.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 10, 2014 at 08:21:18AM +0200, Markus Pargmann wrote:
> On Tue, Sep 09, 2014 at 11:38:05AM -0700, Nicolin Chen wrote:
> > On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:
> > > @@ -1321,7 +1333,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
> > >  		return -ENOMEM;
> > >  	}
> > >  
> > > -	ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
> > > +	if (ssi_private->soc->imx)
> > > +		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
> > > +			"ipg", iomem, &fsl_ssi_regconfig);
> > > +	else
> > > +		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
> > 
> > As Markus mentioned, the key point here is to be compatible with those
> > non-clock-name platforms.
> > 
> > I think it would be safer to keep the current code while adding an extra
> > clk_disable_unprepare() at the end of probe() as a common routine. And
> > meantime, make sure to have the call for imx only because it seems that
> > the other platforms do not depend on the clock. //a bit guessing here :)
> > 
> > Then we can get a patch like:
> > open() {
> > +	clk_prepare_enable();
> > 	....
> > }
> > 
> > close() {
> > 	....
> > +	clk_disable_unprepare()
> > }
> > 
> > probe() {
> > 	clk_get();
> > 	clk_prepare_enable();
> > 	....
> > 	if (xxx)
> > -		goto err_xx;
> > +		return ret;
> > 	....
> > +	clk_disable_unprepare();
> > 	return 0;
> > -err_xx:
> > -	clk_disable_unprepare()
> > }
> > 
> > remove() {
> > 	....
> > -	clk_disable_unprepare()
> > }
> 
> If I remember correctly, there may be AC97 communication with the codec
> before any substream is created. That's why we enable the SSI unit right
> at the beginning for AC97 in fsl_ssi_setup_reg_vals(). So we need to
> check for AC97 before disabling clocks.

Thank you for the input. That's the exact part I couldn't be sure.
And I agree that adding a check for AC97 will be safer while this
may keeps itself removable if being unnecessary.

Thanks
Nicolin
