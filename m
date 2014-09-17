Return-Path: <Shawn.Guo@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0131.outbound.protection.outlook.com [65.55.169.131])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 574A51A0076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 13:07:22 +1000 (EST)
Date: Wed, 17 Sep 2014 09:32:52 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root clock rate of
 spdif in driver
Message-ID: <20140917013251.GA4796@dragon>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
 <20140916180028.GA6784@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140916180028.GA6784@Asurada>
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

On Tue, Sep 16, 2014 at 11:19:28AM -0700, Nicolin Chen wrote:
> On Tue, Sep 16, 2014 at 07:46:34PM +0800, Shengjiu Wang wrote:
> > The spdif root clock may be used by other module or defined with
> > CLK_SET_RATE_GATE, so we can't change the clock rate in driver.
> > In this patch remove the clk_set_rate and clk_round_rate to protect the
> > clock.
> 
> It's a quite convenient and conservative way to remove the clock
> dealing code in the driver, however, it may result less flexible
> functionalities.
> 
> The reason why I left the clk_set_rate() in the driver is to hope
> we may find a better way to tackle those tough situations. For IP
> itself, it doesn't matter if the clock the SoC provides to it is
> being shared by other modules or not.
> 
> So I think, if it's a shared clock, we should not define it as a
> rate-changeable one in the SoC level, as we might still have some
> SoCs provide a dedicated clock to S/PDIF so as to get the maximum
> range of clock support for users.
> 
> @Shawn
> Sorry to involve you in this topic. I'm not so sure if we can do
> this in the clock driver so that the clock rate would be fixed
> even if the driver is trying to change it. If we can, I think we
> may use a better solution here instead.

No, we do not have anything like that today.

Shawn
