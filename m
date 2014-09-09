Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B76551A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 01:24:05 +1000 (EST)
Message-ID: <540F1B90.702@tabi.org>
Date: Tue, 09 Sep 2014 10:24:00 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <540EFDFF.7050804@tabi.org> <20140909152114.GA2601@sirena.org.uk>
In-Reply-To: <20140909152114.GA2601@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/09/2014 10:21 AM, Mark Brown wrote:
>> if (ssi_private->clk)
>> >	clk_prepare_enable(ssi_private->clk);

> Should be a !IS_ERR() - NULL is a valid clock.

In that case, ssi_private->clk needs to be initialized to -EINVAL or 
something, so that the check works on systems that don't have any clocks.
