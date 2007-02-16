Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB324DDD03
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 14:34:53 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0702152046450.9034@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0702152046450.9034@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6B5E8843-06EF-4BD8-BB09-27D4D0607D16@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC 7/7] Unite all PCI-e on 85xx and 86xx under one codebase
Date: Thu, 15 Feb 2007 21:33:56 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/ 
> pci_32.c
> index d8ef2e1..29243ed 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -81,7 +81,18 @@ fixup_cpc710_pci64(struct pci_dev* dev)
>  	dev->resource[1].start = dev->resource[1].end = 0;
>  	dev->resource[1].flags = 0;
>  }
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,	 
> PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_IBM,  
> PCI_DEVICE_ID_IBM_CPC710_PCI64, fixup_cpc710_pci64);
> +
> +static void __devinit skip_fake_bridge(struct pci_dev *dev)
> +{
> +	/* Make it an error to skip the fake bridge
> +	 * in pci_setup_device() in probe.c */
> +	dev->hdr_type = 0x7f;
> +}
> +DECLARE_PCI_FIXUP_EARLY(0x1957, 0x3fff, skip_fake_bridge);
> +DECLARE_PCI_FIXUP_EARLY(0x3fff, 0x1957, skip_fake_bridge);
> +DECLARE_PCI_FIXUP_EARLY(0xff3f, 0x5719, skip_fake_bridge);
> +

What is this all about?  And what's with the various munging going on  
with the vendor and device IDs?

> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/ 
> powerpc/platforms/85xx/mpc85xx_cds.c
> index 2027855..dc8ddde 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
> @@ -65,18 +65,7 @@ extern int mpc85xx_pci2_busno;
>
>  static int mpc85xx_exclude_device(u_char bus, u_char devfn)
>  {
> -	if (bus == 0 && PCI_SLOT(devfn) == 0)
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -	if (mpc85xx_pci2_busno)
> -		if (bus == (mpc85xx_pci2_busno) && PCI_SLOT(devfn) == 0)
> -			return PCIBIOS_DEVICE_NOT_FOUND;
> -	/* We explicitly do not go past the Tundra 320 Bridge */
> -	if ((bus == 1) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
> -		return PCIBIOS_DEVICE_NOT_FOUND;
> -	else
> -		return PCIBIOS_SUCCESSFUL;
> +	return PCIBIOS_SUCCESSFUL;
>  }

If you are going to always return PCIBIOS_SUCCESSFUL, just get ride  
of the function completely.

>
>  void __init
> diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/ 
> platforms/85xx/pci.c
> index 5c70797..8afb74f 100644
> --- a/arch/powerpc/platforms/85xx/pci.c
> +++ b/arch/powerpc/platforms/85xx/pci.c
> @@ -137,7 +137,6 @@ int __init add_bridge(struct device_node
>  	struct pci_controller *hose;
>  	struct resource rsrc;
>  	const int *bus_range;
> -	unsigned int temp;
>  	int primary = 1, has_address = 0;
>  	phys_addr_t immr = get_immrbase();
>
> @@ -177,12 +176,10 @@ int __init add_bridge(struct device_node
>  	if ((rsrc.start & 0xfffff) == 0xa000) {
>  		setup_indirect_pcie(hose, immr + 0xa000, immr + 0xa004);
>  		mpc85xx_setup_pcie(hose);
> -		primary = 1;
> +		primary = 0;
>  		hose->bus_offset = hose->first_busno;
>  		/* Setup PEX window registers */
>  		setup_pcie_atmu(hose, &rsrc);
> -		early_read_config_dword(hose, 0, 0, 0x404, &temp);
> -		printk("Reg 0x404 is 0x%x\n",temp);

having this patch clean stuff others added is fun :)

- k
