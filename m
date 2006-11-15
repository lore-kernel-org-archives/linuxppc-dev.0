Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFE8967C3E
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:40:51 +1100 (EST)
Subject: Re: [PATCH 9/16] Supporting of PCI bus for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061115184328.GD21633@lst.de>
References: <200611150945.kAF9jXRV007053@toshiba.co.jp>
	<20061115184328.GD21633@lst.de>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 10:40:43 +1100
Message-Id: <1163634043.5940.275.camel@localhost.localdomain>
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


> 
> This look broken to me.  Busses that do not support config space
> cycles shouldn't be reported to the PCI layer at all.
> 
> > +struct pci_ops celleb_fake_pci_ops = {
> > +	celleb_fake_pci_read_config,
> > +	celleb_fake_pci_write_config
> > +};
> 
> What are these fake ops for?  If you don't have a real PCI
> bus you shouldn't emulate it but use a vio-style bus insted.

That was discussed with them earlier and we decided that for now
it was ok to do it that way. They are doing like us :-) Except that on
the blade, the PCI is "emulated" for the spider by RTAS and in their
case, they do it explicitely.

With the kernel being able to build the PCI tree from the device-tree,
this isn't really a problem, and that gives them spidernet and usb for
"free" as they already know how to probe PCI devices.

Ben. 
