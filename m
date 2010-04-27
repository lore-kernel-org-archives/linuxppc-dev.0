Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2878CB7D1D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:46:06 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RKk4Uu016667
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 13:46:04 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o3RKk9qn008585
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 15:46:09 -0500 (CDT)
Message-ID: <4BD74D0C.40303@freescale.com>
Date: Tue, 27 Apr 2010 15:46:04 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
In-Reply-To: <g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:

> So, the current 86xx device tree binding assumes a simple layout with
> a node describing an DAI controller, and another node describing the
> codec with a single phandle (pointer) from the DAI to the codec.  In
> this configuration, it is completely reasonable for the DAI node to
> trigger both the instantiation of the ASoC DAI controller device and
> the sound card device.  Linux can treat them as separate even though
> the current device tree has a simplistic representation.

The only problem with this is that there is board-specific programming that needs to be done (look at mpc8610_hpcd_machine_probe), so we still need to have a fabric driver that is independent of the SSI, codec, or DMA drivers.  The P1022 also has an SSI, and I'm hoping that all I need to do is create a new fabric driver, not hack up the SSI driver to support board programming. 

So if the fabric driver still needs to exist, then it still needs a struct device, and it still needs to register with asoc.  I don't see how I can register the sound card itself in the SSI driver, because it won't know anything about the board-specific code in the fabric driver.

> I've tried very hard to maintain a distinction between device tree
> binding (representation) and Linux kernel internal implementation
> details.  The real question is whether or not the binding provides
> sufficient detail for the operating system to figure out what to do.

I think it does, because it's working today.

> In the extreme minimalist case, the audio driver could decide how to
> configure itself solely on the board name property of the root node.
> There is nothing wrong with that, but it also means that no data is
> available to dynamically select common modules or modify connections;
> it all has to be hard coded.

Well, asoc already has several hard-coded requirements:

	machine_data->dai.cpu_dai_drv = &fsl_ssi_dai;
	machine_data->dai.codec_dai_drv = &cs4270_dai;
	machine_data->dai.codec_drv = &soc_codec_device_cs4270;
	machine_data->dai.ops = &mpc8610_hpcd_ops;
	machine_data->dai.platform_drv = &fsl_soc_platform;

So even though I probe for each device separately and register them separately, the fabric driver still needs to have hard-coded addresses 

Maybe the asoc guys can tell me why I need to register the cpu_dai_drv structure via platform_device_add(), when it's already being registered via snd_soc_register_dai().

> (I've omitted the DMA nodes and some irrelevant details)  This is
> enough information for a simplistic driver registration that probably
> makes a lot of assumptions.  Such as the ssi represents a single
> logical sound device.  It won't handle complex representations, but in
> a lot of cases that may be just fine.

Why would I ever represent the SSI as anything but a single logical sound device?  Let ALSA handle synchronizing multiple streams together if it wants to.

> 	sound {
> 		compatible = "fsl,mpc8610-hpcd-sound";
> 		/* maybe something like (totally off the top of my head) */
> 		dai-links = <&ssi1 0 &codec 0
> 		             &ssi1 1 &codec 1>;
> 		[...]
> 	};

I don't know when I would ever do this.  The two SSI devices are completely independent.  Why would I bind them together into one "device"?

> Where the 'sound' node is now the starting point for representing a
> logical sound device instead of the ssi node.  This binding probably
> makes more sense (but I'm not committing to anything like this until I
> see a real proposal for a real device).

The only issue I have with this is all it does is turn the fabric driver from a platform driver that scans the OF tree, into an OF driver that still needs to query the device tree to get all the data it needs.  For example, the fabric driver still needs to know the clock frequency and direction of the codec node, so that it can call snd_soc_dai_set_fmt() and snd_soc_dai_set_sysclk() properly.  To eliminate that, we could have the fabric driver never call these functions, and expect the SSI and codec drivers to gather this information itself.  But the codec driver is not an OF driver, so it has no expectation of being able to query the codec node.

> I would solve the problem this way: In the ssi driver, if the
> codec-node property is present, then call a function to instantiate a
> simple or platform specific sound card instance that makes the
> assumptions listed above.  If not, then just register the ssi and
> exit, which leaves the ssi available for a separate driver to pick it
> up.  I wouldn't do this for new platforms, but it gracefully makes use
> of the data provided in the current 8610 device tree.

Eh, I'll have to think about that.  The absence of a codec pointer in the SSI node means that the SSI is not connected to a codec, so it should just be ignored altogether.  An SSI is useless if it's not connected to a codec.

> BTW Timur, there is nothing wrong with registering multiple devices
> that all have the of_node pointer set to the same node.

Sorry, I don't understand what you're getting at.

-- 
Timur Tabi
Linux kernel developer at Freescale
