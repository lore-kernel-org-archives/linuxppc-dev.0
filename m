Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 248DCDDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 00:27:14 +1000 (EST)
Date: Tue, 18 Sep 2007 18:27:04 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Message-ID: <20070918182704.640c677f@localhost.localdomain>
In-Reply-To: <46EFBEA6.4050406@ru.mvista.com>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
	<46EFBEA6.4050406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Valentine,

On Tue, 18 Sep 2007 16:03:50 +0400
Valentine Barshak wrote:

> Vitaly Bordug wrote:
> > +
> > +			hose->io_base_phys = cpu_phys_addr - pci_addr;
> 
> This is not gonna work on 32-bit platform (unless pci_addr == 0).
> Should be
> hose->io_base_phys = cpu_phys_addr;
> The other way we should adjust io size like we do on 64-bit and rewrite 
> resource fixup functions.
> 
I think the second sounds like a plan then. We should not "assume" where we can make things to behave properly.

> > +			/* handle from 0 to top of I/O window */
> > +#ifdef CONFIG_PPC64
> > +			hose->pci_io_size = pci_addr + size;
> > +#endif
> > +			hose->io_base_virt = ioremap(hose->io_base_phys, size);
> 
> Do we need to ioremap on 64-bit? I think 64-bit uses different approach 
> in handling io space.
> 
Correct - 64 bit code does __get_vm_area() so the upper line is ppc32-specific.
> > +#ifdef CONFIG_PPC32
> > +			if (prim)
> > +				isa_io_base = (unsigned long)hose->io_base_virt;
> > +#endif
> 
> What's exactly the point of merging this single function?
> If this was intended to add 64-bit physical address support to 32-bit 
> platforms (like ppc440), then it does not seem sufficient to make pci 
> stuff work right.
> What about the 32-bit pcibios_fixup_resources(), 
> pcibios_resource_to_bus(), pcibios_bus_to_resource() stuff?
> There's still no 64-bit support. You'll get
> "PCI Cannot allocate resource region" attempting to initialize resources 
> at PCI start-up.
Because this function is critical to get the stuff going. You can have some devices working even without PCI resources initted
(what in fact I had with mpc8272).  I am in process of moving the mentioned to the common_... domain but I suspect there are other 32-bit-stick stuff still. So if you want to assist in cleaning this up, feel free to join the club...
-- 
Sincerely, Vitaly
