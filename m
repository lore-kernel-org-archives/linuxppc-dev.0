Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsJ0Q72qrzDqrL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 07:32:06 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id e69so4903691pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 14:32:06 -0700 (PDT)
Date: Tue, 12 Sep 2017 14:32:34 -0700
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
Message-ID: <20170912213233.GA11419@Asurada-Nvidia>
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 12, 2017 at 04:35:13PM +0200, Arnaud Mouiche wrote:

> >- * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
> >- * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
> >+ * freq: Output BCLK frequency = samplerate * 32 (fixed) * slots (or channels)
> 
> Slots are not necessarily 32 bits width.
> Indeed, a simple grep of snd_soc_dai_set_tdm_slot shows 16, 24, 32
> and 0 bits usage. (don't know the real meaning of 0 BTW...)
> So, it should be good to also remember the slots width given in
> snd_soc_dai_set_tdm_slot() call.

RM says that the word length is fixed to 32 in I2S Master mode.
So I used it here. But I think using it with the slots could be
wrong here as you stated. What kind of clock rates (bit and lr)
does a TDM case have?

The problem of slot width here is handled in the set_tdm_slot()
at all. So I tried to ignored that. But we probably do need it
when calculating things with the slot number.

Could you please give me a few set of examples of how you set
set_sysclk(), set_tdm_slot() with the current driver? The idea
here is to figure out a way to calculate the bclk in hw_params
without getting set_sysclk() involved any more.

> Anyway, there is something wrong in the snd_soc_codec_set_sysclk
> usage by fsl_ssi
> Let's get a look again at the description:
> 
>    /**
>      * snd_soc_dai_set_sysclk - configure DAI system or master clock.
>      * @dai: DAI
>      * @clk_id: DAI specific clock ID
>      * @freq: new clock frequency in Hz
>      * @dir: new clock direction - input/output.
>      *
>      * Configures the DAI master (MCLK) or system (SYSCLK) clocking.
>      */
>    int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>         unsigned int freq, int dir)
> 
> So, it can be used to configure 2 different clocks (and more) with
> different usages.
> 
> Lukasz complains that simple-card is configuring MCLK incorrectly.
> but simple-card, only want to configure the SYSCLK, whereas fsl_ssi
> understand "configure the MCLK..." (fsl_ssi doesn't check the clk_id
> at all)

It's more than a clock_id in my opinion. The driver now sets
the bit clock rate via set_sysclk() other than the MCLK rate
actually.

> I think the problem is here.
> I would propose a new clk_id
> 
>     #define FSL_SSI_SYSCLK_MCLK 1
> 
> And leave fsl_ssi_set_dai_sysclk(xxx, FSL_SSI_SYSCLK_MCLK, ...)
> override the computed mlck.
> This will leave a way for obscure TDM users to specify a specific a
> random mclk frequency for obscure reasons...
> Unfortunately, such generic clock_id (sysclk, mclk) were never
> defined widely.

Unfortunately, it looks like a work around to me. I understand
the idea of leaving set_sysclk() out there to override the bit
clock is convenient, but it is not a standard ALSA design and
may eventually introduce new problems like today.

> Is it really needed ? It is true that, up to now, we are using
> fsl_ssi_set_dai_sysclk() in addition to snd_soc_dai_set_tdm_slot()
> only because this was the only way to deal with correct mclk
> setting. And if now, snd_soc_dai_set_tdm_slot() do its job
> correctly, fsl_ssi_set_dai_sysclk() will become useless (except for
> obscure TDM users of course)

The idea here is to drop the set_sysclk() for all user cases
including TDM cases. So we need a solid patch to calculate the
bit clock rate in hw_params() for TDM user cases..
