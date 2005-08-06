Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id 7F44367F06
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 04:01:34 +1000 (EST)
Date: Sat, 6 Aug 2005 15:01:31 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050806180131.GU5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] 8xx: port i2c-algo-8xx to 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8xx: port i2c-algo_8xx to 2.6

Based on Tom Rini's work

compile tested

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 2.6-8xx/drivers/i2c/algos/i2c-algo-8xx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6-8xx/drivers/i2c/algos/i2c-algo-8xx.c	2005-08-05 17:16:08.000000000 -0300
@@ -0,0 +1,625 @@
+/*
+ * i2c-algo-8xx.c i2x driver algorithms for MPC8XX CPM
+ * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
+ *
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * moved into proper i2c interface; separated out platform specific
+ * parts into i2c-rpx.c
+ * Brad Parker (brad@heeltoe.com)
+ */
+
+// XXX todo
+// timeout sleep?
+
+/* $Id: i2c-algo-8xx.c,v 1.7 2002/08/03 22:48:18 ac9410 Exp $ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+
+#include <asm/mpc8xx.h>
+#include <asm/commproc.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-8xx.h>
+
+#define CPM_MAX_READ	513
+/* Try uncomment this if you have an older CPU(earlier than rev D4) */
+/* #define I2C_CHIP_ERRATA */
+
+static char *module_name = "i2c_algo_8xx";
+#define DEBUGP(level, x, y...) do { \
+				if (cpm_debug >= level) \
+					printk(KERN_DEBUG "%s: " x, \
+					       module_name, ## y); \
+				} while(0)
+
+static wait_queue_head_t iic_wait;
+static ushort r_tbase, r_rbase;
+
+int cpm_scan = 0;
+int cpm_debug = 0;
+
+static  void
+cpm_iic_interrupt(void *dev_id, struct pt_regs *regs)
+ {
+	volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;
+
+	DEBUGP(2, "cpm_iic_interrupt(dev_id=%p)\n", dev_id);
+
+#ifdef I2C_CHIP_ERRATA
+	/* Chip errata, clear enable.
+	 * This seems to not be needed on rev D4 or newer CPUs.
+	 * Someone with an older CPU needs to verify this.
+	 */
+	i2c->i2c_i2mod &= ~1;
+#endif
+
+	/* Clear interrupt.
+	*/
+	i2c->i2c_i2cer = 0xff;
+
+	/* Get 'me going again.
+	*/
+	wake_up_interruptible(&iic_wait);
+}
+
+static void
+cpm_iic_init(struct i2c_algo_8xx_data *cpm_adap)
+{
+	volatile iic_t		*iip = cpm_adap->iip;
+	volatile i2c8xx_t	*i2c = cpm_adap->i2c;
+	unsigned char brg;
+	bd_t *bd = (bd_t *)__res;
+
+	DEBUGP(1, "cpm_iic_init() - iip=%p\n", iip);
+
+	/* Initialize the parameter ram.
+	 * We need to make sure many things are initialized to zero,
+	 * especially in the case of a microcode patch.
+	 */
+	iip->iic_rstate = 0;
+	iip->iic_rdp = 0;
+	iip->iic_rbptr = 0;
+	iip->iic_rbc = 0;
+	iip->iic_rxtmp = 0;
+	iip->iic_tstate = 0;
+	iip->iic_tdp = 0;
+	iip->iic_tbptr = 0;
+	iip->iic_tbc = 0;
+	iip->iic_txtmp = 0;
+
+	/* Set up the IIC parameters in the parameter ram.
+	*/
+	iip->iic_tbase = r_tbase = cpm_adap->dp_addr;
+	iip->iic_rbase = r_rbase = cpm_adap->dp_addr + sizeof(cbd_t) * 2;
+
+	iip->iic_tfcr = SMC_EB;
+	iip->iic_rfcr = SMC_EB;
+
+	/* Set maximum receive size.
+	*/
+	iip->iic_mrblr = CPM_MAX_READ;
+
+	/* Initialize Tx/Rx parameters.
+	*/
+	if (cpm_adap->reloc == 0) {
+		volatile cpm8xx_t *cp = cpm_adap->cp;
+
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	} else {
+		iip->iic_rbptr = iip->iic_rbase;
+		iip->iic_tbptr = iip->iic_tbase;
+		iip->iic_rstate	= 0;
+		iip->iic_tstate	= 0;
+	}
+
+	/* Select an arbitrary address.  Just make sure it is unique.
+	*/
+	i2c->i2c_i2add = 0xfe;
+
+	/* Make clock run at 60 KHz.
+	*/
+	brg = (unsigned char) (bd->bi_intfreq/(32*2*60000) -3);
+	i2c->i2c_i2brg = brg;
+
+	i2c->i2c_i2mod = 0x00;
+	i2c->i2c_i2com = 0x01; /* Master mode */
+
+	/* Disable interrupts.
+	*/
+	i2c->i2c_i2cmr = 0;
+	i2c->i2c_i2cer = 0xff;
+
+	init_waitqueue_head(&iic_wait);
+
+	/* Install interrupt handler.
+	*/
+	DEBUGP(1, "Install ISR for IRQ %d\n", CPMVEC_I2C);
+	cpm_install_handler(CPMVEC_I2C, cpm_iic_interrupt, (void *)i2c);
+}
+
+
+static int
+cpm_iic_shutdown(struct i2c_algo_8xx_data *cpm_adap)
+{
+	volatile i2c8xx_t *i2c = cpm_adap->i2c;
+
+	/* Shut down IIC.
+	*/
+	i2c->i2c_i2mod &= ~1;
+	i2c->i2c_i2cmr = 0;
+	i2c->i2c_i2cer = 0xff;
+
+	return 0;
+}
+
+static void
+cpm_reset_iic_params(volatile iic_t *iip)
+{
+	iip->iic_tbase = r_tbase;
+	iip->iic_rbase = r_rbase;
+
+	iip->iic_tfcr = SMC_EB;
+	iip->iic_rfcr = SMC_EB;
+
+	iip->iic_mrblr = CPM_MAX_READ;
+
+	iip->iic_rstate = 0;
+	iip->iic_rdp = 0;
+	iip->iic_rbptr = iip->iic_rbase;
+	iip->iic_rbc = 0;
+	iip->iic_rxtmp = 0;
+	iip->iic_tstate = 0;
+	iip->iic_tdp = 0;
+	iip->iic_tbptr = iip->iic_tbase;
+	iip->iic_tbc = 0;
+	iip->iic_txtmp = 0;
+}
+
+#define BD_SC_NAK		((ushort)0x0004) /* NAK - did not respond */
+#define BD_SC_OV		((ushort)0x0002) /* OV - receive overrun */
+#define CPM_CR_CLOSE_RXBD	((ushort)0x0007)
+
+static void force_close(struct i2c_algo_8xx_data *cpm)
+{
+	volatile i2c8xx_t *i2c = cpm->i2c;
+	if (cpm->reloc == 0) { /* micro code disabled */
+		volatile cpm8xx_t *cp = cpm->cp;
+
+		DEBUGP(1, "force_close()\n");
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RXBD) |
+			CPM_CR_FLG;
+
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	}
+	i2c->i2c_i2cmr = 0x00;	/* Disable all interrupts */
+	i2c->i2c_i2cer = 0xff;
+}
+
+
+/* Read from IIC...
+ * abyte = address byte, with r/w flag already set
+ */
+static int
+cpm_iic_read(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf, int count)
+{
+	volatile iic_t *iip = cpm->iip;
+	volatile i2c8xx_t *i2c = cpm->i2c;
+	volatile cpm8xx_t *cp = cpm->cp;
+	volatile cbd_t	*tbdf, *rbdf;
+	u_char *tb;
+	unsigned long flags, tmo;
+
+	if (count >= CPM_MAX_READ)
+		return -EINVAL;
+
+	/* check for and use a microcode relocation patch */
+	if (cpm->reloc)
+		cpm_reset_iic_params(iip);
+
+	tbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
+	rbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];
+
+	/* To read, we need an empty buffer of the proper length.
+	 * All that is used is the first byte for address, the remainder
+	 * is just used for timing (and doesn't really have to exist).
+	 */
+	tb = cpm->temp;
+	tb = (u_char *)(((uint)tb + 15) & ~15);
+	tb[0] = abyte;		/* Device address byte w/rw flag */
+
+	flush_dcache_range((unsigned long) tb, (unsigned long) (tb + 1));
+
+	DEBUGP(1, "cpm_iic_read(abyte=0x%x)\n", abyte);
+
+	tbdf->cbd_bufaddr = __pa(tb);
+	tbdf->cbd_datlen = count + 1;
+	tbdf->cbd_sc =
+		BD_SC_READY | BD_SC_LAST |
+		BD_SC_WRAP | BD_IIC_START;
+
+	iip->iic_mrblr = count + 1; /* prevent excessive read, +1
+				      is needed otherwise will the
+				      RXB interrupt come too early */
+
+	/* flush will invalidate too. */
+	flush_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
+
+	rbdf->cbd_datlen = 0;
+	rbdf->cbd_bufaddr = __pa(buf);
+
+	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP| BD_SC_INTRPT;
+	if(count > 16){
+		/* Chip bug, set enable here */
+		local_irq_save(flags);
+		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+
+		/* Wait for IIC transfer */
+		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+		local_irq_restore(flags);
+	} else { /* busy wait for small transfers, its faster */
+		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+		tmo = jiffies + 1*HZ;
+	       	/* Busy wait, with a timeout */
+		while(!(i2c->i2c_i2cer & 0x11 || time_after(jiffies, tmo)));
+	}
+
+	if (signal_pending(current) || !tmo){
+		force_close(cpm);
+		DEBUGP(1, "IIC read: timeout!\n");
+ 		return -EIO;
+	}
+#ifdef I2C_CHIP_ERRATA
+	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
+	 Disabling I2C too early may cause too short stop condition */
+	udelay(4);
+	i2c->i2c_i2mod &= ~1;
+#endif
+
+	DEBUGP(1, "tx sc %04x, rx sc %04x\n", tbdf->cbd_sc, rbdf->cbd_sc);
+
+	if (tbdf->cbd_sc & BD_SC_READY) {
+		printk(KERN_INFO "IIC read; complete but tbuf ready\n");
+		force_close(cpm);
+		printk(KERN_INFO "tx sc %04x, rx sc %04x\n",
+		       tbdf->cbd_sc, rbdf->cbd_sc);
+	}
+
+	if (tbdf->cbd_sc & BD_SC_NAK) {
+		DEBUGP(1, "IIC read; no ack\n");
+		return -EREMOTEIO;
+ 	}
+
+	if (rbdf->cbd_sc & BD_SC_EMPTY) {
+		/* force_close(cpm); */
+		DEBUGP(1, "IIC read; complete but rbuf empty\n");
+		DEBUGP(1, "tx sc %04x, rx sc %04x\n", tbdf->cbd_sc, rbdf->cbd_sc);
+		return -EREMOTEIO;
+	}
+
+	if (rbdf->cbd_sc & BD_SC_OV) {
+		DEBUGP(1, "IIC read; Overrun\n");
+		return -EREMOTEIO;;
+ 	}
+
+	DEBUGP(1, "read %d bytes\n", rbdf->cbd_datlen);
+
+	if (rbdf->cbd_datlen < count) {
+		DEBUGP(1, "IIC read; short, wanted %d got %d\n", count,
+		       rbdf->cbd_datlen);
+		return 0;
+	}
+
+	return count;
+}
+
+/* Write to IIC...
+ * addr = address byte, with r/w flag already set
+ */
+static int
+cpm_iic_write(struct i2c_algo_8xx_data *cpm, u_char abyte, char *buf,int count)
+{
+	volatile iic_t *iip = cpm->iip;
+	volatile i2c8xx_t *i2c = cpm->i2c;
+	volatile cpm8xx_t *cp = cpm->cp;
+	volatile cbd_t	*tbdf;
+	u_char *tb;
+	unsigned long flags, tmo;
+
+	/* check for and use a microcode relocation patch */
+	if (cpm->reloc)
+		cpm_reset_iic_params(iip);
+	tb = cpm->temp;
+	tb = (u_char *)(((uint)tb + 15) & ~15);
+	*tb = abyte;		/* Device address byte w/rw flag */
+
+	flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));
+	flush_dcache_range((unsigned long) buf, (unsigned long) (buf+count));
+
+	DEBUGP(1, "cpm_iic_write(abyte=0x%x)\n", abyte);
+
+	/* set up 2 descriptors */
+	tbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
+
+	tbdf[0].cbd_bufaddr = __pa(tb);
+	tbdf[0].cbd_datlen = 1;
+	tbdf[0].cbd_sc = BD_SC_READY | BD_IIC_START;
+
+	tbdf[1].cbd_bufaddr = __pa(buf);
+	tbdf[1].cbd_datlen = count;
+	tbdf[1].cbd_sc = BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST | BD_SC_WRAP;
+
+	if (count > 16) {
+		/* Chip bug, set enable here */
+		local_irq_save(flags);
+		i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+
+		/* Wait for IIC transfer */
+		tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+		local_irq_restore(flags);
+	} else {  /* busy wait for small transfers, its faster */
+		i2c->i2c_i2cmr = 0x00;	/* Disable I2C interupts */
+		i2c->i2c_i2cer = 0xff;
+		i2c->i2c_i2mod |= 1;	/* Enable */
+		i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+		tmo = jiffies + 1*HZ;
+	       	/* Busy wait, with a timeout */
+		while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo)));
+	}
+
+	if (signal_pending(current) || !tmo){
+		force_close(cpm);
+		if (!tmo)
+			DEBUGP(1, "IIC write: timeout!\n");
+		return -EIO;
+	}
+
+#if I2C_CHIP_ERRATA
+	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
+	 Disabling I2C too early may cause too short stop condition */
+	udelay(4);
+	i2c->i2c_i2mod &= ~1;
+#endif
+	DEBUGP(1, "tx0 sc %04x, tx1 sc %04x\n", tbdf[0].cbd_sc,
+	       tbdf[1].cbd_sc);
+
+	if ((tbdf[0].cbd_sc | tbdf[1].cbd_sc) & BD_SC_NAK) {
+		DEBUGP(1, "IIC write; no ack\n");
+		return 0;
+	}
+
+	if ((tbdf[0].cbd_sc | tbdf[1].cbd_sc) & BD_SC_READY) {
+		DEBUGP(1, "IIC write; complete but tbuf ready\n");
+		return 0;
+	}
+
+	return count;
+}
+
+/* See if an IIC address exists..
+ * addr = 7 bit address, unshifted
+ */
+static int
+cpm_iic_tryaddress(struct i2c_algo_8xx_data *cpm, int addr)
+{
+	volatile iic_t *iip = cpm->iip;
+	volatile i2c8xx_t *i2c = cpm->i2c;
+	volatile cpm8xx_t *cp = cpm->cp;
+	volatile cbd_t *tbdf, *rbdf;
+	u_char *tb;
+	unsigned long flags, len, tmo;
+
+	DEBUGP(2, "cpm_iic_tryaddress(cpm=%p,addr=%d)\n", cpm, addr);
+
+	/* check for and use a microcode relocation patch */
+	if (cpm->reloc)
+		cpm_reset_iic_params(iip);
+
+	if (addr == 0) {
+		DEBUGP(1, "iip %p, dp_addr 0x%x\n", cpm->iip, cpm->dp_addr);
+		DEBUGP(1, "iic_tbase %d, r_tbase %d\n", iip->iic_tbase,
+		       r_tbase);
+	}
+
+	tbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
+	rbdf = (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];
+
+	tb = cpm->temp;
+	tb = (u_char *)(((uint)tb + 15) & ~15);
+
+	/* do a simple read */
+	tb[0] = (addr << 1) | 1;	/* device address (+ read) */
+	len = 2;
+
+	flush_dcache_range((unsigned long) tb, (unsigned long) (tb+1));
+
+	tbdf->cbd_bufaddr = __pa(tb);
+	tbdf->cbd_datlen = len;
+	tbdf->cbd_sc =
+		BD_SC_READY | BD_SC_LAST |
+		BD_SC_WRAP | BD_IIC_START;
+
+	rbdf->cbd_datlen = 0;
+	rbdf->cbd_bufaddr = __pa(tb+2);
+	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;
+
+	local_irq_save(flags);
+	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
+	i2c->i2c_i2cer = 0xff;
+	i2c->i2c_i2mod |= 1;	/* Enable */
+	i2c->i2c_i2com |= 0x80;	/* Begin transmission */
+
+	DEBUGP(1, "about to sleep\n");
+
+	/* wait for IIC transfer */
+	tmo = interruptible_sleep_on_timeout(&iic_wait,1*HZ);
+	local_irq_restore(flags);
+
+#ifdef I2C_CHIP_ERRATA
+	/* Chip errata, clear enable. This is not needed on rev D4 CPUs.
+	 Disabling I2C too early may cause too short stop condition */
+	udelay(4);
+	i2c->i2c_i2mod &= ~1;
+#endif
+
+	if (signal_pending(current) || !tmo){
+		force_close(cpm);
+		if (!tmo)
+			DEBUGP(1, "IIC tryaddress: timeout!\n");
+		return -EIO;
+	}
+
+	DEBUGP(2, "back from sleep\n");
+
+	if (tbdf->cbd_sc & BD_SC_NAK) {
+		DEBUGP(2, "IIC try; no ack\n");
+		return 0;
+	}
+
+	if (tbdf->cbd_sc & BD_SC_READY)
+		printk(KERN_INFO "IIC try; complete but tbuf ready\n");
+
+	return 1;
+}
+
+static int cpm_xfer(struct i2c_adapter *i2c_adap,
+		    struct i2c_msg msgs[],
+		    int num)
+{
+	struct i2c_algo_8xx_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *pmsg;
+	int i, ret;
+	u_char addr;
+
+	for (i = 0; i < num; i++) {
+		pmsg = &msgs[i];
+
+		DEBUGP(1, "#%d addr=0x%x flags=0x%x len=%d\n buf=%p\n",
+		       i, pmsg->addr, pmsg->flags, pmsg->len, pmsg->buf);
+
+		addr = pmsg->addr << 1;
+		if (pmsg->flags & I2C_M_RD)
+			addr |= 1;
+		if (pmsg->flags & I2C_M_REV_DIR_ADDR)
+			addr ^= 1;
+
+		if (pmsg->flags & I2C_M_RD) {
+			/* read bytes into buffer*/
+			ret = cpm_iic_read(adap, addr, pmsg->buf, pmsg->len);
+			DEBUGP(1, "read %d bytes\n", ret);
+			if (ret < pmsg->len)
+				return (ret < 0)? ret:-EREMOTEIO;
+		} else {
+			/* write bytes from buffer */
+			ret = cpm_iic_write(adap, addr, pmsg->buf, pmsg->len);
+			DEBUGP(1, "wrote %d\n", ret);
+			if (ret < pmsg->len)
+				return (ret < 0)? ret:-EREMOTEIO;
+		}
+	}
+	return num;
+}
+
+static u32 cpm_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
+	       I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+static struct i2c_algorithm i2c_algo_8xx = {
+	.name = "MPC8xx CPM algorithm",
+	.id = I2C_ALGO_MPC8XX,
+	.master_xfer = cpm_xfer,
+	.functionality = cpm_func,
+};
+
+/*
+ * registering functions to load algorithms at runtime
+ */
+int i2c_8xx_add_bus(struct i2c_adapter *adap)
+{
+	int i;
+	struct i2c_algo_8xx_data *cpm_adap = adap->algo_data;
+
+	DEBUGP(1, "hw routines for %s registered.\n", adap->name);
+
+	/* register new adapter to i2c module... */
+
+	adap->id |= i2c_algo_8xx.id;
+	adap->algo = &i2c_algo_8xx;
+
+	i2c_add_adapter(adap);
+	cpm_iic_init(cpm_adap);
+
+	/* scan bus */
+	if (cpm_scan) {
+		printk(KERN_INFO "%s: scanning bus %s...\n", module_name,
+		       adap->name);
+		for (i = 0; i < 128; i++)
+			if (cpm_iic_tryaddress(cpm_adap, i)) {
+				printk("(%02x)", i << 1);
+			}
+		printk("\n");
+	}
+	return 0;
+}
+
+int i2c_8xx_del_bus(struct i2c_adapter *adap)
+{
+	int res;
+	struct i2c_algo_8xx_data *cpm_adap = adap->algo_data;
+
+	cpm_iic_shutdown(cpm_adap);
+
+	if ((res = i2c_del_adapter(adap)) < 0)
+		return res;
+
+	printk(KERN_INFO "%s: adapter unregistered: %s\n", module_name,
+	       adap->name);
+
+	return 0;
+}
+
+module_param(cpm_debug, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(cpm_debug, "Sets the debug level. (0 = none, 1 = normal, "
+		 ">1 = plenty");
+MODULE_AUTHOR("Brad Parker <brad@heeltoe.com>");
+MODULE_DESCRIPTION("I2C-Bus MPC8XX algorithm");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(i2c_8xx_add_bus);
+EXPORT_SYMBOL(i2c_8xx_del_bus);
+
Index: 2.6-8xx/drivers/i2c/algos/Makefile
===================================================================
--- 2.6-8xx.orig/drivers/i2c/algos/Makefile	2005-07-28 12:05:11.000000000 -0300
+++ 2.6-8xx/drivers/i2c/algos/Makefile	2005-08-05 16:48:26.000000000 -0300
@@ -8,6 +8,7 @@
 obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
 obj-$(CONFIG_I2C_ALGO_SIBYTE)	+= i2c-algo-sibyte.o
 obj-$(CONFIG_I2C_ALGO_SGI)	+= i2c-algo-sgi.o
+obj-$(CONFIG_I2C_ALGO8XX)	+= i2c-algo-8xx.o
 
 ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
 EXTRA_CFLAGS += -DDEBUG
Index: 2.6-8xx/include/linux/i2c-algo-8xx.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6-8xx/include/linux/i2c-algo-8xx.h	2005-08-05 16:57:21.000000000 -0300
@@ -0,0 +1,28 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-algo-8xx.h i2c driver algorithms for MPX8XX CPM			     */
+/* ------------------------------------------------------------------------- */
+
+/* $Id$ */
+
+#ifndef I2C_ALGO_8XX_H
+#define I2C_ALGO_8XX_H
+
+#include <linux/i2c.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+
+struct i2c_algo_8xx_data {
+	uint dp_addr;
+	int reloc;
+	volatile i2c8xx_t *i2c;
+	volatile iic_t	*iip;
+	volatile cpm8xx_t *cp;
+
+	u_char	temp[513];
+};
+
+int i2c_8xx_add_bus(struct i2c_adapter *);
+int i2c_8xx_del_bus(struct i2c_adapter *);
+
+#endif /* I2C_ALGO_8XX_H */
+
