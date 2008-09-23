Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54C46DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 16:55:36 +1000 (EST)
Subject: Re: mpc8541 pci1 ioport allocation address space problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Jian <lark@linux.net.cn>
In-Reply-To: <20080921011909.GA2693@debian>
References: <48D4DB89.3040607@linux.net.cn>  <20080921011909.GA2693@debian>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 16:55:23 +1000
Message-Id: <1222152923.12085.131.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-09-21 at 09:19 +0800, Wang Jian wrote:
> The following patch works fine.

And will break platforms that explicitely want IO port 0 to be on the
primary bus, though I'm not sure there's many of these left...

Ben.

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 063cdd4..4b913e0 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -582,9 +582,19 @@ void __devinit pci_process_bridge_OF_ranges(struct pci_controller *hose,
>  			hose->io_base_virt = ioremap(cpu_addr, size);
>  
>  			/* Expect trouble if pci_addr is not 0 */
> +#if 0
>  			if (primary)
>  				isa_io_base =
>  					(unsigned long)hose->io_base_virt;
> +#endif
> +#if 1
> +			if (!isa_io_base)
> +				isa_io_base =
> +					(unsigned long)hose->io_base_virt;
> +			else if ((unsigned long)hose->io_base_virt < isa_io_base)
> +				isa_io_base =
> +					(unsigned long)hose->io_base_virt;
> +#endif
>  #endif /* CONFIG_PPC32 */
>  			/* pci_io_size and io_base_phys always represent IO
>  			 * space starting at 0 so we factor in pci_addr
> --
> 
> On Sat, Sep 20, 2008 at 07:16:25PM +0800, Wang Jian wrote:
> > Hi,
> > 
> > Here I have a 8541 dev board, with 2 e1000 attached to pci0 and a
> > homebrewed addon board inserted into pci1. I am trying to make it work
> > under 2.6.26-rc8 (2.6.26 broken so I am working at rc8).
> > 
> > The ioports allocation reads
> > 
> > $ cat /proc/ioports
> > 00000000-000fffff : /pci@e0008000
> >   00001000-0000103f : 0000:00:0a.0
> >   00001040-0000107f : 0000:00:0b.0
> > ffefe000-ffffdfff : /pci@e0009000
> >   ffeff000-ffeff00f : 0001:01:0a.0
> >   ffeff010-ffeff01f : 0001:01:0b.0
> >   ffeff020-ffeff02f : 0001:01:0c.0
> >   ffeff030-ffeff03f : 0001:01:0d.0
> > 
> > The port allocation for pci1 looks ridiculous. The addon board doesn't work.
> > 
> > After poking around, I find pci_process_bridge_OF_ranges() in
> > arch/powerpc/kernel/pci-common.c
> > 
> > --snip--
> > if (primary)
> >         isa_io_base = (unsigned long)hose->io_base_virt;
> > --snip--
> > 
> > then fixup_resource(), _IO_BASE = isa_io_base. fix_resource will use
> > isa_io_base as base address to assign io port address space.
> > 
> > This is reasonable, but on my board, pci1's hose->io_base_virt is
> > smaller than pci0's. This lead to
> > 
> > [    0.064214] PCI:0000:00:0a.0 Resource 4
> > 0000000000001000-000000000000103f [20101] fixup...
> > [    0.064224] fixup_resource() offset=00000000, io_base_virt=fdeb4000,
> > _IO_BASE=fdeb4000, io_base_phys=e2000000
> > [    0.064232] PCI:0000:00:0a.0            0000000000001000-000000000000103f
> > 
> > [    0.065129] PCI:0001:01:0a.0 Resource 2
> > 0000000000001000-000000000000100f [20101] fixup...
> > [    0.065139] fixup_resource() offset=ffefe000, io_base_virt=fddb2000,
> > _IO_BASE=fdeb4000, io_base_phys=e3000000
> > [    0.065147] PCI:0001:01:0a.0            00000000ffeff000-00000000ffeff00f
> > 
> > offset = fddb2000 - fdeb4000 = ffefe000
> > 
> > So far, I think the workaround is to replace the code above with
> > 
> > --snip--
> > if (!isa_io_base)
> >         isa_io_base = (unsigned long)hose->io_base_virt;
> > else if ((unsigned long)hose->io_base_virt < isa_io_base)
> >         isa_io_base = (unsigned long)hose->io_base_virt;
> > --snip--
> > 
> > Then ioport allocation reads (But I haven't test if it works)
> > 
> > $ cat /proc/ioports
> > 00000000-000fffff : /pci@e0009000
> >   00001000-0000100f : 0001:01:0a.0
> >   00001010-0000101f : 0001:01:0b.0
> >   00001020-0000102f : 0001:01:0c.0
> >   00001030-0000103f : 0001:01:0d.0
> > 00102000-00201fff : /pci@e0008000
> >   00103000-0010303f : 0000:00:0a.0
> >   00103040-0010307f : 0000:00:0b.0
> > 
> > Can someone gives a better generic fix for this?
> > 
> > PS: I attach the kernel log (without workaround) for reference. I added
> > some printk code.
> > 
> 
> > [    0.064140] PCI: Found 0000:00:0a.0 [8086/1076] 000200 00
> > [    0.064157] pci_read_bases(): IO: (0000:00:0a.0) l=00001001,start=00001000,flag=00000000
> > [    0.064172] pci 0000:00:0a.0: calling 0xc01e9f98
> > [    0.064182] PCI:0000:00:0a.0 Resource 0 0000000080000000-000000008001ffff [20204] fixup...
> > [    0.064190] PCI:0000:00:0a.0            0000000080000000-000000008001ffff
> > [    0.064198] PCI:0000:00:0a.0 Resource 2 0000000080020000-000000008002ffff [20204] fixup...
> > [    0.064206] PCI:0000:00:0a.0            0000000080020000-000000008002ffff
> > [    0.064214] PCI:0000:00:0a.0 Resource 4 0000000000001000-000000000000103f [20101] fixup...
> > [    0.064224] fixup_resource() offset=00000000, io_base_virt=fdeb4000, _IO_BASE=fdeb4000, io_base_phys=e2000000
> > [    0.064232] PCI:0000:00:0a.0            0000000000001000-000000000000103f
> > [    0.064241] PCI:0000:00:0a.0 Resource 6 0000000000000000-000000000000ffff [27200] is unassigned
> > [    0.064268] PCI: Found 0000:00:0b.0 [8086/1076] 000200 00
> > [    0.064284] pci_read_bases(): IO: (0000:00:0b.0) l=00001041,start=00001040,flag=00000000
> > [    0.064300] pci 0000:00:0b.0: calling 0xc01e9f98
> > [    0.064309] PCI:0000:00:0b.0 Resource 0 0000000080040000-000000008005ffff [20204] fixup...
> > [    0.064316] PCI:0000:00:0b.0            0000000080040000-000000008005ffff
> > [    0.064325] PCI:0000:00:0b.0 Resource 2 0000000080060000-000000008006ffff [20204] fixup...
> > [    0.064353] PCI:0000:00:0b.0            0000000080060000-000000008006ffff
> > [    0.064362] PCI:0000:00:0b.0 Resource 4 0000000000001040-000000000000107f [20101] fixup...
> > [    0.064371] fixup_resource() offset=00000000, io_base_virt=fdeb4000, _IO_BASE=fdeb4000, io_base_phys=e2000000
> > [    0.064379] PCI:0000:00:0b.0            0000000000001040-000000000000107f
> > [    0.064388] PCI:0000:00:0b.0 Resource 6 0000000000000000-000000000000ffff [27200] is unassigned
> > [    0.064408] PCI: Fixups for bus 0000:00
> > [    0.064413] PCI: Fixup bus 0 (PHB)
> > [    0.064420] Try to map irq for 0000:00:00.0...
> > [    0.064447] Try to map irq for 0000:00:0a.0...
> > [    0.064459]  -> got one, spec 2 cells (0x00000000 0x00000001...) on /soc8541@e0000000/pic@40000
> > [    0.064478]  -> mapped to linux irq 16
> > [    0.064482] Try to map irq for 0000:00:0b.0...
> > [    0.064498]  -> got one, spec 2 cells (0x00000001 0x00000001...) on /soc8541@e0000000/pic@40000
> > [    0.064510]  -> mapped to linux irq 17
> > [    0.064517] PCI: Bus scan for 0000:00 returning with max=00
> > [    0.064973] PCI: Scanning bus 0001:01
> > [    0.064989] PCI: Found 0001:01:00.0 [1057/000c] 000b20 00
> > [    0.065011] pci 0001:01:00.0: calling fixup_hide_host_resource_fsl+0x0/0x50
> > [    0.065024] pci 0001:01:00.0: calling 0xc01e9f98
> > [    0.065055] PCI: Found 0001:01:0a.0 [104c/a106] 000000 00
> > [    0.065069] pci_read_bases(): IO: (0001:01:0a.0) l=00001001,start=00001000,flag=00000000
> > [    0.065087] pci 0001:01:0a.0: calling 0xc01e9f98
> > [    0.065097] PCI:0001:01:0a.0 Resource 0 00000000a0400000-00000000a07fffff [21208] fixup...
> > [    0.065105] PCI:0001:01:0a.0            00000000a0400000-00000000a07fffff
> > [    0.065113] PCI:0001:01:0a.0 Resource 1 00000000a0800000-00000000a0ffffff [20200] fixup...
> > [    0.065121] PCI:0001:01:0a.0            00000000a0800000-00000000a0ffffff
> > [    0.065129] PCI:0001:01:0a.0 Resource 2 0000000000001000-000000000000100f [20101] fixup...
> > [    0.065139] fixup_resource() offset=ffefe000, io_base_virt=fddb2000, _IO_BASE=fdeb4000, io_base_phys=e3000000
> > [    0.065147] PCI:0001:01:0a.0            00000000ffeff000-00000000ffeff00f
> > [    0.065169] PCI: Found 0001:01:0b.0 [104c/a106] 000000 00
> > [    0.065184] pci_read_bases(): IO: (0001:01:0b.0) l=00001011,start=00001010,flag=00000000
> > [    0.065202] pci 0001:01:0b.0: calling 0xc01e9f98
> > [    0.065211] PCI:0001:01:0b.0 Resource 0 00000000a1000000-00000000a13fffff [21208] fixup...
> > [    0.065219] PCI:0001:01:0b.0            00000000a1000000-00000000a13fffff
> > [    0.065227] PCI:0001:01:0b.0 Resource 1 00000000a1800000-00000000a1ffffff [20200] fixup...
> > [    0.065235] PCI:0001:01:0b.0            00000000a1800000-00000000a1ffffff
> > [    0.065243] PCI:0001:01:0b.0 Resource 2 0000000000001010-000000000000101f [20101] fixup...
> > [    0.065253] fixup_resource() offset=ffefe000, io_base_virt=fddb2000, _IO_BASE=fdeb4000, io_base_phys=e3000000
> > [    0.065261] PCI:0001:01:0b.0            00000000ffeff010-00000000ffeff01f
> > [    0.065284] PCI: Found 0001:01:0c.0 [104c/a106] 000000 00
> > [    0.065298] pci_read_bases(): IO: (0001:01:0c.0) l=00001021,start=00001020,flag=00000000
> > [    0.065316] pci 0001:01:0c.0: calling 0xc01e9f98
> > [    0.065325] PCI:0001:01:0c.0 Resource 0 00000000a2000000-00000000a23fffff [21208] fixup...
> > [    0.065333] PCI:0001:01:0c.0            00000000a2000000-00000000a23fffff
> > [    0.065341] PCI:0001:01:0c.0 Resource 1 00000000a2800000-00000000a2ffffff [20200] fixup...
> > [    0.065360] PCI:0001:01:0c.0            00000000a2800000-00000000a2ffffff
> > [    0.065369] PCI:0001:01:0c.0 Resource 2 0000000000001020-000000000000102f [20101] fixup...
> > [    0.065378] fixup_resource() offset=ffefe000, io_base_virt=fddb2000, _IO_BASE=fdeb4000, io_base_phys=e3000000
> > [    0.065387] PCI:0001:01:0c.0            00000000ffeff020-00000000ffeff02f
> > [    0.065413] PCI: Found 0001:01:0d.0 [104c/a106] 000000 00
> > [    0.065428] pci_read_bases(): IO: (0001:01:0d.0) l=00001031,start=00001030,flag=00000000
> > [    0.065447] pci 0001:01:0d.0: calling 0xc01e9f98
> > [    0.065456] PCI:0001:01:0d.0 Resource 0 00000000a3000000-00000000a33fffff [21208] fixup...
> > [    0.065464] PCI:0001:01:0d.0            00000000a3000000-00000000a33fffff
> > [    0.065472] PCI:0001:01:0d.0 Resource 1 00000000a3800000-00000000a3ffffff [20200] fixup...
> > [    0.065480] PCI:0001:01:0d.0            00000000a3800000-00000000a3ffffff
> > [    0.065488] PCI:0001:01:0d.0 Resource 2 0000000000001030-000000000000103f [20101] fixup...
> > [    0.065498] fixup_resource() offset=ffefe000, io_base_virt=fddb2000, _IO_BASE=fdeb4000, io_base_phys=e3000000
> > [    0.065506] PCI:0001:01:0d.0            00000000ffeff030-00000000ffeff03f
> > [    0.065527] PCI: Fixups for bus 0001:01
> 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
