Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81A95B7D63
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 00:52:55 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3REqgcZ010622
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 07:52:42 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RF14dA012591
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 10:01:04 -0500 (CDT)
Message-ID: <4BD6FA39.3030400@freescale.com>
Date: Tue, 27 Apr 2010 09:52:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>	
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
In-Reply-To: <1272355624.3204.52.camel@odin>
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

> I think one of the difficulties encountered here is that the device tree
> root for sound in this case is the SSI (Digital Audio Interface)
> controller and not the sound card as in ASoC. So maybe the problem is
> how do we represent an ASoC sound card in the device tree ?

Yes, that is a topic of concern.

If you look at the 8610 DTS, you'll see that the SSI (i2s) is effectively the master.  In reality, I just modeled the board in the DTS.  The SSI node, for example, lists the two DMA channels it needs.  It also points to the codec that it's connected to.  And the clock-frequency property is in the codec node because the oscillator is connected to the codec on the board.

In theory, would could probably get rid of the DMA node pointers if I can update the standard DMA driver to allow me to reserve two DMA channels.  That's not an easy fix, though.

> The sound card within ASoC is a compound device that is made up of the
> SSI, Codec and audio DMA engine components. The SSI/Codec/DMA components
> do not have to be the sound cards child devices wrt the driver model but
> do register with the ASoC core and are 'joined' with each other and the
> sound card driver to form a working audio device.

Yes, today I just walk the device tree looking for these connections implicitly. The code may be ugly, but the device tree is more streamlined.

> Now I don't know the mechanics of adding an ASoC sound card to the
> device tree, but the device tree should be able to define an ASoC sound
> card and also represent the relationships between the sound card and the
> SSI/Codec/DMA components. The components should also be represented in
> the device tree. Parsing the device tree should probe() all the ASoC
> components and sound card. The ASoC core would then instantiated them as
> a sound device.  

Another problem is that ASoC won't let me probe the DMA channels independently.  That is, I cannot tell ASoC that I have a playback DMA and a capture DMA.  ASoC does not recognize two DMA devices for a single SSI.  If you can fix that, then I can turn the DMA driver into an OF driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
