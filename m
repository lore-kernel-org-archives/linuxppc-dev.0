Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91292DE27A
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 07:42:26 +1100 (EST)
Subject: Re: Bamboo PCI interrupt issues
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <9eeb7e8e1acf8a9217a5121fe4ec69d8@kernel.crashing.org>
References: <1204588953.7921.13.camel@basalt>
	<20080303213718.12291eee@zod.rchland.ibm.com>
	<200803040715.22301.sr@denx.de> <1204612384.21545.50.camel@pasglop>
	<9eeb7e8e1acf8a9217a5121fe4ec69d8@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 07:41:57 +1100
Message-Id: <1204663317.21545.73.camel@pasglop>
Mime-Version: 1.0
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-04 at 21:39 +0100, Segher Boessenkool wrote:
> >> Using '8' is correct. PCI interrupts are *always* level sensitive and
> >> active
> >> low.
> >
> > Unless you use one of those strange bridges that stick not gates on the
> > PCI IRQ inputs :-) But I don't think that's the case on the 440EP.
> 
> More generally, the target interrupt descriptors (sense values, in
> particular) in a device tree interrupt map describe the interrupts as
> seen on the target interrupt controller, *not* as seen on this (source)
> interrupt domain.  This should be obvious, but since the source 
> interrupt
> descriptor for PCI doesn't have a sense value (it's always level low,
> after all), it can be confusing.  Well, interrupts always are confusing 
> :-)

Sure. But if your stupid bridge sticks a not gate between the PIRQ input
and the UIC (interrupt controller), effectively, the UIC sees a reversed
polarity. Thus you need to put in your interrupt map a reversed polarity
information for the UIC interrupt specifiers.

Ben.
