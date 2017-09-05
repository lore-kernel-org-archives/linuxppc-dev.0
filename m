Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x231.google.com (mail-pg0-x231.google.com
 [IPv6:2607:f8b0:400e:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmf8S361mzDqZ0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 17:52:55 +1000 (AEST)
Received: by mail-pg0-x231.google.com with SMTP id v66so7515696pgb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 00:52:55 -0700 (PDT)
Date: Tue, 5 Sep 2017 00:52:48 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Message-ID: <20170905075247.GA6112@Asurada>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <20170905050602.GA2774@Asurada-CZ80>
 <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 05, 2017 at 09:37:43AM +0200, Łukasz Majewski wrote:

> >>The last call is changing the bit clock (BCLK) frequency to SSI's IP
> >>block clock (ipg = 66 MHz) [1].
> >
> >I think a bigger question here is why the routine sets BCLK to 66MHz.
> 
> Yes, exactly.
> 
> In my case the bclk is set to ipg clock, which is the SSI IP block clock
> (ipg).

Can you elaborate why you set ipg clock as bclk? I don't remember SSI could
derive bitclock from ipg clock.

> >>This is wrong, since IMX SSI block requires the I2S BCLK to be less
> >>than 1/5 of [1].
> >>
> >>As a result the driver initialization passes without any errors, but the
> >>speaker-test test case breaks.
> >>
> >>This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
> >>not equal to [1].
> >
> >I don't feel it's quite comprehensive...what if it's being set to 67MHz.
> 
> I think that this clock is not changing for the SoC. It should be 66 MHz
> fixed.

What I mean is that we cannot just look at this SoC. Today is 66MHz for this
SoC. Tomorrow could be 133MHz for another one. We should put a check that none
of these shall pass -- the 1/5 limit.
