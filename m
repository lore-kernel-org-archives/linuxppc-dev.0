Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24F90B7D59
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 14:19:31 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <4BD74351.9030704@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
	<4BD70292.20001@freescale.com> <1272386470.11000.84.camel@odin>
	<4BD72DB0.20808@freescale.com>
	<s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
	<4BD74351.9030704@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 14:19:19 +1000
Message-ID: <1272428359.24542.66.camel@pasglop>
Mime-Version: 1.0
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

On Tue, 2010-04-27 at 15:04 -0500, Timur Tabi wrote:
> What I need is something like a hashing function that can convert a
> "struct device_node *" into an "int".  I'm going to have two functions
> that independently parse the device tree and locate a specific node.
> Both functions will "register the node" with asoc, but they'll use an
> integer ID to uniquely identify the node.
> 
> At least, that's the way ASoC likes to operate.  AsoC takes a fixed
> string plus a unique integer.  I could technically create a unique
> string for each DMA device, and have the integer always be 0. 

That's just plain gross and horrible. You could use phandles you
know :-)

Or you could use path in your strings, or something like that.

Note that any time you have a struct device, you have a free device_node
pointer as well.

Cheers,
Ben.
