Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D0E167CB4
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:32:17 +1100 (EST)
Subject: Re: [patch 11/16] powerpc: remove occurences of PPC_MULTIPLATFORM
	in pci_64.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125628.463964000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125628.463964000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:32:08 +1100
Message-Id: <1162506728.10630.52.camel@localhost.localdomain>
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

On Thu, 2006-11-02 at 13:56 +0100, s.hauer@pengutronix.de wrote:
> plain text document attachment
> (powerpc-pci_64.S-remove-MULTIPLATFORM.diff)
> Since iSeries is merged to MULTIPLATFORM, there is no way to build a 64bit
> kernel without MULTIPLATFORM, so PPC_MULTIPLATFORM can be removed in
> 64bit-only files 
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Index: arch/powerpc/kernel/pci_64.c
> ===================================================================
> --- a/arch/powerpc/kernel/pci_64.c.orig
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -42,11 +42,9 @@
>  unsigned long pci_probe_only = 1;
>  int pci_assign_all_buses = 0;
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
>  static void fixup_resource(struct resource *res, struct pci_dev *dev);
>  static void do_bus_setup(struct pci_bus *bus);
>  static void phbs_remap_io(void);
> -#endif
>  
>  /* pci_io_base -- the base address from which io bars are offsets.
>   * This is the lowest I/O base address (so bar values are always positive),
> @@ -251,7 +249,6 @@ static void __init pcibios_claim_of_setu
>  		pcibios_claim_one_bus(b);
>  }
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
>  static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
>  {
>  	const u32 *prop;
> @@ -506,7 +503,6 @@ void __devinit of_scan_pci_bridge(struct
>  		pci_scan_child_bus(bus);
>  }
>  EXPORT_SYMBOL(of_scan_pci_bridge);
> -#endif /* CONFIG_PPC_MULTIPLATFORM */
>  
>  void __devinit scan_phb(struct pci_controller *hose)
>  {
> @@ -540,7 +536,7 @@ void __devinit scan_phb(struct pci_contr
>  	}
>  
>  	mode = PCI_PROBE_NORMAL;
> -#ifdef CONFIG_PPC_MULTIPLATFORM
> +
>  	if (node && ppc_md.pci_probe_mode)
>  		mode = ppc_md.pci_probe_mode(bus);
>  	DBG("    probe mode: %d\n", mode);
> @@ -548,7 +544,7 @@ void __devinit scan_phb(struct pci_contr
>  		bus->subordinate = hose->last_busno;
>  		of_scan_bus(node, bus);
>  	}
> -#endif /* CONFIG_PPC_MULTIPLATFORM */
> +
>  	if (mode == PCI_PROBE_NORMAL)
>  		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
>  }
> @@ -592,11 +588,9 @@ static int __init pcibios_init(void)
>  	if (ppc64_isabridge_dev != NULL)
>  		printk(KERN_DEBUG "ISA bridge at %s\n", pci_name(ppc64_isabridge_dev));
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
>  	if (!firmware_has_feature(FW_FEATURE_ISERIES))
>  		/* map in PCI I/O space */
>  		phbs_remap_io();
> -#endif
>  
>  	printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
>  
> @@ -873,8 +867,6 @@ void pcibios_add_platform_entries(struct
>  	device_create_file(&pdev->dev, &dev_attr_devspec);
>  }
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
> -
>  #define ISA_SPACE_MASK 0x1
>  #define ISA_SPACE_IO 0x1
>  
> @@ -1343,8 +1335,6 @@ struct pci_controller* pci_find_hose_for
>  	return NULL;
>  }
>  
> -#endif /* CONFIG_PPC_MULTIPLATFORM */
> -
>  unsigned long pci_address_to_pio(phys_addr_t address)
>  {
>  	struct pci_controller *hose, *tmp;
> 
> --
>  Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>       Hannoversche Str. 2, 31134 Hildesheim, Germany
>     Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
