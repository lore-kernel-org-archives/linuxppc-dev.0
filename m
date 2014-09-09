Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C5421A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 04:03:27 +1000 (EST)
Received: by mail-pd0-f170.google.com with SMTP id fp1so1684629pdb.29
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 11:03:25 -0700 (PDT)
Date: Tue, 9 Sep 2014 11:03:10 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140909180309.GA6784@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909112750.GS2601@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140909112750.GS2601@sirena.org.uk>
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

On Tue, Sep 09, 2014 at 12:27:50PM +0100, Mark Brown wrote:
> On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:
> > -	ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
> > +	ssi_private->clk = devm_clk_get(&pdev->dev, "ipg");
> >  	if (IS_ERR(ssi_private->clk)) {
> >  		ret = PTR_ERR(ssi_private->clk);
> > -		dev_err(&pdev->dev, "could not get clock: %d\n", ret);
> > -		return ret;
> 
> Why is this change being made?  It wasn't mentioned in the commit log
> and doesn't seem relevant to moving where the enable and disable are
> done which is what the patch is supposed to be doing...

I think Shengjiu is trying to keep the clock disabled while SSI's idle.
The current driver enables ipg clock anyway even if there's no stream
running.

Apparently, these should be put into the comment log.

Thank you
Nicolin
