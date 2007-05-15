Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E517ADDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 14:23:08 +1000 (EST)
Date: Mon, 14 May 2007 23:26:11 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Fix IO space on PCI busses created from
	of_platform
Message-ID: <20070515042611.GA6349@lixom.net>
References: <20070515041656.41CE7DDECA@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070515041656.41CE7DDECA@ozlabs.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 02:16:26PM +1000, Benjamin Herrenschmidt wrote:
> Index: linux-cell/arch/powerpc/kernel/pci_64.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2007-05-15 14:13:21.000000000 +1000
> +++ linux-cell/arch/powerpc/kernel/pci_64.c	2007-05-15 14:13:48.000000000 +1000
> @@ -41,6 +41,7 @@
>  
>  unsigned long pci_probe_only = 1;
>  int pci_assign_all_buses = 0;
> +static int pci_initial_scan;
>  
>  static void fixup_resource(struct resource *res, struct pci_dev *dev);
>  static void do_bus_setup(struct pci_bus *bus);
> @@ -604,6 +605,8 @@ static int __init pcibios_init(void)
>  		/* map in PCI I/O space */
>  		phbs_remap_io();
>  
> +	pci_initial_scan = 1;
> +
>  	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
>  
>  	return 0;
> @@ -1042,13 +1045,16 @@ void __devinit pci_process_bridge_OF_ran
>  	}
>  }
>  
> -void __init pci_setup_phb_io(struct pci_controller *hose, int primary)
> +void __devinit pci_setup_phb_io(struct pci_controller *hose, int primary)
>  {
>  	unsigned long size = hose->pci_io_size;
>  	unsigned long io_virt_offset;
>  	struct resource *res;
>  	struct device_node *isa_dn;
>  
> +	if (size == 0)
> +		return;
> +
>  	hose->io_base_virt = reserve_phb_iospace(size);
>  	DBG("phb%d io_base_phys 0x%lx io_base_virt 0x%lx\n",
>  		hose->global_number, hose->io_base_phys,
> @@ -1069,6 +1075,15 @@ void __init pci_setup_phb_io(struct pci_
>  	res = &hose->io_resource;
>  	res->start += io_virt_offset;
>  	res->end += io_virt_offset;
> +
> +	/* If this is called after the initial PCI scan, then we need to
> +	 * proceed to IO mappings now
> +	 */
> +	if (pci_initial_scan)
> +		__ioremap_explicit(hose->io_base_phys,
> +				   (unsigned long)hose->io_base_virt,
> +				   hose->pci_io_size,
> +				   _PAGE_NO_CACHE | _PAGE_GUARDED);

The code and comment seems contradictory to me. Maybe name it pci_initial_scan_done? The
way I read it otherwise is:
	if (pci_initial_scan_going_on_now)

:-)


Otherwise it looks OK.


-Olof
