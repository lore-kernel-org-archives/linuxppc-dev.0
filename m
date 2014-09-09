Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E8A721A0012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 06:27:23 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id fp1so4138303pdb.28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Sep 2014 13:27:22 -0700 (PDT)
Date: Tue, 9 Sep 2014 13:27:10 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140909202710.GB5224@Asurada>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada> <540F5D29.7040309@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540F5D29.7040309@tabi.org>
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

On Tue, Sep 09, 2014 at 03:03:53PM -0500, Timur Tabi wrote:
> On 09/09/2014 02:59 PM, Nicolin Chen wrote:
> >+	/*
> >+	 * Initially mark the clock to NULL for all platforms so that later
> >+	 * clk_prepare_enable() will ignore and return 0 for non-clock cases.
> >+	 */
> >+	ssi_private->clk = NULL;
> 
> According to Mark, NULL is a valid clock, so this should be instead:
> 
> 	ssi_private->clk = PTR_ERR(-EINVAL);
> 
> although that doesn't sit well with me.

I guess Mark's comment is merely against the check for clk validation
because if talking about clk validation, we should check IS_ERR(clk)
rather than check !=NULL directly.

However, my approach doesn't need any check. The open() or pm_resume()
can just call clk_prepare_enable() directly. The __clk_enable() will
then handle the 'clk == NULL' case:

static int __clk_enable(struct clk *clk)
{
	int ret = 0;

	if (!clk)
		return 0;
