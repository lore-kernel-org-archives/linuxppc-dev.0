Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D3EBDE04D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 20:05:33 +1000 (EST)
Subject: Re: [PATCH 2/9] celleb: consolidate io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080424.182413.-1300541813.kouish@swc.toshiba.co.jp>
References: <20080424.182413.-1300541813.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 20:05:27 +1000
Message-Id: <1209031527.9060.178.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-04-24 at 18:24 +0900, Ishizaki Kou wrote:
> Now, we can use generic io-workarounds mechanism and the workaround
> code for spider-pci. This patch changes Celleb PCI code to use
> spider-pci code.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  arch/powerpc/platforms/cell/Makefile           |    6 
>  arch/powerpc/platforms/celleb/Makefile         |    3 
>  arch/powerpc/platforms/celleb/io-workarounds.c |  280 -------------------------
>  arch/powerpc/platforms/celleb/pci.c            |   41 ++-
>  arch/powerpc/platforms/celleb/pci.h            |   18 -
>  arch/powerpc/platforms/celleb/scc_epci.c       |   59 -----
>  arch/powerpc/platforms/celleb/setup.c          |    2 
>  7 files changed, 52 insertions(+), 357 deletions(-)
> 
> Index: b/arch/powerpc/platforms/celleb/pci.c
> ===================================================================
> --- a/arch/powerpc/platforms/celleb/pci.c	2008-04-24 12:05:34.000000000 +0900
> +++ b/arch/powerpc/platforms/celleb/pci.c	2008-04-24 12:06:12.000000000 +0900
> @@ -41,6 +41,7 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/ppc-pci.h>
>  
> +#include "../cell/io-workarounds.h"
>  #include "pci.h"
>  #include "interrupt.h"
>  
> @@ -457,33 +458,39 @@
>  	return 0;
>  }
>  
> -void __init fake_pci_workaround_init(struct pci_controller *phb)
> -{
> -	/**
> -	 *  We will add fake pci bus to scc_pci_bus for the purpose to improve
> -	 *  I/O Macro performance. But device-tree and device drivers
> -	 *  are not ready to use address with a token.
> -	 */
> -
> -	/* celleb_pci_add_one(phb, NULL); */
> -}
> +static struct celleb_phb_spec celleb_fake_pci_spec __initdata = {
> +	.setup = celleb_setup_fake_pci,
> +};
>  
>  static struct of_device_id celleb_phb_match[] __initdata = {
>  	{
>  		.name = "pci-pseudo",
> -		.data = celleb_setup_fake_pci,
> +		.data = &celleb_fake_pci_spec,
>  	}, {
>  		.name = "epci",
> -		.data = celleb_setup_epci,
> +		.data = &celleb_epci_spec,
>  	}, {
>  	},
>  };
>  
> +static int __init celleb_io_workaround_init(struct pci_controller *phb,
> +					    struct celleb_phb_spec *phb_spec)
> +{
> +	if (phb_spec->ops) {
> +		iowa_register_bus(phb, phb_spec->ops, phb_spec->iowa_init,
> +				  phb_spec->iowa_data);
> +		io_workaround_init();
> +	}
> +
> +	return 0;
> +}
> +
>  int __init celleb_setup_phb(struct pci_controller *phb)
>  {
>  	struct device_node *dev = phb->dn;
>  	const struct of_device_id *match;
> -	int (*setup_func)(struct device_node *, struct pci_controller *);
> +	struct celleb_phb_spec *phb_spec;
> +	int rc;
>  
>  	match = of_match_node(celleb_phb_match, dev);
>  	if (!match)
> @@ -492,8 +499,12 @@
>  	phb_set_bus_ranges(dev, phb);
>  	phb->buid = 1;
>  
> -	setup_func = match->data;
> -	return (*setup_func)(dev, phb);
> +	phb_spec = match->data;
> +	rc = (*phb_spec->setup)(dev, phb);
> +	if (rc)
> +		return 1;
> +
> +	return celleb_io_workaround_init(phb, phb_spec);
>  }
>  
>  int celleb_pci_probe_mode(struct pci_bus *bus)
> Index: b/arch/powerpc/platforms/celleb/pci.h
> ===================================================================
> --- a/arch/powerpc/platforms/celleb/pci.h	2008-04-24 12:05:34.000000000 +0900
> +++ b/arch/powerpc/platforms/celleb/pci.h	2008-04-24 12:06:12.000000000 +0900
> @@ -27,16 +27,18 @@
>  #include <asm/prom.h>
>  #include <asm/ppc-pci.h>
>  
> +#include "../cell/io-workarounds.h"
> +
> +struct celleb_phb_spec {
> +	int (*setup)(struct device_node *, struct pci_controller *);
> +	struct ppc_pci_io *ops;
> +	int (*iowa_init)(struct iowa_bus *, void *);
> +	void *iowa_data;
> +};
> +
>  extern int celleb_setup_phb(struct pci_controller *);
>  extern int celleb_pci_probe_mode(struct pci_bus *);
>  
> -extern int celleb_setup_epci(struct device_node *, struct pci_controller *);
> -
> -extern void *celleb_dummy_page_va;
> -extern int __init celleb_pci_workaround_init(void);
> -extern void __init celleb_pci_add_one(struct pci_controller *,
> -				      void (*)(struct pci_controller *));
> -extern void fake_pci_workaround_init(struct pci_controller *);
> -extern void epci_workaround_init(struct pci_controller *);
> +extern struct celleb_phb_spec celleb_epci_spec;
>  
>  #endif /* _CELLEB_PCI_H */
> Index: b/arch/powerpc/platforms/celleb/scc_epci.c
> ===================================================================
> --- a/arch/powerpc/platforms/celleb/scc_epci.c	2008-04-24 12:05:34.000000000 +0900
> +++ b/arch/powerpc/platforms/celleb/scc_epci.c	2008-04-24 12:06:39.000000000 +0900
> @@ -43,10 +43,6 @@
>  
>  #define iob()  __asm__ __volatile__("eieio; sync":::"memory")
>  
> -struct epci_private {
> -	dma_addr_t	dummy_page_da;
> -};
> -
>  static inline PCI_IO_ADDR celleb_epci_get_epci_base(
>  					struct pci_controller *hose)
>  {
> @@ -71,42 +67,6 @@
>  	return hose->cfg_data;
>  }
>  
> -static void scc_epci_dummy_read(struct pci_controller *hose)
> -{
> -	PCI_IO_ADDR epci_base;
> -	u32 val;
> -
> -	epci_base = celleb_epci_get_epci_base(hose);
> -
> -	val = in_be32(epci_base + SCC_EPCI_WATRP);
> -	iosync();
> -
> -	return;
> -}
> -
> -void __init epci_workaround_init(struct pci_controller *hose)
> -{
> -	PCI_IO_ADDR epci_base;
> -	PCI_IO_ADDR reg;
> -	struct epci_private *private = hose->private_data;
> -
> -	BUG_ON(!private);
> -
> -	private->dummy_page_da = dma_map_single(hose->parent,
> -		celleb_dummy_page_va, PAGE_SIZE, DMA_FROM_DEVICE);
> -	if (private->dummy_page_da == DMA_ERROR_CODE) {
> -		printk(KERN_ERR "EPCI: dummy read disabled. "
> -		       "Map dummy page failed.\n");
> -		return;
> -	}
> -
> -	celleb_pci_add_one(hose, scc_epci_dummy_read);
> -	epci_base = celleb_epci_get_epci_base(hose);
> -
> -	reg = epci_base + SCC_EPCI_DUMYRADR;
> -	out_be32(reg, private->dummy_page_da);
> -}
> -
>  static inline void clear_and_disable_master_abort_interrupt(
>  					struct pci_controller *hose)
>  {
> @@ -425,8 +385,8 @@
>  	return 0;
>  }
>  
> -int __init celleb_setup_epci(struct device_node *node,
> -				struct pci_controller *hose)
> +static int __init celleb_setup_epci(struct device_node *node,
> +				    struct pci_controller *hose)
>  {
>  	struct resource r;
>  
> @@ -462,20 +422,12 @@
>  		 r.start, (unsigned long)hose->cfg_data,
>  		(r.end - r.start + 1));
>  
> -	hose->private_data = kzalloc(sizeof(struct epci_private), GFP_KERNEL);
> -	if (hose->private_data == NULL) {
> -		printk(KERN_ERR "EPCI: no memory for private data.\n");
> -		goto error;
> -	}
> -
>  	hose->ops = &celleb_epci_ops;
>  	celleb_epci_init(hose);
>  
>  	return 0;
>  
>  error:
> -	kfree(hose->private_data);
> -
>  	if (hose->cfg_addr)
>  		iounmap(hose->cfg_addr);
>  
> @@ -483,3 +435,10 @@
>  		iounmap(hose->cfg_data);
>  	return 1;
>  }
> +
> +struct celleb_phb_spec celleb_epci_spec __initdata = {
> +	.setup = celleb_setup_epci,
> +	.ops = &spiderpci_ops,
> +	.iowa_init = &spiderpci_iowa_init,
> +	.iowa_data = (void *)0,
> +};
> Index: b/arch/powerpc/platforms/celleb/io-workarounds.c
> ===================================================================
> --- a/arch/powerpc/platforms/celleb/io-workarounds.c	2008-04-24 12:05:34.000000000 +0900
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,280 +0,0 @@
> -/*
> - * Support for Celleb io workarounds
> - *
> - * (C) Copyright 2006-2007 TOSHIBA CORPORATION
> - *
> - * This file is based to arch/powerpc/platform/cell/io-workarounds.c
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - */
> -
> -#undef DEBUG
> -
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/irq.h>
> -
> -#include <asm/io.h>
> -#include <asm/prom.h>
> -#include <asm/machdep.h>
> -#include <asm/pci-bridge.h>
> -#include <asm/ppc-pci.h>
> -
> -#include "pci.h"
> -
> -#define MAX_CELLEB_PCI_BUS	4
> -
> -void *celleb_dummy_page_va;
> -
> -static struct celleb_pci_bus {
> -	struct pci_controller *phb;
> -	void (*dummy_read)(struct pci_controller *);
> -} celleb_pci_busses[MAX_CELLEB_PCI_BUS];
> -
> -static int celleb_pci_count = 0;
> -
> -static struct celleb_pci_bus *celleb_pci_find(unsigned long vaddr,
> -					      unsigned long paddr)
> -{
> -	int i, j;
> -	struct resource *res;
> -
> -	for (i = 0; i < celleb_pci_count; i++) {
> -		struct celleb_pci_bus *bus = &celleb_pci_busses[i];
> -		struct pci_controller *phb = bus->phb;
> -		if (paddr)
> -			for (j = 0; j < 3; j++) {
> -				res = &phb->mem_resources[j];
> -				if (paddr >= res->start && paddr <= res->end)
> -					return bus;
> -			}
> -		res = &phb->io_resource;
> -		if (vaddr && vaddr >= res->start && vaddr <= res->end)
> -			return bus;
> -	}
> -	return NULL;
> -}
> -
> -static void celleb_io_flush(const PCI_IO_ADDR addr)
> -{
> -	struct celleb_pci_bus *bus;
> -	int token;
> -
> -	token = PCI_GET_ADDR_TOKEN(addr);
> -
> -	if (token && token <= celleb_pci_count)
> -		bus = &celleb_pci_busses[token - 1];
> -	else {
> -		unsigned long vaddr, paddr;
> -		pte_t *ptep;
> -
> -		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
> -		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
> -			return;
> -
> -		ptep = find_linux_pte(init_mm.pgd, vaddr);
> -		if (ptep == NULL)
> -			paddr = 0;
> -		else
> -			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
> -		bus = celleb_pci_find(vaddr, paddr);
> -
> -		if (bus == NULL)
> -			return;
> -	}
> -
> -	if (bus->dummy_read)
> -		bus->dummy_read(bus->phb);
> -}
> -
> -static u8 celleb_readb(const PCI_IO_ADDR addr)
> -{
> -	u8 val;
> -	val = __do_readb(addr);
> -	celleb_io_flush(addr);
> -	return val;
> -}
> -
> -static u16 celleb_readw(const PCI_IO_ADDR addr)
> -{
> -	u16 val;
> -	val = __do_readw(addr);
> -	celleb_io_flush(addr);
> -	return val;
> -}
> -
> -static u32 celleb_readl(const PCI_IO_ADDR addr)
> -{
> -	u32 val;
> -	val = __do_readl(addr);
> -	celleb_io_flush(addr);
> -	return val;
> -}
> -
> -static u64 celleb_readq(const PCI_IO_ADDR addr)
> -{
> -	u64 val;
> -	val = __do_readq(addr);
> -	celleb_io_flush(addr);
> -	return val;
> -}
> -
> -static u16 celleb_readw_be(const PCI_IO_ADDR addr)
> -{
> -	u16 val;
> -	val = __do_readw_be(addr);
> -	celleb_io_flush(addr);
> -	return val;
> -}
> -
> -static u32 celleb_readl_be(const PCI_IO_ADDR addr)
> -{
> -	u32 val;
> -	val = __do_readl_be(addr);
> -	celleb_io_flush(addr);
> -	return val;
> -}
> -
> -static u64 celleb_readq_be(const PCI_IO_ADDR addr)
> -{
> -	u64 val;
> -	val = __do_readq_be(addr);
> -	celleb_io_flush(addr);
> -	return val;
> -}
> -
> -static void celleb_readsb(const PCI_IO_ADDR addr,
> -			  void *buf, unsigned long count)
> -{
> -	__do_readsb(addr, buf, count);
> -	celleb_io_flush(addr);
> -}
> -
> -static void celleb_readsw(const PCI_IO_ADDR addr,
> -			  void *buf, unsigned long count)
> -{
> -	__do_readsw(addr, buf, count);
> -	celleb_io_flush(addr);
> -}
> -
> -static void celleb_readsl(const PCI_IO_ADDR addr,
> -			  void *buf, unsigned long count)
> -{
> -	__do_readsl(addr, buf, count);
> -	celleb_io_flush(addr);
> -}
> -
> -static void celleb_memcpy_fromio(void *dest,
> -				 const PCI_IO_ADDR src,
> -				 unsigned long n)
> -{
> -	__do_memcpy_fromio(dest, src, n);
> -	celleb_io_flush(src);
> -}
> -
> -static void __iomem *celleb_ioremap(unsigned long addr,
> -				     unsigned long size,
> -				     unsigned long flags)
> -{
> -	struct celleb_pci_bus *bus;
> -	void __iomem *res = __ioremap(addr, size, flags);
> -	int busno;
> -
> -	bus = celleb_pci_find(0, addr);
> -	if (bus != NULL) {
> -		busno = bus - celleb_pci_busses;
> -		PCI_SET_ADDR_TOKEN(res, busno + 1);
> -	}
> -	return res;
> -}
> -
> -static void celleb_iounmap(volatile void __iomem *addr)
> -{
> -	return __iounmap(PCI_FIX_ADDR(addr));
> -}
> -
> -static struct ppc_pci_io celleb_pci_io __initdata = {
> -	.readb = celleb_readb,
> -	.readw = celleb_readw,
> -	.readl = celleb_readl,
> -	.readq = celleb_readq,
> -	.readw_be = celleb_readw_be,
> -	.readl_be = celleb_readl_be,
> -	.readq_be = celleb_readq_be,
> -	.readsb = celleb_readsb,
> -	.readsw = celleb_readsw,
> -	.readsl = celleb_readsl,
> -	.memcpy_fromio = celleb_memcpy_fromio,
> -};
> -
> -void __init celleb_pci_add_one(struct pci_controller *phb,
> -			       void (*dummy_read)(struct pci_controller *))
> -{
> -	struct celleb_pci_bus *bus = &celleb_pci_busses[celleb_pci_count];
> -	struct device_node *np = phb->dn;
> -
> -	if (celleb_pci_count >= MAX_CELLEB_PCI_BUS) {
> -		printk(KERN_ERR "Too many pci bridges, workarounds"
> -		       " disabled for %s\n", np->full_name);
> -		return;
> -	}
> -
> -	celleb_pci_count++;
> -
> -	bus->phb = phb;
> -	bus->dummy_read = dummy_read;
> -}
> -
> -static struct of_device_id celleb_pci_workaround_match[] __initdata = {
> -	{
> -		.name = "pci-pseudo",
> -		.data = fake_pci_workaround_init,
> -	}, {
> -		.name = "epci",
> -		.data = epci_workaround_init,
> -	}, {
> -	},
> -};
> -
> -int __init celleb_pci_workaround_init(void)
> -{
> -	struct pci_controller *phb;
> -	struct device_node *node;
> -	const struct  of_device_id *match;
> -	void (*init_func)(struct pci_controller *);
> -
> -	celleb_dummy_page_va = kmalloc(PAGE_SIZE, GFP_KERNEL);
> -	if (!celleb_dummy_page_va) {
> -		printk(KERN_ERR "Celleb: dummy read disabled. "
> -			"Alloc celleb_dummy_page_va failed\n");
> -		return 1;
> -	}
> -
> -	list_for_each_entry(phb, &hose_list, list_node) {
> -		node = phb->dn;
> -		match = of_match_node(celleb_pci_workaround_match, node);
> -
> -		if (match) {
> -			init_func = match->data;
> -			(*init_func)(phb);
> -		}
> -	}
> -
> -	ppc_pci_io = celleb_pci_io;
> -	ppc_md.ioremap = celleb_ioremap;
> -	ppc_md.iounmap = celleb_iounmap;
> -
> -	return 0;
> -}
> Index: b/arch/powerpc/platforms/celleb/setup.c
> ===================================================================
> --- a/arch/powerpc/platforms/celleb/setup.c	2008-04-24 12:05:34.000000000 +0900
> +++ b/arch/powerpc/platforms/celleb/setup.c	2008-04-24 12:06:12.000000000 +0900
> @@ -114,8 +114,6 @@
>  	/* Publish OF platform devices for southbridge IOs */
>  	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
>  
> -	celleb_pci_workaround_init();
> -
>  	return 0;
>  }
>  machine_device_initcall(celleb_beat, celleb_publish_devices);
> Index: b/arch/powerpc/platforms/celleb/Makefile
> ===================================================================
> --- a/arch/powerpc/platforms/celleb/Makefile	2008-04-24 12:05:34.000000000 +0900
> +++ b/arch/powerpc/platforms/celleb/Makefile	2008-04-24 12:06:12.000000000 +0900
> @@ -1,7 +1,6 @@
>  obj-y				+= interrupt.o iommu.o setup.o \
>  				   htab.o beat.o hvCall.o pci.o \
> -				   scc_epci.o scc_uhc.o \
> -				   io-workarounds.o
> +				   scc_epci.o scc_uhc.o
>  
>  obj-$(CONFIG_SMP)		+= smp.o
>  obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
> Index: b/arch/powerpc/platforms/cell/Makefile
> ===================================================================
> --- a/arch/powerpc/platforms/cell/Makefile	2008-04-24 12:06:01.000000000 +0900
> +++ b/arch/powerpc/platforms/cell/Makefile	2008-04-24 12:06:12.000000000 +0900
> @@ -27,3 +27,9 @@
>  					   spufs/
>  
>  obj-$(CONFIG_PCI_MSI)			+= axon_msi.o
> +
> +
> +# celleb stuff
> +ifeq ($(CONFIG_PPC_CELLEB),y)
> +obj-y					+= io-workarounds.o spider-pci.o
> +endif
