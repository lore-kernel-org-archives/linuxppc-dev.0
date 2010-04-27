Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98A93B7D64
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:05:39 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RK5bh0003421
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 13:05:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o3RK5f1h025373
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 15:05:41 -0500 (CDT)
Message-ID: <4BD74390.6060601@freescale.com>
Date: Tue, 27 Apr 2010 15:05:36 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for ALSA SoC
	drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<j2qfa686aa41004271221g18f04fbcla8b74861f87b8c84@mail.gmail.com>
In-Reply-To: <j2qfa686aa41004271221g18f04fbcla8b74861f87b8c84@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
>> +       /* Register the platform device for the ASoC fabric driver */
>> > +       platform_device_register_simple("snd-soc-mpc8610-hpcd", 0, NULL, 0);
>> > +
> Since this is a temporary measure, this device registration is
> probably best put into the .probe() hook of the i2s driver.  That will
> keep everything contained in the same place until we can hammer out a
> reasonable binding.

This part is not temporary, I think.  The fabric driver will always be a standard platform driver, not an OF driver, because there are no DT nodes that it can probe against.  BenH is suggestion that maybe we can create one, but I'm not sure that's really the best approach.

-- 
Timur Tabi
Linux kernel developer at Freescale
