Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BF941A001C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 04:41:45 +1000 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kx10so5959571pab.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 11:41:42 -0700 (PDT)
Date: Tue, 9 Sep 2014 11:41:31 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140909184130.GB6944@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909112750.GS2601@sirena.org.uk>
 <20140909180309.GA6784@Asurada>
 <20140909181516.GI2601@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140909181516.GI2601@sirena.org.uk>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
 timur@tabi.org, perex@perex.cz, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2014 at 07:15:16PM +0100, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 11:03:10AM -0700, Nicolin Chen wrote:
> > On Tue, Sep 09, 2014 at 12:27:50PM +0100, Mark Brown wrote:
> > > On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:
> > > > -	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
> > > > +	ssi_private->clk = devm_clk_get(&pdev->dev, "ipg");
> 
> > > Why is this change being made?  It wasn't mentioned in the commit log
> > > and doesn't seem relevant to moving where the enable and disable are
> > > done which is what the patch is supposed to be doing...
> 
> > I think Shengjiu is trying to keep the clock disabled while SSI's idle.
> > The current driver enables ipg clock anyway even if there's no stream
> > running.
> 
> > Apparently, these should be put into the comment log.
> 
> I got that bit.  However as well as changing where the enable and
> disable take place this is also changing from requesting a clock with a
> NULL to requesting one called "ipg".

Understood. Making one patch do one single change is the rule we should
always follow.
