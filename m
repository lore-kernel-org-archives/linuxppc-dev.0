Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC69D1A0E59
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 10:50:28 +1100 (AEDT)
Received: by mail-pd0-f179.google.com with SMTP id v10so4639267pde.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 15:50:27 -0800 (PST)
Date: Thu, 22 Jan 2015 15:50:20 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <b50113@freescale.com>
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: fsl_sai: Add support for tdm slots
 operation
Message-ID: <20150122235019.GA3204@Asurada-GSX>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
 <20150121180801.GA3361@Alpha> <20150122045515.GA3467@b50113>
 <20150122054409.GA7748@Asurada> <20150122062004.GA7046@b50113>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150122062004.GA7046@b50113>
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

On Thu, Jan 22, 2015 at 02:20:06PM +0800, Zidan Wang wrote:
> > > > > @@ -369,10 +380,25 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> > > > >  	u32 word_width = snd_pcm_format_width(params_format(params));
> > > > >  	u32 val_cr4 = 0, val_cr5 = 0;
> > > > >  	int ret;
> > > > > +	u32 bclk;
> > > > > +
> > > > > +	if (channels == 1)
> > > > > +		channels = 2;
> > > > > +
> > > > > +	if (!sai->slots || sai->slots % channels)
> > > > > +		sai->slots = channels;
> > > > > +
> > > > > +	sai->slots = sai->slots / channels;
> > > > > +
> > > > > +	if (sai->slot_width < word_width || sai->is_dsp_mode)
> > > > > +		sai->slot_width = word_width;
> > > > 
> > > > Could you pls explain a bit what's this overriding for?
> > > > Or it might be better to put into a comment.
> > > >
> > > In machine driver, we should use snd_soc_dai_set_tdm_slot to set slots
> > > and slot width. In my opinion, slots in machine driver means the slot
> > > number of all channels. But in sai driver, the slots means the slot number
> > > of one channel. So snd_soc_calc_bclk use fs*sample_size*channels*tdm_slots
> > > to caculate bclk.
> > 
> > Could you pls use the standard way as you described for slot number
> > in machine driver instead of defining some other meanings? That one
> > is really confusing, not to mention a code without any comment.
> > 
> > You can add some extra local variables with extinguished names and
> > calculate the slot number and channels you want without changing
> > the original sai->slots and channels in the hw_params(). As you said,
> > you only need that new slot number and channels for snd_soc_calc_bclk
> > call. So you may also put this code right before the call -- a normal
> > routine doesn't need to recalculate the special slots and channels,
> > right?

> Actually i don't kown which meaning is the standard way. Because i found
> in wm8993 and wm8904 codec driver, they also use slots/channels to set 
> tdm_slots in set_tdm_slot function.

The slots via machine driver should be total slot number per frame.
For I2S, we're passing 2 for slots parameter in our machine drivers.

So why not just following that pattern. You code for calculating slot
per channel is used to calculate bclk. But keeping slot per frame will
also allow you to do that, meanwhile you can drop some code to do the
extra calculation so as to keep it neat.

I suggest you to take a look at fsl_esai.c and to follow that way:
Override slots and slot_width if specified from machine driver.

And another problem of your patch is the configurations for FRSZ and
xMR fields. For monaural case, the channels == 1, the current code
passes it directly to set them while your code overrides it to 2.

I'm not sure if you've tested the monaural case and confirmed it works.
But, apparently, the configurations look pretty different.

Nicolin
