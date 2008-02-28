Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g5t0009.atlanta.hp.com (g5t0009.atlanta.hp.com [15.192.0.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 39C76DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 11:22:30 +1100 (EST)
Message-Id: <20080228000437.880811124@ldl.fc.hp.com>
Date: Wed, 27 Feb 2008 17:04:37 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 0/6] RFC: PCI: consolidate pcibios_enable_resources()
	implementations, v2
Cc: Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are many implementations of pcibios_enable_resources() that differ
in minor ways that look more like bugs than architectural differences.
This patch series consolidates most of them to use the x86 version.

Changes between v1 and v2:

  - Moved ARM bridge enable to new platform_pci_enable_device(),
    called by pcibios_enable_device()

  - Moved PA-RISC SERR & PERR enable to new platform_pci_enable_device(),
    called by pcibios_enable_device()

  - In the generic pcibios_enable_resources(), adopted powerpc resource
    collision detection (check for (!r->parent) instead of
    (!r->start && r->end))

  - In the generic pcibios_enable_resources(), added a little more detail to
    the resource collision error message

  - Moved consolidated pcibios_enable_resources() from bios.c to setup-res.c

Thanks for the comments on the first version.  I think this addresses
all of them.

Any other comments would be welcome.

Bjorn
-- 
