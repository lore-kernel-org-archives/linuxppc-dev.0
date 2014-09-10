Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 136881A0014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 20:17:25 +1000 (EST)
Date: Wed, 10 Sep 2014 18:01:42 +0800
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140910100141.GA17326@audiosh1>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140909195928.GA5224@Asurada>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, Timur Tabi <timur@tabi.org>, perex@perex.cz,
 broonie@kernel.org, mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2014 at 12:59:29PM -0700, Nicolin Chen wrote:
> On Tue, Sep 09, 2014 at 02:37:42PM -0500, Timur Tabi wrote:
> > On 09/09/2014 01:38 PM, Nicolin Chen wrote:
> > >make sure to have the call for imx only because it seems that
> > >the other platforms do not depend on the clock.
> > 
> > Although I doubt anyone will every add support for clocks to PowerPC "side"
> > of this driver, I would prefer to avoid IMX-specific changes. Instead, the
> > code should check if a clock is available.  That's why I suggested this
> > change:
> > 
> > -	if (ssi_private->soc->imx)
> > +	if (!IS_ERR(ssi_private->clk))
> 
> Hmm.... I think the following change may be better?
> 
> probe() {
> 	....
> +	/*
> +	 * Initially mark the clock to NULL for all platforms so that later
> +	 * clk_prepare_enable() will ignore and return 0 for non-clock cases.
> +	 */
> +	ssi_private->clk = NULL;
> 	.....
> 	fsl_ssi_imx_probe();
> }
ssi_private is initialized to zero in beginning of probe. I think no need to
add this change here.

wang shengjiu
> 
> In this way, all platforms, not confined to imx any more, will be able
> to call clk_prepare_enable(). Then we don't need an extra platform check
> before calling it.
