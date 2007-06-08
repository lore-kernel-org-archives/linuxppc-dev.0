Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9704FDDEF0
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 18:30:02 +1000 (EST)
In-Reply-To: <1181254330.14818.71.camel@localhost.localdomain>
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
	<1181254330.14818.71.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <71535aedbbc915db81f6c7486db3257f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Fri, 8 Jun 2007 10:29:51 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Right.  Unless there's an interrupt mapping, which has to include
>> the
>> bus number in the filter.  When that happens, parsing the interrupt
>> map for the i8259's mapping fails because its address doesn't match.
>
> Hrm... does the interrupt-map include the bus number for you ? They
> generally don't ...

Any interrupt mapping should serve one interrupt domain
only.  For a PCI bus, that bus is that domain, so all
bus#s in the interrupt-map should be identical.

Now you can cheat and have one interrupt-map handle
mappings for several PCI busses (in the same PCI domain).
Whenever this works at all, it is not by design, and
results in a huge mess and various (little) problems.

Just don't :-)


Segher
