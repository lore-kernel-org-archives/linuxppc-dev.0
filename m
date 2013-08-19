Return-Path: <B42378@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12ADF2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 16:25:27 +1000 (EST)
Date: Mon, 19 Aug 2013 14:24:39 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [PATCH v6 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130819062438.GB10544@MrMyself>
References: <cover.1376657643.git.b42378@freescale.com>
 <df3c09cd5679649b144bb45dfd5fc746628266d4.1376657643.git.b42378@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07114BC3@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130819030743.GA10544@MrMyself>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07116BA7@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07116BA7@039-SN2MPN1-013.039d.mgd.msft.net>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bhushan,

   I'll revise some as you suggest. Just a few replies here.

On Mon, Aug 19, 2013 at 12:38:11PM +0800, Bhushan Bharat-R65777 wrote:
> > We here suppose the reset bit would be cleared -- "The software reset will last
> > 8 cycles." from RM, so if this happened to be a failure, the whole IP module
> > won't be normally working as well.
> 
> Also add a comment describing this against why cycle = 1000 is selected.

If it is done in 8 cycles, 1000-cycle will be surely a safe value for it.
As long as it finished in 8 cycles, it would quit anyway. Why against?


> > > > +static bool fsl_spdif_volatile_reg(struct device *dev, unsigned int reg)
> > > > +{
> > > > +	/* Sync all registers after reset */
> > >
> > > Where us sync :) ?
> > 
> > The "return true" would do that. For volatile registers, if no "return true"
> > here, the whole regmap would use the value in cache, while for some bits
> > we need to trace its true value from the physical registers not from cache.
> 
> Where will be device registers cached? Do not we program them to be non-cacheable in core?

regmap has a regcache for all the mapped registers. Set the regsiters as
volatile will allow the driver to sync the regcache with physical memory
each time when using regmap_read/write/update_bits().

But I think I can try to use the regcache_bypass instead.


Thank you,
Nicolin Chen
