Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id D1675DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 22:20:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/7] Celleb: update for PCI
Date: Wed, 26 Sep 2007 14:09:31 +0200
References: <20070926.134050.1102532600.kouish@swc.toshiba.co.jp>
In-Reply-To: <20070926.134050.1102532600.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261409.32231.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 September 2007, Ishizaki Kou wrote:
> This is a patch kit to support PCI bus on Celleb with new "I/O routines
> for PowerPC." External PCI on Celleb must do explicit synchronization
> with devices (Bus has no automatic synchronization feature).

It seems you are duplicating a lot of
arch/powerpc/platforms/cell/io-workarounds.c, in order to work around
the same problem:

> +static struct celleb_pci_bus *celleb_pci_find(unsigned long vaddr,
> +					      unsigned long paddr)
> +{
> +	int i, j;
> +	struct resource *res;
> +
> +	for (i = 0; i < celleb_pci_count; i++) {
> +		struct celleb_pci_bus *bus = &celleb_pci_busses[i];
> +		struct pci_controller *phb = bus->phb;
> +		if (paddr)
> +			for (j = 0; j < 3; j++) {
> +				res = &phb->mem_resources[j];
> +				if (paddr >= res->start && paddr <= res->end)
> +					return bus;
> +			}
> +		res = &phb->io_resource;
> +		if (vaddr && vaddr >= res->start && vaddr <= res->end)
> +			return bus;
> +	}
> +	return NULL;
> +}
> +
> +static void celleb_io_flush(const PCI_IO_ADDR addr)
> +{
> +	struct celleb_pci_bus *bus;
> +	int token;
> +
> +	token = PCI_GET_ADDR_TOKEN(addr);
> +
> +	if (token && token <= celleb_pci_count)
> +		bus = &celleb_pci_busses[token - 1];
> +	else {
> +		unsigned long vaddr, paddr;
> +		pte_t *ptep;
> +
> +		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
> +		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
> +			return;
> +
> +		ptep = find_linux_pte(init_mm.pgd, vaddr);
> +		if (ptep == NULL)
> +			paddr = 0;
> +		else
> +			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
> +		bus = celleb_pci_find(vaddr, paddr);
> +
> +		if (bus == NULL)
> +			return;
> +	}
> +
> +	if (bus->dummy_read)
> +		bus->dummy_read(bus->phb);
> +}
> +
> +static u8 celleb_readb(const PCI_IO_ADDR addr)
> +{
> +	u8 val;
> +	val = __do_readb(addr);
> +	celleb_io_flush(addr);
> +	return val;
> +}
> +
> +static u16 celleb_readw(const PCI_IO_ADDR addr)
> +{
> +	u16 val;
> +	val = __do_readw(addr);
> +	celleb_io_flush(addr);
> +	return val;
> +}
> +
> +static u32 celleb_readl(const PCI_IO_ADDR addr)
> +{
> +	u32 val;
> +	val = __do_readl(addr);
> +	celleb_io_flush(addr);
> +	return val;
> +}
> +
> +static u64 celleb_readq(const PCI_IO_ADDR addr)
> +{
> +	u64 val;
> +	val = __do_readq(addr);
> +	celleb_io_flush(addr);
> +	return val;
> +}
> +
> +static u16 celleb_readw_be(const PCI_IO_ADDR addr)
> +{
> +	u16 val;
> +	val = __do_readw_be(addr);
> +	celleb_io_flush(addr);
> +	return val;
> +}
> +
> +static u32 celleb_readl_be(const PCI_IO_ADDR addr)
> +{
> +	u32 val;
> +	val = __do_readl_be(addr);
> +	celleb_io_flush(addr);
> +	return val;
> +}
> +
> +static u64 celleb_readq_be(const PCI_IO_ADDR addr)
> +{
> +	u64 val;
> +	val = __do_readq_be(addr);
> +	celleb_io_flush(addr);
> +	return val;
> +}
> +
> +static void celleb_readsb(const PCI_IO_ADDR addr,
> +			  void *buf, unsigned long count)
> +{
> +	__do_readsb(addr, buf, count);
> +	celleb_io_flush(addr);
> +}
> +
> +static void celleb_readsw(const PCI_IO_ADDR addr,
> +			  void *buf, unsigned long count)
> +{
> +	__do_readsw(addr, buf, count);
> +	celleb_io_flush(addr);
> +}
> +
> +static void celleb_readsl(const PCI_IO_ADDR addr,
> +			  void *buf, unsigned long count)
> +{
> +	__do_readsl(addr, buf, count);
> +	celleb_io_flush(addr);
> +}
> +
> +static void celleb_memcpy_fromio(void *dest,
> +				 const PCI_IO_ADDR src,
> +				 unsigned long n)
> +{
> +	__do_memcpy_fromio(dest, src, n);
> +	celleb_io_flush(src);
> +}
> +
> +static void __iomem *celleb_ioremap(unsigned long addr,
> +				     unsigned long size,
> +				     unsigned long flags)
> +{
> +	struct celleb_pci_bus *bus;
> +	void __iomem *res = __ioremap(addr, size, flags);
> +	int busno;
> +
> +	bus = celleb_pci_find(0, addr);
> +	if (bus != NULL) {
> +		busno = bus - celleb_pci_busses;
> +		PCI_SET_ADDR_TOKEN(res, busno + 1);
> +	}
> +	return res;
> +}

Is there a way that we can make that code common? I guess there could be a
file in arch/powerpc/sysdev that can handle this correctly for all hardware
that requires this particular workaround (currently celleb and QS20, but
potentially more).

	Arnd <><
