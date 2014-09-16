Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com
 [IPv6:2607:f8b0:400e:c02::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 609B31A0090
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 04:20:18 +1000 (EST)
Received: by mail-pd0-f174.google.com with SMTP id v10so313712pde.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 11:20:14 -0700 (PDT)
Date: Tue, 16 Sep 2014 11:19:28 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>, shawn.guo@freescale.com
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root clock rate of
 spdif in driver
Message-ID: <20140916180028.GA6784@Asurada>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2014 at 07:46:34PM +0800, Shengjiu Wang wrote:
> The spdif root clock may be used by other module or defined with
> CLK_SET_RATE_GATE, so we can't change the clock rate in driver.
> In this patch remove the clk_set_rate and clk_round_rate to protect the
> clock.

It's a quite convenient and conservative way to remove the clock
dealing code in the driver, however, it may result less flexible
functionalities.

The reason why I left the clk_set_rate() in the driver is to hope
we may find a better way to tackle those tough situations. For IP
itself, it doesn't matter if the clock the SoC provides to it is
being shared by other modules or not.

So I think, if it's a shared clock, we should not define it as a
rate-changeable one in the SoC level, as we might still have some
SoCs provide a dedicated clock to S/PDIF so as to get the maximum
range of clock support for users.

@Shawn
Sorry to involve you in this topic. I'm not so sure if we can do
this in the clock driver so that the clock rate would be fixed
even if the driver is trying to change it. If we can, I think we
may use a better solution here instead.

Thank you
Nicolin
