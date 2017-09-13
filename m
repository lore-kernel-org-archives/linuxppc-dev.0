Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsxwt5W8QzDrCn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 09:01:18 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m30so738332pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:01:18 -0700 (PDT)
Date: Wed, 13 Sep 2017 16:01:48 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com,
 fabio.estevam@nxp.com, timur@tabi.org, lukma@denx.de,
 caleb@crome.org, max.krummenacher@toradex.com, mpa@pengutronix.de,
 mail@maciej.szmigiero.name
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
Message-ID: <20170913230147.GA21287@Asurada-Nvidia>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
 <20170912213233.GA11419@Asurada-Nvidia>
 <fdb71350-0b89-8c5a-9ed0-c744bb6f2118@invoxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fdb71350-0b89-8c5a-9ed0-c744bb6f2118@invoxia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 13, 2017 at 10:02:20AM +0200, Arnaud Mouiche wrote:

> >Could you please give me a few set of examples of how you set
> >set_sysclk(), set_tdm_slot() with the current driver? The idea
> >here is to figure out a way to calculate the bclk in hw_params
> >without getting set_sysclk() involved any more.

> Here is one, where a bclk = 4*16*fs is expected

> In another setup, there are 8 x 16 bits slots, whatever the number
> of active channels is.
> In this case bclk = 128 * fs
> The number of slots is completely arbitrary. Some slots can even be
> reserved for communication between codecs that don't communicate
> with linux.

In summary, bclk = sample rate * slots * slot_width;

I will update my patch soon.

> >Unfortunately, it looks like a work around to me. I understand
> >the idea of leaving set_sysclk() out there to override the bit
> >clock is convenient, but it is not a standard ALSA design and
> >may eventually introduce new problems like today.
> 
> I agree. I'm not conservative at all concerning this question.
> I don't see a way to remove set_sysclk without breaking current TDM
> users anyway, at least for those who don't have their code
> upstreamed.

Which TDM case would be broken by this removal? The only impact
that I can see is that the ASoC core returns an ENOTSUPP for a
set_sysclk() call now, which is something that a dai-link driver
should have taken care of anyway.

> All information provided through snd_soc_dai_set_tdm_slot( cpu_dai,
> mask, mask, slots, width ) should be enough
> In this case, for TDM users
> 
>    bclk = slots * width * fs   (where slots is != channels)

> will manage 99 % of the cases.
> And the remaining 1% will concern people who need to hack the kernel
> so widely they don't care about the set_sysclk removal.

A patch from those people will be always welcome.

> - fsl-asoc-card.c : *something will break since
> snd_soc_dai_set_sysclk returned code is checked*

I've already submitted a patch to ignore all ENOTSUPP.
