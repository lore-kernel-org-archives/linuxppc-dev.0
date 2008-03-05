Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98B42DDF98
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 03:32:09 +1100 (EST)
Message-ID: <47CECB21.3060704@freescale.com>
Date: Wed, 05 Mar 2008 10:32:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
References: <20080303144727.GA27949@ingate.macqel>	
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>	
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>	
	<20080303212622.GB20382@netgate.macqel>
	<47CC73CE.4080801@freescale.com>	
	<20080304080828.GA18829@netgate.macqel>
	<1204618939.21545.52.camel@pasglop>	
	<20080304091059.GD18829@netgate.macqel>
	<1204693264.21545.165.camel@pasglop>
In-Reply-To: <1204693264.21545.165.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Philippe De Muyter <phdm@macqel.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> So at this stage, that's not enough information. We need to know exactly how
> you have wired things on your board, and somebody from fsl needs to tell
> me how the ExtIrq are routed to the MPIC on that guy.

This part's easy -- the external IRQ is used as the mpic interrupt 
number as-is (internal IRQs start at 16).

> Once that's done, you seem to have grasped the interrupt map... for any
> device or slot, you provide the mapping between idsel/pirq line on one side,
> and mpic interrupt & sense on the other. For PCI, sense is always 1 for an
> mpic so you mostly have to check your actual MPIC source numbers.
> 
>>From your .dts, I see you've been doing some swizzling of slots using
> interrupts 1...4 ... do that correspond to EXTIRQ 5....8 ?

No, those correspond to the EXT1-4 that are the other side of the #ifdef 
for this board in arch/ppc. :-)

-Scott
