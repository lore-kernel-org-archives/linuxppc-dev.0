Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14CDFB7D2E
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 03:27:18 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3SHREnd019462
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 10:27:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3SHai9G017494
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 12:36:44 -0500 (CDT)
Message-ID: <4BD86FF1.1090507@freescale.com>
Date: Wed, 28 Apr 2010 12:27:13 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<4BD74D0C.40303@freescale.com>
	<q2xfa686aa41004272237ld1ffc08fhebb55ff84b51d1c2@mail.gmail.com>
	<u2xed82fe3e1004280635vaeb792d2xf86996cac299ba2b@mail.gmail.com>
	<j2zfa686aa41004280657g49db18d9g563e643e16ca64e9@mail.gmail.com>
	<k2ped82fe3e1004280920xb1d8ef7ew34f86fd0ae67cf61@mail.gmail.com>
	<j2lfa686aa41004280947wbd8a90aeo3516475aa0987c78@mail.gmail.com>
In-Reply-To: <j2lfa686aa41004280947wbd8a90aeo3516475aa0987c78@mail.gmail.com>
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

> Didn't you just finish saying that you cannot see any situation where
> you would want the SSI devices linked into a single audio device?  So
> then if both SSIs are being used for audio, then do you not need a
> machine driver for each ssi?

That's right.  But in order for my fabric/machine driver to be called at all, I thought I needed to make it a platform driver and use platform_device_register_simple() and platform_driver_register().

>> Are you saying that I should call platform_device_register_simple()
>> from the SSI's driver initialization function, fsl_ssi_init()?
> 
> No, I'm saying call it from the probe hook.

But then platform_device_register_simple() will be called twice, and it should be called only once. 

I must be missing something here.

> However, you should probably do a two stage platform_device_alloc() /
> platform_device_add() so you can add data (node pointer) to the
> platform device before it gets probed by the machine driver.

Don't you mean platform_device_add_resources() instead of platform_device_add()?  That is, use platform_device_add_resources() too add information about each SSI that gets probed, and then after all of the SSIs are probed, then call platform_device_add().

If that's what you mean, then where do I call platform_device_add()?

> I'm not talking about platform_data or about the ssi driver decoding
> things that the machine driver needs.  I'm talking about giving the
> machine driver a pointer to the ssi device tree node so you don't need
> to go through weird gymnastics to find the correct node again.

The only gymnastics I need to go through is this:

while ((np = of_find_compatible_node(np, NULL, "fsl,mpc8610-ssi"))) {

This finds every SSI node.  I then extract the information from the SSI nodes and all the other nodes, and then register it with ASoC. 

-- 
Timur Tabi
Linux kernel developer at Freescale
