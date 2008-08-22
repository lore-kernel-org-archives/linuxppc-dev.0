Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3C9B7DF0E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 00:03:25 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add AMCC 4XX PCIe MSI support
Date: Fri, 22 Aug 2008 16:03:14 +0200
References: <1219380144-17175-1-git-send-email-fkan@amcc.com>
In-Reply-To: <1219380144-17175-1-git-send-email-fkan@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808221603.14925.arnd@arndb.de>
Cc: Preetesh Parekh <pparekh@amcc.com>,
	Michael Ellerman <michael@ellerman.id.au>, fkan@amcc.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 22 August 2008, fkan@amcc.com wrote:

Have you taken a look at the implementation of
arch/powerpc/platforms/cell/axon_msi.c? I would guess
that it should be possible to unify the code and put
it into sysdev, because both drivers are made for the
same hardware and the differences should all be
abstracted through the device tree already.

> --- a/arch/powerpc/platforms/40x/kilauea.c
> +++ b/arch/powerpc/platforms/40x/kilauea.c
> @@ -22,6 +22,11 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/ppc4xx.h>
>  
> +#ifdef CONFIG_PCI_MSI
> +extern int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> +extern void ppc4xx_teardown_msi_irqs(struct pci_dev *dev);
> +#endif
> +

These declarations need to be in a header file.

> diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
> index 3949289..ee38fb7 100644
> --- a/arch/powerpc/platforms/44x/canyonlands.c
> +++ b/arch/powerpc/platforms/44x/canyonlands.c
> @@ -25,6 +25,12 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/ppc4xx.h>
>  
> +
> +#ifdef CONFIG_PCI_MSI
> +extern int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> +extern void ppc4xx_teardown_msi_irqs(struct pci_dev *dev);
> +#endif
> +
>  static __initdata struct of_device_id canyonlands_of_bus[] = {
>  	{ .compatible = "ibm,plb4", },
>  	{ .compatible = "ibm,opb", },

same here

> @@ -49,6 +55,14 @@ static int __init canyonlands_probe(void)
>  
>  	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
>  
> +#ifdef CONFIG_PCI_MSI
> +	/*
> +	 * Setting callback functions for MSI support
> +	 */
> +	ppc_md.setup_msi_irqs = ppc4xx_setup_msi_irqs;
> +	ppc_md.teardown_msi_irqs = ppc4xx_teardown_msi_irqs;
> +#endif
> +
>  	return 1;
>  }
>  

If the header file looks like

#ifdef CONFIG_PCI_MSI
extern int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
extern void ppc4xx_teardown_msi_irqs(struct pci_dev *dev);
#else
#define ppc4xx_setup_msi_irqs NULL
#define extern void ppc4xx_teardown_msi_irqs NULL
#endif

Then you don't need this #ifdef either.



> diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_pci.c
> index fb368df..bdb3663 100644
> --- a/arch/powerpc/sysdev/ppc4xx_pci.c
> +++ b/arch/powerpc/sysdev/ppc4xx_pci.c
> @@ -35,6 +35,11 @@
>  
>  static int dma_offset_set;
>  
> +#ifdef CONFIG_PCI_MSI
> +#include <linux/msi.h>
> +#include "../../../drivers/pci/msi.h"
> +#endif
> +

#include should not be inside of #ifdef.

You should also not #include a header from another directory through
a relative path. Why do you think you need this?

