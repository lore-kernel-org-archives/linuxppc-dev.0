Return-Path: <helgaas@ldl.fc.hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bastion.smtp.hp.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id E7107DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 15:52:19 +1100 (EST)
Message-Id: <20080219043952.845136014@ldl.fc.hp.com>
Date: Mon, 18 Feb 2008 21:39:52 -0700
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
To: linux-arch@vger.kernel.org
Subject: [patch 0/4] RFC: PCI: consolidate several pcibios_enable_resources()
	implementations
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

This series is for discussion only at this point.  I'm interested in
feedback about whether any of the differences are "real" and need to
be preserved.

ARM and PA-RISC, in particular, have interesting differences:
    - ARM always enables bridge devices, which no other arch does
    - PA-RISC always turns on SERR and PARITY, which no other arch does

Should other arches do the same thing, or are these somehow related to
ARM and PA-RISC architecture?

Bjorn

-- 
