In-Reply-To: <1087746455.1547.23.camel@newt>
References: <1087746455.1547.23.camel@newt>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <282B6E73-C58F-11D8-9384-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>,
	"Kumar K. Gala" <kumar.gala@motorola.com>, <mgreer@mvista.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH][RFC] Second version of MPC10x OCP
Date: Wed, 23 Jun 2004 22:32:45 -0500
To: Adrian Cox <adrian@humboldt.co.uk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jun 20, 2004, at 10:47 AM, Adrian Cox wrote:

> Here's the second version of OCP-ifying the mpc10x. I've removed the
> hardcoded positions in the core_ocp array, and I've added the DMA
> devices in case anybody needs them. I haven't yet tested the I2C driver
> from 2.4, but I've put in the flags field for it.
> - Adrian Cox
> Humboldt Solutions Ltd.
>
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/06/20 16:25:45+01:00 adrian@humboldt.co.uk
> #   Add OCP code for MPC10x, and a common Openpic setup routine.
> #
> # include/asm-ppc/mpc10x.h
> #   2004/06/20 16:25:10+01:00 adrian@humboldt.co.uk +3 -0
> #   Add Openpic setup routine.
> #
> # arch/ppc/syslib/mpc10x_common.c
> #   2004/06/20 16:25:10+01:00 adrian@humboldt.co.uk +79 -2
> #   Add MPC10x OCP code, and a standard Openpic setup routine.
> #
> # arch/ppc/syslib/Makefile
> #   2004/06/20 16:25:10+01:00 adrian@humboldt.co.uk +4 -4
> #   Add common MPC10x openpic config option.
> #
> # arch/ppc/platforms/sandpoint.c
> #   2004/06/20 16:25:10+01:00 adrian@humboldt.co.uk +1 -11
> #   Use common Openpic setup.
> #
> # arch/ppc/platforms/powerpmc250.c
> #   2004/06/20 16:25:10+01:00 adrian@humboldt.co.uk +1 -1
> #   Use common Openpic setup.
> #
> # arch/ppc/platforms/lopec_setup.c
> #   2004/06/20 16:25:10+01:00 adrian@humboldt.co.uk +1 -14
> #   Use common Openpic setup.
> #
> # arch/ppc/Kconfig
> #   2004/06/20 16:25:10+01:00 adrian@humboldt.co.uk +10 -0
> #   Add OCP and common Openpic code for MPC10x boards.
> #
> diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
> --- a/arch/ppc/Kconfig	Sun Jun 20 16:40:17 2004
> +++ b/arch/ppc/Kconfig	Sun Jun 20 16:40:17 2004
> @@ -685,6 +685,16 @@
>  	depends on PCORE || POWERPMC250 || LOPEC || SANDPOINT
>  	default y
>
> +config FSL_OCP
> +	bool
> +	depends on MPC10X_BRIDGE
> +	default y
> +
> +config MPC10X_OPENPIC
> +	bool
> +	depends on POWERPMC250 || LOPEC || SANDPOINT
> +	default y
> +
>  config MPC10X_STORE_GATHERING
>  	bool "Enable MPC10x store gathering"
>  	depends on MPC10X_BRIDGE
> diff -Nru a/arch/ppc/platforms/lopec_setup.c
> b/arch/ppc/platforms/lopec_setup.c
> --- a/arch/ppc/platforms/lopec_setup.c	Sun Jun 20 16:40:17 2004
> +++ b/arch/ppc/platforms/lopec_setup.c	Sun Jun 20 16:40:17 2004
> @@ -193,21 +193,8 @@
>  	OpenPIC_InitSenses = lopec_openpic_initsenses;
>  	OpenPIC_NumInitSenses = sizeof(lopec_openpic_initsenses);
>
> -	/*
> -	 * We need to tell openpic_set_sources where things actually are.
> -	 * mpc10x_common will setup OpenPIC_Addr at ioremap(EUMB phys base +
> -	 * EPIC offset (0x40000));  The EPIC IRQ Register Address Map -
> -	 * Interrupt Source Configuration Registers gives these numbers
> -	 * as offsets starting at 0x50200, we need to adjust occordinly.
> -	 */
> -	/* Map serial interrupts 0-15 */
> -	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
> -	/* Skip reserved space and map i2c and DMA Ch[01] */
> -	openpic_set_sources(16, 3, OpenPIC_Addr + 0x11020);
> -	/* Skip reserved space and map Message Unit Interrupt (I2O) */
> -	openpic_set_sources(19, 1, OpenPIC_Addr + 0x110C0);
> +	mpc10x_set_openpic();
>
> -	openpic_init(NUM_8259_INTERRUPTS);
>  	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
>  	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
>  			&i8259_irq);
> diff -Nru a/arch/ppc/platforms/powerpmc250.c
> b/arch/ppc/platforms/powerpmc250.c
> --- a/arch/ppc/platforms/powerpmc250.c	Sun Jun 20 16:40:17 2004
> +++ b/arch/ppc/platforms/powerpmc250.c	Sun Jun 20 16:40:17 2004
> @@ -197,7 +197,7 @@
>
>  	OpenPIC_InitSenses = powerpmc250_openpic_initsenses;
>  	OpenPIC_NumInitSenses = sizeof(powerpmc250_openpic_initsenses);
> -	openpic_init(1, 0, 0, -1);
> +	mpc10x_set_openpic();
>  }
>
>  /*
> diff -Nru a/arch/ppc/platforms/sandpoint.c
> b/arch/ppc/platforms/sandpoint.c
> --- a/arch/ppc/platforms/sandpoint.c	Sun Jun 20 16:40:17 2004
> +++ b/arch/ppc/platforms/sandpoint.c	Sun Jun 20 16:40:17 2004
> @@ -433,17 +433,7 @@
>  	OpenPIC_InitSenses = sandpoint_openpic_initsenses;
>  	OpenPIC_NumInitSenses = sizeof(sandpoint_openpic_initsenses);
>
> -	/*
> -	 * We need to tell openpic_set_sources where things actually are.
> -	 * mpc10x_common will setup OpenPIC_Addr at ioremap(EUMB phys base +
> -	 * EPIC offset (0x40000));  The EPIC IRQ Register Address Map -
> -	 * Interrupt Source Configuration Registers gives these numbers
> -	 * as offsets starting at 0x50200, we need to adjust occordinly.
> -	 */
> -	/* Map serial interrupts 0-15 */
> -	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10200);
> -
> -	openpic_init(NUM_8259_INTERRUPTS);
> +	mpc10x_set_openpic();
>  	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
>  			i8259_irq);
>
> diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
> --- a/arch/ppc/syslib/Makefile	Sun Jun 20 16:40:17 2004
> +++ b/arch/ppc/syslib/Makefile	Sun Jun 20 16:40:17 2004
> @@ -51,7 +51,7 @@
>  obj-$(CONFIG_GEMINI)		+= open_pic.o indirect_pci.o
>  obj-$(CONFIG_K2)		+= i8259.o indirect_pci.o todc_time.o \
>  					pci_auto.o
> -obj-$(CONFIG_LOPEC)		+= pci_auto.o open_pic.o i8259.o todc_time.o
> +obj-$(CONFIG_LOPEC)		+= i8259.o pci_auto.o todc_time.o
>  obj-$(CONFIG_MCPN765)		+= todc_time.o indirect_pci.o pci_auto.o \
>  					open_pic.o i8259.o hawk_common.o
>  obj-$(CONFIG_MENF1)		+= todc_time.o i8259.o mpc10x_common.o \
> @@ -61,15 +61,14 @@
>  obj-$(CONFIG_OCOTEA)		+= indirect_pci.o pci_auto.o todc_time.o
>  obj-$(CONFIG_PAL4)		+= cpc700_pic.o
>  obj-$(CONFIG_PCORE)		+= todc_time.o i8259.o pci_auto.o
> -obj-$(CONFIG_POWERPMC250)	+= open_pic.o pci_auto.o
> +obj-$(CONFIG_POWERPMC250)	+= pci_auto.o
>  obj-$(CONFIG_PPLUS)		+= hawk_common.o open_pic.o i8259.o \
>  				   indirect_pci.o todc_time.o pci_auto.o
>  obj-$(CONFIG_PRPMC750)		+= open_pic.o indirect_pci.o pci_auto.o \
>  					hawk_common.o
>  obj-$(CONFIG_HARRIER)		+= harrier.o
>  obj-$(CONFIG_PRPMC800)		+= open_pic.o indirect_pci.o pci_auto.o
> -obj-$(CONFIG_SANDPOINT)		+= i8259.o open_pic.o pci_auto.o todc_time.o
> +obj-$(CONFIG_SANDPOINT)		+= i8259.o pci_auto.o todc_time.o
>  obj-$(CONFIG_SBC82xx)		+= todc_time.o
>  obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
>  				   todc_time.o
> @@ -80,6 +79,7 @@
>  endif
>  obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
>  obj-$(CONFIG_MPC10X_BRIDGE)     += mpc10x_common.o indirect_pci.o
> +obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
>  obj-$(CONFIG_40x)		+= dcr.o
>  obj-$(CONFIG_BOOKE)		+= dcr.o
>  obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o
> diff -Nru a/arch/ppc/syslib/mpc10x_common.c
> b/arch/ppc/syslib/mpc10x_common.c
> --- a/arch/ppc/syslib/mpc10x_common.c	Sun Jun 20 16:40:17 2004
> +++ b/arch/ppc/syslib/mpc10x_common.c	Sun Jun 20 16:40:17 2004
> @@ -30,7 +30,60 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/open_pic.h>
>  #include <asm/mpc10x.h>
> +#include <asm/ocp.h>
>
> +/* The OCP structure is fixed by code below, before OCP initialises.
> +   paddr depends on where the board places the EUMB.
> +    - fixed in mpc10x_bridge_init().
> +   irq depends on two things:
> +    > does the board use the EPIC at all? (PCORE does not).
> +    > is the EPIC in serial or parallel mode?
> +    - fixed in mpc10x_set_openpic().
> +*/
> +
> +#ifdef CONFIG_MPC10X_OPENPIC
> +#ifdef CONFIG_EPIC_SERIAL_MODE
> +#define EPIC_IRQ_BASE 16
> +#else
> +#define EPIC_IRQ_BASE 5
> +#endif
> +#define MPC10X_I2C_IRQ (EPIC_IRQ_BASE + NUM_8259_INTERRUPTS)
> +#define MPC10X_DMA0_IRQ (EPIC_IRQ_BASE + 1 + NUM_8259_INTERRUPTS)
> +#define MPC10X_DMA1_IRQ (EPIC_IRQ_BASE + 2 + NUM_8259_INTERRUPTS)
> +#else
> +#define MPC10X_I2C_IRQ OCP_IRQ_NA
> +#define MPC10X_DMA0_IRQ OCP_IRQ_NA
> +#define MPC10X_DMA1_IRQ OCP_IRQ_NA
> +#endif
> +
> +
> +struct ocp_def core_ocp[] = {
> +	{ .vendor	= OCP_VENDOR_INVALID
> +	}
> +};
> +

