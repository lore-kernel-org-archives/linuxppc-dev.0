Return-Path: <pantelis.antoniou@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.192])
	by ozlabs.org (Postfix) with ESMTP id B79B86885E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 03:55:06 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id m18so31025nfc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Dec 2005 08:55:03 -0800 (PST)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Tue, 6 Dec 2005 19:02:47 +0200
References: <200512052115.45858.pantelis.antoniou@gmail.com>
	<20051206153659.GA6771@dmt.cnet>
In-Reply-To: <20051206153659.GA6771@dmt.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512061902.48512.pantelis.antoniou@gmail.com>
Cc: Robert Applebaum <rapplebaum@silicontkx.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Support 8xx based Silicon Turnkey XTc
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 06 December 2005 17:36, Marcelo Tosatti wrote:
> Hi Panto!
> 
Hi Marcelo!

> On Mon, Dec 05, 2005 at 09:15:43PM +0200, Pantelis Antoniou wrote:
> > Support of Silicon Turnkey's XTc.
> > 
> > ---
> > commit fac9bbd80d8f8ab3c6af5a417f804dbf8537c700
> > tree 7863f94249651a26ca3eb29aed4c65c214968dda
> > parent e4f5c82a92c2a546a16af1614114eec19120e40a
> > author Pantelis Antoniou <pantelis.antoniou@gmail.com> Mon, 05 Dec 2005 21:13:56 +0200
> > committer Pantelis Antoniou <pantelis.antoniou@gmail.com> Mon, 05 Dec 2005 21:13:56 +0200
> > 
> >  arch/ppc/Kconfig                  |    5 
> >  arch/ppc/configs/stxxtc_defconfig |  804 +++++++++++++++++++++++++++++++++++++
> >  arch/ppc/platforms/Makefile       |    1 
> >  arch/ppc/platforms/stxxtc.h       |  285 +++++++++++++
> >  arch/ppc/platforms/stxxtc_setup.c |  193 +++++++++
> >  arch/ppc/syslib/m8xx_setup.c      |   14 +
> >  drivers/mtd/maps/Kconfig          |    6 
> >  drivers/mtd/maps/Makefile         |    1 
> >  drivers/mtd/maps/stxxtc_nor.c     |  326 +++++++++++++++
> >  drivers/mtd/nand/Kconfig          |    8 
> >  drivers/mtd/nand/Makefile         |    1 
> >  drivers/mtd/nand/stxxtc_nand.c    |  277 +++++++++++++
> >  include/asm-ppc/mpc8xx.h          |    4 
> >  13 files changed, 1922 insertions(+), 3 deletions(-)
> > 
> 
> > +# CONFIG_PIN_TLB is not set
> 
> Might want to enable by default? 
>

Not a bad idea.
 
> > diff --git a/arch/ppc/platforms/stxxtc.h b/arch/ppc/platforms/stxxtc.h
> > new file mode 100644
> > --- /dev/null
> > +++ b/arch/ppc/platforms/stxxtc.h
> > @@ -0,0 +1,285 @@
> > +/*
> > + * A collection of structures, addresses, and values associated with
> > + * the STXXTC systems.
> > + *
> > + * Copyright (c) 2005 Pantelis Antoniou <pantelis.antoniou@gmail.com>
> > + *                    Dan Malek <dan@embeddedalley.com>
> > + *
> > + */
> > +#ifndef __MACH_STXXTC_DEFS
> > +#define __MACH_STXXTC_DEFS
> > +
> > +#include <linux/config.h>
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <asm/ppcboot.h>
> > +
> > +#include <asm/8xx_immap.h>
> > +#include <asm/commproc.h>
> > +#include <asm/mpc8xx.h>
> > +#include <asm/delay.h>
> > +
> > +#endif
> > +
> > +#define	IMAP_ADDR	0xFF000000		/* physical base address of IMMR area	*/
> 
> Extra TAB (or missing tab below, whatever you prefer ;)
>

Nice catch.
 
