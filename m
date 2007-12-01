Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9388CDDD01
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 07:39:01 +1100 (EST)
Subject: Re: [RFC] [PATCH] pasemi: NMI support with MPIC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071201182841.GA25103@lixom.net>
References: <20071201182841.GA25103@lixom.net>
Content-Type: text/plain
Date: Sun, 02 Dec 2007 07:38:45 +1100
Message-Id: <1196541525.13230.144.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-12-01 at 12:28 -0600, Olof Johansson wrote:
> Some PWRficient-based boards have a NMI button that's wired up to a GPIO
> as interrupt source. By configuring the openpic accordingly, these get
> delivered as a machine check with high priority, instead of as an external
> interrupt.
> 
> The device tree contains a property "nmi-source" in the openpic node
> for these systems, and it's the (hwirq) source for the input.
> 
> Also, for these interrupts, the IACK is read from another register than
> the regular (MCACK), but they are EOI'd as usual. So implement said
> function for the mpic driver.
> 
> Finally, move a couple of external function defines to include/ instead
> of local under sysdev. Being able to mask/unmask and eoi directly saves
> us from setting up a dummy irq handler that will never be called.

It's interesting how creative implementors are with MPICs :-)

Looks allright to me but I haven't tested for regressions.

Ben.
