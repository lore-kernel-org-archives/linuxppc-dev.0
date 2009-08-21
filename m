Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0685B7BB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:05:38 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40F4ADDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 16:05:37 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/pci: move pci_64.c device tree scanning
	code into pci-common.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090821053014.2289.59798.stgit@localhost.localdomain>
References: <20090821052714.2289.41279.stgit@localhost.localdomain>
	<20090821053014.2289.59798.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Aug 2009 16:05:29 +1000
Message-Id: <1250834729.7625.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-20 at 23:30 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> The PCI device tree scanning code in pci_64.c is some useful functionality.
> It allows PCI devices to be described in the device tree instead of being
> probed for, which in turn allows pci devices to use all of the device tree
> facilities to describe complex PCI bus architectures like GPIO and IRQ
> routing (perhaps not a common situation for desktop or server systems,
> but useful for embedded systems with on-board PCI devices).
> 
> This patch moves the device tree scanning into pci-common.c so it is
> available for 32-bit powerpc machines too.

I'd rather move it into a separate pci-of-scan.c file so we can more
easily try to move it to drivers/of or drivers/pci for use by other
archs later on.

Ben.
