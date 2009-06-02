Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 922D1DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 13:02:20 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix annotation of pcibios_claim_one_bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1243908409.6119.2.camel@concordia>
References: <20090602105353.b4a7e93d.sfr@canb.auug.org.au>
	<1243908409.6119.2.camel@concordia>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 13:02:00 +1000
Message-Id: <1243911720.5308.0.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-06-02 at 12:06 +1000, Michael Ellerman wrote:
> On Tue, 2009-06-02 at 10:53 +1000, Stephen Rothwell wrote:
> > It was __devinit, but it is also within a CONFIG_HOTPLUG guarded section
> > of code, so the __devinit does nothing but cause the following warning:
> > 
> > WARNING: vmlinux.o(.text+0x107a8): Section mismatch in reference from the function pcibios_finish_adding_to_bus() to the function .devinit.text:pcibios_claim_one_bus()
> 
> Isn't the real problem that the PCI hotplug code is not marked as
> __devinit?

I'll take Stephen patch for now. We can do a proper sweep through PCI
hotplug after Kumar is done finishing the 32/64-bit PCI merge...

Cheers,
Ben.
