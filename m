Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 407BDB7D7F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 01:28:23 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RFSKMP025742
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 08:28:20 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3RFcPM9006934
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 10:38:26 -0500 (CDT)
Message-ID: <4BD70292.20001@freescale.com>
Date: Tue, 27 Apr 2010 10:28:18 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>	
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>	
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
In-Reply-To: <1272381611.11000.39.camel@odin>
Content-Type: text/plain; charset=ISO-8859-1
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

Liam Girdwood wrote:

> Iirc, the SSI and DMA controllers on your SoC mean that each DMA device
> can only do one direction (either Playback or Capture). So I'm thinking
> we create two DAI link entries for your sound card (one for playback and
> the other for capture) and they both use the same SSI device but each
> would have it's own DMA device.

Do you mean here:

	machine_data->card.probe = mpc8610_hpcd_machine_probe;
	machine_data->card.remove = mpc8610_hpcd_machine_remove;
	machine_data->card.name = "MPC8610 HPCD";
	machine_data->card.num_links = 1;
	machine_data->card.dai_link = &machine_data->dai;

So that num_links would be 2 instead of 1?

I would need some way for fsl_dma_open() to get a pointer to private, DMA-specific data.  I'm not sure how I can do that.

> This would result in two separate pcm devices being exported to
> userspace i.e one for playback only and the other for capture only. I
> think this is also a more accurate representation of your hardware too
> (since we have different DMA devices for each pcm stream direction).

I can say for certain whether that will actually work.  My gut tells me that I might run into problems trying to implement that.  The only way to know for sure is to start hacking.  Unfortunately, my window of opportunity to work on this just closed, and it may not open for a while.  I know my current patch is less-than-ideal, but it does restore functionality to the 8610, and without needing any U-Boot or device-tree changes.  So unless there are any real objections, I'd like it to be merged.  Otherwise, 8610 audio will be broken in the next release.

-- 
Timur Tabi
Linux kernel developer at Freescale
