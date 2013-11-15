Return-Path: <guangyu.chen@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 179742C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2013 02:27:00 +1100 (EST)
Date: Fri, 15 Nov 2013 23:17:40 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ASoC: fsl_ssi: Add monaural audio support for
 non-ac97 interface
Message-ID: <20131115151739.GA2226@MrMyself>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <1384427230-979-3-git-send-email-b42378@freescale.com>
 <20131115122107.GK16735@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20131115122107.GK16735@n2100.arm.linux.org.uk>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 lgirdwood@gmail.com, swarren@wwwdotorg.org, timur@tabi.org,
 rob.herring@calxeda.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 12:21:08PM +0000, Russell King - ARM Linux wrote:
> > @@ -517,10 +517,12 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
> >  {
> >  	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> >  	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> > +	unsigned int channels = params_channels(hw_params);
> >  	unsigned int sample_size =
> >  		snd_pcm_format_width(params_format(hw_params));
> >  	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
> >  	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
> > +	static u8 i2s_mode;
> 
> Throwing a static variable into the middle of a driver with none is a
> really horrid thing to do and is very bad programming practice.  What
> if some freescale device decides to have to of these interfaces?  Both
> will try to use this same static variable.
> 
> This is extremely bad programming practice.

Sir, I'm glad you're teaching me this lesson. I did hesitate before I
sent this patch, just couldn't tell the reason. And swear to god, I
hadn't used and will never use this practice again.
 

> > +	/* Save i2s mode configuration so that we can restore it later */
> > +	switch (read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK) {
> > +	case CCSR_SSI_SCR_I2S_MODE_SLAVE:
> > +	case CCSR_SSI_SCR_I2S_MODE_MASTER:
> > +		i2s_mode = read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK;
> > +	default:
> > +		break;
> > +	}
> 
> So all you're doing is saving the mode only if it specifies master or
> slave mode, but not if it's normal mode (== 0).  This just looks like
> it's complicated just for the sake of being complicated.
> 
> Since we know what mode this is in when we run fsl_ssi_setup(), can we
> not save that value into the fsl_ssi_private structure and re-use it
> here?

Currently we only have fsl_ssi_setup() to set I2S mode. It's definitely
a good idea to save it into private structure at that point. But there
will be new ASoC function -- set_dai_fmt() appending to this driver.
It will provide ASoC machine driver an interface to set I2S mode again,
and we must put a saving code as well at that time. So I think put the
saving code here would keep the modification within a small range. But
I here might be so obsessed with trying to make the patch as neat as
possible that I picked a demon sword.

But I'm still willing to learn the lesson. And I'll refine this patch.

Much obliged,
Nicolin Chen
