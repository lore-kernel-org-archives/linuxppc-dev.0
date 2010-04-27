Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC5EAB7D59
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:04:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RK4Zhh002985
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 13:04:45 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RKE4jb008245
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 15:14:05 -0500 (CDT)
Message-ID: <4BD74351.9030704@freescale.com>
Date: Tue, 27 Apr 2010 15:04:33 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com>
	<1272381611.11000.39.camel@odin> <4BD70292.20001@freescale.com>
	<1272386470.11000.84.camel@odin> <4BD72DB0.20808@freescale.com>
	<s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
In-Reply-To: <s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
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

> Can you not dynamically assign an id?  If alsa soc needs a unique id
> number, then just create a lookup function. 

What I need is something like a hashing function that can convert a "struct device_node *" into an "int".  I'm going to have two functions that independently parse the device tree and locate a specific node.  Both functions will "register the node" with asoc, but they'll use an integer ID to uniquely identify the node.

At least, that's the way ASoC likes to operate.  AsoC takes a fixed string plus a unique integer.  I could technically create a unique string for each DMA device, and have the integer always be 0.

> Something like
> of_asoc_phandle_to_codec_id() that will either return a previously
> assigned id, or will assign a new id.  You shouldn't ever need to add
> data to the tree at runtime.

I know.  It just would have been nice if my nodes already had phandles in them.

-- 
Timur Tabi
Linux kernel developer at Freescale
