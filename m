Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C241DDED1
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 07:31:52 +1000 (EST)
Subject: Re: [PATCH] fix pci_setup_phb_io_dynamic for pci_iomap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705032142.39031.arnd@arndb.de>
References: <200705032142.39031.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 04 May 2007 07:31:43 +1000
Message-Id: <1178227903.6353.53.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 21:42 +0200, Arnd Bergmann wrote:
> We had a problem on a system with only dynamically allocated
> PCI buses (using of_pci_phb_driver) in combination with libata.
> 
> It turns out that pci_setup_phb_io_dynamic does a simple ioremap
> instead of an __ioremap_explicit into the reserved I/O space
> region, which causes pcim_iomap->pci_iomap->ioport_map to fail
> a sanity check for the virtual address of the I/O port.
> 
> Also, our setup ended up having no "primary" phb, which means
> that pci_io_base never got initialized. This caused the same
> bug independently.
> 
> This patch fixes both problems.

Hrm... dynamically added PHBs shouldn't use the reserved region.

We need to fix ioport_map instead I think. I'll have a look.

Ben.
