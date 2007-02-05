Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C72DDDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 02:05:28 +1100 (EST)
In-Reply-To: <45C6F464.9010508@freescale.com>
References: <45C6F464.9010508@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BC5F5DDA-2714-49DE-A197-52C3BD600831@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Mon, 5 Feb 2007 09:04:24 -0600
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2007, at 3:09 AM, Li Yang wrote:

You have no description about what this patch does and why its needed.

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/83xx/Kconfig       |    4 ++
> arch/powerpc/platforms/83xx/mpc834x_sys.c |   77 +++++++++++++++++++ 
> ++++++++++
> arch/powerpc/platforms/83xx/mpc834x_sys.h |   23 +++++++++
> 3 files changed, 104 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/ 
> platforms/83xx/Kconfig
> index edcd5b8..5371645 100644
> --- a/arch/powerpc/platforms/83xx/Kconfig
> +++ b/arch/powerpc/platforms/83xx/Kconfig
> @@ -59,4 +59,8 @@ config PPC_MPC836x
> 	select PPC_INDIRECT_PCI
> 	default y if MPC8360E_PB
> +config 834x_USB_SUPPORT
> +	bool
> +	default y if MPC834x_SYS && (USB || USB_GADGET)
> +

Do we really need to introduce a new config option?

> endmenu
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/ 
> powerpc/platforms/83xx/mpc834x_sys.c
> index 80b735a..9b6abe9 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
> @@ -35,14 +35,69 @@
> #include <asm/prom.h>
> #include <asm/udbg.h>
> #include <sysdev/fsl_soc.h>
> +#include <linux/fsl_devices.h>
> #include "mpc83xx.h"
> +#include "mpc834x_sys.h"
> #ifndef CONFIG_PCI
> unsigned long isa_io_base = 0;
> unsigned long isa_mem_base = 0;
> #endif
> +static volatile u8 *bcsr_regs = NULL;
> +
> +#ifdef CONFIG_834x_USB_SUPPORT
> +/* Note: This is only for PB, not for PB+PIB
> + * On PB only port0 is connected using ULPI */
> +static int mpc834x_usb_cfg(void)
> +{
> +	unsigned long sccr, sicrl;
> +	volatile unsigned long *p;
> +	unsigned long __iomem *immap;
> +	struct device_node *np = NULL;
> +	int port0_is_dr = 0;
> +
> +	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) !=  
> NULL)
> +		port0_is_dr = 1;
> +	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) !=  
> NULL){
> +		if (port0_is_dr) {
> +			printk(KERN_WARNING
> +				"There is only one USB port on PB board! \n");
> +			return -1;
> +		} else if (!port0_is_dr)
> +			/* No usb port enabled */
> +			return -1;
> +	}
> +
> +	immap = ioremap(get_immrbase(), 0x100000);

How about checking if ioremap returned something valid.

> +
> +	/* Configure clock */
> +	p = (volatile unsigned long *)((u32)immap + MPC83XX_SCCR_OFFS);
> +	sccr = *p;

Don't do direct pointer access like this, use in_be32/out_be32

> +	if (port0_is_dr)
> +		sccr |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
> +	else
> +		sccr |= MPC83XX_SCCR_USB_MPHCM_11; /* 1:3 */
> +	*p = sccr;
> +
> +	/* Configure Pin */
> +	p = (volatile unsigned long *)((u32)immap + MPC83XX_SICRL_OFFS);
> +	sicrl = *p;
> +	/* set port0 only */
> +	if (port0_is_dr)
> +		sicrl |= MPC83XX_SICRL_USB0;
> +	else
> +		sicrl &= ~(MPC83XX_SICRL_USB0);
> +	*p = sicrl;
> +
> +	iounmap(immap);
> +	return 0;
> +}
> +
> +#endif /* CONFIG_834x_USB_SUPPORT */
> +
> +
> /*  
> ********************************************************************** 
> **
>  *
>  * Setup the architecture
> @@ -65,6 +120,7 @@ static void __init mpc834x_sys_setup_arch(void)
> 			loops_per_jiffy = 50000000 / HZ;
> 		of_node_put(np);
> 	}
> +
> #ifdef CONFIG_PCI
> 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> 		add_bridge(np);
> @@ -72,6 +128,27 @@ static void __init mpc834x_sys_setup_arch(void)
> 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> #endif
> +#ifdef CONFIG_834x_USB_SUPPORT
> +	mpc834x_usb_cfg();
> +
> +	/* Map BCSR area */
> +	np = of_find_node_by_name(NULL, "bcsr");
> +	if (np != 0) {
> +		struct resource res;
> +
> +		of_address_to_resource(np, 0, &res);
> +		bcsr_regs = ioremap(res.start, res.end - res.start + 1);
> +		of_node_put(np);
> +	}
> +
> +	/*
> +	 * if SYS board is plug into PIB board,
> +	 * force to use the PHY on SYS board
> +	 * */
> +	if ((bcsr_regs != NULL) && !(bcsr_regs[5] & BCSR5_INT_USB))
> +		bcsr_regs[5] |= BCSR5_INT_USB;

why not fold all this into mpc834x_usb_cfg() since its all board  
related config code?

iounmap(bcsr) ?

> +#endif
> +
> #ifdef  CONFIG_ROOT_NFS
> 	ROOT_DEV = Root_NFS;
> #else
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.h b/arch/ 
> powerpc/platforms/83xx/mpc834x_sys.h
> index 7d5bbef..c2786fe 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_sys.h
> +++ b/arch/powerpc/platforms/83xx/mpc834x_sys.h
> @@ -20,4 +20,27 @@
> #define PIRQC	MPC83xx_IRQ_EXT6
> #define PIRQD	MPC83xx_IRQ_EXT7
> +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> +#define BCSR_SIZE		((uint)(32 * 1024))
> + +#define BCSR5_OFF		0x05
> +#define BCSR5_INT_USB		0x02
> +
> +#define MPC83XX_SCCR_OFFS          0xA08
> +#define MPC83XX_SCCR_USB_MPHCM_11  0x00c00000
> +#define MPC83XX_SCCR_USB_MPHCM_01  0x00400000
> +#define MPC83XX_SCCR_USB_MPHCM_10  0x00800000
> +#define MPC83XX_SCCR_USB_DRCM_11   0x00300000
> +#define MPC83XX_SCCR_USB_DRCM_01   0x00100000
> +#define MPC83XX_SCCR_USB_DRCM_10   0x00200000
> +
> +/* system i/o configuration register low */
> +#define MPC83XX_SICRL_OFFS         0x114
> +#define MPC83XX_SICRL_USB0         0x40000000
> +#define MPC83XX_SICRL_USB1         0x20000000
> +
> +/* system i/o configuration register high */
> +#define MPC83XX_SICRH_OFFS         0x118
> +#define MPC83XX_SICRH_USB_UTMI     0x00020000

You should stick these defines in mpc83xx.h so they are available to  
everyone.

- k