> > +#define IMAP_SIZE	(64 * 1024)		/* mapped size of IMMR area		*/
> 
> > +
> > +/* We don't use the 8259.
> > +*/
> > +#define NR_8259_INTS	0
> > +
> > +#define NAND_SIZE	0x00010000
> > +#define NAND_BASE	0xF1000000
> > +
> > +/*-----------------------------------------------------------------------
> > + * PCMCIA stuff
> > + *-----------------------------------------------------------------------
> > + *
> > + */
> > +#define PCMCIA_MEM_SIZE		( 64 << 20 )
> > +
> > +#define	MAX_HWIFS	1	/* overwrite default in include/asm-ppc/ide.h	*/
> > +
> > +/*
> > + * Definitions for IDE0 Interface
> > + */
> > +#define IDE0_BASE_OFFSET		0
> > +#define IDE0_DATA_REG_OFFSET		(PCMCIA_MEM_SIZE + 0x320)
> > +#define IDE0_ERROR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 1)
> > +#define IDE0_NSECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 2)
> > +#define IDE0_SECTOR_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 3)
> > +#define IDE0_LCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 4)
> > +#define IDE0_HCYL_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 5)
> > +#define IDE0_SELECT_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 6)
> > +#define IDE0_STATUS_REG_OFFSET		(2 * PCMCIA_MEM_SIZE + 0x320 + 7)
> > +#define IDE0_CONTROL_REG_OFFSET		0x0106
> > +#define IDE0_IRQ_REG_OFFSET		0x000A	/* not used			*/
> > +
> > +#define	IDE0_INTERRUPT			13
> > +
> > +/* XXX FUCK!, for IDE disk set to 0, for normal PCMCIA set to 1 */
> > +/* XXX don't ask me why.. */ 
> 
> Can you make the comment a bit nicer? :)
>

OK. We don't want to offend our politically correct viewers, don't we? :)
 