> @@ -1704,6 +1723,97 @@ static void __init ppc4xx_probe_pciex_bridge(struct device_node *np)
>  	ppc4xx_pciex_port_setup_hose(port);
>  }
>  
> +#ifdef CONFIG_PCI_MSI
> +int ppc4xx_setup_peih(void)
> +{
> +	void __iomem *peih_base;
> +
> +	printk(KERN_INFO " %s \n",__FUNCTION__);	
> +	/* Set base address for PEIH and enable PEIH */
> +	SDR_WRITE(PESDR0_4XX_IHS1, PPC4XX_PEIH_REGBASE_HADDR);	
> +	SDR_WRITE(PESDR0_4XX_IHS2, PPC4XX_PEIH_REGBASE_LADDR);	
> +
> +	/* Map in PCI-E Interrupt Handler Registers */
> +	peih_base = ioremap(PPC4XX_PEIH_REGBASE, PPC4XX_PEIH_REGSIZE);
> +	if(!peih_base) {
> +		printk(KERN_ERR "%s: ioremap64 failed for addr 0x%08x\n",
> +			__FUNCTION__, PPC4XX_PEIH_REGBASE);
> +		return -ENODEV;
> +	}

Please use of_iomap to map the registers on the device.

> +int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> +{

I think this needs to go through ppc_md instead of just overriding
the common function, probably something like

int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
{
	if (ppc_md->setup_msi_irq)
		return ppc_md->setup_msi_irq(dev, desc);

	return 0;
}

So that each platform can provide its own variant of it.

> +int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	struct msi_desc *entry;
> +	int ret;
> +
> +	list_for_each_entry(entry, &dev->msi_list, list) {
> +		ret = arch_setup_msi_irq(dev, entry);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void ppc4xx_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	return;
> +}

These on the other hand don't look platform specific at all,
so maybe you can put them as a generic implementation into
arch/powerpc/kernel/msi.c.

> +#ifdef CONFIG_PCI_MSI
> +	ppc4xx_setup_peih();
> +#endif
> +

Is it ok to call this function unconditionally? I can't see
any check for whether there is an msi-controller device at
all.

>  /*
> + * 4xx PCIe IRQ Handler register definitions
> + */
> +#ifdef CONFIG_PCI_MSI
> +
> +#if defined(CONFIG_405EX)
> +#define PESDR0_4XX_IHS1				0x04B0
> +#define PESDR0_4XX_IHS2				0x04B1
> +#define PPC4XX_PEIH_REGBASE			0x0EF620000
> +#define PPC4XX_PEIH_REGBASE_HADDR   	0x0
> +#define PPC4XX_PEIH_REGBASE_LADDR   	0xEF620000
> +#define PPC4XX_PCIE_MSI_ADDR  			0x080000000
> +#define PPC4XX_PCIE_MSI_HADDR  		0x0
> +#define PPC4XX_PCIE_MSI_LADDR  		0x80000000
> +
> +#elif defined(CONFIG_460EX)
> +#define PESDR0_4XX_IHS1				0x036C
> +#define PESDR0_4XX_IHS2				0x036D
> +#define PPC4XX_PEIH_REGBASE			0xC10000000
> +#define PPC4XX_PEIH_REGBASE_HADDR   	0xC
> +#define PPC4XX_PEIH_REGBASE_LADDR   	0x10000000
> +#define PPC4XX_PCIE_MSI_ADDR  			0xe80000000
> +#define PPC4XX_PCIE_MSI_HADDR  		0xe
> +#define PPC4XX_PCIE_MSI_LADDR  		0x80000000
> +#endif

These should be read from the msi-controller node in the device tree.

> diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
> index 72d2b72..357ba36 100644
> --- a/include/asm-powerpc/dcr-native.h
> +++ b/include/asm-powerpc/dcr-native.h
> @@ -111,6 +111,18 @@ static inline void __dcri_clrset(int base_addr, int base_data, int reg,
>  							      DCRN_ ## base ## _CONFIG_DATA,	\
>  							      reg, clr, set)
>  
> +/* SDR read/write helper macros */
> +
> +#define DCRN_SDR_CONFIG_ADDR    0x00E
> +#define DCRN_SDR_CONFIG_DATA    0x00F
> +
> +#define SDR_READ(offset) ({			\
> +	mtdcr(DCRN_SDR_CONFIG_ADDR, offset);	\
> +	mfdcr(DCRN_SDR_CONFIG_DATA);})
> +#define SDR_WRITE(offset, data) ({		\
> +	mtdcr(DCRN_SDR_CONFIG_ADDR, offset);	\
> +	mtdcr(DCRN_SDR_CONFIG_DATA, data);})
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>  #endif /* _ASM_POWERPC_DCR_NATIVE_H */

You should use dcr_map and friends to find the SDR register and define it in a
platform independent way. There are systems using SDR that do not use dcr-native
but dcr-mmio.

	Arnd <><
