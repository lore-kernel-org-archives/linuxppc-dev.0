Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D86581A0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 05:59:44 +1000 (EST)
Received: by mail-pd0-f182.google.com with SMTP id w10so4692494pde.27
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 12:59:42 -0700 (PDT)
Date: Tue, 9 Sep 2014 12:59:29 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140909195928.GA5224@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540F5706.1050303@tabi.org>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de, linux-kernel@vger.kernel.org, broonie@kernel.org,
 lgirdwood@gmail.com, perex@perex.cz, Li.Xiubo@freescale.com,
 mpa@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2014 at 02:37:42PM -0500, Timur Tabi wrote:
> On 09/09/2014 01:38 PM, Nicolin Chen wrote:
> >make sure to have the call for imx only because it seems that
> >the other platforms do not depend on the clock.
> 
> Although I doubt anyone will every add support for clocks to PowerPC "side"
> of this driver, I would prefer to avoid IMX-specific changes. Instead, the
> code should check if a clock is available.  That's why I suggested this
> change:
> 
> -	if (ssi_private->soc->imx)
> +	if (!IS_ERR(ssi_private->clk))

Hmm.... I think the following change may be better?

probe() {
	....
+	/*
+	 * Initially mark the clock to NULL for all platforms so that later
+	 * clk_prepare_enable() will ignore and return 0 for non-clock cases.
+	 */
+	ssi_private->clk = NULL;
	.....
	fsl_ssi_imx_probe();
}

In this way, all platforms, not confined to imx any more, will be able
to call clk_prepare_enable(). Then we don't need an extra platform check
before calling it.
