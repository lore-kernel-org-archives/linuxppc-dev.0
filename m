Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2538B687E9
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 06:09:46 +1100 (EST)
Date: Wed, 23 Nov 2005 13:06:18 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Heiko Schocher <hs@denx.de>
In-Reply-To: <AHEILKONAKAEJPHNMOPNEEMNCDAA.hs@denx.de>
Message-ID: <Pine.LNX.4.44.0511231249351.4255-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org
Subject: RE: [PATCH] I2C: Add I2C support for the MPC8260
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 23 Nov 2005, Heiko Schocher wrote:

* There is a bunch of code commented out in one form or another, is this 
needed?
* Single line comment style
* some other comments are inline.

- kumar


> Hello
> 
> On Wednesday, November 23, 2005 8:01 AM Kumar Gala wrote:
> > Can we rename the driver from mpc8260 -> cpm2. The driver should work
> > on any device that has a "CPM2" which includes a number of MPC82xx
> > and MPC85xx processors.  So calling it and its config options, etc
> > MPC8260 is going to be confusing to users.
> 
> [PATCH]	I2C:	Add I2C Bus support for MPC with CPM2.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> ---
> 
>  drivers/i2c/busses/Kconfig    |   10 +
>  drivers/i2c/busses/Makefile   |    1 
>  drivers/i2c/busses/i2c-cpm2.c |  616 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-algo-cpm2.h |   26 ++
>  include/linux/i2c-id.h        |    3 
>  5 files changed, 656 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4010fe9..2acb4cc 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -270,6 +270,16 @@ config I2C_MPC
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mpc.
>  
> +config I2C_CPM2
> +	tristate "CPM2"
> +	depends on I2C && PPC32

it should really depend on CPM2 being set not PPC32.