In 85xx we would put paddr in the structs and have them as offsets from
EUMBAR.  Then we can fixup all the devices in a simple loop.

> +static struct ocp_fs_i2c_data mpc10x_i2c_data = {
> +	.flags		= FS_I2C_32BIT
> +};
> +static struct ocp_def mpc10x_i2c_ocp = {
> +	.vendor		= OCP_VENDOR_MOTOROLA,
> +	.function	= OCP_FUNC_IIC,
> +	.index		= 0,
> +	.irq		= MPC10X_I2C_IRQ,
> +	.additions	= &mpc10x_i2c_data
> +};
> +

Interesting, you went and made each channel a device.  I dont have a
'real' driver for DMA on 85xx and only made a single device hmm, I
think I like the idea of make each channel its own 'device'.

> +static struct ocp_def mpc10x_dma_ocp[2] = {
> +{	.vendor		= OCP_VENDOR_MOTOROLA,
> +	.function	= OCP_FUNC_DMA,
> +	.index		= 0,
> +	.irq		= MPC10X_DMA0_IRQ
> +},
> +{	.vendor		= OCP_VENDOR_MOTOROLA,
> +	.function	= OCP_FUNC_DMA,
> +	.index		= 1,
> +	.irq		= MPC10X_DMA1_IRQ }
> +};
>
>  /* Set resources to match bridge memory map */
>  void __init
> @@ -231,11 +284,21 @@
>  					 PCI_DEVFN(0,0),
>  					 MPC10X_CFG_EUMBBAR,
>  					 phys_eumb_base);
> -
> -		/* Map EPIC register part of EUMB into vitual memory */
> +#ifdef CONFIG_MPC10X_OPENPIC
> +		/* Map EPIC register part of EUMB into vitual memory  - PCORE
> +		   uses an i8259 instead of EPIC. */
>  		OpenPIC_Addr =
>  			ioremap(phys_eumb_base + MPC10X_EUMB_EPIC_OFFSET,
>  				MPC10X_EUMB_EPIC_SIZE);
> +#endif

