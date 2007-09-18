Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 85F8CDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 22:04:55 +1000 (EST)
Message-ID: <46EFBEA6.4050406@ru.mvista.com>
Date: Tue, 18 Sep 2007 16:03:50 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64
	bit	pci_process_bridge_OF_ranges() instances
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
In-Reply-To: <20070911224952.9838.46644.stgit@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> +
> +			hose->io_base_phys = cpu_phys_addr - pci_addr;

This is not gonna work on 32-bit platform (unless pci_addr == 0).
Should be
hose->io_base_phys = cpu_phys_addr;
The other way we should adjust io size like we do on 64-bit and rewrite 
resource fixup functions.

> +			/* handle from 0 to top of I/O window */
> +#ifdef CONFIG_PPC64
> +			hose->pci_io_size = pci_addr + size;
> +#endif
> +			hose->io_base_virt = ioremap(hose->io_base_phys, size);

Do we need to ioremap on 64-bit? I think 64-bit uses different approach 
in handling io space.

> +#ifdef CONFIG_PPC32
> +			if (prim)
> +				isa_io_base = (unsigned long)hose->io_base_virt;
> +#endif

What's exactly the point of merging this single function?
If this was intended to add 64-bit physical address support to 32-bit 
platforms (like ppc440), then it does not seem sufficient to make pci 
stuff work right.
What about the 32-bit pcibios_fixup_resources(), 
pcibios_resource_to_bus(), pcibios_bus_to_resource() stuff?
There's still no 64-bit support. You'll get
"PCI Cannot allocate resource region" attempting to initialize resources 
at PCI start-up.
Thanks,
Valentine.
