Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1882E1A05F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 18:27:50 +1000 (EST)
Date: Wed, 10 Sep 2014 16:12:53 +0800
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140910081251.GA14662@audiosh1>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140909183804.GA6944@Asurada>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz, broonie@kernel.org,
 mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2014 at 11:38:05AM -0700, Nicolin Chen wrote:
> On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:
> > @@ -1321,7 +1333,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >  
> > -	ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
> > +	if (ssi_private->soc->imx)
> > +		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
> > +			"ipg", iomem, &fsl_ssi_regconfig);
> > +	else
> > +		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
> 
> As Markus mentioned, the key point here is to be compatible with those
> non-clock-name platforms.
> 
> I think it would be safer to keep the current code while adding an extra
> clk_disable_unprepare() at the end of probe() as a common routine. And
> meantime, make sure to have the call for imx only because it seems that
> the other platforms do not depend on the clock. //a bit guessing here :)
> 
> Then we can get a patch like:
> open() {
> +	clk_prepare_enable();
> 	....
> }
> 
> close() {
> 	....
> +	clk_disable_unprepare()
> }
what is the open() and close()? do you mean the fsl_ssi_startup()
and fsl_ssi_shutdown()?
> 
> probe() {
> 	clk_get();
> 	clk_prepare_enable();
> 	....
> 	if (xxx)
> -		goto err_xx;
> +		return ret;
> 	....
> +	clk_disable_unprepare();
> 	return 0;
> -err_xx:
> -	clk_disable_unprepare()
> }
If this probe() is fsl_ssi_imx_probe(), I think no need to add
clk_prepare_enable() or clk_disable_unprepare(), seems there is no 
registers accessing in this probe.
> 
> remove() {
> 	....
> -	clk_disable_unprepare()
> }
> 
> As long as you make the subject clear as 'Don't enable core/ipg clock
> when SSI's idle', I'm sure you can make them within a single patch.
> 
> And an alternative way for open() and close() is to put those code into
> pm_runtime_resume/suspend() instead (since we might have some internal
> code need to be added by using pm_runtime as well), which would make
> the further code neater IMO.
> 
> Thank you
> Nicolin
