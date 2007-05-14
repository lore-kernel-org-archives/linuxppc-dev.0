Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id BAF27DDEC1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 00:37:25 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] powerpc: Rewrite IO allocation & mapping on powerpc64
Date: Mon, 14 May 2007 16:37:19 +0200
References: <20070514075415.7999BDDEC8@ozlabs.org>
In-Reply-To: <20070514075415.7999BDDEC8@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705141637.19572.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 May 2007, Benjamin Herrenschmidt wrote:
> + * Define the address ranges for MMIO and IO space :
> + *
> + *  ISA_IO_BASE = VMALLOC_END, 64K reserved area
> + *  PHB_IO_BASE = ISA_IO_BASE + 64K to ISA_IO_BASE + 2G, PHB IO spaces
> + * IOREMAP_BASE = ISA_IO_BASE + 2G to VMALLOC_START + PGTABLE_RANGE
> + */
> +#define  ISA_IO_BASE	(VMALLOC_END)
> +#define  ISA_IO_END	(VMALLOC_END + 0x10000ul)
> +#define  PHB_IO_BASE	(ISA_IO_END)
> +#define  PHB_IO_END	(VMALLOC_END + 0x80000000ul)
> +#define IOREMAP_BASE	(PHB_IO_END)
> +#define IOREMAP_END	(VMALLOC_START + PGTABLE_RANGE)

Very nice layout, it suddenly all makes sense ;-)

PHB_IO_END should probably be 

#define  PHB_IO_END	(VMALLOC_END + PIO_RESERVED)

At least, that is how I understand the definition of PIO_RESERVED.

Do you think it's ok to not treat the range between 64k and 1M special?
There might be ISA drivers that expect devices in there. Maybe we should
start PHB_IO_BASE after a 1M guard area where nothing is mapped.

Where should Olof's PCMCIA space go? The ISA or the PHB range?

> Index: linux-cell/arch/powerpc/kernel/Makefile
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/Makefile	2007-05-10 13:21:02.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/Makefile	2007-05-14 16:43:03.000000000 +1000
> @@ -65,7 +65,7 @@ obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_s
>  module-$(CONFIG_PPC64)		+= module_64.o
>  obj-$(CONFIG_MODULES)		+= $(module-y)
>  
> -pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o
> +pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o isa-bridge.o
>  pci32-$(CONFIG_PPC32)		:= pci_32.o
>  obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
>  obj-$(CONFIG_PCI_MSI)		+= msi.o

Can we make this depend on CONFIG_ISA? Most platforms don't actually want
to build in ISA support.

> @@ -11,7 +11,7 @@
>   *      2 of the License, or (at your option) any later version.
>   */
>  
> -#undef DEBUG
> +#define DEBUG
>  
>  #include <linux/kernel.h>
>  #include <linux/pci.h>

needs to get reverted of course

>  /* pci_io_base -- the base address from which io bars are offsets.
>   * This is the lowest I/O base address (so bar values are always positive),
>   * and it *must* be the start of ISA space if an ISA bus exists because
> - * ISA drivers use hard coded offsets.  If no ISA bus exists a dummy
> - * page is mapped and isa_io_limit prevents access to it.
> + * ISA drivers use hard coded offsets.
>   */
> -unsigned long isa_io_base;	/* NULL if no ISA bus */
> -EXPORT_SYMBOL(isa_io_base);
> -unsigned long pci_io_base;
> +unsigned long pci_io_base = ISA_IO_BASE;
>  EXPORT_SYMBOL(pci_io_base);
>  
>  void iSeries_pcibios_init(void);

Why do we even need to make pci_io_base a variable? There are not many
places where it's used, and they are are read-only. Replacing it with the
constant of ISA_IO_BASE should reduce the code size in every driver
that uses port access functions.

	Arnd <><