I'm confused are we adding the OCP struct for every 10x device?  Did we
get closure on the question if 105, 106 & 8240 would also work?  If so
I would suggest doing the following:

struct ocp_def core_ocp[] = {
  {	.vendor		= OCP_VENDOR_MOTOROLA,
	.function	= OCP_FUNC_IIC,
	.index		= 0,
	.irq		= MPC10X_I2C_IRQ,
	.additions	= &mpc10x_i2c_data,
	.paddr = MPC10X_EUMB_I2C_OFFSET
  },
  {	.vendor		= OCP_VENDOR_MOTOROLA,
  	.function	= OCP_FUNC_DMA,
  	.index		= 0,
  	.irq		= MPC10X_DMA0_IRQ,
	.paddr = MPC10X_EUMB_DMA_OFFSET + 0x100
  },
  {	.vendor		= OCP_VENDOR_MOTOROLA,
  	.function	= OCP_FUNC_DMA,
  	.index		= 1,
  	.irq		= MPC10X_DMA1_IRQ,
	.paddr = MPC10X_EUMB_DMA_OFFSET + 0x200
  },
};


> +		mpc10x_i2c_ocp.paddr = phys_eumb_base + MPC10X_EUMB_I2C_OFFSET;
> +		ocp_add_one_device(&mpc10x_i2c_ocp);
> +		mpc10x_dma_ocp[0].paddr = phys_eumb_base +
> +					MPC10X_EUMB_DMA_OFFSET + 0x100;
> +		ocp_add_one_device(&mpc10x_dma_ocp[0]);
> +		mpc10x_dma_ocp[1].paddr = phys_eumb_base +
> +					MPC10X_EUMB_DMA_OFFSET + 0x200;
> +		ocp_add_one_device(&mpc10x_dma_ocp[1]);
>  	}
>
>  #ifdef CONFIG_MPC10X_STORE_GATHERING
> @@ -397,3 +460,17 @@
>
>  	return 0;
>  }
> +
> +#ifdef CONFIG_MPC10X_OPENPIC
> +void __init mpc10x_set_openpic(void)
> +{
> +	/* Map external IRQs */
> +	openpic_set_sources(0, EPIC_IRQ_BASE, OpenPIC_Addr + 0x10200);
> +	/* Skip reserved space and map i2c and DMA Ch[01] */
> +	openpic_set_sources(EPIC_IRQ_BASE, 3, OpenPIC_Addr + 0x11020);
> +	/* Skip reserved space and map Message Unit Interrupt (I2O) */
> +	openpic_set_sources(EPIC_IRQ_BASE + 3, 1, OpenPIC_Addr + 0x110C0);
> +
> +	openpic_init(NUM_8259_INTERRUPTS);
> +}
> +#endif
> diff -Nru a/include/asm-ppc/mpc10x.h b/include/asm-ppc/mpc10x.h
> --- a/include/asm-ppc/mpc10x.h	Sun Jun 20 16:40:17 2004
> +++ b/include/asm-ppc/mpc10x.h	Sun Jun 20 16:40:17 2004
> @@ -164,4 +164,7 @@
>  int mpc10x_enable_store_gathering(struct pci_controller *hose);
>  int mpc10x_disable_store_gathering(struct pci_controller *hose);
>
> +/* For MPC107 boards that use the built-in openpic */
> +void mpc10x_set_openpic(void);
> +
>  #endif	/* __PPC_KERNEL_MPC10X_H */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
