Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E3BEB7D51
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 14:10:41 +1000 (EST)
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration
	for ALSA SoC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
In-Reply-To: <20100427222913.GE15083@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 14:10:11 +1000
Message-ID: <1272427811.24542.59.camel@pasglop>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 23:29 +0100, Mark Brown wrote:
> 
> On the other hand from a pragmatic point of view it's just much less
> hassle to just only provide the mechanism for instantiating a machine
> with custom code and use that for everything.

Right, that's the balance to find. A too descriptive device-tree becomes
a mess, and attempting to deal with any kind of representation in SW is
horrible.

There is a fine balance to be found between how much goes into the
device-tree and how much is eventually just a plain C file that puts
things together.

For example, one could imagine a /sound node with simply a "compatible"
property that matches what we call in AOA terminology a "fabric" driver.
IE. The one thing specific to the board that puts bits and pieces
together.

Now, the device-tree is still obviously useful to provide things like
the actual i2c IDs of codecs, GPIOs used for various actions, link to
from various components to their clock source devices, etc.. All these
things simplify the code, avoids horrid board specific code in the
actual drivers (codecs, busses, etc...) and overall help keeping the
code more maintainable. 

This is not an issue specific to audio. The same problem to some extent
shows up at the arch level, which is why I was never too much in favor
of doing a "generic" platform on powerpc, but still want to have a per
board (or at least board family) platform .c file which has the upper
hand, even if it ends up mostly using device-tree based "helpers" to put
things together.

The device-tree helps keep the platform .c file simple and devoid of too
horrible hacks, it allows to easily pass various configuration data to
leaf drivers such as i2c thingies, PHY devices etc... without gross
hooks between these and the platform, but the platform code still has
the upper hand for doing ad-hoc bits and pieces (or overwriting the
device-tree based behaviour) if necessary.

Cheers,
Ben.
