Return-Path: <ckeepax@opensource.wolfsonmicro.com>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsw9j1hRTzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 02:41:43 +1100 (AEDT)
Date: Tue, 28 Mar 2017 16:42:38 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
To: Mark Brown <broonie@kernel.org>
CC: Daniel Baluta <daniel.baluta@gmail.com>, Daniel Baluta
 <daniel.baluta@nxp.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, <Xiubo.Lee@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 <fabio.estevam@nxp.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
Message-ID: <20170328154238.GS6986@localhost.localdomain>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
 <20170328115306.GR6986@localhost.localdomain>
 <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 28, 2017 at 04:24:57PM +0100, Mark Brown wrote:
> On Tue, Mar 28, 2017 at 12:53:06PM +0100, Charles Keepax wrote:
> > On Tue, Mar 28, 2017 at 01:47:04PM +0300, Daniel Baluta wrote:
> 
> > > >> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> > > >> +     codec_clk = clk_get(&codec_dev->dev, NULL);
> 
> > > is different from &codec_dev->dev.
> 
> > I get that they are different, I just don't get why changing
> > from a devm_clk_get to a clk_get is a better fix than changing
> > &codec->dev to &pdev->dev.
> 
> This should be clear from the semantics of clk_get(): you're looking up
> the clock in the context of the supplied device and the clock is
> attached to the CODEC so you need to look up in the CODEC context.  What
> would be even better would be to move the allocation of the clock into
> the CODEC driver...

Ah yes thats what I was missing.

Thanks,
Charles
