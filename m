Return-Path: <daniel.baluta@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtQkV605mzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 22:38:25 +1100 (AEDT)
Received: by mail-it0-x241.google.com with SMTP id 190so9139935itm.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 04:38:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
 <20170328115306.GR6986@localhost.localdomain>
 <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 29 Mar 2017 14:38:23 +0300
Message-ID: <CAEnQRZCiaCfzQRDo-3UupH8fv9BttZBVVXo63FdnrdqG49F1GQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 28, 2017 at 6:24 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 28, 2017 at 12:53:06PM +0100, Charles Keepax wrote:
>> On Tue, Mar 28, 2017 at 01:47:04PM +0300, Daniel Baluta wrote:
>
>> > >> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
>> > >> +     codec_clk = clk_get(&codec_dev->dev, NULL);
>
>> > is different from &codec_dev->dev.
>
>> I get that they are different, I just don't get why changing
>> from a devm_clk_get to a clk_get is a better fix than changing
>> &codec->dev to &pdev->dev.
>
> This should be clear from the semantics of clk_get(): you're looking up
> the clock in the context of the supplied device and the clock is
> attached to the CODEC so you need to look up in the CODEC context.  What
> would be even better would be to move the allocation of the clock into
> the CODEC driver...

If I read the code correctly, both machine and codec driver are doing:

* codec_clk = clk_get(...)

I guess that the codec driver is the first to be loaded and it will call:

* __clk_create_clk

which will do the allocation. Then when machine driver is loaded, it
will only take a reference to the allocated clock.

I might be very wrong on this. Can you clarify what does moving allocation
of the clock into codec driver implies? Machine driver only needs a reference
to codec_clk to just get the clock's rate.

Daniel.
