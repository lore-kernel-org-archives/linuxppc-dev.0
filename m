Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 02AB52C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 05:04:02 +1000 (EST)
Subject: Re: [PATCH V5 2/3] powerpc/swiotlb: Enable at early stage and disable
 if not necessary
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1343988851-884-3-git-send-email-B38951@freescale.com>
Date: Wed, 8 Aug 2012 14:03:45 -0500
Message-Id: <66F04906-39B4-493D-8C63-202112AB1EA3@kernel.crashing.org>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-3-git-send-email-B38951@freescale.com>
To: Josh Boyer <jwboyer@gmail.com>, Tony Breeds <tony@bakeyournoodle.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 3, 2012, at 5:14 AM, Jia Hongtao wrote:

> Remove the dependency on PCI initialization for SWIOTLB =
initialization.
> So that PCI can be initialized at proper time.
>=20
> SWIOTLB is partly determined by PCI inbound/outbound map which is =
assigned
> in PCI initialization. But swiotlb_init() should be done at the stage =
of
> mem_init() which is much earlier than PCI initialization. So we =
reserve the
> memory for SWIOTLB first and free it if not necessary.
>=20
> All boards are converted to fit this change.
>=20
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/include/asm/swiotlb.h       |    6 ++++++
> arch/powerpc/kernel/dma-swiotlb.c        |   20 ++++++++++++++++++++
> arch/powerpc/mm/mem.c                    |    3 +--
> arch/powerpc/platforms/44x/currituck.c   |   10 ++--------
> arch/powerpc/platforms/85xx/mpc85xx_ds.c |    1 +
> arch/powerpc/platforms/85xx/qemu_e500.c  |    1 +
> arch/powerpc/sysdev/fsl_pci.c            |    5 +----
> 7 files changed, 32 insertions(+), 14 deletions(-)

Josh, Tony

Can you ack the 44x/currituck.c change.

thanks

- k

>=20
> diff --git a/arch/powerpc/include/asm/swiotlb.h =
b/arch/powerpc/include/asm/swiotlb.h
> index 8979d4c..de99d6e 100644
> --- a/arch/powerpc/include/asm/swiotlb.h
> +++ b/arch/powerpc/include/asm/swiotlb.h
> @@ -22,4 +22,10 @@ int __init swiotlb_setup_bus_notifier(void);
>=20
> extern void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev);
>=20
> +#ifdef CONFIG_SWIOTLB
> +void swiotlb_detect_4g(void);
> +#else
> +static inline void swiotlb_detect_4g(void) {}
> +#endif
> +
> #endif /* __ASM_SWIOTLB_H */
> diff --git a/arch/powerpc/kernel/dma-swiotlb.c =
b/arch/powerpc/kernel/dma-swiotlb.c
> index 4ab88da..aa85550 100644
> --- a/arch/powerpc/kernel/dma-swiotlb.c
> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> @@ -104,3 +104,23 @@ int __init swiotlb_setup_bus_notifier(void)
> 			      &ppc_swiotlb_plat_bus_notifier);
> 	return 0;
> }
> +
> +void swiotlb_detect_4g(void)
> +{
> +	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
> +		ppc_swiotlb_enable =3D 1;
> +}
> +
> +static int __init swiotlb_late_init(void)
> +{
> +	if (ppc_swiotlb_enable) {
> +		swiotlb_print_info();
> +		set_pci_dma_ops(&swiotlb_dma_ops);
> +		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> +	} else {
> +		swiotlb_free();
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall(swiotlb_late_init);
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index baaafde..f23c4e0 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -300,8 +300,7 @@ void __init mem_init(void)
> 	unsigned long reservedpages =3D 0, codesize, initsize, datasize, =
bsssize;
>=20
> #ifdef CONFIG_SWIOTLB
> -	if (ppc_swiotlb_enable)
> -		swiotlb_init(1);
> +	swiotlb_init(0);
> #endif
>=20
> 	num_physpages =3D memblock_phys_mem_size() >> PAGE_SHIFT;
> diff --git a/arch/powerpc/platforms/44x/currituck.c =
b/arch/powerpc/platforms/44x/currituck.c
> index 9f6c33d..6bd89a0 100644
> --- a/arch/powerpc/platforms/44x/currituck.c
> +++ b/arch/powerpc/platforms/44x/currituck.c
> @@ -21,7 +21,6 @@
>  */
>=20
> #include <linux/init.h>
> -#include <linux/memblock.h>
> #include <linux/of.h>
> #include <linux/of_platform.h>
> #include <linux/rtc.h>
> @@ -159,13 +158,8 @@ static void __init ppc47x_setup_arch(void)
>=20
> 	/* No need to check the DMA config as we /know/ our windows are =
all of
>  	 * RAM.  Lets hope that doesn't change */
> -#ifdef CONFIG_SWIOTLB
> -	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
> -		ppc_swiotlb_enable =3D 1;
> -		set_pci_dma_ops(&swiotlb_dma_ops);
> -		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> -	}
> -#endif
> +	swiotlb_detect_4g();
> +
> 	ppc47x_smp_init();
> }
>=20
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c =
b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> index 6d3265f..56f8c8f 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> @@ -159,6 +159,7 @@ static void __init mpc85xx_ds_setup_arch(void)
> 	if (ppc_md.progress)
> 		ppc_md.progress("mpc85xx_ds_setup_arch()", 0);
>=20
> +	swiotlb_detect_4g();
> 	mpc85xx_ds_pci_init();
> 	mpc85xx_smp_init();
>=20
> diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c =
b/arch/powerpc/platforms/85xx/qemu_e500.c
> index 95a2e53..3c5490c 100644
> --- a/arch/powerpc/platforms/85xx/qemu_e500.c
> +++ b/arch/powerpc/platforms/85xx/qemu_e500.c
> @@ -42,6 +42,7 @@ static void __init qemu_e500_setup_arch(void)
> 	ppc_md.progress("qemu_e500_setup_arch()", 0);
>=20
> 	fsl_pci_init();
> +	swiotlb_detect_4g();
> 	mpc85xx_smp_init();
> }
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c =
b/arch/powerpc/sysdev/fsl_pci.c
> index 6938792..da7a3d7 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -872,11 +872,8 @@ void __devinit fsl_pci_init(void)
> 	 * we need SWIOTLB to handle buffers located outside of
> 	 * dma capable memory region
> 	 */
> -	if (memblock_end_of_DRAM() - 1 > max) {
> +	if (memblock_end_of_DRAM() - 1 > max)
> 		ppc_swiotlb_enable =3D 1;
> -		set_pci_dma_ops(&swiotlb_dma_ops);
> -		ppc_md.pci_dma_dev_setup =3D pci_dma_dev_setup_swiotlb;
> -	}
> #endif
> }
> #endif
> --=20
> 1.7.5.1
>=20
