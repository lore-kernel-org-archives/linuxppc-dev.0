Return-Path: <guangyu.chen@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 26B142C0096
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 04:07:02 +1100 (EST)
Date: Sat, 11 Jan 2014 00:45:44 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Add ESAI CPU DAI driver
Message-ID: <20140110164543.GB17609@MrMyself>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109184453.GP12858@sirena.org.uk>
 <20140110023252.GA16467@MrMyself> <20140110023537.GB16467@MrMyself>
 <20140110120439.GG29039@sirena.org.uk>
 <20140110130338.GA17392@MrMyself>
 <20140110132642.GM29039@sirena.org.uk>
 <20140110154824.GA17609@MrMyself>
 <20140110165229.GP29039@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140110165229.GP29039@sirena.org.uk>
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

On Fri, Jan 10, 2014 at 04:52:29PM +0000, Mark Brown wrote:
> On Fri, Jan 10, 2014 at 11:48:25PM +0800, Nicolin Chen wrote:
> 
> > I think I start to understand the point here: If a user only needs to playback
> > the default case - 44.1KHz for example, the driver can just configure all the
> > dividers once at the beginning, not every time, so that we can save further
> > register overriding operation or even complicated clock selection and divisor
> > calculation, which obviously makes the procedure clean and reduces the system
> > loading even if it might be just in a slight level.
> 
> > Is this the reason, or maybe one of the reasons, to the defaults providing?
> 
> The main thing is that if the DAI driver does it then it's less code in
> the machine drivers using it - what tends to happen otherwise is that
> quite a few machine drivers end up replicating the same logic.  Hardware
> designers tend to do a lot of cut'n'paste with these things so even if
> the CODEC is different the clocking is often very similar.

Point taken. And it also depends on how common the defaults would be.
I think I should try to figure out a comparably generic template for
the clock selection and its rate settings here and also check other
redundant places.

I learned another lesson today. Thank you indeed.
Nicolin
