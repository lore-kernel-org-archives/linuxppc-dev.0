Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 702931A10CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 19:27:20 +1100 (AEDT)
Received: by mail-pd0-f169.google.com with SMTP id g10so4597403pdj.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 00:27:17 -0800 (PST)
Date: Fri, 23 Jan 2015 00:27:09 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <b50113@freescale.com>
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: fsl_sai: Add support for tdm slots
 operation
Message-ID: <20150123082708.GA3408@Alpha>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
 <20150121180801.GA3361@Alpha> <20150122045515.GA3467@b50113>
 <20150122054409.GA7748@Asurada> <20150122062004.GA7046@b50113>
 <20150122235019.GA3204@Asurada-GSX> <20150123025507.GA2382@b50113>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150123025507.GA2382@b50113>
Cc: alsa-devel@alsa-project.org, timur@tabi.org,
 Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 23, 2015 at 10:55:09AM +0800, Zidan Wang wrote:
> I have another question.
> 
> Can a channel have several slots? Or channel just means slot.

Strictly speaking, a channel surely may have several slots IMO.
The idea for TDM, even for I2S, left channel can bear multiple
slots -- each may be masked and then received by a different
peripheral.

The reason I've said that much against your code is not fully
objection against your idea of using Slot Per Channel but for
the implementation -- you divided them and then multiplied them
again while your true motivation was just to calculate the bclk.
And I could not understand it without seeing your later explain.
Code and things would be much easier if you make it straight
forward.

But actually I don't mind if you feel comfortable to make a
detour like that, but as I commented at the first place. Code
like that should be companied with comments to tell its meaning.
And I still don't fully understand why you override the channels
for monaural cases.

> > And another problem of your patch is the configurations for FRSZ and
> > xMR fields. For monaural case, the channels == 1, the current code
> > passes it directly to set them while your code overrides it to 2.
> > 
> > I'm not sure if you've tested the monaural case and confirmed it works.
> > But, apparently, the configurations look pretty different.

> I have tested the mono case, it works well.

I just ran a simple test with speaker-test -Dhw:0 -c1, it works
but the FRSZ value is changed to 0x1 for a monaural case (0x0
originally). Setting FRSZ to 0x0 makes more sense to me since
it looks like the configuration for active slot number. But
that depends on the internal logic design of SAI so it may be
better for you to double check with IC owner and run more tests.
If you confirm that, I for sure will be willing to ignore the
change here.

Nicolin
