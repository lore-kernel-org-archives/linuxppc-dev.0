Return-Path: <B50113@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0128.outbound.protection.outlook.com [207.46.100.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1027C1A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 17:19:14 +1100 (AEDT)
Date: Thu, 22 Jan 2015 14:20:06 +0800
From: Zidan Wang <b50113@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: fsl_sai: Add support for tdm slots
 operation
Message-ID: <20150122062004.GA7046@b50113>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
 <20150121180801.GA3361@Alpha> <20150122045515.GA3467@b50113>
 <20150122054409.GA7748@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150122054409.GA7748@Asurada>
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

On Wed, Jan 21, 2015 at 09:44:10PM -0800, Nicolin Chen wrote:
> On Thu, Jan 22, 2015 at 12:55:35PM +0800, Zidan Wang wrote:
> > On Wed, Jan 21, 2015 at 10:08:03AM -0800, Nicolin Chen wrote:
> > > On Tue, Jan 20, 2015 at 08:21:19PM +0800, Zidan Wang wrote:
> > > > @@ -369,10 +380,25 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
> > > >  	u32 word_width = snd_pcm_format_width(params_format(params));
> > > >  	u32 val_cr4 = 0, val_cr5 = 0;
> > > >  	int ret;
> > > > +	u32 bclk;
> > > > +
> > > > +	if (channels == 1)
> > > > +		channels = 2;
> > > > +
> > > > +	if (!sai->slots || sai->slots % channels)
> > > > +		sai->slots = channels;
> > > > +
> > > > +	sai->slots = sai->slots / channels;
> > > > +
> > > > +	if (sai->slot_width < word_width || sai->is_dsp_mode)
> > > > +		sai->slot_width = word_width;
> > > 
> > > Could you pls explain a bit what's this overriding for?
> > > Or it might be better to put into a comment.
> > >
> > In machine driver, we should use snd_soc_dai_set_tdm_slot to set slots
> > and slot width. In my opinion, slots in machine driver means the slot
> > number of all channels. But in sai driver, the slots means the slot number
> > of one channel. So snd_soc_calc_bclk use fs*sample_size*channels*tdm_slots
> > to caculate bclk.
> 
> Could you pls use the standard way as you described for slot number
> in machine driver instead of defining some other meanings? That one
> is really confusing, not to mention a code without any comment.
> 
> You can add some extra local variables with extinguished names and
> calculate the slot number and channels you want without changing
> the original sai->slots and channels in the hw_params(). As you said,
> you only need that new slot number and channels for snd_soc_calc_bclk
> call. So you may also put this code right before the call -- a normal
> routine doesn't need to recalculate the special slots and channels,
> right?
> 
> Nicolin

Actually i don't kown which meaning is the standard way. Because i found
in wm8993 and wm8904 codec driver, they also use slots/channels to set 
tdm_slots in set_tdm_slot function.


Best Regards,
Zidan
