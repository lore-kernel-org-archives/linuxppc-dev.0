Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKYft58wfzF0QH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 11:11:17 +1100 (AEDT)
Received: by mail-pf0-x234.google.com with SMTP id e11so7255532pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 16:11:17 -0800 (PST)
Date: Sun, 14 Jan 2018 16:11:12 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: Re: [PATCH v2 13/16] ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
Message-ID: <20180115001111.GC2925@Asurada-CZ80>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
 <1515652995-15996-14-git-send-email-nicoleotsuka@gmail.com>
 <2e285df9-834b-41bf-1a09-a8de3f2a1f7c@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2e285df9-834b-41bf-1a09-a8de3f2a1f7c@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 14, 2018 at 11:40:31PM +0100, Maciej S. Szmigiero wrote:
> >  	case SND_SOC_DAIFMT_I2S:
> > -		regmap_update_bits(regs, REG_SSI_STCCR,
> > -				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
> > -		regmap_update_bits(regs, REG_SSI_SRCCR,
> > -				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
> >  		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> >  		case SND_SOC_DAIFMT_CBM_CFS:
> >  		case SND_SOC_DAIFMT_CBS_CFS:
> > +			if (IS_ERR(ssi->baudclk)) {
> > +				dev_err(ssi->dev,
> > +					"missing baudclk for master mode\n");
> > +				return -EINVAL;
> > +			}
> 
> The original code did this check only for fsl_ssi_is_i2s_master(ssi),
> that is, only for SND_SOC_DAIFMT_CBS_CFS while here you also do it for
> SND_SOC_DAIFMT_CBM_CFS.

You are right. This patch isn't supposed to change that. I mixed an
intention from another patch. Will revise this part in the v3.

Thanks a lot
