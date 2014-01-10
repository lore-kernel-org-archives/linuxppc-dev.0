Return-Path: <guangyu.chen@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EBC5F2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 03:04:58 +1100 (EST)
Date: Fri, 10 Jan 2014 23:48:25 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Add ESAI CPU DAI driver
Message-ID: <20140110154824.GA17609@MrMyself>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109184453.GP12858@sirena.org.uk>
 <20140110023252.GA16467@MrMyself> <20140110023537.GB16467@MrMyself>
 <20140110120439.GG29039@sirena.org.uk>
 <20140110130338.GA17392@MrMyself>
 <20140110132642.GM29039@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140110132642.GM29039@sirena.org.uk>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, shawn.guo@linaro.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, timur@tabi.org, lgirdwood@gmail.com,
 robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org,
 grant.likely@linaro.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 10, 2014 at 01:26:42PM +0000, Mark Brown wrote:
> On Fri, Jan 10, 2014 at 09:03:39PM +0800, Nicolin Chen wrote:
> > On Fri, Jan 10, 2014 at 12:04:39PM +0000, Mark Brown wrote:
> 
> > > This is about what I'd expect but then surely the next step is for the
> > > driver to choose a defualt BCLK ratio - that's how most drivers work,
> > > they try to generate the exact rate that is needed to clock the data.
> 
> > Does that mean I should call set_bclk() once in the startup() when !active
> > to set a default bit clock rate to suit a common sample rate like 44100Hz?
> > I'm a bit confused if so. Because the driver would call set_bclk() any way
> > in the hw_params().
> 
> Right, any choice here needs to be deferred to hw_params() as you say.
> 
> > But your suggestion just reminds me of the slave mode in SSI driver as
> > default mode. And I should patch ESAI to slave mode for default as well,
> > shouldn't I?
> 
> master/slave selection is kind of orthogonal here - the two bits of
> information that are normally needed are the MCLK to use (and its rate)
> and the sample rate/format (which give you the BCLK that is needed).
> Normally it's then possible to caculate a divider which generates BCLK
> from MCLK.  Overriding is normally only needed if there are additional
> constraints on BCLK due to something like limitations in one of the
> devices or sample rates for the opposite direction if the BCLK is shared
> but LRCLK isn't.

I think I start to understand the point here: If a user only needs to playback
the default case - 44.1KHz for example, the driver can just configure all the
dividers once at the beginning, not every time, so that we can save further
register overriding operation or even complicated clock selection and divisor
calculation, which obviously makes the procedure clean and reduces the system
loading even if it might be just in a slight level.

Is this the reason, or maybe one of the reasons, to the defaults providing?

Thank you,
Nicolin Chen
