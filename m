Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6B57A67A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 05:41:56 +1100 (EST)
Date: Tue, 15 Mar 2005 10:41:53 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Message-ID: <20050315184153.GB28823@gate.ebshome.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1110907039.24673.12.camel@rhino.az.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2005 at 10:17:19AM -0700, Wade Farnsworth wrote:
> Hello all,
> 
> This adds support for the IBM/AMCC PPC440EP SoC and the Bamboo reference
> board.  Any comments would be appreciated.

[snip]

> diff -uprN linux-2.6.11-bk7/arch/ppc/platforms/4xx/ibm440ep.c linux-2.6.11-bk7-440ep/arch/ppc/platforms/4xx/ibm440ep.c
> --- linux-2.6.11-bk7/arch/ppc/platforms/4xx/ibm440ep.c	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.11-bk7-440ep/arch/ppc/platforms/4xx/ibm440ep.c	2005-03-11 16:26:19.000000000 -0700
> @@ -0,0 +1,176 @@
> +/*
> + * arch/ppc/platforms/4xx/ibm440ep.c
> + *
> + * PPC440EP I/O descriptions
> + *
> + * Wade Farnsworth <wfarnsworth@mvista.com>
> + * Copyright 2004 MontaVista Software Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <platforms/4xx/ibm440ep.h>
> +#include <asm/ocp.h>
> +
> +static struct ocp_func_emac_data ibm440ep_emac0_def = {
> +	.rgmii_idx	= -1,           /* No RGMII */
> +	.rgmii_mux	= -1,           /* No RGMII */
> +	.zmii_idx       = 0,            /* ZMII device index */
> +	.zmii_mux       = 0,            /* ZMII input of this EMAC */
> +	.mal_idx        = 0,            /* MAL device index */
> +	.mal_rx_chan    = 0,            /* MAL rx channel number */
> +	.mal_tx_chan    = 0,            /* MAL tx channel number */
> +	.wol_irq        = 61,		/* WOL interrupt number */
> +	.mdio_idx       = -1,           /* No shared MDIO */
> +	.tah_idx	= -1,           /* No TAH */
> +};
> +
> +static struct ocp_func_emac_data ibm440ep_emac1_def = {
> +	.rgmii_idx	= -1,           /* No RGMII */
> +	.rgmii_mux	= -1,           /* No RGMII */
> +	.zmii_idx       = 0,            /* ZMII device index */
> +	.zmii_mux       = 1,            /* ZMII input of this EMAC */
> +	.mal_idx        = 0,            /* MAL device index */
> +	.mal_rx_chan    = 1,            /* MAL rx channel number */
> +	.mal_tx_chan    = 2,            /* MAL tx channel number */
> +	.wol_irq        = 63,  		/* WOL interrupt number */
> +	.mdio_idx       = -1,           /* No shared MDIO */
> +	.tah_idx	= -1,           /* No TAH */
> +};
> +OCP_SYSFS_EMAC_DATA()
> +
> +static struct ocp_func_mal_data ibm440ep_mal0_def = {
> +	.num_tx_chans   = 4,  		/* Number of TX channels */
> +	.num_rx_chans   = 2,    	/* Number of RX channels */
> +	.txeob_irq	= 10,		/* TX End Of Buffer IRQ  */
> +	.rxeob_irq	= 11,		/* RX End Of Buffer IRQ  */
> +	.txde_irq	= 33,		/* TX Descriptor Error IRQ */
> +	.rxde_irq	= 34,		/* RX Descriptor Error IRQ */
> +	.serr_irq	= 32,		/* MAL System Error IRQ    */
> +};
> +OCP_SYSFS_MAL_DATA()
> +
> +static struct ocp_func_iic_data ibm440ep_iic0_def = {
> +	.fast_mode	= 0,		/* Use standad mode (100Khz) */
> +};
> +
> +static struct ocp_func_iic_data ibm440ep_iic1_def = {
> +	.fast_mode	= 0,		/* Use standad mode (100Khz) */
> +};
> +OCP_SYSFS_IIC_DATA()
> +
> +struct ocp_def core_ocp[] = {
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_OPB,
> +	  .index	= 0,
> +	  .paddr	= 0xEF600000,
> +	  .irq		= OCP_IRQ_NA,
> +	  .pm		= OCP_CPM_NA,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_16550,
> +	  .index	= 0,
> +	  .paddr	= PPC440EP_UART0_ADDR,
> +	  .irq		= UART0_INT,
> +	  .pm		= IBM_CPM_UART0,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_16550,
> +	  .index	= 1,
> +	  .paddr	= PPC440EP_UART1_ADDR,
> +	  .irq		= UART1_INT,
> +	  .pm		= IBM_CPM_UART1,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_16550,
> +	  .index	= 2,
> +	  .paddr	= PPC440EP_UART2_ADDR,
> +	  .irq		= UART2_INT,
> +	  .pm		= IBM_CPM_UART2,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_16550,
> +	  .index	= 3,
> +	  .paddr	= PPC440EP_UART3_ADDR,
> +	  .irq		= UART3_INT,
> +	  .pm		= IBM_CPM_UART3,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_IIC,
> +	  .index	= 0,
> +	  .paddr	= PPC440EP_IIC0_ADDR,

Do we need PPC440EP_IIC0_ADDR define? I think not, please, don't 
introduce useless defines which are only used in one file. Use numbers 
directly, it helps readability. Please, look at how this is 
handled in other 4xx platform files.

> +	  .irq		= IIC0_IRQ,

Ditto

> +	  .pm		= IBM_CPM_IIC0,
> +	  .additions	= &ibm440ep_iic0_def,
> +	  .show		= &ocp_show_iic_data
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_IIC,
> +	  .index	= 1,
> +	  .paddr	= PPC440EP_IIC1_ADDR,

Ditto.

> +	  .irq		= IIC1_IRQ,
> +	  .pm		= IBM_CPM_IIC1,
> +	  .additions	= &ibm440ep_iic1_def,
> +	  .show		= &ocp_show_iic_data
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_GPIO,
> +	  .index	= 0,
> +	  .paddr	= PPC440EP_GPIO0_ADDR,

Ditto.

> +	  .irq		= OCP_IRQ_NA,
> +	  .pm		= IBM_CPM_GPIO0,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_GPIO,
> +	  .index	= 1,
> +	  .paddr	= PPC440EP_GPIO1_ADDR,

Ditto.

> +	  .irq		= OCP_IRQ_NA,
> +	  .pm		= OCP_CPM_NA,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_MAL,
> +	  .paddr	= OCP_PADDR_NA,
> +	  .irq		= OCP_IRQ_NA,
> +	  .pm		= OCP_CPM_NA,
> +	  .additions	= &ibm440ep_mal0_def,
> +	  .show		= &ocp_show_mal_data,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_EMAC,
> +	  .index	= 0,
> +	  .paddr	= PPC440EP_EMAC0_ADDR,

Ditto

> +	  .irq		= BL_MAC_ETH0,

Ditto.

> +	  .pm		= OCP_CPM_NA,
> +	  .additions	= &ibm440ep_emac0_def,
> +	  .show		= &ocp_show_emac_data,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_EMAC,
> +	  .index	= 1,
> +	  .paddr	= PPC440EP_EMAC1_ADDR,
> +	  .irq		= BL_MAC_ETH1,
> +	  .pm		= OCP_CPM_NA,
> +	  .additions	= &ibm440ep_emac1_def,
> +	  .show		= &ocp_show_emac_data,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_ZMII,
> +	  .paddr	= PPC440EP_ZMII_ADDR,
> +	  .irq		= OCP_IRQ_NA,
> +	  .pm		= OCP_CPM_NA,
> +	},
> +	{ .vendor	= OCP_VENDOR_IBM,
> +	  .function	= OCP_FUNC_USB,
> +	  .paddr	= PPC440EP_USB1HOST_ADDR,
> +	  .irq		= USB0_IRQ,
> +	  .pm		= IBM_CPM_USB1H,
> +	},
> +	{ .vendor	= OCP_VENDOR_INVALID
> +	}
> +};
> +
> diff -uprN linux-2.6.11-bk7/arch/ppc/platforms/4xx/ibm440ep.h linux-2.6.11-bk7-440ep/arch/ppc/platforms/4xx/ibm440ep.h
> --- linux-2.6.11-bk7/arch/ppc/platforms/4xx/ibm440ep.h	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.11-bk7-440ep/arch/ppc/platforms/4xx/ibm440ep.h	2005-03-11 16:26:19.000000000 -0700
> @@ -0,0 +1,224 @@
> +/*
> + * arch/ppc/platforms/4xx/ibm440ep.h
> + *
> + * PPC440EP definitions
> + *
> + * Wade Farnsworth <wfarnsworth@mvista.com>
> + *
> + * Copyright 2002 Roland Dreier
> + * Copyright 2004 MontaVista Software, Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifdef __KERNEL__
> +#ifndef __PPC_PLATFORMS_IBM440EP_H
> +#define __PPC_PLATFORMS_IBM440EP_H
> +
> +#include <linux/config.h>
> +
> +/* GPT */
> +#define PPC440EP_GPT_ADDR               0x0EF600000
> +#define PPC440EP_GPT_SIZE               0x200
> +#define GPT_NUMS                        1
> +
> +/* UART */
> +#define PPC440EP_UART0_ADDR             0x0EF600300
> +#define PPC440EP_UART1_ADDR             0x0EF600400
> +#define PPC440EP_UART2_ADDR             0x0EF600500
> +#define PPC440EP_UART3_ADDR             0x0EF600600
> +#define PPC440EP_UART_SIZE              0x08
> +#define UART_NUMS                       4
> +
> +/* EMAC */
> +#define PPC440EP_EMAC0_ADDR             0x0EF600E00
> +#define PPC440EP_EMAC1_ADDR             0x0EF600F00
> +#define PPC440EP_EMAC_SIZE              0x100
> +#define EMAC_NUMS                       2
> +
> +/* EMAC IRQ's */
> +#define BL_MAC_WOL      61      /* WOL */
> +#define BL_MAC_WOL1     63      /* WOL */
> +#define BL_MAL_SERR     32      /* MAL SERR */
> +#define BL_MAL_TXDE     33      /* MAL TXDE */
> +#define BL_MAL_RXDE     34      /* MAL RXDE */
> +#define BL_MAL_TXEOB    10      /* MAL TX EOB */
> +#define BL_MAL_RXEOB    11      /* MAL RX EOB */
> +#define BL_MAC_ETH0     60      /* MAC */
> +#define BL_MAC_ETH1     62      /* MAC */