> > +#if 1
> > +/* define IO_BASE for PCMCIA */
> > +#define _IO_BASE 0x80000000
> > +#define _IO_BASE_SIZE  (64<<10)
> > +#endif
> > +
> > +/***********************************************************************/
> > +
> > +/* shorthand for the ports data registers */
> > +#define PORTA		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_padat)
> > +#define PORTB		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pbdat)
> > +#define PORTC		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pcdat)
> > +#define PORTD		(((volatile immap_t *)IMAP_ADDR)->im_ioport.iop_pddat)
> > +#define PORTE		(((volatile immap_t *)IMAP_ADDR)->im_cpm.cp_pedat)
> > +
> > +/********************************************************************************/
> > +
> > +#define PIN_PORT_EQ(p, x)	((void *) & x ## _PORT == (void *) & p)
> > +#define PIN_PORT_NE(p, x)	((void *) & x ## _PORT != (void *) & p)
> > +
> > +#define PIN_PORT_RW(x)		(PIN_PORT_NE(PORTXWO, x) && PIN_PORT_NE(PORTXRO, x))
> > +#define PIN_PORT_RO(x)		PIN_PORT_EQ(PORTXRO, x)
> > +#define PIN_PORT_WO(x)		PIN_PORT_EQ(PORTXWO, x)
> > +
> > +/********************************************************************************/
> > +
> > +#define PIN_SFT(x) ((sizeof(x ## _PORT) * 8 - 1) - x ## _BIT)
> > +#define PIN_MSK(x) (1U << PIN_SFT(x))
> > +
> > +/********************************************************************************/
> > +
> > +/* normal m8xx pins */
> > +#define _PIN_HI(x) \
> > +	do { \
> > +		x ## _PORT |=  PIN_MSK(x); \
> > +	} while(0)
> > +
> > +#define _PIN_LO(x) \
> > +	do { \
> > +		x ## _PORT &= ~PIN_MSK(x); \
> > +	} while(0)
> > +
> > +#define _PIN_TGL(x) \
> > +	do { \
> > +		x ## _PORT ^=  PIN_MSK(x); \
> > +	} while(0)
> > +
> > +#define _PIN_GET(x) \
> > +	(!!(x ## _PORT & PIN_MSK(x)))
> > +
> > +#define _PIN_SET(x, v)	\
> > +	do { \
> > +		if (__builtin_constant_p(v)) { \
> > +			if ((v) != 0) \
> > +				_PIN_HI(x); \
> > +			else \
> > +				_PIN_LO(x); \
> > +		} else \
> > +			x ## _PORT = ( x ## _PORT & ~PIN_MSK(x)) | (!!(v) << PIN_SFT(x)); \
> > +	} while(0)
> > +
> > +#define _PIN_CFG_IN(x) \
> > +	do { \
> > +		if (PIN_PORT_EQ(PORTA, x)) \
> > +			PORTA_config(PIN_MSK(x), 0, 0); \
> > +		if (PIN_PORT_EQ(PORTB, x)) \
> > +			PORTB_config(PIN_MSK(x), 0, 0); \
> > +		if (PIN_PORT_EQ(PORTC, x)) \
> > +			PORTC_config(PIN_MSK(x), 0, 0); \
> > +		if (PIN_PORT_EQ(PORTD, x)) \
> > +			PORTD_config(PIN_MSK(x), 0, 0); \
> > +		if (PIN_PORT_EQ(PORTE, x)) \
> > +			PORTE_config(PIN_MSK(x), 0, 0); \
> > +	} while(0)
> > +
> > +#define _PIN_CFG_INT_ANY(x) \
> > +	do { \
> > +		if (PIN_PORT_EQ(PORTC, x)) \
> > +			PORTC_config(PIN_MSK(x), 0, 0); \
> > +	} while(0)
> > +
> > +#define _PIN_CFG_INT_FALL(x) \
> > +	do { \
> > +		if (PIN_PORT_EQ(PORTC, x)) \
> > +			PORTC_config(PIN_MSK(x), 0, 0); \
> > +	} while(0)
> > +
> > +#define _PIN_CFG_OUT(x, v) \
> > +	do { \
> > +		_PIN_SET(x, v); \
> > +		if (PIN_PORT_EQ(PORTA, x)) \
> > +			PORTA_config(0, PIN_MSK(x), 0); \
> > +		if (PIN_PORT_EQ(PORTB, x)) \
> > +			PORTB_config(0, PIN_MSK(x), 0); \
> > +		if (PIN_PORT_EQ(PORTC, x)) \
> > +			PORTC_config(0, PIN_MSK(x), 0); \
> > +		if (PIN_PORT_EQ(PORTD, x)) \
> > +			PORTD_config(0, PIN_MSK(x), 0); \
> > +		if (PIN_PORT_EQ(PORTE, x)) \
> > +			PORTE_config(0, PIN_MSK(x), 0); \
> > +	} while(0)
> > +
> > +#define _PIN_CFG_OUT_HI(x) _PIN_CFG_OUT(x, 1)
> > +#define _PIN_CFG_OUT_LO(x) _PIN_CFG_OUT(x, 0)
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +static inline void PORTA_config(uint inmsk, uint outmsk, uint dummy)
> > +{
> > +	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
> > +	ushort msk = (ushort)inmsk | (ushort)outmsk;
> > +
> > +	imap->im_ioport.iop_padir  = (imap->im_ioport.iop_padir & ~(ushort)inmsk) | (ushort)outmsk;
> > +	imap->im_ioport.iop_paodr &= ~msk;
> > +	imap->im_ioport.iop_papar &= ~msk;
> > +}
> > +
> > +static inline void PORTB_config(uint inmsk, uint outmsk, uint dummy)
> > +{
> > +	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
> > +	uint msk = inmsk | outmsk;
> > +
> > +	imap->im_cpm.cp_pbdir  = (imap->im_cpm.cp_pbdir & ~inmsk) | outmsk;
> > +	imap->im_cpm.cp_pbodr &= ~msk;
> > +	imap->im_cpm.cp_pbpar &= ~msk;
> > +}
> > +
> > +static inline void PORTC_config(uint inmsk, uint outmsk, uint fallmsk)
> > +{
> > +	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
> > +	ushort msk = (ushort)inmsk | (ushort)outmsk;
> > +
> > +	imap->im_ioport.iop_pcdir  = (imap->im_ioport.iop_pcdir & ~(ushort)inmsk) | (ushort)outmsk;
> > +	imap->im_ioport.iop_pcso  &= ~msk;
> > +	imap->im_ioport.iop_pcint  = (imap->im_ioport.iop_pcint & ~(ushort)inmsk) | ((ushort)fallmsk & (ushort)inmsk);
> > +	imap->im_ioport.iop_pcpar &= ~msk;
> > +}
> > +
> > +static inline void PORTD_config(uint inmsk, uint outmsk, uint dummy)
> > +{
> > +	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
> > +	ushort msk = (ushort)inmsk | (ushort)outmsk;
> > +
> > +	imap->im_ioport.iop_pddir  = (imap->im_ioport.iop_pddir & ~(ushort)inmsk) | (ushort)outmsk;
> > +	imap->im_ioport.iop_pdpar &= ~msk;
> > +}
> > +
> > +static inline void PORTE_config(uint inmsk, uint outmsk, uint dummy)
> > +{
> > +	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
> > +	uint msk = inmsk | outmsk;
> > +
> > +	imap->im_cpm.cp_pedir  = (imap->im_cpm.cp_pedir & ~inmsk) | outmsk;
> > +	imap->im_cpm.cp_peodr &= ~msk;
> > +	imap->im_cpm.cp_pepar &= ~msk;
> > +}
> 
> I don't like this macros being board specific - can't you simplify/beautify 
> this all? 
>

Understood. I'll try to clean & clarify the rationale between these 
(admitably) obscure macros.
 
> > +
> > +/**********************************************/
> > +
> > +unsigned long pin_lock(void);
> > +void pin_unlock(unsigned long flags);
> > +
> > +#endif /* __ASSEMBLY */
> > +
> > +/******************************************************************************/
> > +
> > +/* NAND flash pins */
> > +
> > +#define F_ALE_PORT	PORTC
> > +#define F_ALE_BIT	15
> > +
> > +#define F_CLE_PORT	PORTB
> > +#define F_CLE_BIT	23
> > +
> > +#define F_CE_PORT	PORTA
> > +#define F_CE_BIT	7
> > +
> > +#define F_RY_BY_PORT	PORTA
> > +#define F_RY_BY_BIT	6
> > +
> > +/***********************************************************************/
> > +
> > +/* SPI pin definitions */
> > +
> > +#define SPI_RXD_PORT	PORTB
> > +#define SPI_RXD_BIT	28
> > +
> > +#define SPI_TXD_PORT	PORTB
> > +#define SPI_TXD_BIT	29
> > +
> > +#define SPI_CLK_PORT	PORTB
> > +#define SPI_CLK_BIT	30
> > +
> > +#define SPI_DELAY() 	udelay(1)
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +static inline unsigned int spi_transfer(unsigned int tx)
> > +{
> > +	unsigned int rx;
> > +	int i;
> > +
> > +	rx = 0;
> > +	for (i = 0; i < 8; i++) {
> > +		_PIN_SET(SPI_TXD, tx & 0x80);
> > +		tx <<= 1;
> > +		_PIN_TGL(SPI_CLK);
> > +		SPI_DELAY();
> > +		rx <<= 1;
> > +		rx |= _PIN_GET(SPI_RXD);
> > +		_PIN_TGL(SPI_CLK);
> > +		SPI_DELAY();
> > +	}
> > +
> > +	return rx;
> > +}
> > +
> > +#endif
> > +
> > +#define BOARD_CHIP_NAME "MPC870"
> > +
> > +#endif	/* __MACH_STXXTC_DEFS */
> > +
> > diff --git a/arch/ppc/platforms/stxxtc_setup.c b/arch/ppc/platforms/stxxtc_setup.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/arch/ppc/platforms/stxxtc_setup.c
> > @@ -0,0 +1,193 @@
> > +/*
> > + * arch/ppc/platforms/stxxtc.c
> > + * 
> > + * Platform setup for the Silicon Turnkey eXpress XTc
> > + */
> > +
> > +#include <linux/config.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/param.h>
> > +#include <linux/string.h>
> > +#include <linux/ioport.h>
> > +#include <linux/device.h>
> > +
> > +#include <asm/delay.h>
> > +#include <asm/io.h>
> > +#include <asm/machdep.h>
> > +#include <asm/page.h>
> > +#include <asm/processor.h>
> > +#include <asm/system.h>
> > +#include <asm/time.h>
> > +#include <asm/ppcboot.h>
> > +#include <asm/ppc_sys.h>
> > +
> > +#include <linux/stddef.h>
> > +
> > +#include <linux/fs_enet_pd.h>
> > +
> > +#include <platforms/stxxtc.h>
> > +
> > +/***********************************************************************/
> > +
> > +#ifdef CONFIG_FW_ENV
> > +#include <syslib/fw_env.h>
> > +
> > +static const char *ro_vars[] = {
> > +	"ethaddr", "eth1addr", "adsladdr", "serial#", "usbaddr", "usb1addr", "ver", "board",
> > +	NULL
> > +};
> > +#endif
> > +
> > +/***********************************************************************/
> > +
> > +static spinlock_t port_spinlock;
> > +
> > +unsigned long pin_lock(void)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&port_spinlock, flags);
> > +	return flags;
> > +}
> > +EXPORT_SYMBOL(pin_lock);
> > +
> > +void pin_unlock(unsigned long flags)
> > +{
> > +	spin_unlock_irqrestore(&port_spinlock, flags);
> > +}
> > +EXPORT_SYMBOL(pin_unlock);
> 
> Unused? Why do you need this? 
> 

