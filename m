Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E86BCDDFA1
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 06:54:31 +1100 (EST)
Date: Mon, 3 Mar 2008 19:44:09 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 0/6] RFC: PCI: consolidate pcibios_enable_resources()
	implementations, v2
Message-ID: <20080303194408.GC20251@flint.arm.linux.org.uk>
References: <20080228000437.880811124@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080228000437.880811124@ldl.fc.hp.com>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 27, 2008 at 05:04:37PM -0700, Bjorn Helgaas wrote:
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
> This patch series consolidates most of them to use the x86 version.
> 
> Changes between v1 and v2:
> 
>   - Moved ARM bridge enable to new platform_pci_enable_device(),
>     called by pcibios_enable_device()

Looks fine.  However, long term I've no idea what to do about this because
I don't remember the reasoning behind it.  So to change it risks breakage
of one sort or another.

It might have been something to do with the Mobility Cardbus docking
station, which adds a pair of P2P bridges onto the PCI chain downstream
of the Cardbus controller, and then a full PCI bus containing USB, VGA,
and other peripherals.

This _once_ used to work with Linux but I suspect as a result of "fixing"
other issues its now utterly broken.

In any case, that docking station isn't ARM specific in any way; merely
a toy Alan Cox sent me.  When I gave up my PCMCIA maintainership, I gave
up trying to keep it supported by Linux.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