We don't need these defines.

> +
> +/* ZMII */
> +#define PPC440EP_ZMII_ADDR              0x0EF600D00
> +#define PPC440EP_ZMII_SIZE              0x10
> +#define ZMII_NUMS                       1

And these

> +
> +/* IIC */
> +#define PPC440EP_IIC0_ADDR              0x0EF600700
> +#define PPC440EP_IIC1_ADDR              0x0EF600800
> +#define PPC440EP_IIC_SIZE               0x20
> +#define IIC0_IRQ                        2
> +#define IIC1_IRQ                        7
> +#define IIC_NUMS                        2
> +
> +/* SPI */
> +#define PPC440EP_SPI_ADDR               0x0EF600900
> +#define PPC440EP_SPI_SIZE               0x06
> +#define SPI_NUMS                        1
> +
> +/* GPIO */
> +#define PPC440EP_GPIO0_ADDR             0x0EF600B00
> +#define PPC440EP_GPIO1_ADDR             0x0EF600C00
> +#define PPC440EP_GPIO_SIZE              0x80
> +#define GPIO_NUMS                       2


And these....

> +
> +/* USB1HOST */
> +#define PPC440EP_USB1HOST_ADDR          0x0EF601000
> +#define PPC440EP_USB1HOST_SIZE          0x80
> +#define USB1HOST_IRQ                    40
> +#define USB1HOST_NUMS                   1
> +
> +/* USB 1.1 Host constants for usb-ocp-ohci.c */
> +#define USB0_IRQ                        USB1HOST_IRQ
> +#define USB0_BASE                       PPC440EP_USB1HOST_ADDR
> +#define USB0_SIZE                       PPC440EP_USB1HOST_SIZE
> +#define USB0_EXTENT                     4096

