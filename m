Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98854DDE29
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 01:43:25 +1000 (EST)
Date: Tue, 7 Aug 2007 10:43:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070807154307.GA27504@ld0162-tx32.am.freescale.net>
References: <20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<46B76A5A.3030300@ru.mvista.com>
	<20070807032806.GE15619@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070807032806.GE15619@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 01:28:06PM +1000, David Gibson wrote:
> It would be possible, I guess, to define a 'swizzled-ranges' property
> or something which allows child devices to be embedded in the parent's
> address range in a not-direct way.  However, the swizzling on the
> flash bank is really a property of the flash bank, not of the parent
> bus - requiring it to be encoded in the parent is pretty yucky -
> especially if the flash bank is just part of a larger chunk of bus
> address space, defined by a single large ranges entry in the parent.

It's more a property of the connection between the bus and the flash
chips, and that connection could be described as its own "bus" node,
something like:

localbus {
	#address-cells = <1>;
	#size-cells = <1>;
	ranges;

	random-sane-device@ff000000 {
		reg = <ff000000 800000>;
		...
	};
	
	freaky-swizzle-bus@ff800000 {
		#address-cells = <1>;
		#size-cells = <1>;
		compatible = "with-enough-lsd";
		swizzle-bytes = <4>;
		swizzle-ranges = <0 ff800000 00800000 2 3 0 1>;
		
		flash@0 {
			compatible = "cfi-flash";
			reg = <0 800000>;
			bank-width = <4>;
			device-width = <2>;
		};
	};
};

Similar intermediary buses could be used for flashes with indirect
access (SPI and such).

-Scott
