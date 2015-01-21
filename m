Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75FF21A0E29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 04:37:02 +1100 (AEDT)
Received: by mail-pa0-f50.google.com with SMTP id bj1so54181981pad.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 09:36:59 -0800 (PST)
Date: Wed, 21 Jan 2015 09:36:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <b50113@freescale.com>
Subject: Re: [alsa-devel][PATCH 1/3] SoC: fsl_sai: add sai master mode support
Message-ID: <20150121173619.GA1184@Asurada>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-2-git-send-email-zidan.wang@freescale.com>
 <20150121060702.GB3275@Alpha> <20150121092529.GA27441@b50113>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150121092529.GA27441@b50113>
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

On Wed, Jan 21, 2015 at 05:25:32PM +0800, Zidan Wang wrote:
> On Tue, Jan 20, 2015 at 10:07:03PM -0800, Nicolin Chen wrote:
> > On Tue, Jan 20, 2015 at 08:21:18PM +0800, Zidan Wang wrote:

> > > +	if ((tx && sai->synchronous[TX]) || (!tx && !sai->synchronous[RX])) {
> > > +		regmap_update_bits(sai->regmap, FSL_SAI_RCR2,
> > > +			FSL_SAI_CR2_MSEL_MASK, FSL_SAI_CR2_MSEL(sai->mclk_id));

> > "tx && sai->synchronous[TX]" means the playback in synchronous
> > mode (TX following RX). What if the recording has been already
> > activated with an MSEL setting at this point? Then the playback
> > stream, as a secondary stream, will overwrite MSEL of the first
> > stream -- Record. Same would happen to the DIV configuration.
> > 
> When TX following RX(or RX following TX), TX and RX works on same bit
> clock and frame clock. They will use same MCLK source, and just need set
> the bclk DIV for RX(or TX). The secondary stream will overwrite MSEL and
> bclk DIV of the first stream, but it doesn't matter.
> 
> For RX(or TX) sync:
> fsl_sai_dai.symmetric_rates = 1;
> fsl_sai_dai.symmetric_channels = 1;
> fsl_sai_dai.symmetric_samplebits = 1;

Ah, I forgot we have protection here. It's fine then.

> When TX and RX both works on async mode, TX and RX may works on
> different bit clock and frame clock. We need set MCLK source and bclk
> DIV for TX and RX. mclk_id just save a MCLK source id, so i need to define
> mclk_id[2] for differnet stream.

Yes, you need to change this part as you just realized.

And one more thing for your coding style for multi-line comment:
/*
 * Typically use this format.
 */

Thanks
Nicolin
