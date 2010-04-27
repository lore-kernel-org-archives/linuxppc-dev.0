Return-Path: <lgirdwood@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217]) by ozlabs.org (Postfix) with ESMTP id 6C903B7D43
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 01:20:19 +1000 (EST)
Received: by bwz9 with SMTP id 9so12013540bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 08:20:17 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Liam Girdwood <lrg@slimlogic.co.uk>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4BD6FA39.3030400@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 16:20:11 +0100
Message-ID: <1272381611.11000.39.camel@odin>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 09:52 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 

> > Now I don't know the mechanics of adding an ASoC sound card to the
> > device tree, but the device tree should be able to define an ASoC sound
> > card and also represent the relationships between the sound card and the
> > SSI/Codec/DMA components. The components should also be represented in
> > the device tree. Parsing the device tree should probe() all the ASoC
> > components and sound card. The ASoC core would then instantiated them as
> > a sound device.  
> 
> Another problem is that ASoC won't let me probe the DMA channels
> independently.  That is, I cannot tell ASoC that I have a playback DMA
> and a capture DMA.  ASoC does not recognize two DMA devices for a
> single SSI.  If you can fix that, then I can turn the DMA driver into
> an OF driver.
> 

Iirc, the SSI and DMA controllers on your SoC mean that each DMA device
can only do one direction (either Playback or Capture). So I'm thinking
we create two DAI link entries for your sound card (one for playback and
the other for capture) and they both use the same SSI device but each
would have it's own DMA device.

This would result in two separate pcm devices being exported to
userspace i.e one for playback only and the other for capture only. I
think this is also a more accurate representation of your hardware too
(since we have different DMA devices for each pcm stream direction).

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