It's not used in these drivers. I need the lock to protect
potential port accesses coherent.

> > +
> > +/***********************************************************************/
> > +
> > +static struct fs_mii_bus_info fec_mii_bus_info = {
> > +        .method                 = fsmii_fec,
> > +        .id                     = 0,
> > +};
> > +
> > +static struct fs_platform_info mpc8xx_fec_pdata[2] = {
> > +	[0] = {
> > +		.phy_addr	= 0x01,
> > +		.phy_irq	= -1,
> > +		.fs_no		= fsid_fec1,
> > +		.rx_ring	= 128,
> > +		.tx_ring	= 16,
> > +		.napi_weight	= 17,
> > +		.bus_info	= &fec_mii_bus_info,
> > +		.rx_copybreak	= 240,
> > +		.use_napi	= 1,
> > +		.use_rmii	= 0,
> > +	},
> > +	[1] = {
> > +		.phy_addr	= 0x03,
> > +		.phy_irq	= -1,
> > +		.fs_no		= fsid_fec2,
> > +		.rx_ring	= 128,
> > +		.tx_ring	= 16,
> > +		.napi_weight	= 17,
> > +		.bus_info	= &fec_mii_bus_info,
> > +		.rx_copybreak	= 240,
> > +		.use_napi	= 1,
> > +		.use_rmii	= 0,
> > +	}
> > +};
> > +
> > +/***********************************************************************/
> > +
> > +static void stxxtc_fixup_fs_pdata(struct platform_device *pd, int fs_no)
> > +{
> > +	struct fs_platform_info *fpi;
> > +	bd_t *bd;
> > +	int idx;
> > +
> > +	idx = fs_get_fec_index(fs_no);
> > +	if (idx == -1) {
> > +		printk(KERN_ERR "stxxtc_setup: Only FEC ethernets supported by STXXTC.\n");
> > +		return;
> > +	}
> > +
> > +	fpi = &mpc8xx_fec_pdata[idx];
> > +
> > +	bd = (bd_t *)__res;
> > +
> > +	memcpy(fpi->macaddr, bd->bi_enetaddr, 6);
> > +	fpi->macaddr[5] += idx;	/* different per interface */
> > +
> > +	pd->dev.platform_data = fpi;
> > +
> > +	/* we don't setup *any* pins, we trust the bootloader */
> > +}
> > +
> > +static void stxxtc_fixup_fec_pdata(struct platform_device *pd, int idx)
> > +{
> > +	int fs_no = fsid_fec1 + pd->id - 1;
> > +
> > +	stxxtc_fixup_fs_pdata(pd, fs_no);
> > +}
> > +
> > +static int stxxtc_platform_notify(struct device *dev)
> > +{
> > +	static struct {
> > +		const char *bus_id;
> > +		void (*rtn)(struct platform_device * pdev, int idx);
> > +	} dev_map[] = {
> > +		{ "fsl-cpm-fec", stxxtc_fixup_fec_pdata },
> > +	};
> > +	struct platform_device *pdev;
> > +	int i, j, idx;
> > +	const char *s;
> > +
> > +	if (dev && dev->bus_id)
> > +		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
> > +			idx = -1;
> > +			if ((s = strrchr(dev->bus_id, '.')) != NULL)
> > +				idx = (int)simple_strtol(s + 1, NULL, 10);
> > +			else
> > +				s = dev->bus_id + strlen(s);
> > +
> > +			j = s - dev->bus_id;
> > +
> > +			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
> > +				pdev = container_of(dev, struct platform_device, dev);
> > +				dev_map[i].rtn(pdev, idx);
> > +			}
> > +		}
> > +
> > +	return 0;
> > +}
> 
> Isnt a lot of this common code between all boards? (other than the dev_map array
> definition).
> 

