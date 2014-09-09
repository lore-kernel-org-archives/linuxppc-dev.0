Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F38F51A0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 06:03:56 +1000 (EST)
Message-ID: <540F5D29.7040309@tabi.org>
Date: Tue, 09 Sep 2014 15:03:53 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <540F5706.1050303@tabi.org>
 <20140909195928.GA5224@Asurada>
In-Reply-To: <20140909195928.GA5224@Asurada>
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

On 09/09/2014 02:59 PM, Nicolin Chen wrote:
> +	/*
> +	 * Initially mark the clock to NULL for all platforms so that later
> +	 * clk_prepare_enable() will ignore and return 0 for non-clock cases.
> +	 */
> +	ssi_private->clk = NULL;

According to Mark, NULL is a valid clock, so this should be instead:

	ssi_private->clk = PTR_ERR(-EINVAL);

although that doesn't sit well with me.