> +
> +/* NDFC Registers */
> +#define PPC440EP_NDFC_REG_BASE          0x090000000
> +#define PPC440EP_NDFC_REG_SIZE          0x2000
> +
> +/* Clock and Power Management */
> +#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
> +#define IBM_CPM_IIC1		0x40000000	/* IIC interface */
> +#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
> +#define IBM_CPM_USB1H		0x08000000	/* USB 1.1 Host */
> +#define IBM_CPM_FPU		0x04000000	/* floating point unit */
> +#define IBM_CPM_CPU		0x02000000	/* processor core */
> +#define IBM_CPM_DMA		0x01000000	/* DMA controller */
> +#define IBM_CPM_BGO		0x00800000	/* PLB to OPB bus arbiter */
> +#define IBM_CPM_BGI		0x00400000	/* OPB to PLB bridge */
> +#define IBM_CPM_EBC		0x00200000	/* External Bus Controller */
> +#define IBM_CPM_EBM		0x00100000	/* Ext Bus Master Interface */
> +#define IBM_CPM_DMC		0x00080000	/* SDRAM peripheral controller */
> +#define IBM_CPM_PLB4		0x00040000	/* PLB4 bus arbiter */
> +#define IBM_CPM_PLB4x3		0x00020000	/* PLB4 to PLB3 bridge controller */
> +#define IBM_CPM_PLB3x4		0x00010000	/* PLB3 to PLB4 bridge controller */
> +#define IBM_CPM_PLB3		0x00008000	/* PLB3 bus arbiter */
> +#define IBM_CPM_PPM		0x00002000	/* PLB Performance Monitor */
> +#define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
> +#define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
> +#define IBM_CPM_GPT		0x00000400	/* General Purpose Timers  */
> +#define IBM_CPM_UART0		0x00000200	/* serial port 0 */
> +#define IBM_CPM_UART1		0x00000100	/* serial port 1 */
> +#define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
> +#define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
> +#define IBM_CPM_EMAC0		0x00000020	/* ethernet port 0 */
> +#define IBM_CPM_EMAC1		0x00000010	/* ethernet port 1 */
> +#define IBM_CPM_UART2		0x00000008	/* serial port 2 */
> +#define IBM_CPM_UART3		0x00000004	/* serial port 3 */
> +#define IBM_CPM_USB2D		0x00000002	/* USB 2.0 Device */
> +#define IBM_CPM_USB2H		0x00000001	/* USB 2.0 Host */
> +
> +#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC0 | IBM_CPM_UIC1 | IBM_CPM_CPU \
> +				| IBM_CPM_EBC | IBM_CPM_BGO | IBM_CPM_FPU \
> +				| IBM_CPM_EBM | IBM_CPM_PLB4 | IBM_CPM_3x4 \
> +				| IBM_CPM_PLB3 | IBM_CPM_PLB4x3 \
> +				| IBM_CPM_EMAC0 | IBM_CPM_TMRCLK \
> +				| IBM_CPM_DMA | IBM_CPM_PCI | IBM_CPM_EMAC1)
> +/*
> + * Serial port defines
> + */
> +#define RS_TABLE_SIZE	4
> +
> +#include <asm/ibm44x.h>
> +#include <syslib/ibm440ep_common.h>
> +
> +/*
> + * DCRs (the common ones will be defined in ibm44x.h)
> + */
> +
> +/* Base DCR address values for all peripheral cores in the 440EP */
> +
> +#define CPR0_DCR_BASE           0x00C  /* Clock and Power Reset */
> +#define SDR0_DCR_BASE           0x00E  /* chip control registers */
> +
> +/* DMA */
> +
> +#define MAX_DMA_PLB4_CHANNELS   4
> +
> +/* Base DCRNs */
> +#define DCRN_DMA0_PLB4_BASE            0x300      /* DMA to PL4 Channel 0 */
> +#define DCRN_DMA1_PLB4_BASE            0x308      /* DMA to PL4 Channel 1 */
> +#define DCRN_DMA2_PLB4_BASE            0x310      /* DMA to PL4 Channel 2 */
> +#define DCRN_DMA3_PLB4_BASE            0x318      /* DMA to PL4 Channel 3 */
> +#define DCRN_DMASR_PLB4_BASE            0x320      /* DMA to PL4 status Register */
> +
> +#define DCRN_DMACR0_PLB4       (DCRN_DMA0_PLB4_BASE + 0x0)     /* DMA Channel Control 0 */
> +#define DCRN_DMACT0_PLB4        (DCRN_DMA0_PLB4_BASE + 0x1)     /* DMA Count 0 */
> +#define DCRN_DMASAH0_PLB4       (DCRN_DMA0_PLB4_BASE + 0x2)    /* DMA Src Addr High 0 */
> +#define DCRN_DMASA0_PLB4        (DCRN_DMA0_PLB4_BASE + 0x3)    /* DMA Src Addr Low 0 */
> +#define DCRN_DMADAH0_PLB4       (DCRN_DMA0_PLB4_BASE + 0x4)    /* DMA Dest Addr High 0 */
> +#define DCRN_DMADA0_PLB4       (DCRN_DMA0_PLB4_BASE + 0x5)     /* DMA Dest Addr Low 0 */
> +#define DCRN_ASGH0_PLB4                (DCRN_DMA0_PLB4_BASE + 0x6)     /* DMA SG Desc Addr High 0 */
> +#define DCRN_ASG0_PLB4         (DCRN_DMA0_PLB4_BASE + 0x7)     /* DMA SG Desc Addr Low 0 */
> +
> +#define DCRN_DMACR1_PLB4       (DCRN_DMA1_PLB4_BASE + 0x0)     /* DMA Channel Control 1 */
> +#define DCRN_DMACT1_PLB4       (DCRN_DMA1_PLB4_BASE + 0x1)     /* DMA Count 1 */
> +#define DCRN_DMASAH1_PLB4      (DCRN_DMA1_PLB4_BASE + 0x2)     /* DMA Src Addr High 1 */
> +#define DCRN_DMASA1_PLB4       (DCRN_DMA1_PLB4_BASE + 0x3)     /* DMA Src Addr Low 1 */
> +#define DCRN_DMADAH1_PLB4      (DCRN_DMA1_PLB4_BASE + 0x4)     /* DMA Dest Addr High 1 */
> +#define DCRN_DMADA1_PLB4       (DCRN_DMA1_PLB4_BASE + 0x5)     /* DMA Dest Addr Low 1 */
> +#define DCRN_ASGH1_PLB4                (DCRN_DMA1_PLB4_BASE + 0x6)     /* DMA SG Desc Addr High 1 */
> +#define DCRN_ASG1_PLB4         (DCRN_DMA1_PLB4_BASE + 0x7)     /* DMA SG Desc Addr Low 1 */
> +
> +#define DCRN_DMACR2_PLB4       (DCRN_DMA2_PLB4_BASE + 0x0)     /* DMA Channel Control 2 */
> +#define DCRN_DMACT2_PLB4       (DCRN_DMA2_PLB4_BASE + 0x1)     /* DMA Count 2 */
> +#define DCRN_DMASAH2_PLB4      (DCRN_DMA2_PLB4_BASE + 0x2)     /* DMA Src Addr High 2 */
> +#define DCRN_DMASA2_PLB4       (DCRN_DMA2_PLB4_BASE + 0x3)     /* DMA Src Addr Low 2 */
> +#define DCRN_DMADAH2_PLB4      (DCRN_DMA2_PLB4_BASE + 0x4)     /* DMA Dest Addr High 2 */
> +#define DCRN_DMADA2_PLB4       (DCRN_DMA2_PLB4_BASE + 0x5)     /* DMA Dest Addr Low 2 */
> +#define DCRN_ASGH2_PLB4                (DCRN_DMA2_PLB4_BASE + 0x6)     /* DMA SG Desc Addr High 2 */
> +#define DCRN_ASG2_PLB4         (DCRN_DMA2_PLB4_BASE + 0x7)     /* DMA SG Desc Addr Low 2 */
> +
> +#define DCRN_DMACR3_PLB4       (DCRN_DMA3_PLB4_BASE + 0x0)     /* DMA Channel Control 3 */
> +#define DCRN_DMACT3_PLB4       (DCRN_DMA3_PLB4_BASE + 0x1)     /* DMA Count 3 */
> +#define DCRN_DMASAH3_PLB4      (DCRN_DMA3_PLB4_BASE + 0x2)     /* DMA Src Addr High 3 */
> +#define DCRN_DMASA3_PLB4       (DCRN_DMA3_PLB4_BASE + 0x3)     /* DMA Src Addr Low 3 */
> +#define DCRN_DMADAH3_PLB4      (DCRN_DMA3_PLB4_BASE + 0x4)     /* DMA Dest Addr High 3 */
> +#define DCRN_DMADA3_PLB4       (DCRN_DMA3_PLB4_BASE + 0x5)     /* DMA Dest Addr Low 3 */
> +#define DCRN_ASGH3_PLB4                (DCRN_DMA3_PLB4_BASE + 0x6)     /* DMA SG Desc Addr High 3 */
> +#define DCRN_ASG3_PLB4         (DCRN_DMA3_PLB4_BASE + 0x7)     /* DMA SG Desc Addr Low 3 */
> +
> +#define DCRN_DMASR_PLB4                (DCRN_DMASR_PLB4_BASE + 0x0)    /* DMA Status Register */
> +#define DCRN_ASGC_PLB4         (DCRN_DMASR_PLB4_BASE + 0x3)    /* DMA Scatter/Gather Command */
> +#define DCRN_SLP_PLB4          (DCRN_DMASR_PLB4_BASE + 0x5)    /* DMA Sleep Register */
> +#define DCRN_POL_PLB4          (DCRN_DMASR_PLB4_BASE + 0x6)    /* DMA Polarity Register */
> +
> +#define DMA_CE_ENABLE_PLB4           0x80000000
> +#define DMA_CIE_ENABLE_PLB4          0x40000000
> +#define DMA_TD_PLB4                  0x20000000
> +#define DMA_PL_PLB4                  0x10000000
> +#define DMA_PW_WORD                  0x04000000
> +#define DMA_DAI_PLB4                 0x01000000
> +#define DMA_SAI_PLB4                 0x00800000
> +#define DMA_BUFFER_ENABLED_PLB4      0x00400000
> +#define DMA_MTM_HARDWARE_START_PLB4  0x00300000
> +#define DMA_TS_IS_OUTPUT_PLB4        0x00000100
> +#define DMA_STOP_AT_TC_PLB4          0x00000080
> +#define DMA_PRIORITY_HIGH_PLB4       0x00000060
> +
> +#define DMA_TCIE_ENABLED_PLB4        0x20000000
> +#define DMA_ETIE_ENABLED_PLB4        0x10000000
> +#define DMA_EIE_ENABLED_PLB4         0x08000000
> +#define DMA_BURST_ENABLED_PLB4       0x00800000
> +#define DMA_BURST_SIZE_8_PLB4        0x00400000
> +
> +/* SDR0 */
> +#define SDR0_USB         0x0320  /* Selection of USB2.0 and USB1.1 Device */
> +
> +#endif /* __PPC_PLATFORMS_IBM440EP_H */
> +#endif /* __KERNEL__ */
> diff -uprN linux-2.6.11-bk7/arch/ppc/syslib/Makefile linux-2.6.11-bk7-440ep/arch/ppc/syslib/Makefile
> --- linux-2.6.11-bk7/arch/ppc/syslib/Makefile	2005-03-11 16:25:17.000000000 -0700
> +++ linux-2.6.11-bk7-440ep/arch/ppc/syslib/Makefile	2005-03-14 14:59:52.000000000 -0700
> @@ -11,6 +11,7 @@ obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram
>  obj-$(CONFIG_PPC_OCP)		+= ocp.o
>  obj-$(CONFIG_IBM_OCP)		+= ibm_ocp.o
>  obj-$(CONFIG_44x)		+= ibm44x_common.o
> +obj-$(CONFIG_440EP)		+= ibm440gx_common.o ibm440ep_common.o
>  obj-$(CONFIG_440GP)		+= ibm440gp_common.o
>  obj-$(CONFIG_440GX)		+= ibm440gx_common.o
>  obj-$(CONFIG_440SP)		+= ibm440gx_common.o ibm440sp_common.o
> @@ -44,6 +45,7 @@ obj-$(CONFIG_PPC_CHRP)		+= open_pic.o in
>  obj-$(CONFIG_PPC_PREP)		+= open_pic.o indirect_pci.o i8259.o todc_time.o
>  obj-$(CONFIG_ADIR)		+= i8259.o indirect_pci.o pci_auto.o \
>  					todc_time.o
> +obj-$(CONFIG_BAMBOO)            += indirect_pci.o pci_auto.o todc_time.o
>  obj-$(CONFIG_CPCI690)		+= todc_time.o pci_auto.o
>  obj-$(CONFIG_EBONY)		+= indirect_pci.o pci_auto.o todc_time.o
>  obj-$(CONFIG_EV64260)		+= todc_time.o pci_auto.o
> diff -uprN linux-2.6.11-bk7/arch/ppc/syslib/ibm440ep_common.c linux-2.6.11-bk7-440ep/arch/ppc/syslib/ibm440ep_common.c
> --- linux-2.6.11-bk7/arch/ppc/syslib/ibm440ep_common.c	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.11-bk7-440ep/arch/ppc/syslib/ibm440ep_common.c	2005-03-14 13:49:37.000000000 -0700
> @@ -0,0 +1,334 @@
> +/*
> + * arch/ppc/kernel/ibm440ep_common.c
> + *
> + * PPC440EP system library
> + *
> + * Wade Farnsworth <wfarnsworth@mvista.com>
> + * Copyright 2004 MontaVista Software, Inc.
> + * 
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + */
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <asm/ibm44x.h>
> +#include <asm/mmu.h>
> +#include <asm/processor.h>
> +#include <syslib/ibm440ep_common.h>
> +#include <linux/module.h>
> +
> +/* DMA functions reserved for DMA to PLB4 (used for USB2.0 Device) */
> +
> +/*
> + *  * Clear DMA Status Register (DMA2P40_SR)
> + *   */
> +void clear_dma2pl4_status(void)
> +{
> +	mtdcr(DCRN_DMASR_PLB4, 0xffffffff);
> +}
> +
> +/*
> + *  * Get the DMA to PLB4 status Register (DMA2P40_SR)
> + *   */
> +int get_dma2pl4_status(void)
> +{
> +	return (mfdcr(DCRN_DMASR_PLB4));
> +}
> +
> +/*
> + *  * Get the DMA to PLB4 ADDRESS DEST (DMA2P40_DA)
> + *   */
> +unsigned long get_dma2pl4_dst_addr(unsigned int dmanr)
> +{
> +	unsigned long dst_addr;
> +
> +	switch (dmanr) {
> +	case 0:
> +		dst_addr = mfdcr(DCRN_DMADA0_PLB4);
> +		break;
> +
> +	case 1:
> +		dst_addr = mfdcr(DCRN_DMADA1_PLB4);
> +		break;
> +
> +	case 2:
> +		dst_addr = mfdcr(DCRN_DMADA2_PLB4);
> +		break;
> +
> +	case 3:
> +		dst_addr = mfdcr(DCRN_DMADA3_PLB4);
> +		break;


PLEASE, there is already "inderect" DCR stuff in the tree. You don't 
need all these ugly switch statements. 


> +
> +	default:
> +		dst_addr = 0;
> +		if (dmanr >= MAX_DMA_PLB4_CHANNELS)
> +			printk("get_dma2pl4_dst_addr: bad channel: %d\n", dmanr);
> +	}
> +	return dst_addr;
> +}
> +
> +/*
> + * Set the source address
> + */
> +void set_src_addr_dma2pl4(unsigned int dmanr, phys_addr_t src_addr)
> +{
> +	switch (dmanr) {
> +
> +	case 0:
> +		mtdcr(DCRN_DMASAH0_PLB4, (u32)(src_addr >> 32));
> +		mtdcr(DCRN_DMASA0_PLB4, (u32)src_addr);
> +		break;
> +
> +	case 1:
> +		mtdcr(DCRN_DMASAH1_PLB4, (u32)(src_addr >> 32));
> +		mtdcr(DCRN_DMASA1_PLB4, (u32)src_addr);
> +		break;
> +
> +	case 2:
> +		mtdcr(DCRN_DMASAH2_PLB4, (u32)(src_addr >> 32));
> +		mtdcr(DCRN_DMASA2_PLB4, (u32)src_addr);
> +		break;
> +
> +	case 3:
> +		mtdcr(DCRN_DMASAH3_PLB4, (u32)(src_addr >> 32));
> +		mtdcr(DCRN_DMASA3_PLB4, (u32)src_addr);
> +		break;

Ditto.

> +
> +	default:
> +		if (dmanr >= MAX_DMA_PLB4_CHANNELS)
> +			printk("set_src_addr_dma2pl4: bad channel: %d\n", dmanr);
> +	}
> +}
> +
> +/*
> + * Set the destimation address
> + */
> +void set_dst_addr_dma2pl4(unsigned int dmanr, phys_addr_t dst_addr)
> +{
> +	switch (dmanr) {
> +	case 0:
> +		mtdcr(DCRN_DMADAH0_PLB4, (u32)(dst_addr >> 32));
> +		mtdcr(DCRN_DMADA0_PLB4, (u32)dst_addr);
> +		break;
> +	case 1:
> +		mtdcr(DCRN_DMADAH1_PLB4, (u32)(dst_addr >> 32));
> +		mtdcr(DCRN_DMADA1_PLB4, (u32)dst_addr);
> +		break;
> +	case 2:
> +		mtdcr(DCRN_DMADAH2_PLB4, (u32)(dst_addr >> 32));
> +		mtdcr(DCRN_DMADA2_PLB4, (u32)dst_addr);
> +		break;
> +	case 3:
> +		mtdcr(DCRN_DMADAH3_PLB4, (u32)(dst_addr >> 32));
> +		mtdcr(DCRN_DMADA3_PLB4, (u32)dst_addr);
> +		break;

Ditto.

> +	default:
> +		if (dmanr >= MAX_DMA_PLB4_CHANNELS)
> +			printk("set_dst_addr_dma2pl4: bad channel: %d\n", dmanr);
> +	}
> +}
> +
> +/*
> + * Enable the DMA to PLB4 Peripheral to Memory
> + */
> +void enable_dma2pl4_peripheral_to_memory(unsigned int dmanr,
> +					 phys_addr_t srcAddr,
> +					 phys_addr_t destAddr,
> +					 unsigned int count)
> +{
> +	unsigned int control = 0x00;
> +
> +	control |= DMA_CIE_ENABLE_PLB4;         /* Channel Interrupt Enable */
> +	control |= DMA_TD_PLB4;                 /* Transfers are from peripheral-to-memory */
> +	control |= DMA_PL_PLB4;                 /* Device located on the OPB */
> +	control |= DMA_PW_WORD;                 /* Peripheral Width (32 bits) */
> +	control |= DMA_DAI_PLB4;                /* Destination Address Increment */
> +	control |= 0x00;                        /* Do not increment Source Address */
> +	control |= DMA_BUFFER_ENABLED_PLB4;     /* Enable DMA Buffer */
> +	control |= DMA_MTM_HARDWARE_START_PLB4; /* Transfert mode: Device spaced memory-to-memory */
> +	control |= 0x00;                        /* Peripheral Setup Cycles:000 */
> +	control |= DMA_TS_IS_OUTPUT_PLB4;       /* End of transfert Terminal/Count */
> +	control |= DMA_STOP_AT_TC_PLB4;         /* Stop at TC */
> +	control |= DMA_PRIORITY_HIGH_PLB4;      /* Channel priority High */
> +
> +	switch (dmanr) {
> +	case 0:
> +		mtdcr(DCRN_DMACR0_PLB4, control);
> +		break;
> +	case 1:
> +		mtdcr(DCRN_DMACR1_PLB4, control);
> +		break;
> +	case 2:
> +		mtdcr(DCRN_DMACR2_PLB4, control);
> +		break;
> +	case 3:
> +		mtdcr(DCRN_DMACR3_PLB4, control);
> +		break;

Ditto

> +	default:
> +		printk("enable_dma: bad channel: %d\n", dmanr);
> +	}
> +
> +	/*
> + 	 * Clear the CS, TS, RI bits for the channel from DMASR.  This
> + 	 * has been observed to happen correctly only after the mode and
> +	 * ETD/DCE bits in DMACRx are set above.  Must do this before
> +	 * enabling the channel.
> +	 */
> +	mtdcr(DCRN_DMASR_PLB4, 0xffffffff);
> +
> +	/* peripheral to memory */
> +	set_src_addr_dma2pl4(dmanr, srcAddr);
> +	set_dst_addr_dma2pl4(dmanr, destAddr);
> +
> +	count |= DMA_TCIE_ENABLED_PLB4;
> +	count |= DMA_ETIE_ENABLED_PLB4;
> +	count |= DMA_EIE_ENABLED_PLB4;
> +	count |= DMA_BURST_ENABLED_PLB4;
> +	count |= DMA_BURST_SIZE_8_PLB4;
> +
> +	/* Set the number of bytes to transfer */
> +	switch (dmanr) {
> +	case 0:
> +		mtdcr(DCRN_DMACT0_PLB4, count);
> +		break;
> +	case 1:
> +		mtdcr(DCRN_DMACT1_PLB4, count);
> +		break;
> +	case 2:
> +		mtdcr(DCRN_DMACT2_PLB4, count);
> +		break;
> +	case 3:
> +		mtdcr(DCRN_DMACT3_PLB4, count);
> +		break;

Ditto

> +	default:
> +		printk("enable_dma: bad channel: %d\n", dmanr);
> +	}
> +
> +	/*
> +	 * Now enable the channel.
> +	 */
> +	control |= DMA_CE_ENABLE_PLB4;
> +
> +	switch (dmanr) {
> +	case 0:
> +		mtdcr(DCRN_DMACR0_PLB4, control);
> +		break;
> +	case 1:
> +		mtdcr(DCRN_DMACR1_PLB4, control);
> +		break;
> +	case 2:
> +		mtdcr(DCRN_DMACR2_PLB4, control);
> +		break;
> +	case 3:
> +		mtdcr(DCRN_DMACR3_PLB4, control);
> +		break;

Ditto

> +	default:
> +		printk("enable_dma: bad channel: %d\n", dmanr);
> +	}
> +}
> +
> +/*
> + *  * Enable the DMA to PLB4 Memory to Peripheral
> + *   */
> +void enable_dma2pl4_memory_to_peripheral(unsigned int dmanr,
> +					 phys_addr_t srcAddr,
> +					 phys_addr_t destAddr,
> +					 unsigned int count)
> +{
> +	unsigned int control = 0x00;
> +
> +	control |= DMA_CIE_ENABLE_PLB4;         /* Channel Interrupt Enable */
> +	control |= 0x00;                        /* Transfers are from memory_to_peripheral */
> +	control |= DMA_PL_PLB4;                 /* Device located on the OPB */
> +	control |= DMA_PW_WORD;                 /* Peripheral Width (32 bits) */
> +	control |= 0x00;                        /* Do not increment Destination Address */
> +	control |= DMA_SAI_PLB4;                /* Source Address Increment */
> +	control |= DMA_BUFFER_ENABLED_PLB4;     /* Enable DMA Buffer */
> +	control |= DMA_MTM_HARDWARE_START_PLB4; /* Transfert mode: Device spaced memory-to-memory */
> +	control |= 0x00;                        /* Peripheral Setup Cycles:000 */
> +	control |= DMA_TS_IS_OUTPUT_PLB4;       /* End of transfert Terminal/Count */
> +	control |= DMA_STOP_AT_TC_PLB4;         /* Stop at TC */
> +	control |= DMA_PRIORITY_HIGH_PLB4;      /* Channel priority High */
> +	switch (dmanr) {
> +	case 0:
> +		mtdcr(DCRN_DMACR0_PLB4, control);
> +		break;
> +	case 1:
> +		mtdcr(DCRN_DMACR1_PLB4, control);
> +		break;
> +	case 2:
> +		mtdcr(DCRN_DMACR2_PLB4, control);
> +		break;
> +	case 3:
> +		mtdcr(DCRN_DMACR3_PLB4, control);
> +		break;

Ditto

> +	default:
> +		printk("enable_dma: bad channel: %d\n", dmanr);
> +	}
> +	/*
> +	 * Clear the CS, TS, RI bits for the channel from DMASR.  This
> +	 * has been observed to happen correctly only after the mode and
> +	 * ETD/DCE bits in DMACRx are set above.  Must do this before
> +	 * enabling the channel.
> +	 */
> +	mtdcr(DCRN_DMASR_PLB4, 0xffffffff);
> +
> +	/* peripheral to memory */
> +	set_src_addr_dma2pl4(dmanr, srcAddr);
> +	set_dst_addr_dma2pl4(dmanr, destAddr);
> +	count |= DMA_TCIE_ENABLED_PLB4;
> +	count |= DMA_ETIE_ENABLED_PLB4;
> +	count |= DMA_EIE_ENABLED_PLB4;
> +	count |= DMA_BURST_ENABLED_PLB4;
> +	count |= DMA_BURST_SIZE_8_PLB4;
> +
> +	/* Set the number of bytes to transfer */
> +	switch (dmanr) {
> +	case 0:
> +		mtdcr(DCRN_DMACT0_PLB4, count);
> +		break;
> +	case 1:
> +		mtdcr(DCRN_DMACT1_PLB4, count);
> +		break;
> +	case 2:
> +		mtdcr(DCRN_DMACT2_PLB4, count);
> +		break;
> +	case 3:
> +		mtdcr(DCRN_DMACT3_PLB4, count);
> +		break;

Ditto

> +	default:
> +		printk("enable_dma: bad channel: %d\n", dmanr);
> +	}
> +
> +	/*
> +	 * Now enable the channel.
> +	 */
> +	control |= DMA_CE_ENABLE_PLB4;
> +
> +	switch (dmanr) {
> +	case 0:
> +		mtdcr(DCRN_DMACR0_PLB4, control);
> +		break;
> +	case 1:
> +		mtdcr(DCRN_DMACR1_PLB4, control);
> +		break;
> +	case 2:
> +		mtdcr(DCRN_DMACR2_PLB4, control);
> +		break;
> +	case 3:
> +		mtdcr(DCRN_DMACR3_PLB4, control);
> +		break;

Ditto

> +	default:
> +		printk("enable_dma: bad channel: %d\n", dmanr);
> +	}
> +}
> +
> +EXPORT_SYMBOL(get_dma2pl4_status);
> +EXPORT_SYMBOL(clear_dma2pl4_status);
> +EXPORT_SYMBOL(get_dma2pl4_dst_addr);
> +EXPORT_SYMBOL(enable_dma2pl4_peripheral_to_memory);
> +EXPORT_SYMBOL(enable_dma2pl4_memory_to_peripheral);

[snip]


> diff -uprN linux-2.6.11-bk7/include/asm-ppc/reg.h linux-2.6.11-bk7-440ep/include/asm-ppc/reg.h
> --- linux-2.6.11-bk7/include/asm-ppc/reg.h	2005-03-11 16:25:22.000000000 -0700
> +++ linux-2.6.11-bk7-440ep/include/asm-ppc/reg.h	2005-03-14 10:05:47.000000000 -0700
> @@ -449,6 +449,8 @@
>  #define PVR_STB03XXX	0x40310000
>  #define PVR_NP405H	0x41410000
>  #define PVR_NP405L	0x41610000
> +#define PVR_440EP_RA	0x42221850
> +#define PVR_440EP_RB	0x422218D3


I don't think it's needed. There are plans to get rid of all not-used 
PVR defines.

>  #define PVR_440GP_RB	0x40120440
>  #define PVR_440GP_RC1	0x40120481
>  #define PVR_440GP_RC2	0x40200481


--
Eugene
