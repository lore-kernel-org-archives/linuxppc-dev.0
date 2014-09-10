Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E641E1A0014
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 03:42:21 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id fa1so7546665pad.30
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 10:42:19 -0700 (PDT)
Date: Wed, 10 Sep 2014 10:42:04 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140910174204.GA4628@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <20140910081251.GA14662@audiosh1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140910081251.GA14662@audiosh1>
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

On Wed, Sep 10, 2014 at 04:12:53PM +0800, Shengjiu Wang wrote:
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

> what is the open() and close()? do you mean the fsl_ssi_startup()
> and fsl_ssi_shutdown()?

Yea.

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

> If this probe() is fsl_ssi_imx_probe(), I think no need to add
> clk_prepare_enable() or clk_disable_unprepare(), seems there is no 
> registers accessing in this probe.

This is trying to be safe, especially for such a driver being used
by multiple platforms. You can omit this as long as the patch can
pass the test on old imx, PowerPC, and AC97 platforms.

>

And another risk just came to my mind is that there would be a
possibility that a machine driver would call set_dai_fmt() early,
after SSI's probe() and before SSI's startup(), if the machine
driver contains dai_fmt assignment in its probe(). Then, without
regmap_mmio_clk(), it'll be tough for us over here because we may
also need to add clock enable/disable for set_dai_fmt/set_sysclk(),
even if there might be still tiny risk that we missed something.

Then there could be a selfish approach to circumvent it is to use
regmap_mmio_clk() with "ipg" at the beginning and call regmap_mmio()
without "ipg" if getting a failed return value from regmap_mmio_clk,
and meanwhile to keep the clock always enabled for the regmap_mmio()
case just like what the current driver is doing. This may result
those non-ipg-clk platforms can't benefit from this refinement
unless they update their DT bindings -- use "ipg" for core clock
This might be the safest and simplest way for us, I'm not sure
everyone would be comfortable with this idea though.

Best regards,
Nicolin
