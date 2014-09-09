Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 309111A06E2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 05:37:47 +1000 (EST)
Message-ID: <540F5706.1050303@tabi.org>
Date: Tue, 09 Sep 2014 14:37:42 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada>
In-Reply-To: <20140909183804.GA6944@Asurada>
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

On 09/09/2014 01:38 PM, Nicolin Chen wrote:
> make sure to have the call for imx only because it seems that
> the other platforms do not depend on the clock.

Although I doubt anyone will every add support for clocks to PowerPC 
"side" of this driver, I would prefer to avoid IMX-specific changes. 
Instead, the code should check if a clock is available.  That's why I 
suggested this change:

-	if (ssi_private->soc->imx)
+	if (!IS_ERR(ssi_private->clk))
