Return-Path: <Shawn.Guo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B24D11A0014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 12:46:20 +1000 (EST)
Date: Wed, 17 Sep 2014 10:31:28 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root clock rate of
 spdif in driver
Message-ID: <20140917023127.GA16456@dragon>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
 <20140916180028.GA6784@Asurada> <20140917013251.GA4796@dragon>
 <20140917022440.GA3216@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140917022440.GA3216@Asurada>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
 broonie@kernel.org, timur@tabi.org, perex@perex.cz, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2014 at 07:24:40PM -0700, Nicolin Chen wrote:
> It's not supported in the clock API or just not implemented in our
> code? Can we just register a clock without CLK_SET_RATE_PARENT to
> achieve the purpose? (We are just trying to fix those PRED and PODF
> dividers when the driver calls set_rate to their GATE clock.)

It seems I misunderstood your question.  Yes, if we drop flag
CLK_SET_RATE_PARENT for the gate clock in question, the rate change
request will not be propagated to upstream dividers.

Shawn
