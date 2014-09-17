Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E87FB1A019A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 12:50:35 +1000 (EST)
Received: by mail-pd0-f173.google.com with SMTP id ft15so1106948pdb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 19:50:32 -0700 (PDT)
Date: Tue, 16 Sep 2014 19:50:15 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root clock rate of
 spdif in driver
Message-ID: <20140917025014.GA6048@Asurada>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
 <20140916180028.GA6784@Asurada> <20140917013251.GA4796@dragon>
 <20140917022440.GA3216@Asurada> <20140917023127.GA16456@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140917023127.GA16456@dragon>
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

On Wed, Sep 17, 2014 at 10:31:28AM +0800, Shawn Guo wrote:
> On Tue, Sep 16, 2014 at 07:24:40PM -0700, Nicolin Chen wrote:
> > It's not supported in the clock API or just not implemented in our
> > code? Can we just register a clock without CLK_SET_RATE_PARENT to
> > achieve the purpose? (We are just trying to fix those PRED and PODF
> > dividers when the driver calls set_rate to their GATE clock.)
> 
> It seems I misunderstood your question.  Yes, if we drop flag
> CLK_SET_RATE_PARENT for the gate clock in question, the rate change
> request will not be propagated to upstream dividers.

Okay. Since there's a solution that allows us to handle it better,
problem solved then.

@Shengjiu
Would you please take a look at the clock driver to implement a
new clock register function? And make sure to register the GATE
clock only without the flag CLK_SET_RATE_PARENT, as we may still
need to set a reasonable rate for the clock by setting its PODF
clock node instead.

Thank you both
Nicolin
