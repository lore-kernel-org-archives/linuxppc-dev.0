Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4212DDEFA
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 10:47:28 +1100 (EST)
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <47CECB21.3060704@freescale.com>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop> <47CECB21.3060704@freescale.com>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 10:46:51 +1100
Message-Id: <1204760811.21545.231.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Philippe De Muyter <phdm@macqel.be>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >>From your .dts, I see you've been doing some swizzling of slots using
> > interrupts 1...4 ... do that correspond to EXTIRQ 5....8 ?
> 
> No, those correspond to the EXT1-4 that are the other side of the #ifdef 
> for this board in arch/ppc. :-)

Yes, that's what I was thinking. So that's what he got wrong in
his .dts.

Philippe, you need to fix those numbers so they map your EXTIRQ.

(that is 1 -> 5, 2 -> 6, etc... )

And of course you need to make sure you have the right routing to the
chip. it's funny the way you keep providing all sort of info but -never-
the one we actually asked for :-)

We basically, to help you, need to know for each PCI device connected to
the SoC, or PCI slot if you have such, which address line is used for
IDSEL, and to which MPIC interrupt inputs.

Once you have given us that, we'll be able to help.

It appears that just looking at the arch/ppc code is a bit too messy and
confusing (and not necessarily right).

In addition, you will also need to do proper interrupt routing for you
other devices (RTC, etc...) but we can look at that separately.

Ben.