True. But currently I see no other way to do it, since it is not totally generic.

> > +
> > +int __init
> > +stxxtc_init(void)
> > +{
> > +	immap_t *imap = (immap_t *)IMAP_ADDR;
> > +
> > +	spin_lock_init(&port_spinlock);
> > +
> > +	imap->im_siu_conf.sc_sypcr |= 0x0000FF00;
> > +
> > +	/* configure SPI pins */
> > +	_PIN_CFG_OUT_HI(SPI_TXD);
> > +	_PIN_CFG_OUT_HI(SPI_CLK);
> > +	_PIN_CFG_IN(SPI_RXD);
> > +
> > +	/* configure NAND pins */
> > +	_PIN_CFG_OUT_LO(F_ALE);
> > +	_PIN_CFG_OUT_LO(F_CLE);
> > +	_PIN_CFG_OUT_HI(F_CE);
> > +	_PIN_CFG_IN(F_RY_BY);
> > +
> > +	platform_notify = stxxtc_platform_notify;
> > +
> > +	identify_ppc_sys_by_name("MPC885");
> > +
> > +	/* remove these devices */
> > +	ppc_sys_device_remove(MPC8xx_CPM_SCC1);
> > +	ppc_sys_device_remove(MPC8xx_CPM_SCC2);
> > +	ppc_sys_device_remove(MPC8xx_CPM_SCC3);
> > +	ppc_sys_device_remove(MPC8xx_CPM_SCC4);
> > +
> > +	return 0;
> > +}
> > +
> > +arch_initcall(stxxtc_init);
> > +
> > diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
> > --- a/arch/ppc/syslib/m8xx_setup.c
> > +++ b/arch/ppc/syslib/m8xx_setup.c
> > @@ -370,16 +370,26 @@ m8xx_map_io(void)
> >  #if defined(CONFIG_NETTA)
> >  	io_block_mapping(_IO_BASE,_IO_BASE,_IO_BASE_SIZE, _PAGE_IO);
> >  #endif
> > +#if defined(CONFIG_STXXTC)
> > + 	io_block_mapping(_IO_BASE,_IO_BASE,64 << 10, _PAGE_IO);
> 
> 64<<10 = IO_BASE_SIZE?
> 

