Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A992DDF8C
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 15:57:52 +1000 (EST)
Message-Id: <A254D12F-2709-48BB-8E7B-2F82D45D1372@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0904291546130.19681@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC][PATCH] powerpc/pci: Pull ppc32 code we need in ppc64
Date: Wed, 20 May 2009 00:57:44 -0500
References: <Pine.LNX.4.64.0904291546130.19681@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Comments on the pmac case?

- k

On Apr 29, 2009, at 3:49 PM, Kumar Gala wrote:

> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>
> Ben,
>
> My question is if we think fake_pci_bus will always get a valid  
> hose().
> The users of EARLY_PCI_OP are fsl/8xxx, 4xx, and pmac.  I verified  
> that
> fsl/8xxx & 4xx pass a valid hose.  Do we think pmac does?
>
> - k
>
> arch/powerpc/include/asm/machdep.h    |    6 +-
> arch/powerpc/include/asm/pci-bridge.h |   35 +++++++---------
> arch/powerpc/kernel/pci-common.c      |   70 ++++++++++++++++++++++++ 
> ++++++++
> arch/powerpc/kernel/pci_32.c          |   71  
> ---------------------------------
> 4 files changed, 89 insertions(+), 93 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/ 
> include/asm/machdep.h
> index 0efdb1d..1b389ff 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -205,14 +205,14 @@ struct machdep_calls {
> 	/*
> 	 * optional PCI "hooks"
> 	 */
> -	/* Called in indirect_* to avoid touching devices */
> -	int (*pci_exclude_device)(struct pci_controller *, unsigned char,  
> unsigned char);
> -
> 	/* Called at then very end of pcibios_init() */
> 	void (*pcibios_after_init)(void);
>
> #endif /* CONFIG_PPC32 */
>
> +	/* Called in indirect_* to avoid touching devices */
> +	int (*pci_exclude_device)(struct pci_controller *, unsigned char,  
> unsigned char);
> +
> 	/* Called after PPC generic resource fixup to perform
> 	   machine specific fixups */
> 	void (*pcibios_fixup_resources)(struct pci_dev *);
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/ 
> include/asm/pci-bridge.h
> index 48f58aa..8b371df 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -77,9 +77,7 @@ struct pci_controller {
>
> 	int first_busno;
> 	int last_busno;
> -#ifndef CONFIG_PPC64
> 	int self_busno;
> -#endif
>
> 	void __iomem *io_base_virt;
> #ifdef CONFIG_PPC64
> @@ -104,7 +102,6 @@ struct pci_controller {
> 	unsigned int __iomem *cfg_addr;
> 	void __iomem *cfg_data;
>
> -#ifndef CONFIG_PPC64
> 	/*
> 	 * Used for variants of PCI indirect handling and possible quirks:
> 	 *  SET_CFG_TYPE - used on 4xx or any PHB that does explicit type0/1
> @@ -128,7 +125,6 @@ struct pci_controller {
> #define PPC_INDIRECT_TYPE_BIG_ENDIAN		0x00000010
> #define PPC_INDIRECT_TYPE_BROKEN_MRM		0x00000020
> 	u32 indirect_type;
> -#endif	/* !CONFIG_PPC64 */
> 	/* Currently, we limit ourselves to 1 IO range and 3 mem
> 	 * ranges since the common pci_bus structure can't handle more
> 	 */
> @@ -146,21 +142,6 @@ struct pci_controller {
> #endif	/* CONFIG_PPC64 */
> };
>
> -#ifndef CONFIG_PPC64
> -
> -static inline struct pci_controller *pci_bus_to_host(const struct  
> pci_bus *bus)
> -{
> -	return bus->sysdata;
> -}
> -
> -static inline int isa_vaddr_is_ioport(void __iomem *address)
> -{
> -	/* No specific ISA handling on ppc32 at this stage, it
> -	 * all goes through PCI
> -	 */
> -	return 0;
> -}
> -
> /* These are used for config access before all the PCI probing
>   has been done. */
> extern int early_read_config_byte(struct pci_controller *hose, int  
> bus,
> @@ -182,6 +163,22 @@ extern int early_find_capability(struct  
> pci_controller *hose, int bus,
> extern void setup_indirect_pci(struct pci_controller* hose,
> 			       resource_size_t cfg_addr,
> 			       resource_size_t cfg_data, u32 flags);
> +
> +#ifndef CONFIG_PPC64
> +
> +static inline struct pci_controller *pci_bus_to_host(const struct  
> pci_bus *bus)
> +{
> +	return bus->sysdata;
> +}
> +
> +static inline int isa_vaddr_is_ioport(void __iomem *address)
> +{
> +	/* No specific ISA handling on ppc32 at this stage, it
> +	 * all goes through PCI
> +	 */
> +	return 0;
> +}
> +
> #else	/* CONFIG_PPC64 */
>
> /*
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/ 
> pci-common.c
> index 9c69e7e..cae4ee1 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1620,3 +1620,73 @@ void __devinit  
> pcibios_setup_phb_resources(struct pci_controller *hose)
>
> }
>
> +/*
> + * Null PCI config access functions, for the case when we can't
> + * find a hose.
> + */
> +#define NULL_PCI_OP(rw, size, type)					\
> +static int								\
> +null_##rw##_config_##size(struct pci_dev *dev, int offset, type  
> val)	\
> +{									\
> +	return PCIBIOS_DEVICE_NOT_FOUND;    				\
> +}
> +
> +static int
> +null_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
> +		 int len, u32 *val)
> +{
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +static int
> +null_write_config(struct pci_bus *bus, unsigned int devfn, int  
> offset,
> +		  int len, u32 val)
> +{
> +	return PCIBIOS_DEVICE_NOT_FOUND;
> +}
> +
> +static struct pci_ops null_pci_ops =
> +{
> +	.read = null_read_config,
> +	.write = null_write_config,
> +};
> +
> +/*
> + * These functions are used early on before PCI scanning is done
> + * and all of the pci_dev and pci_bus structures have been created.
> + */
> +static struct pci_bus *
> +fake_pci_bus(struct pci_controller *hose, int busnr)
> +{
> +	static struct pci_bus bus;
> +
> +	if (hose == 0) {
> +		printk(KERN_ERR "Can't find hose for PCI bus %d!\n", busnr);
> +	}
> +	bus.number = busnr;
> +	bus.sysdata = hose;
> +	bus.ops = hose? hose->ops: &null_pci_ops;
> +	return &bus;
> +}
> +
> +#define EARLY_PCI_OP(rw, size, type)					\
> +int early_##rw##_config_##size(struct pci_controller *hose, int  
> bus,	\
> +			       int devfn, int offset, type value)	\
> +{									\
> +	return pci_bus_##rw##_config_##size(fake_pci_bus(hose, bus),	\
> +					    devfn, offset, value);	\
> +}
> +
> +EARLY_PCI_OP(read, byte, u8 *)
> +EARLY_PCI_OP(read, word, u16 *)
> +EARLY_PCI_OP(read, dword, u32 *)
> +EARLY_PCI_OP(write, byte, u8)
> +EARLY_PCI_OP(write, word, u16)
> +EARLY_PCI_OP(write, dword, u32)
> +
> +extern int pci_bus_find_capability (struct pci_bus *bus, unsigned  
> int devfn, int cap);
> +int early_find_capability(struct pci_controller *hose, int bus, int  
> devfn,
> +			  int cap)
> +{
> +	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
> +}
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/ 
> pci_32.c
> index d473634..32fbadb 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -497,75 +497,4 @@ long sys_pciconfig_iobase(long which, unsigned  
> long bus, unsigned long devfn)
> 	return result;
> }
>
> -/*
> - * Null PCI config access functions, for the case when we can't
> - * find a hose.
> - */
> -#define NULL_PCI_OP(rw, size, type)					\
> -static int								\
> -null_##rw##_config_##size(struct pci_dev *dev, int offset, type  
> val)	\
> -{									\
> -	return PCIBIOS_DEVICE_NOT_FOUND;    				\
> -}
> -
> -static int
> -null_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
> -		 int len, u32 *val)
> -{
> -	return PCIBIOS_DEVICE_NOT_FOUND;
> -}
> -
> -static int
> -null_write_config(struct pci_bus *bus, unsigned int devfn, int  
> offset,
> -		  int len, u32 val)
> -{
> -	return PCIBIOS_DEVICE_NOT_FOUND;
> -}
> -
> -static struct pci_ops null_pci_ops =
> -{
> -	.read = null_read_config,
> -	.write = null_write_config,
> -};
>
> -/*
> - * These functions are used early on before PCI scanning is done
> - * and all of the pci_dev and pci_bus structures have been created.
> - */
> -static struct pci_bus *
> -fake_pci_bus(struct pci_controller *hose, int busnr)
> -{
> -	static struct pci_bus bus;
> -
> -	if (hose == 0) {
> -		hose = pci_bus_to_hose(busnr);
> -		if (hose == 0)
> -			printk(KERN_ERR "Can't find hose for PCI bus %d!\n", busnr);
> -	}
> -	bus.number = busnr;
> -	bus.sysdata = hose;
> -	bus.ops = hose? hose->ops: &null_pci_ops;
> -	return &bus;
> -}
> -
> -#define EARLY_PCI_OP(rw, size, type)					\
> -int early_##rw##_config_##size(struct pci_controller *hose, int  
> bus,	\
> -			       int devfn, int offset, type value)	\
> -{									\
> -	return pci_bus_##rw##_config_##size(fake_pci_bus(hose, bus),	\
> -					    devfn, offset, value);	\
> -}
> -
> -EARLY_PCI_OP(read, byte, u8 *)
> -EARLY_PCI_OP(read, word, u16 *)
> -EARLY_PCI_OP(read, dword, u32 *)
> -EARLY_PCI_OP(write, byte, u8)
> -EARLY_PCI_OP(write, word, u16)
> -EARLY_PCI_OP(write, dword, u32)
> -
> -extern int pci_bus_find_capability (struct pci_bus *bus, unsigned  
> int devfn, int cap);
> -int early_find_capability(struct pci_controller *hose, int bus, int  
> devfn,
> -			  int cap)
> -{
> -	return pci_bus_find_capability(fake_pci_bus(hose, bus), devfn, cap);
> -}
> -- 
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
