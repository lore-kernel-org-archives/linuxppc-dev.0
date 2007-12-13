Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2881BDDFF1
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 22:13:12 +1100 (EST)
Subject: Re: [PATCH 19/20] [POWERPC] pci32: 4xx embedded platforms want to
	reassign all PCI resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200712131042.48354.sr@denx.de>
References: <20071213073851.C321FDDFC9@ozlabs.org>
	<200712131042.48354.sr@denx.de>
Content-Type: text/plain
Date: Thu, 13 Dec 2007 22:12:24 +1100
Message-Id: <1197544344.15741.126.camel@pasglop>
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


On Thu, 2007-12-13 at 10:42 +0100, Stefan Roese wrote:
> On Thursday 13 December 2007, Benjamin Herrenschmidt wrote:
> > This makes 4xx embedded platforms re-assign all PCI resources as we
> > pretty much never care about what the various firmwares have done on
> > these, it's generally not compatible with the way the kernel will map
> > the bridges.
> >
> > We still need to also enable bus renumbering on some of them, but I
> > will do that from a separate patch after I've fixed 4xx PCIe to handle
> > all bus numbers.
> 
> I just applied this series on top of Paulus's for-2.6.25 branch and I
> get the following error:
> 
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c: In function 'kilauea_probe':
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: 'ppc_pci_flags' undeclared (first use in this function)
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: (Each undeclared identifier is reported only once
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: for each function it appears in.)
> /home/stefan/git/linux-2.6/paulus-powerpc/arch/powerpc/platforms/40x/kilauea.c:49: error: 'PPC_PCI_REASSIGN_ALL_RSRC' undeclared (first use in this function)
> make[3]: *** [arch/powerpc/platforms/40x/kilauea.o] Error 1

As discussed on IRC, that's just because you are missing the PCI
series of patches :-)

Cheers,
Ben.