Ugh, yes.

> > +#endif
> >  }
> >  
> >  void __init
> >  platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> >  		unsigned long r6, unsigned long r7)
> >  {
> > +	bd_t *bd;
> > +
> >  	parse_bootinfo(find_bootinfo());
> >  
> > -	if ( r3 )
> > -		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
> > +	if ( r3 ) {
> > +		bd = (bd_t *)(r3+KERNELBASE);
> > +		/* skip OF tree if present */
> > +		if (*(u32 *)bd == 0xd00dfeed)
> > +			bd = (bd_t *)((char *)bd + ((u32 *)bd)[1]);
> > +		memcpy(__res, bd, sizeof(bd_t));
> > +	}
> 
> Separate patch?
>

If you say so.
 
> >  
> >  #ifdef CONFIG_PCI
> >  	m8xx_setup_pci_ptrs();
> > diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> > --- a/drivers/mtd/maps/Kconfig
> > +++ b/drivers/mtd/maps/Kconfig
> > @@ -639,5 +639,11 @@ config MTD_PLATRAM
> >  
> >  	  This selection automatically selects the map_ram driver.
> >  
> > +config MTD_STXXTC_NOR
> > +	tristate "NOR Map driver for STXXTC NOR flash"
> > +	depends on STXXTC && MTD_CONCAT && MTD_PARTITIONS && MTD_CFI_INTELEXT
> > +	help
> > +	  Map driver for Silicon Turnkey eXpress XTc NOR flash. 
> > +
> >  endmenu
> 
> Would be easier if the flash driver was a separate patch.
> 

Hrmf. OK

Regards

Pantelis
