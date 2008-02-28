Return-Path: <kyle@phobos.cabal.ca>
Received: from phobos.cabal.ca (206-248-169-182.dsl.ncf.ca [206.248.169.182])
	by ozlabs.org (Postfix) with ESMTP id A8FC6DDF39
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 04:38:18 +1100 (EST)
Date: Thu, 28 Feb 2008 12:38:16 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 5/6] PARISC: move PERR & SERR enables out of
	pcibios_enable_resources()
Message-ID: <20080228173816.GA32265@phobos.i.cabal.ca>
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.209248743@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080228001053.209248743@ldl.fc.hp.com>
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

On Wed, Feb 27, 2008 at 05:04:42PM -0700, Bjorn Helgaas wrote:
> Move PERR and SERR enables from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.
> 

I don't have any problems with this, but I think the naming needs to
change. pcibios_* namespace should probably remain arch dependent.
Renaming the unified implementation to pci_enable_resources, and adding
a weak function pcibios_enable_resources that can be overridden by
parisc and arm to enable PERR/SERR after calling the generic
pci_enable_resources function. No?

regards, Kyle
