Return-Path: <kyle@phobos.cabal.ca>
Received: from phobos.cabal.ca (206-248-169-182.dsl.ncf.ca [206.248.169.182])
	by ozlabs.org (Postfix) with ESMTP id 5FB6EDDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 18:03:26 +1100 (EST)
Date: Tue, 19 Feb 2008 02:03:25 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Message-ID: <20080219070325.GB10115@phobos.i.cabal.ca>
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219044307.878416912@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080219044307.878416912@ldl.fc.hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2008 at 09:39:56PM -0700, Bjorn Helgaas wrote:
>     parisc: checks DEVICE_COUNT_RESOURCE (12) instead of PCI_NUM_RESOURCES
>	(11) resources at (1),
>

Good catch.

> has no IORESOURCE_{IO,MEM} check at (3),

What else can it be?

> 	has no PCI_ROM_RESOURCE check at (4), has no collision check at (5)
> 	always turns on PCI_COMMAND_SERR | PCI_COMMAND_PARITY at (6),
> 	writes cmd even if unchanged at (7)
> 

I'll have to check into 4 & 5, there might be a good reason for it. For
instance on a four port HP ethernet card (pci-pci bridge + 4 tulips) all
4 of the rom resources are mapped to the same address, which afaict, is
allowed but breaks things in mysterious and subtle ways.

That said, the parisc pci code is a rats nest...

cheers, Kyle