> +	help
> +	  If you say yes to this option, support will be included for the
> +	  I2C interface on PPC with CPM2
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-cpm2.
> +
>  config I2C_NFORCE2
>  	tristate "Nvidia nForce2, nForce3 and nForce4"
>  	depends on I2C && PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index f1df00f..a4c1b69 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
>  obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
>  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> +obj-$(CONFIG_I2C_CPM2)		+= i2c-cpm2.o
>  
>  ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff --git a/drivers/i2c/busses/i2c-cpm2.c b/drivers/i2c/busses/i2c-cpm2.c
> new file mode 100644
> index 0000000..80dc532
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-cpm2.c
> @@ -0,0 +1,616 @@
> +/*
> + * (C) Copyright 2005
> + * Heiko Schocher <hs@denx.de>
> + *
> + * This is a combined i2c adapter and algorithm driver for
> + * PPC with CPM2
> + *
> + * Release 0.1
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/pci.h>
> +#include <asm/io.h>
> +#include <linux/fsl_devices.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <asm/immap_cpm2.h>
> +#include <asm/mpc8260.h>
> +#include <asm/cpm2.h>
> +
> +#include <linux/i2c-algo-cpm2.h>
> +#include <linux/platform_device.h>
> +
> +#define CPM_MAX_READ	513
> +
> +static wait_queue_head_t iic_wait;
> +static ushort r_tbase, r_rbase;
> +
> +int cpm_scan = 0;
> +int cpm_debug = 0;
> +

It would be nice to rename the struct so its unique between i2c-mpc and 
i2c-cpm2.  Since its reasonable for both drivers to exist in a system.

> +struct mpc_i2c {
> +	u32 interrupt;
> +	wait_queue_head_t queue;
> +	struct i2c_adapter adap;
> +	int irq;
> +	u32 flags;
> +	struct i2c_algo_cpm2_data *data;
> +};
> +
> +static struct i2c_algo_cpm2_data cpm2_data;
> +
> +static void
> +cpm2_iic_init(struct i2c_algo_cpm2_data *data)
> +{
> +	volatile cpm_cpm2_t *cp;
> +	volatile cpm2_map_t *immap;
> +
> +	cp = cpmp;	/* Get pointer to Communication Processor */
> +	immap = (cpm2_map_t *)CPM_MAP_ADDR;	/* and to internal registers */
> +
> +	*(ushort *)(&immap->im_dprambase[PROFF_I2C_BASE]) = PROFF_I2C;
> +	data->iip = (iic_t *)&immap->im_dprambase[PROFF_I2C];
> +
> +	data->i2c = (i2c_cpm2_t *)&(immap->im_i2c);
> +	data->cp = cp;
> +
> +	/* Initialize Port D IIC pins.
> +	*/
> +	immap->im_ioport.iop_ppard |= 0x00030000;
> +	immap->im_ioport.iop_pdird &= ~0x00030000;
> +	immap->im_ioport.iop_podrd |= 0x00030000;
> +	immap->im_ioport.iop_psord |= 0x00030000;
> +
> +	/* Allocate space for two transmit and two receive buffer
> +	 * descriptors in the DP ram.
> +	 */
> +	data->dp_addr = cpm_dpalloc(sizeof(cbd_t) * 4, 8);
> +
> +	/* ptr to i2c area */
> +	data->i2c = (i2c_cpm2_t *)&(((cpm2_map_t *)CPM_MAP_ADDR)->im_i2c);
> +}
> +
> +static irqreturn_t cpm2_i2c_isr(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct mpc_i2c *mpc_i2c = dev_id;
> +	struct i2c_algo_cpm2_data *cpm_adap = mpc_i2c->data;
> +	volatile i2c_cpm2_t *i2c = cpm_adap->i2c;
> +	
> +	if (cpm_debug > 1)
> +		printk(KERN_DEBUG "cpm_iic_interrupt(dev_id=%p)\n", dev_id);
> +
> +	/* Clear interrupt.
> +	*/
> +	i2c->i2c_i2cer = 0xff;
> +
> +	/* Get 'me going again.
> +	*/
> +	wake_up_interruptible(&iic_wait);
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static void
> +cpm_iic_init(struct i2c_algo_cpm2_data *cpm_adap)
> +{
> +	volatile iic_t		*iip = cpm_adap->iip;
> +	volatile i2c_cpm2_t	*i2c = cpm_adap->i2c;
> +
> +	if (cpm_debug) printk(KERN_DEBUG "cpm_iic_init() - iip=%p\n",iip);
> +
> +	/* Initialize the parameter ram.
> +	 * We need to make sure many things are initialized to zero,
> +	 * especially in the case of a microcode patch.
> +	 */
> +	iip->iic_rstate = 0;
> +	iip->iic_rdp = 0;
> +	iip->iic_rbptr = 0;
> +	iip->iic_rbc = 0;
> +	iip->iic_rxtmp = 0;
> +	iip->iic_tstate = 0;
> +	iip->iic_tdp = 0;
> +	iip->iic_tbptr = 0;
> +	iip->iic_tbc = 0;
> +	iip->iic_txtmp = 0;
> +
> +	/* Set up the IIC parameters in the parameter ram.
> +	*/
> +	iip->iic_tbase = r_tbase = cpm_adap->dp_addr;
> +	iip->iic_rbase = r_rbase = cpm_adap->dp_addr + sizeof(cbd_t)*2;
> +
> +	iip->iic_tfcr = CPMFCR_GBL | CPMFCR_EB;
> +	iip->iic_rfcr = CPMFCR_GBL | CPMFCR_EB;
> +
> +	/* Set maximum receive size.
> +	*/
> +	iip->iic_mrblr = CPM_MAX_READ;
> +
> +		/* Initialize Tx/Rx parameters.
> +		*/
> +	{
> +		volatile cpm_cpm2_t *cp = cpm_adap->cp;
> +		cp->cp_cpcr =
> +			mk_cr_cmd(CPM_CR_I2C_PAGE, CPM_CR_I2C_SBLOCK, 0x00, CPM_CR_INIT_TRX) | CPM_CR_FLG;
> +		while (cp->cp_cpcr & CPM_CR_FLG);
> +	}
> +
> +	/* Select an arbitrary address.  Just make sure it is unique.
> +	*/
> +	i2c->i2c_i2add = 0x34;
> +
> +	/* Divider is 2 * ( 15 + 3 )
> +	*/
> +	i2c->i2c_i2brg = 0x0f;
> +
> +	/* Pre-divider is BRGCLK/4
> +	 */
> +	i2c->i2c_i2mod = 0x06;
> +
> +	/* Disable interrupts.
> +	*/
> +	i2c->i2c_i2cmr = 0;
> +	i2c->i2c_i2cer = 0xff;
> +
> +	init_waitqueue_head(&iic_wait);
> +}
> +
> +
> +#if 0
> +static int
> +cpm_iic_shutdown(struct i2c_algo_cpm2_data *cpm_adap)
> +{
> +	volatile i2c_cpm2_t *i2c = cpm_adap->i2c;
> +
> +	/* Shut down IIC.
> +	*/
> +	i2c->i2c_i2mod = 0;
> +	i2c->i2c_i2cmr = 0;
> +	i2c->i2c_i2cer = 0xff;
> +
> +	return(0);
> +}
> +#endif
> +
> +static void 
> +cpm_reset_iic_params(volatile iic_t *iip)
> +{
> +	iip->iic_tbase = r_tbase;
> +	iip->iic_rbase = r_rbase;
> +
> +	iip->iic_tfcr = CPMFCR_GBL | CPMFCR_EB;
> +	iip->iic_rfcr = CPMFCR_GBL | CPMFCR_EB;
> +
> +	iip->iic_mrblr = CPM_MAX_READ;
> +
> +	iip->iic_rstate = 0;
> +	iip->iic_rdp = 0;
> +	iip->iic_rbptr = 0;
> +	iip->iic_rbc = 0;
> +	iip->iic_rxtmp = 0;
> +	iip->iic_tstate = 0;
> +	iip->iic_tdp = 0;
> +	iip->iic_tbptr = 0;
> +	iip->iic_tbc = 0;
> +	iip->iic_txtmp = 0;
> +}
> +
> +#define BD_SC_NAK		((ushort)0x0004) /* NAK - did not respond */
> +#define CPM_CR_CLOSE_RXBD	((ushort)0x0007)
> +
> +static void force_close(struct i2c_algo_cpm2_data *cpm)
> +{
> +#if 0
> +	volatile cpm_cpm2_t *cp = cpm->cp;
> +
> +	if (cpm_debug) printk(KERN_DEBUG "force_close()\n");
> +	cp->cp_cpcr =
> +		mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
> +		CPM_CR_FLG;
> +
> +	while (cp->cp_cpcr & CPM_CR_FLG);
> +#endif
> +}
> +
> +
> +/* Read from IIC...
> + * abyte = address byte, with r/w flag already set
> + */
> +static int
> +cpm_iic_read(struct i2c_algo_cpm2_data *cpm, u_char abyte, char *buf, int count)
> +{
> +	volatile cpm2_map_t *immap = (cpm2_map_t *)CPM_MAP_ADDR;
> +	volatile iic_t *iip = cpm->iip;
> +	volatile i2c_cpm2_t *i2c = cpm->i2c;
> +	volatile cbd_t	*tbdf, *rbdf;
> +	u_char *tb;
> +	unsigned long flags;
> +
> +	if (count >= CPM_MAX_READ)
> +		return -EINVAL;
> +
> +	tbdf = (cbd_t *)&immap->im_dprambase[iip->iic_tbase];
> +	rbdf = (cbd_t *)&immap->im_dprambase[iip->iic_rbase];
> +
> +	/* To read, we need an empty buffer of the proper length.
> +	 * All that is used is the first byte for address, the remainder
> +	 * is just used for timing (and doesn't really have to exist).
> +	 */
> +	if (/*cpm->reloc*/0) {
> +		cpm_reset_iic_params(iip);
> +	}
> +	tb = cpm->temp;
> +	tb = (u_char *)(((uint)tb + 15) & ~15);
> +	tb[0] = abyte;		/* Device address byte w/rw flag */
> +
> +	dma_cache_wback_inv (tb, 1);
> +
> +	if (cpm_debug) printk(KERN_DEBUG "cpm_iic_read(abyte=0x%x)\n", abyte);
> +
> +	tbdf->cbd_bufaddr = __pa(tb);
> +	tbdf->cbd_datlen = count + 1;
> +	tbdf->cbd_sc =
> +		BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
> +		BD_SC_WRAP | BD_IIC_START;
> +
> +	rbdf->cbd_datlen = 0;
> +	rbdf->cbd_bufaddr = __pa(buf);
> +	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
> +
> +	if (count > 0 && count < CPM_MAX_READ)
> +		iip->iic_mrblr = count;	/* prevent excessive read */
> +
> +	dma_cache_inv (buf, count);
> +
> +	/* Chip bug, set enable here */
> +	local_irq_save(flags);
> +	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +	i2c->i2c_i2cer = 0xff;
> +	i2c->i2c_i2mod |= 1;	/* Enable */
> +	i2c->i2c_i2com = 0x81;	/* Start master */
> +
> +	/* Wait for IIC transfer */
> +	interruptible_sleep_on(&iic_wait);
> +	local_irq_restore(flags);
> +	if (signal_pending(current))
> +		return -EIO;
> +
> +	if (cpm_debug) {
> +		printk(KERN_DEBUG "tx sc %04x, rx sc %04x\n",
> +		       tbdf->cbd_sc, rbdf->cbd_sc);
> +	}
> +
> +	if (tbdf->cbd_sc & BD_SC_NAK) {
> +		printk(KERN_INFO "IIC read; no ack\n");
> +		return 0;
> +	}
> +
> +	if (rbdf->cbd_sc & BD_SC_EMPTY) {
> +		printk(KERN_INFO "IIC read; complete but rbuf empty\n");
> +		force_close(cpm);
> +		printk(KERN_INFO "tx sc %04x, rx sc %04x\n",
> +		       tbdf->cbd_sc, rbdf->cbd_sc);
> +	}
> +
> +	if (cpm_debug) printk(KERN_DEBUG "read %d bytes\n", rbdf->cbd_datlen);
> +
> +	if (rbdf->cbd_datlen < count) {
> +		printk(KERN_INFO "IIC read; short, wanted %d got %d\n",
> +		       count, rbdf->cbd_datlen);
> +		return 0;
> +	}
> +	if (cpm_debug) {
> +			int u;
> +			for (u = 0; u < count; u++) {
> +				printk(KERN_DEBUG "buf[%d] = 0x%x\n", u, buf[u]);
> +			}
> +			}
> +
> +
> +	return count;
> +}
> +
> +/* Write to IIC...
> + * addr = address byte, with r/w flag already set
> + */
> +static int
> +cpm_iic_write(struct i2c_algo_cpm2_data *cpm, u_char abyte, char *buf,int count)
> +{
> +	volatile cpm2_map_t *immap = (cpm2_map_t *)CPM_MAP_ADDR;
> +	volatile iic_t *iip = cpm->iip;
> +	volatile i2c_cpm2_t *i2c = cpm->i2c;
> +	volatile cbd_t	*tbdf;
> +	u_char *tb;
> +	unsigned long flags;
> +
> +	tb = cpm->temp;
> +	tb = (u_char *)(((uint)tb + 15) & ~15);
> +	*tb = abyte;		/* Device address byte w/rw flag */
> +
> +	dma_cache_wback_inv (tb, 1);
> +	dma_cache_wback_inv (buf, count);
> +
> +	if (cpm_debug) printk(KERN_DEBUG "cpm_iic_write(abyte=0x%x)\n", abyte);
> +	if (cpm_debug) printk(KERN_DEBUG "buf[0] = 0x%x, buf[1] = 0x%x\n", buf[0], buf[1]);
> +
> +	/* set up 2 descriptors */
> +	tbdf = (cbd_t *)&immap->im_dprambase[iip->iic_tbase];
> +
> +	tbdf[0].cbd_bufaddr = __pa(tb);
> +	tbdf[0].cbd_datlen = 1;
> +	tbdf[0].cbd_sc = BD_SC_READY | BD_IIC_START;
> +
> +	tbdf[1].cbd_bufaddr = __pa(buf);
> +	tbdf[1].cbd_datlen = count;
> +	tbdf[1].cbd_sc = BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;
> +
> +	/* Chip bug, set enable here */
> +	local_irq_save(flags);;
> +	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +	i2c->i2c_i2cer = 0xff;
> +	i2c->i2c_i2mod |= 1;	/* Enable */
> +	i2c->i2c_i2com = 0x81;	/* Start master */
> +
> +	/* Wait for IIC transfer */
> +	interruptible_sleep_on(&iic_wait);
> +	local_irq_restore(flags);
> +	if (signal_pending(current))
> +		return -EIO;
> +
> +	if (cpm_debug) {
> +		printk(KERN_DEBUG "tx0 sc %04x, tx1 sc %04x\n",
> +		       tbdf[0].cbd_sc, tbdf[1].cbd_sc);
> +	}
> +
> +	if (tbdf->cbd_sc & BD_SC_NAK) {
> +		printk(KERN_INFO "IIC write; no ack\n");
> +		return 0;
> +	}
> +	  
> +	if (tbdf->cbd_sc & BD_SC_READY) {
> +		printk(KERN_INFO "IIC write; complete but tbuf ready\n");
> +		return 0;
> +	}
> +
> +	return count;
> +}
> +
> +#if 0
> +/* See if an IIC address exists..
> + * addr = 7 bit address, unshifted
> + */
> +static int
> +cpm_iic_tryaddress(struct i2c_algo_cpm2_data *cpm, int addr)
> +{
> +	volatile cpm2_map_t *immap = (cpm2_map_t *)CPM_MAP_ADDR;
> +	volatile iic_t *iip = cpm->iip;
> +	volatile i2c_cpm2_t *i2c = cpm->i2c;
> +	volatile cbd_t *tbdf, *rbdf;
> +	u_char *tb;
> +	unsigned long flags, len;
> +
> +	if (cpm_debug > 1)
> +		printk(KERN_DEBUG "cpm_iic_tryaddress(cpm=%p,addr=%d)\n", cpm, addr);
> +
> +	if (cpm_debug && addr == 0) {
> +		printk(KERN_DEBUG "iip %p, dp_addr 0x%x\n", cpm->iip, cpm->dp_addr);
> +		printk(KERN_DEBUG "iic_tbase %d, r_tbase %d\n", iip->iic_tbase, r_tbase);
> +	}
> +
> +	tbdf = (cbd_t *)&immap->im_dprambase[iip->iic_tbase];
> +	rbdf = (cbd_t *)&immap->im_dprambase[iip->iic_rbase];
> +
> +	tb = cpm->temp;
> +	tb = (u_char *)(((uint)tb + 15) & ~15);
> +
> +	/* do a simple read */
> +	tb[0] = (addr << 1) | 1;	/* device address (+ read) */
> +	len = 2;
> +
> +	dma_cache_wback_inv (tb, 1);
> +
> +	tbdf->cbd_bufaddr = __pa(tb);
> +	tbdf->cbd_datlen = len;
> +	tbdf->cbd_sc =
> +		BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
> +		BD_SC_WRAP | BD_IIC_START;
> +
> +	rbdf->cbd_datlen = 0;
> +	rbdf->cbd_bufaddr = __pa(tb+2);
> +	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;
> +
> +	local_irq_save(flags);
> +	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
> +	i2c->i2c_i2cer = 0xff;
> +	i2c->i2c_i2mod |= 1;	/* Enable */
> +	i2c->i2c_i2com = 0x81;	/* Start master */
> +
> +	if (cpm_debug > 1) printk(KERN_DEBUG "about to sleep\n");
> +
> +	/* wait for IIC transfer */
> +	interruptible_sleep_on(&iic_wait);
> +	local_irq_restore(flags);
> +	if (signal_pending(current))
> +		return -EIO;
> +
> +	if (cpm_debug > 1) printk(KERN_DEBUG "back from sleep\n");
> +
> +	if (tbdf->cbd_sc & BD_SC_NAK) {
> +		if (cpm_debug > 1) printk(KERN_DEBUG "IIC try; no ack\n");
> +		return 0;
> +	}
> +	  
> +	if (tbdf->cbd_sc & BD_SC_READY) {
> +		printk(KERN_INFO "IIC try; complete but tbuf ready\n");
> +	}
> +	
> +	return 1;
> +}
> +#endif
> +
> +static int cpm2_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct i2c_msg *pmsg;
> +	int i;
> +	int ret = 0;
> +	struct mpc_i2c *mpc_i2c = i2c_get_adapdata(adap);
> +	struct i2c_algo_cpm2_data *data = mpc_i2c->data;
> +	u_char addr;
> +
> +	for (i = 0; i < num; i++) {
> +			pmsg = &msgs[i];
> +
> +		if (cpm_debug)
> +			printk(KERN_DEBUG "i2c-cpm2.o: "
> +			       "#%d addr=0x%x flags=0x%x len=%d\n",
> +			       i, pmsg->addr, pmsg->flags, pmsg->len);
> +
> +		addr = pmsg->addr << 1;
> +		if (pmsg->flags & I2C_M_RD )
> +			addr |= 1;
> +		if (pmsg->flags & I2C_M_REV_DIR_ADDR )
> +			addr ^= 1;
> +   
> +		if (!(pmsg->flags & I2C_M_NOSTART)) {
> +		}
> +		if (pmsg->flags & I2C_M_RD ) {
> +			/* read bytes into buffer*/
> +			ret = cpm_iic_read(data, addr, pmsg->buf, pmsg->len);
> +			if (cpm_debug)
> +				printk(KERN_DEBUG "i2c-cpm2.o: read %d bytes\n", ret);
> +			if (ret < pmsg->len ) {
> +				return (ret<0)? ret : -EREMOTEIO;
> +			}
> +		} else {
> +			/* write bytes from buffer */
> +			ret = cpm_iic_write(data, addr, pmsg->buf, pmsg->len);
> +			if (cpm_debug)
> +				printk(KERN_DEBUG "i2c-cpm2.o: wrote %d\n", ret);
> +			if (ret < pmsg->len ) {
> +				return (ret<0) ? ret : -EREMOTEIO;
> +			}
> +		}
> +	}
> +	return (ret < 0) ? ret : num;
> +}
> +
> +static u32 cpm2_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
> +	       I2C_FUNC_PROTOCOL_MANGLING; 
> +}
> +
> +static struct i2c_algorithm cpm2_algo = {
> +	.master_xfer = cpm2_xfer,
> +	.functionality = cpm2_functionality,
> +};
> +
> +static struct i2c_adapter cpm2_ops = {
> +	.owner = THIS_MODULE,
> +	.name = "MPC CPM2 adapter",
> +	.id = I2C_HW_MPC82xx,
> +	.algo = &cpm2_algo,
> +	.class = I2C_CLASS_HWMON,
> +	.timeout = 1,
> +	.retries = 1
> +};
> +
> +static int fsl_i2c_probe(struct device *device)
> +{
> +	int result = 0;
> +	struct mpc_i2c *i2c;
> +	struct platform_device *pdev = to_platform_device(device);
> +	struct fsl_i2c_platform_data *pdata;
> +
> +	pdata = (struct fsl_i2c_platform_data *) pdev->dev.platform_data;
> +
> +	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))) {
> +		return -ENOMEM;
> +	}
> +	memset(i2c, 0, sizeof(*i2c));
> +
> +	i2c->data = &cpm2_data;
> +	/* CPM Plattform initialisation */
> +	cpm2_iic_init (i2c->data);
> +	/* CPM init */
> +	cpm_iic_init (i2c->data);
> +	i2c->irq = platform_get_irq(pdev, 0);
> +
> +	if (i2c->irq != 0) {
> +		if ((result = request_irq(i2c->irq, cpm2_i2c_isr,
> +					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
> +			printk(KERN_ERR
> +			       "i2c-mpc - failed to attach interrupt\n");
> +			goto fail_irq;
> +		}
> +	}
> +	dev_set_drvdata(device, i2c);
> +
> +	i2c->adap = cpm2_ops;
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +	i2c->adap.dev.parent = &pdev->dev;
> +	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
> +		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
> +		goto fail_add;
> +	}
> +
> +	return result;
> +
> +  fail_add:
> +	if (i2c->irq != 0)
> +		free_irq(i2c->irq, NULL);
> +  fail_irq:
> +	kfree(i2c);
> +	return result;
> +};
> +
> +static int fsl_i2c_remove(struct device *device)
> +{
> +	struct mpc_i2c *i2c = dev_get_drvdata(device);
> +
> +	cpm_dpfree (i2c->data->dp_addr);
> +	
> +	i2c_del_adapter(&i2c->adap);
> +	dev_set_drvdata(device, NULL);
> +
> +	if (i2c->irq != 0)
> +		free_irq(i2c->irq, i2c);
> +
> +	kfree(i2c);
> +	return 0;
> +};
> +
> +/* Structure for a device driver */
> +static struct device_driver fsl_i2c_driver = {
> +	.name = "fsl-cpm-i2c",
> +	.bus = &platform_bus_type,
> +	.probe = fsl_i2c_probe,
> +	.remove = fsl_i2c_remove,
> +};
> +
> +static int __init fsl_i2c_init(void)
> +{
> +	return driver_register(&fsl_i2c_driver);
> +}
> +
> +static void __exit fsl_i2c_exit(void)
> +{
> +	driver_unregister(&fsl_i2c_driver);
> +}
> +
> +module_init(fsl_i2c_init);
> +module_exit(fsl_i2c_exit);
> +
> +MODULE_AUTHOR("Heiko Schocher <hs@denx.de>");
> +MODULE_DESCRIPTION
> +    ("I2C-Bus adapter for MPC with CPM2 processors");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/i2c-algo-cpm2.h b/include/linux/i2c-algo-cpm2.h
> new file mode 100644
> index 0000000..f03277c
> --- /dev/null
> +++ b/include/linux/i2c-algo-cpm2.h
> @@ -0,0 +1,26 @@
> +/* ----------------------------------------------------------- */
> +/* i2c-algo-cpm2.h i2c driver algorithms for MPC with CPM2     */
> +/* ----------------------------------------------------------- */
> +
> +/* $Id$ */
> +
> +#ifndef I2C_ALGO_CPM2_H
> +#define I2C_ALGO_CPM2_H 1
> +
> +#include <linux/i2c.h>
> +
> +struct i2c_algo_cpm2_data {
> +	uint dp_addr;
> +	int reloc;
> +	volatile i2c_cpm2_t *i2c;
> +	volatile iic_t	*iip;
> +	volatile cpm_cpm2_t *cp;
> +
> +	int	(*setisr) (int irq,
> +			   void (*func)(int, void (*)(void *), void *),
> +			   void *data);
> +
> +	u_char	temp[513];
> +};
> +
> +#endif /* I2C_ALGO_CPM2_H */
> diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
> index 1543daa..e7a12cc 100644
> --- a/include/linux/i2c-id.h
> +++ b/include/linux/i2c-id.h
> @@ -223,6 +223,9 @@
>  /* --- PowerPC on-chip adapters						*/
>  #define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */
>  
> +/* --- MPC82xx PowerPC adapters				*/
> +#define I2C_HW_MPC82xx		0x100002 /* MPC82xx I2C adapter */
> +
>  /* --- Broadcom SiByte adapters						*/
>  #define I2C_HW_SIBYTE		0x150000
>  
> 
