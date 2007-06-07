Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D146ADDF1B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:53:15 +1000 (EST)
In-Reply-To: <FE5191F7-8A1D-428A-B4F0-32AD3A08B08A@freescale.com>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es>
	<02DC2E36-86B1-4458-BB0C-13CF79AC1D11@freescale.com>
	<466492DC.6050708@mvista.com>
	<1181113764.31677.242.camel@localhost.localdomain>
	<FE5191F7-8A1D-428A-B4F0-32AD3A08B08A@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bfe9e3f1cb3bbbe8f061173da27eef90@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Thu, 7 Jun 2007 18:53:09 +0200
To: Andy Fleming <afleming@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The bus number shouldn't matter as long as low IO cycles are properly
>> forwarded to it.
>
> Right.  Unless there's an interrupt mapping, which has to include the
> bus number in the filter.

No it doesn't; the PCI device # of the thing that gets
its interrupt mapped is enough.  PCI bus # is not a
hardware property (except for bus #0) so it isn't a
structural thing in the device tree at all.

> When that happens, parsing the interrupt
> map for the i8259's mapping fails because its address doesn't match.

That's because you're trying to map interrupts from
two separate interrupt domains in your interrupt-map:
the PCI bus of that node, and some child PCI bus
somewhere deeper down.  This isn't designed to work,
and hey, it doesn't ;-)


Segher
