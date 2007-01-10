Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 07887DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 08:29:59 +1100 (EST)
Subject: Re: Problems with devices that use PCI shared memory on 2nd PCI
	bus (6 slot powermac)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bob Brose <linuxppcdev@qbjnet.com>
In-Reply-To: <20070110150511.31047.qmail@kunk.qbjnet.com>
References: <20070110150511.31047.qmail@kunk.qbjnet.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 08:29:53 +1100
Message-Id: <1168464593.22458.352.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-10 at 15:05 +0000, Bob Brose wrote:
> Since Ben fixed the irq routing on 32 bit powermacs with changes to pci_32.c
> and prom_parse.c I've been able to use all 6 slots with interrupt
> driven devices however there appears to be a problem with devices that use
> memory mapping. (this is on a S900 w/ 21052 second PCI controller)
> 
> A couple of examples:
> When using a 21143 tulip ethernet card on the second PCI bus and with the 
> "Use PCI shared mem for NIC registers" option turned on the driver
> fails with incorrect status register reads. If I compile a kernel without
> this option it works fine.
> 
> Also, if I put a rage 128 video board in one of the slots on the
> second bus it cannot do DRM. If I turn DRM off it works ok or if I move the
> card to the first bus it works fine with DRM.

In lspci -vv, do you see the BusMaster bit enabled on the PCI-2-PCI
bridge ?

Ben.
