Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A18F3DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 17:31:51 +1100 (EST)
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20080219044307.878416912@ldl.fc.hp.com>
References: <20080219043952.845136014@ldl.fc.hp.com>
	<20080219044307.878416912@ldl.fc.hp.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 17:31:07 +1100
Message-Id: <1203402667.6740.94.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-arm-kernel@lists.arm.linux.org.uk,
	Russell King <rmk@arm.linux.org.uk>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-02-18 at 21:39 -0700, Bjorn Helgaas wrote:
>     powerpc: has a different collision check at (5)

I've always found the collision check dodgy. I tend to want to keep
the way powerpc does it here.

pci_enable_device() should only enable resources that have successfully
been added to the resource tree (that have passed all the collision
check etc...). There is a simple & clear indication of that: res->parent
is non-NULL. I think that is a better check than the test x86 does on
start and end.

That is, whatever the arch code decides to use to decide whether
resources are assigned by firmware or by the first pass assignment code
or not and collide or not, once that phase is finished (which is the
case when calling pcibios_enable_device(), having the resource in the
resource-tree or not is, I believe, the proper way to test whether it's
a useable resource.

Ben.
