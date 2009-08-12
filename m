Return-Path: <broonie@sirena.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0B46B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 23:05:39 +1000 (EST)
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 81EC3DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 23:05:39 +1000 (EST)
Date: Wed, 12 Aug 2009 13:35:51 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARM clock API to PowerPC
Message-ID: <20090812123551.GC11227@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1250063825.15143.43.camel@pasglop>
Cc: John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Torez Smith <torez@us.ibm.com>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2009 at 05:57:05PM +1000, Benjamin Herrenschmidt wrote:

>  - From the above, question: Do we want to keep that parent pointer ?
> Does it make sense ? Will we have objects that are clock providers and
> themselves source from multiple parent ? Or we don't care and it becomes

That happens and at times one or more of the sources is off-chip.

> entirely the responsibility of a given struct clk instance to deal with
> its own parenthood ? Parenthood in the core has the advantage of making
> it potentially easier to represent clock nets in the device-tree.

> The core would thus be able to do a search in that list based on the
> clock-id passed in, or if clk_get(dev, NULL), then, use the first one.

What happens if another clock gets added or the list gets reordered for
some reason?

> Also, it would be nice to have a way to have "generic" clock provider
> drivers. For example, have a driver for the FooBar Clock chip, which is
> known to provide 4 fully programmable clocks. So there could be a
> generic driver for that, attached to the clock provider by the probe
> code or via the device-tree, the devices clock-map's just provide the
> clock ID within the chip (which output of the chip they are connected
> to), and so the remaining questions is what to program in each clocks.

Note that the present ARM implementations don't handle anything except
the core SoC normally.
