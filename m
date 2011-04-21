Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/pci: Move IO workarounds to the common
	kernel dir
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ozlabs.org>
In-Reply-To: <5c32389c0780cd3cc0b45885ea68238908433b59.1302593231.git.michael@ellerman.id.au>
References: <a19ba86ac6fd999e3482e2c04b6fb10af04bb4a4.1302593231.git.michael@ellerman.id.au>
	<5c32389c0780cd3cc0b45885ea68238908433b59.1302593231.git.michael@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Apr 2011 10:50:02 +1000
Message-ID: <1303347002.2513.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-12 at 17:25 +1000, Michael Ellerman wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---

This misses a couple of #include "io-workarounds.h" ->
<asm/io-workarounds.h> conversions. I'll fix it up before merging.

Cheers,
Ben.

>  arch/powerpc/include/asm/io-workarounds.h    |   49 +++++++
>  arch/powerpc/kernel/Makefile                 |    2 +
>  arch/powerpc/kernel/io-workarounds.c         |  184 +++++++++++++++++++++++++
>  arch/powerpc/platforms/Kconfig               |    3 +
>  arch/powerpc/platforms/cell/Kconfig          |    1 +
>  arch/powerpc/platforms/cell/Makefile         |    8 +-
>  arch/powerpc/platforms/cell/celleb_pci.c     |    1 -
>  arch/powerpc/platforms/cell/celleb_pci.h     |    3 +-
>  arch/powerpc/platforms/cell/io-workarounds.c |  185 --------------------------
>  arch/powerpc/platforms/cell/io-workarounds.h |   49 -------
>  arch/powerpc/platforms/cell/qpace_setup.c    |    1 -
>  arch/powerpc/platforms/cell/setup.c          |    2 +-
>  arch/powerpc/platforms/cell/spider-pci.c     |    3 +-
>  13 files changed, 247 insertions(+), 244 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/io-workarounds.h b/arch/powerpc/include/asm/io-workarounds.h
> new file mode 100644
> index 0000000..6efc778
> --- /dev/null
> +++ b/arch/powerpc/include/asm/io-workarounds.h
> @@ -0,0 +1,49 @@
> +/*
> + * Support PCI IO workaround
> + *
> + * (C) Copyright 2007-2008 TOSHIBA CORPORATION
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef _IO_WORKAROUNDS_H
> +#define _IO_WORKAROUNDS_H
> +
> +#include <linux/io.h>
> +#include <asm/pci-bridge.h>
> +
> +/* Bus info */
> +struct iowa_bus {
> +	struct pci_controller *phb;
> +	struct ppc_pci_io *ops;
> +	void   *private;
> +};
> +
> +void __devinit io_workaround_init(void);
> +void __devinit iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
> +				 int (*)(struct iowa_bus *, void *), void *);
> +struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR);
> +struct iowa_bus *iowa_pio_find_bus(unsigned long);
> +
> +extern struct ppc_pci_io spiderpci_ops;
> +extern int spiderpci_iowa_init(struct iowa_bus *, void *);
> +
> +#define SPIDER_PCI_REG_BASE		0xd000
> +#define SPIDER_PCI_REG_SIZE		0x1000
> +#define SPIDER_PCI_VCI_CNTL_STAT	0x0110
> +#define SPIDER_PCI_DUMMY_READ		0x0810
> +#define SPIDER_PCI_DUMMY_READ_BASE	0x0814
> +
> +#endif /* _IO_WORKAROUNDS_H */
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 0fd6273..b0ba78f 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -105,6 +105,8 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o \
>  obj-$(CONFIG_AUDIT)		+= audit.o
>  obj64-$(CONFIG_AUDIT)		+= compat_audit.o
>  
> +obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
> +
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
> diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
> new file mode 100644
> index 0000000..7e58457
> --- /dev/null
> +++ b/arch/powerpc/kernel/io-workarounds.c
> @@ -0,0 +1,184 @@
> +/*
> + * Support PCI IO workaround
> + *
> + *  Copyright (C) 2006 Benjamin Herrenschmidt <benh@kernel.crashing.org>
> + *		       IBM, Corp.
> + *  (C) Copyright 2007-2008 TOSHIBA CORPORATION
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#undef DEBUG
> +
> +#include <linux/kernel.h>
> +
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/pgtable.h>
> +#include <asm/ppc-pci.h>
> +#include <asm/io-workarounds.h>
> +
> +#define IOWA_MAX_BUS	8
> +
> +static struct iowa_bus iowa_busses[IOWA_MAX_BUS];
> +static unsigned int iowa_bus_count;
> +
> +static struct iowa_bus *iowa_pci_find(unsigned long vaddr, unsigned long paddr)
> +{
> +	int i, j;
> +	struct resource *res;
> +	unsigned long vstart, vend;
> +
> +	for (i = 0; i < iowa_bus_count; i++) {
> +		struct iowa_bus *bus = &iowa_busses[i];
> +		struct pci_controller *phb = bus->phb;
> +
> +		if (vaddr) {
> +			vstart = (unsigned long)phb->io_base_virt;
> +			vend = vstart + phb->pci_io_size - 1;
> +			if ((vaddr >= vstart) && (vaddr <= vend))
> +				return bus;
> +		}
> +
> +		if (paddr)
> +			for (j = 0; j < 3; j++) {
> +				res = &phb->mem_resources[j];
> +				if (paddr >= res->start && paddr <= res->end)
> +					return bus;
> +			}
> +	}
> +
> +	return NULL;
> +}
> +
> +struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
> +{
> +	struct iowa_bus *bus;
> +	int token;
> +
> +	token = PCI_GET_ADDR_TOKEN(addr);
> +
> +	if (token && token <= iowa_bus_count)
> +		bus = &iowa_busses[token - 1];
> +	else {
> +		unsigned long vaddr, paddr;
> +		pte_t *ptep;
> +
> +		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
> +		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
> +			return NULL;
> +
> +		ptep = find_linux_pte(init_mm.pgd, vaddr);
> +		if (ptep == NULL)
> +			paddr = 0;
> +		else
> +			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
> +		bus = iowa_pci_find(vaddr, paddr);
> +
> +		if (bus == NULL)
> +			return NULL;
> +	}
> +
> +	return bus;
> +}
> +
> +struct iowa_bus *iowa_pio_find_bus(unsigned long port)
> +{
> +	unsigned long vaddr = (unsigned long)pci_io_base + port;
> +	return iowa_pci_find(vaddr, 0);
> +}
> +
> +
> +#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)		\
> +static ret iowa_##name at					\
> +{								\
> +	struct iowa_bus *bus;					\
> +	bus = iowa_##space##_find_bus(aa);			\
> +	if (bus && bus->ops && bus->ops->name)			\
> +		return bus->ops->name al;			\
> +	return __do_##name al;					\
> +}
> +
> +#define DEF_PCI_AC_NORET(name, at, al, space, aa)		\
> +static void iowa_##name at					\
> +{								\
> +	struct iowa_bus *bus;					\
> +	bus = iowa_##space##_find_bus(aa);			\
> +	if (bus && bus->ops && bus->ops->name) {		\
> +		bus->ops->name al;				\
> +		return;						\
> +	}							\
> +	__do_##name al;						\
> +}
> +
> +#include <asm/io-defs.h>
> +
> +#undef DEF_PCI_AC_RET
> +#undef DEF_PCI_AC_NORET
> +
> +static const struct ppc_pci_io __devinitconst iowa_pci_io = {
> +
> +#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)	.name = iowa_##name,
> +#define DEF_PCI_AC_NORET(name, at, al, space, aa)	.name = iowa_##name,
> +
> +#include <asm/io-defs.h>
> +
> +#undef DEF_PCI_AC_RET
> +#undef DEF_PCI_AC_NORET
> +
> +};
> +
> +static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
> +				  unsigned long flags, void *caller)
> +{
> +	struct iowa_bus *bus;
> +	void __iomem *res = __ioremap_caller(addr, size, flags, caller);
> +	int busno;
> +
> +	bus = iowa_pci_find(0, (unsigned long)addr);
> +	if (bus != NULL) {
> +		busno = bus - iowa_busses;
> +		PCI_SET_ADDR_TOKEN(res, busno + 1);
> +	}
> +	return res;
> +}
> +
> +/* Regist new bus to support workaround */
> +void __devinit iowa_register_bus(struct pci_controller *phb,
> +			struct ppc_pci_io *ops,
> +			int (*initfunc)(struct iowa_bus *, void *), void *data)
> +{
> +	struct iowa_bus *bus;
> +	struct device_node *np = phb->dn;
> +
> +	if (iowa_bus_count >= IOWA_MAX_BUS) {
> +		pr_err("IOWA:Too many pci bridges, "
> +		       "workarounds disabled for %s\n", np->full_name);
> +		return;
> +	}
> +
> +	bus = &iowa_busses[iowa_bus_count];
> +	bus->phb = phb;
> +	bus->ops = ops;
> +
> +	if (initfunc)
> +		if ((*initfunc)(bus, data))
> +			return;
> +
> +	iowa_bus_count++;
> +
> +	pr_debug("IOWA:[%d]Add bus, %s.\n", iowa_bus_count-1, np->full_name);
> +}
> +
> +/* enable IO workaround */
> +void __devinit io_workaround_init(void)
> +{
> +	static int io_workaround_inited;
> +
> +	if (io_workaround_inited)
> +		return;
> +	ppc_pci_io = iowa_pci_io;
> +	ppc_md.ioremap = iowa_ioremap;
> +	io_workaround_inited = 1;
> +}
> diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
> index 34e34ba..114d748 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -163,6 +163,9 @@ config PPC_INDIRECT_MMIO
>  	bool
>  	select PPC_INDIRECT_IO
>  
> +config PPC_IO_WORKAROUNDS
> +	bool
> +
>  config GENERIC_IOMAP
>  	bool
>  
> diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
> index 3c7f1de..67d5009 100644
> --- a/arch/powerpc/platforms/cell/Kconfig
> +++ b/arch/powerpc/platforms/cell/Kconfig
> @@ -16,6 +16,7 @@ config PPC_CELL_NATIVE
>  	bool
>  	select PPC_CELL_COMMON
>  	select MPIC
> +	select PPC_IO_WORKAROUNDS
>  	select IBM_NEW_EMAC_EMAC4
>  	select IBM_NEW_EMAC_RGMII
>  	select IBM_NEW_EMAC_ZMII #test only
> diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
> index 83fafe9..8839ef6 100644
> --- a/arch/powerpc/platforms/cell/Makefile
> +++ b/arch/powerpc/platforms/cell/Makefile
> @@ -1,7 +1,7 @@
>  obj-$(CONFIG_PPC_CELL_COMMON)		+= cbe_regs.o interrupt.o pervasive.o
>  
>  obj-$(CONFIG_PPC_CELL_NATIVE)		+= iommu.o setup.o spider-pic.o \
> -					   pmu.o io-workarounds.o spider-pci.o
> +					   pmu.o spider-pci.o
>  obj-$(CONFIG_CBE_RAS)			+= ras.o
>  
>  obj-$(CONFIG_CBE_THERM)			+= cbe_thermal.o
> @@ -39,9 +39,9 @@ obj-y					+= celleb_setup.o \
>  					   celleb_pci.o celleb_scc_epci.o \
>  					   celleb_scc_pciex.o \
>  					   celleb_scc_uhc.o \
> -					   io-workarounds.o spider-pci.o \
> -					   beat.o beat_htab.o beat_hvCall.o \
> -					   beat_interrupt.o beat_iommu.o
> +					   spider-pci.o beat.o beat_htab.o \
> +					   beat_hvCall.o beat_interrupt.o \
> +					   beat_iommu.o
>  
>  obj-$(CONFIG_SMP)			+= beat_smp.o
>  obj-$(CONFIG_PPC_UDBG_BEAT)		+= beat_udbg.o
> diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
> index 404d1fc..c19b783 100644
> --- a/arch/powerpc/platforms/cell/celleb_pci.c
> +++ b/arch/powerpc/platforms/cell/celleb_pci.c
> @@ -41,7 +41,6 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/ppc-pci.h>
>  
> -#include "io-workarounds.h"
>  #include "celleb_pci.h"
>  
>  #define MAX_PCI_DEVICES    32
> diff --git a/arch/powerpc/platforms/cell/celleb_pci.h b/arch/powerpc/platforms/cell/celleb_pci.h
> index 4cba152..a801fcc 100644
> --- a/arch/powerpc/platforms/cell/celleb_pci.h
> +++ b/arch/powerpc/platforms/cell/celleb_pci.h
> @@ -26,8 +26,9 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/prom.h>
>  #include <asm/ppc-pci.h>
> +#include <asm/io-workarounds.h>
>  
> -#include "io-workarounds.h"
> +struct iowa_bus;
>  
>  struct celleb_phb_spec {
>  	int (*setup)(struct device_node *, struct pci_controller *);
> diff --git a/arch/powerpc/platforms/cell/io-workarounds.c b/arch/powerpc/platforms/cell/io-workarounds.c
> deleted file mode 100644
> index 5c1118e..0000000
> --- a/arch/powerpc/platforms/cell/io-workarounds.c
> +++ /dev/null
> @@ -1,185 +0,0 @@
> -/*
> - * Support PCI IO workaround
> - *
> - *  Copyright (C) 2006 Benjamin Herrenschmidt <benh@kernel.crashing.org>
> - *		       IBM, Corp.
> - *  (C) Copyright 2007-2008 TOSHIBA CORPORATION
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#undef DEBUG
> -
> -#include <linux/kernel.h>
> -
> -#include <asm/io.h>
> -#include <asm/machdep.h>
> -#include <asm/pgtable.h>
> -#include <asm/ppc-pci.h>
> -
> -#include "io-workarounds.h"
> -
> -#define IOWA_MAX_BUS	8
> -
> -static struct iowa_bus iowa_busses[IOWA_MAX_BUS];
> -static unsigned int iowa_bus_count;
> -
> -static struct iowa_bus *iowa_pci_find(unsigned long vaddr, unsigned long paddr)
> -{
> -	int i, j;
> -	struct resource *res;
> -	unsigned long vstart, vend;
> -
> -	for (i = 0; i < iowa_bus_count; i++) {
> -		struct iowa_bus *bus = &iowa_busses[i];
> -		struct pci_controller *phb = bus->phb;
> -
> -		if (vaddr) {
> -			vstart = (unsigned long)phb->io_base_virt;
> -			vend = vstart + phb->pci_io_size - 1;
> -			if ((vaddr >= vstart) && (vaddr <= vend))
> -				return bus;
> -		}
> -
> -		if (paddr)
> -			for (j = 0; j < 3; j++) {
> -				res = &phb->mem_resources[j];
> -				if (paddr >= res->start && paddr <= res->end)
> -					return bus;
> -			}
> -	}
> -
> -	return NULL;
> -}
> -
> -struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR addr)
> -{
> -	struct iowa_bus *bus;
> -	int token;
> -
> -	token = PCI_GET_ADDR_TOKEN(addr);
> -
> -	if (token && token <= iowa_bus_count)
> -		bus = &iowa_busses[token - 1];
> -	else {
> -		unsigned long vaddr, paddr;
> -		pte_t *ptep;
> -
> -		vaddr = (unsigned long)PCI_FIX_ADDR(addr);
> -		if (vaddr < PHB_IO_BASE || vaddr >= PHB_IO_END)
> -			return NULL;
> -
> -		ptep = find_linux_pte(init_mm.pgd, vaddr);
> -		if (ptep == NULL)
> -			paddr = 0;
> -		else
> -			paddr = pte_pfn(*ptep) << PAGE_SHIFT;
> -		bus = iowa_pci_find(vaddr, paddr);
> -
> -		if (bus == NULL)
> -			return NULL;
> -	}
> -
> -	return bus;
> -}
> -
> -struct iowa_bus *iowa_pio_find_bus(unsigned long port)
> -{
> -	unsigned long vaddr = (unsigned long)pci_io_base + port;
> -	return iowa_pci_find(vaddr, 0);
> -}
> -
> -
> -#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)		\
> -static ret iowa_##name at					\
> -{								\
> -	struct iowa_bus *bus;					\
> -	bus = iowa_##space##_find_bus(aa);			\
> -	if (bus && bus->ops && bus->ops->name)			\
> -		return bus->ops->name al;			\
> -	return __do_##name al;					\
> -}
> -
> -#define DEF_PCI_AC_NORET(name, at, al, space, aa)		\
> -static void iowa_##name at					\
> -{								\
> -	struct iowa_bus *bus;					\
> -	bus = iowa_##space##_find_bus(aa);			\
> -	if (bus && bus->ops && bus->ops->name) {		\
> -		bus->ops->name al;				\
> -		return;						\
> -	}							\
> -	__do_##name al;						\
> -}
> -
> -#include <asm/io-defs.h>
> -
> -#undef DEF_PCI_AC_RET
> -#undef DEF_PCI_AC_NORET
> -
> -static const struct ppc_pci_io __devinitconst iowa_pci_io = {
> -
> -#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)	.name = iowa_##name,
> -#define DEF_PCI_AC_NORET(name, at, al, space, aa)	.name = iowa_##name,
> -
> -#include <asm/io-defs.h>
> -
> -#undef DEF_PCI_AC_RET
> -#undef DEF_PCI_AC_NORET
> -
> -};
> -
> -static void __iomem *iowa_ioremap(phys_addr_t addr, unsigned long size,
> -				  unsigned long flags, void *caller)
> -{
> -	struct iowa_bus *bus;
> -	void __iomem *res = __ioremap_caller(addr, size, flags, caller);
> -	int busno;
> -
> -	bus = iowa_pci_find(0, (unsigned long)addr);
> -	if (bus != NULL) {
> -		busno = bus - iowa_busses;
> -		PCI_SET_ADDR_TOKEN(res, busno + 1);
> -	}
> -	return res;
> -}
> -
> -/* Regist new bus to support workaround */
> -void __devinit iowa_register_bus(struct pci_controller *phb,
> -			struct ppc_pci_io *ops,
> -			int (*initfunc)(struct iowa_bus *, void *), void *data)
> -{
> -	struct iowa_bus *bus;
> -	struct device_node *np = phb->dn;
> -
> -	if (iowa_bus_count >= IOWA_MAX_BUS) {
> -		pr_err("IOWA:Too many pci bridges, "
> -		       "workarounds disabled for %s\n", np->full_name);
> -		return;
> -	}
> -
> -	bus = &iowa_busses[iowa_bus_count];
> -	bus->phb = phb;
> -	bus->ops = ops;
> -
> -	if (initfunc)
> -		if ((*initfunc)(bus, data))
> -			return;
> -
> -	iowa_bus_count++;
> -
> -	pr_debug("IOWA:[%d]Add bus, %s.\n", iowa_bus_count-1, np->full_name);
> -}
> -
> -/* enable IO workaround */
> -void __devinit io_workaround_init(void)
> -{
> -	static int io_workaround_inited;
> -
> -	if (io_workaround_inited)
> -		return;
> -	ppc_pci_io = iowa_pci_io;
> -	ppc_md.ioremap = iowa_ioremap;
> -	io_workaround_inited = 1;
> -}
> diff --git a/arch/powerpc/platforms/cell/io-workarounds.h b/arch/powerpc/platforms/cell/io-workarounds.h
> deleted file mode 100644
> index 6efc778..0000000
> --- a/arch/powerpc/platforms/cell/io-workarounds.h
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -/*
> - * Support PCI IO workaround
> - *
> - * (C) Copyright 2007-2008 TOSHIBA CORPORATION
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
> -#ifndef _IO_WORKAROUNDS_H
> -#define _IO_WORKAROUNDS_H
> -
> -#include <linux/io.h>
> -#include <asm/pci-bridge.h>
> -
> -/* Bus info */
> -struct iowa_bus {
> -	struct pci_controller *phb;
> -	struct ppc_pci_io *ops;
> -	void   *private;
> -};
> -
> -void __devinit io_workaround_init(void);
> -void __devinit iowa_register_bus(struct pci_controller *, struct ppc_pci_io *,
> -				 int (*)(struct iowa_bus *, void *), void *);
> -struct iowa_bus *iowa_mem_find_bus(const PCI_IO_ADDR);
> -struct iowa_bus *iowa_pio_find_bus(unsigned long);
> -
> -extern struct ppc_pci_io spiderpci_ops;
> -extern int spiderpci_iowa_init(struct iowa_bus *, void *);
> -
> -#define SPIDER_PCI_REG_BASE		0xd000
> -#define SPIDER_PCI_REG_SIZE		0x1000
> -#define SPIDER_PCI_VCI_CNTL_STAT	0x0110
> -#define SPIDER_PCI_DUMMY_READ		0x0810
> -#define SPIDER_PCI_DUMMY_READ_BASE	0x0814
> -
> -#endif /* _IO_WORKAROUNDS_H */
> diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
> index d31c594..51e2901 100644
> --- a/arch/powerpc/platforms/cell/qpace_setup.c
> +++ b/arch/powerpc/platforms/cell/qpace_setup.c
> @@ -42,7 +42,6 @@
>  #include "interrupt.h"
>  #include "pervasive.h"
>  #include "ras.h"
> -#include "io-workarounds.h"
>  
>  static void qpace_show_cpuinfo(struct seq_file *m)
>  {
> diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
> index fd57bfe..af7b13c 100644
> --- a/arch/powerpc/platforms/cell/setup.c
> +++ b/arch/powerpc/platforms/cell/setup.c
> @@ -51,11 +51,11 @@
>  #include <asm/udbg.h>
>  #include <asm/mpic.h>
>  #include <asm/cell-regs.h>
> +#include <asm/io-workarounds.h>
>  
>  #include "interrupt.h"
>  #include "pervasive.h"
>  #include "ras.h"
> -#include "io-workarounds.h"
>  
>  #ifdef DEBUG
>  #define DBG(fmt...) udbg_printf(fmt)
> diff --git a/arch/powerpc/platforms/cell/spider-pci.c b/arch/powerpc/platforms/cell/spider-pci.c
> index ca7731c..f1f7878 100644
> --- a/arch/powerpc/platforms/cell/spider-pci.c
> +++ b/arch/powerpc/platforms/cell/spider-pci.c
> @@ -27,8 +27,7 @@
>  
>  #include <asm/ppc-pci.h>
>  #include <asm/pci-bridge.h>
> -
> -#include "io-workarounds.h"
> +#include <asm/io-workarounds.h>
>  
>  #define SPIDER_PCI_DISABLE_PREFETCH
>  
