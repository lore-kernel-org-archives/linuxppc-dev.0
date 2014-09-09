Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C752C1A014D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 06:37:29 +1000 (EST)
Message-ID: <540F6506.4060302@tabi.org>
Date: Tue, 09 Sep 2014 15:37:26 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada> <540F5D29.7040309@tabi.org>
 <20140909202710.GB5224@Asurada>
In-Reply-To: <20140909202710.GB5224@Asurada>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 09/09/2014 03:27 PM, Nicolin Chen wrote:
> I guess Mark's comment is merely against the check for clk validation
> because if talking about clk validation, we should check IS_ERR(clk)
> rather than check !=NULL directly.

Ah, that makes sense now.

> However, my approach doesn't need any check. The open() or pm_resume()
> can just call clk_prepare_enable() directly. The __clk_enable() will
> then handle the 'clk == NULL' case:

Yes, I was thinking the same thing.
