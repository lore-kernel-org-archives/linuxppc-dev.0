Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16FFA689FD
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 10:00:26 +1100 (EST)
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <17310.1137755798@www009.gmx.net>
References: <1137708554.12998.31.camel@localhost.localdomain>
	<17310.1137755798@www009.gmx.net>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 10:00:16 +1100
Message-Id: <1137798016.12998.49.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-01-20 at 12:16 +0100, Gerhard Pircher wrote:

> > Nope... look at drivers/pci/setup-res.c how it does for allocating new
> > resources for PCI devices.
> I guess you mean something like this code snipped from the efficeon-agp.c
> source code (with pci_assign_resource()):

Something around those lines... you will probably need to use lower
level routines, not pci_* as the AGP aperture isn't generally a BAR.

> BTW: I took a look at the PCI resources list of the AmigaOne and found out
> that the resources of the AGP graphic card are allocated to bus 0 (PCI
> only). IMHO their allocation should be assigned to bus 1 (AGP) (at least
> this is the case on x86!?), so I think this should be fixed. Is my
> assumption correct?

Hrm... sounds weird, can you send me the output of lspci -vv,
cat /proc/iomem and cat /prop/ioports ?

Ben.
