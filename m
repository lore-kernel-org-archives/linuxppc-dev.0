Return-Path: <cmurch@mrv.com>
Received: from chmailqsrv.int.mrv.com (mx2.lb.mrv.com [66.43.110.200])
	by ozlabs.org (Postfix) with ESMTP id 6C88B67BAC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 06:30:50 +1000 (EST)
Received: from chmailqsrv.int.mrv.com (127.0.0.1) by chmailqsrv.int.mrv.com
	(MlfMTA v3.2r1b3) id h7kirk0171s4 for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Oct 2006 13:22:34 -0700 (envelope-from <cmurch@mrv.com>)
Subject: Re: MPC8xx CPM I2C interface driver
From: Christopher Murch <cmurch@mrv.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20061023025001.45e821c3@localhost.localdomain>
References: <20061023025001.45e821c3@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-JyBpLYAhTGwcXPjAqgwY"
Date: Mon, 23 Oct 2006 16:17:05 -0400
Message-Id: <1161634626.23416.7.camel@cmurch>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-JyBpLYAhTGwcXPjAqgwY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's a simple driver that we wrote for 8xx i2c master-only usage.  It
only supports the I2C_RDWR ioctl to send and receive reads/writes to
various devices.

To integrate the patch, it will be necessary to modify your
linux/drivers/i2c/Makefile to build in the i2c-cpm support.

We've used this driver successfully with LM77 temp sensors, DS1337 RTC
and some EEPROMs.


On Sun, 2006-10-22 at 18:50 -0400, Vitaly Bordug wrote:
> _______________________________________________ 
> Linuxppc-embedded mailing list 
> Linuxppc-embedded@ozlabs.org 
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> email message attachment
> > -------- Forwarded Message --------
> > Subject: 
> > Date: Sun, 22 Oct 2006 18:57:11 -0400
> > 

--=-JyBpLYAhTGwcXPjAqgwY
Content-Disposition: attachment; filename=i2c-cpm.patch
Content-Type: text/x-patch; name=i2c-cpm.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- nothing	1969-12-31 19:00:00.000000000 -0500
+++ i2c-cpm.c	2006-10-23 16:00:56.000000000 -0400
@@ -0,0 +1,999 @@
+/*
+ *	ASP Watchdog   0.05:	In-Reach ASP Watchdog Device
+ *
+ *	(c) Copyright 2002 Ken Poole <kpoole@mrv.com>, All Rights Reserved.
+ *				http://www.mrv.com
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *	
+ *	Neither Ken Poole nor MRV Communications, Inc. admit liability
+ *      nor provide warranty for any of this software. This material is
+ *      provided "AS-IS" and at no charge.	
+ *
+ */
+ 
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/i2c-dev.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/proc_fs.h>
+#include <linux/dma-mapping.h>
+#include <asm/commproc.h>
+#include <asm/8xx_immap.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#define CPM_MAX_READ   513
+#define CPM_TIMEOUT    1000
+#define CPM_NUM_BDS    4
+#define CPM_WRT_BUF_SZ 128
+
+#define BD_SC_CLEARALL  (BD_SC_LAST | BD_SC_INTRPT | BD_IIC_START \
+			 | BD_SC_READY | BD_IIC_NAK | BD_IIC_UN | BD_IIC_CL)
+
+#define LOG_INT        1
+#define LOG_WRITE_ENT  2
+#define LOG_WRITE_CMD  3
+#define LOG_READ_ENT   4
+#define LOG_READ_CMD   5
+#define LOG_WRITE_DONE 6
+#define LOG_READ_DONE  7
+#define LOG_SIZE 128
+#define LOG_DISP  32
+
+struct i2c_datalog {
+  char type;          
+  char displayed;
+  char pad[2];
+  unsigned long msecs;
+  cbd_t *tbdf;
+  cbd_t *rbdf;
+  u16 tx_sc;
+  u16 rx_sc;
+  u16 tbptr;
+  u16 rbptr;
+};
+
+int i2c_logindex = 0;
+
+struct i2c_datalog i2c_log[LOG_SIZE];
+
+struct i2c_8xx {
+	uint dp_addr;
+	u16 reloc;
+	volatile i2c8xx_t *i2c;
+	volatile iic_t	*iip;
+	volatile cpm8xx_t *cp;
+        spinlock_t lock;
+};
+
+struct i2c_8xx cpm_i2c_8xx;
+
+#ifdef DECLARE_WAITQUEUE
+static wait_queue_head_t iic_rd_wait;
+static wait_queue_head_t iic_wr_wait;
+static wait_queue_head_t iic_cbd_wait;
+#else	
+static struct wait_queue *iic_rd_wait;
+static struct wait_queue *iic_wr_wait;
+static struct wait_queue *iic_cbd_wait;
+#endif	
+
+static ushort r_tbase, r_rbase;
+volatile static cbd_t *tbdf_cur, *rbdf_cur, *tbdf_base, *rbdf_base;
+#ifdef DEBUG_SHORT
+static char spbuf[256]; /* TEST TEST TEST */
+#endif
+
+#ifdef DEBUG_TIMEOUT
+unsigned char save_cer[32];
+int save_idx = 0;
+#endif
+
+unsigned char in_use;
+
+int cpm_scan = 0;
+int cpm_debug;
+
+static int cpm_iic_release(struct inode *inode, struct file *file);
+
+static unsigned long last_jifs = 0;
+
+static void make_log (char type, volatile cbd_t *tbdf, volatile cbd_t *rbdf)
+{
+  volatile iic_t *iip = cpm_i2c_8xx.iip;
+
+  i2c_log[i2c_logindex].type = type;
+  i2c_log[i2c_logindex].displayed = 0;
+  i2c_log[i2c_logindex].tbdf = (cbd_t *)tbdf;
+  i2c_log[i2c_logindex].rbdf = (cbd_t *)rbdf;
+  i2c_log[i2c_logindex].tx_sc = tbdf->cbd_sc;
+  i2c_log[i2c_logindex].rx_sc = rbdf->cbd_sc;
+  i2c_log[i2c_logindex].tbptr = iip->iic_tbptr;
+  i2c_log[i2c_logindex].rbptr = iip->iic_rbptr;
+  i2c_log[i2c_logindex].msecs = jiffies - last_jifs;
+
+  last_jifs = jiffies;
+
+  if (++i2c_logindex >= sizeof(i2c_log)/sizeof(struct i2c_datalog))
+    i2c_logindex = 0;
+}
+
+static void show_log (void)
+{
+  int index;
+  int count = 0;
+
+  index = i2c_logindex - LOG_DISP;
+  if (index < 0)
+    index = LOG_SIZE + index;
+
+  printk(KERN_DEBUG "logindex is %d\n", i2c_logindex);
+  while(1) {
+    if (i2c_log[index].displayed == 0) {
+      printk(KERN_DEBUG "%03d ", index);
+      printk(KERN_DEBUG "%04ld ", i2c_log[index].msecs);
+      switch (i2c_log[index].type) {
+      case LOG_INT:
+	printk(KERN_DEBUG "intrpt     "); break;
+      case LOG_WRITE_ENT:
+	printk(KERN_DEBUG "write ent  "); break;
+      case LOG_WRITE_CMD:
+	printk(KERN_DEBUG "write cmd  "); break;
+      case LOG_READ_ENT:
+	printk(KERN_DEBUG "read ent   "); break;
+      case LOG_READ_CMD:
+	printk(KERN_DEBUG "read cmd   "); break;
+      case LOG_WRITE_DONE:
+	printk(KERN_DEBUG "write done "); break;
+      case LOG_READ_DONE:
+	printk(KERN_DEBUG "read done  "); break;
+      }
+      printk(KERN_DEBUG "tbdf=%p rbdf=%p tx_sc=%04x rx_sc=%04x tbptr=%04x rbptr=%04x\n",
+	   i2c_log[index].tbdf, i2c_log[index].rbdf, i2c_log[index].tx_sc, i2c_log[index].rx_sc,
+	   i2c_log[index].tbptr, i2c_log[index].rbptr);
+      i2c_log[index].displayed = 1;
+    }
+    if (++index >= LOG_SIZE)
+      index = 0;
+    if (++count >= LOG_DISP)
+      break;
+  }
+  return;
+}
+
+static irqreturn_t
+cpm_iic_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;
+	unsigned char local_cer;
+	volatile iic_t *iip = cpm_i2c_8xx.iip;
+	volatile cpm8xx_t *cp = cpm_i2c_8xx.cp;
+
+	if (cpm_debug > 1)
+		printk("cpm_iic_interrupt(dev_id=%p)\n", dev_id);
+
+	/* Save status */
+	local_cer = i2c->i2c_i2cer;
+	/* Clear interrupt */
+	i2c->i2c_i2cer = local_cer;
+
+	if ((local_cer & 0x14) && cpm_debug)
+	  printk("cpm_iic_int: error int %02x\n", local_cer);
+
+	/* Chip errata, clear enable.
+	*/
+	/* i2c->i2c_i2mod = 0; */
+
+#ifdef DEBUG_TIMEOUT
+	/* Record interrupt status */
+	save_cer[++save_idx] = local_cer;
+	if (save_idx >= 32)
+	  save_idx = 0;
+#endif
+	/* printk(KERN_ERR "cpm_iic_int: iip=%p tbdf=%p rbdf=%p\n",
+	       iip, &cp->cp_dpmem[iip->iic_tbptr],
+	       &cp->cp_dpmem[iip->iic_rbptr]); */
+        make_log(LOG_INT, (cbd_t *)&cp->cp_dpmem[iip->iic_tbptr], (cbd_t *)&cp->cp_dpmem[iip->iic_rbptr]);
+
+	/* Get 'me going again.
+	*/
+	if (local_cer & 0x01) {
+	  wake_up_interruptible(&iic_rd_wait);
+	}
+	if (local_cer & 0x02) {
+	  wake_up_interruptible(&iic_wr_wait);
+	}
+	if (local_cer & 0x14) {
+	  wake_up_interruptible(&iic_rd_wait);
+	  wake_up_interruptible(&iic_wr_wait);
+	}	  
+	return IRQ_HANDLED;
+}
+
+#ifdef DEBUG_TIMEOUT
+static void
+show_last_ints(void)
+{
+  int i, j;
+
+	  j = save_idx - 7;
+	  if (j < 0)
+	    j = save_idx + 32;
+
+	  printk("last 8 ints (idx=%d): ", save_idx);
+	  for ( i = 0;  i < 8; i++) {
+	    printk(" %02x", save_cer[j]);
+	    if (j++ >= 32)
+	      j = 0;
+	  }
+	  printk("\n");
+}
+#endif
+
+
+static void 
+cpm_reset_iic_params(volatile iic_t *iip)
+{
+	iip->iic_tbase = r_tbase;
+	iip->iic_rbase = r_rbase;
+
+	tbdf_cur = tbdf_base;
+	rbdf_cur = rbdf_base;
+
+	iip->iic_tfcr = SMC_EB;
+	iip->iic_rfcr = SMC_EB;
+
+	iip->iic_mrblr = CPM_MAX_READ;
+
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
+}
+
+#define BD_SC_NAK		((ushort)0x0004) /* NAK - did not respond */
+
+static void force_close(struct i2c_8xx *cpm)
+{
+	if (cpm->reloc == 0) {
+		volatile cpm8xx_t *cp = cpm->cp;
+
+		if (cpm_debug) printk("force_close()\n");
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_CLOSE_RX_BD) |
+			CPM_CR_FLG;
+
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	}
+}
+
+/*
+ */
+static int cpm_iic_open(struct inode *inode, struct file *file)
+{
+  /* Ok, so what do we do with the open? */
+
+	return 0;
+}
+
+ssize_t cpm_iic_read(u_char abyte, dma_addr_t buf, int count)
+{
+	DECLARE_WAITQUEUE(rdwait, current);
+	volatile iic_t *iip = cpm_i2c_8xx.iip;
+	volatile i2c8xx_t *i2c = cpm_i2c_8xx.i2c;
+	volatile cpm8xx_t *cp = cpm_i2c_8xx.cp;
+	volatile cbd_t	*tbdf, *rbdf;
+	u_char *tb;
+	dma_addr_t tx_dma;
+	unsigned long orig;
+	int i;
+#ifdef DEBUG_TIMEOUT
+	int save_save_idx;
+#endif
+	if (count >= CPM_MAX_READ)
+		return -EINVAL;
+
+	/* check for and use a microcode relocation patch */
+	if (cpm_i2c_8xx.reloc) {
+		cpm_reset_iic_params(iip);
+	}
+
+	if (cpm_debug) printk("cpm_iic_read(abyte=0x%x)\n", abyte);
+
+	tbdf = tbdf_cur;
+	rbdf = rbdf_cur;
+	
+	/* Bump current and wrap */
+	if (tbdf->cbd_sc & BD_SC_WRAP)
+	        tbdf_cur = tbdf_base;
+	else
+	        tbdf_cur = tbdf + 1;
+	
+	if (rbdf->cbd_sc & BD_SC_WRAP)
+	        rbdf_cur = rbdf_base;
+	else
+	        rbdf_cur = rbdf + 1;
+
+	/* Allocate one transmit buffer. To read, we need an empty buffer
+	 * of the proper length. All that is used is the first byte for
+	 * address, the remainder is just used for timing (and doesn't
+	 * really have to exist).
+	 */
+	tb = dma_alloc_coherent(NULL, CPM_WRT_BUF_SZ, &tx_dma, GFP_KERNEL);
+	if (tb == NULL) {
+	  printk(KERN_ERR "cpm_iic_read: allocate failed\n");
+	}
+
+	tb[0] = abyte;		/* Device address byte w/rw flag */
+
+	//spin_lock_irqsave(&cpm_i2c_8xx.lock, flags );
+	spin_lock_irq(&cpm_i2c_8xx.lock);
+
+	/* Set up tx and rx descriptors */
+	tbdf->cbd_bufaddr = tx_dma;
+	tbdf->cbd_datlen = count + 1;
+
+	rbdf->cbd_datlen = 0;
+	rbdf->cbd_bufaddr = buf;
+
+	rbdf->cbd_sc |= BD_SC_EMPTY | BD_SC_INTRPT;
+	tbdf->cbd_sc |= BD_SC_READY | BD_SC_LAST | BD_IIC_START;
+
+	make_log(LOG_READ_CMD, tbdf, rbdf);
+
+	if (cpm_debug)
+	  printk("cpm_iic_read: tbdf=%p rbdf=%p rbptr=%x tx sc=%04x rx sc=%04x\n",
+		 tbdf, rbdf, iip->iic_rbptr, tbdf->cbd_sc, rbdf->cbd_sc);
+
+	/* Chip bug, set enable here */
+	i2c->i2c_i2cer = i2c->i2c_i2cer;
+	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
+	i2c->i2c_i2mod = 1;	/* Enable */
+	i2c->i2c_i2com = 0x81;	/* Start master */
+#ifdef DEBUG_TIMEOUT
+	save_save_idx = save_idx;
+#endif
+	orig = jiffies;         /* Remember start time */
+	add_wait_queue(&iic_rd_wait, &rdwait);
+	spin_unlock_irq(&cpm_i2c_8xx.lock);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	/* Wait for IIC transfer */
+	while(1) {
+	        if (!(rbdf->cbd_sc & BD_SC_EMPTY) && !(tbdf->cbd_sc & BD_SC_READY))
+		        break;
+		if (tbdf->cbd_sc & (BD_SC_NAK | BD_SC_OV | BD_SC_CL))
+		        break;
+
+	        if ((jiffies - orig) >= CPM_TIMEOUT) {
+#ifdef DEBUG_TIMEOUT
+	                printk("cpm_iic_read: timed out tx sc %04x, rx sc %04x \n",
+			       tbdf->cbd_sc, rbdf->cbd_sc);
+			printk("cpm_iic_read: tbdf=%p rbdf=%p rbptr=%x\n",
+			       tbdf, rbdf, iip->iic_rbptr);
+			show_last_ints();
+#endif
+			/* read_int_defect: */
+			show_log();
+			printk(KERN_DEBUG "cpm_iic_read: timed out wait for complete tbdf=%p rbdf=%p tx sc=%04x, rx sc=%04x\n",
+			       tbdf, rbdf, tbdf->cbd_sc, rbdf->cbd_sc);
+			tbdf->cbd_sc &= ~BD_SC_CLEARALL;
+			rbdf->cbd_sc &= ~BD_SC_OV;
+			/* Restore BD ptrs by reading controller reg */
+			tbdf_cur = (cbd_t *)&cp->cp_dpmem[iip->iic_tbptr];
+			rbdf_cur = (cbd_t *)&cp->cp_dpmem[iip->iic_rbptr];
+			i2c->i2c_i2mod = 0;
+			__set_current_state(TASK_RUNNING);
+			remove_wait_queue(&iic_rd_wait, &rdwait);
+			dma_free_coherent(NULL, CPM_WRT_BUF_SZ, tb, tx_dma);
+			return -ETIMEDOUT;
+		}
+		schedule_timeout(CPM_TIMEOUT);
+
+		if (signal_pending(current)) {
+			i2c->i2c_i2mod = 0;
+		        __set_current_state(TASK_RUNNING);
+		        remove_wait_queue(&iic_rd_wait, &rdwait);
+			dma_free_coherent(NULL, CPM_WRT_BUF_SZ, tb, tx_dma);
+		        return -EIO;
+		}
+	}
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&iic_rd_wait, &rdwait);
+	dma_free_coherent(NULL, CPM_WRT_BUF_SZ, tb, tx_dma);
+
+	make_log(LOG_READ_DONE, tbdf, rbdf);
+
+	if (cpm_debug) {
+		printk("tx sc %04x, rx sc %04x\n",
+		       tbdf->cbd_sc, rbdf->cbd_sc);
+	}
+
+	if (tbdf->cbd_sc & BD_SC_NAK) {
+	        if (cpm_debug)
+		    printk("IIC read; no ack tbdf %p rbdf %p\n",
+			   tbdf, rbdf);
+		force_close(&cpm_i2c_8xx);
+		/* NAK does not bump internal RBD pointer, so
+		   we have to re-use the software rbd index */
+		rbdf_cur = rbdf;
+		count = -ENODEV;
+		goto read_out;
+	}
+
+	if (rbdf->cbd_sc & BD_SC_EMPTY) {
+		printk("IIC read; complete but rbuf empty\n");
+		printk("tx sc %04x, rx sc %04x\n",
+		       tbdf->cbd_sc, rbdf->cbd_sc);
+		force_close(&cpm_i2c_8xx);
+	}
+
+	if (rbdf->cbd_datlen < count) {
+	        show_log();
+		printk("IIC read; short, wanted %d got %d (%d) ",
+		       count, rbdf->cbd_datlen, tbdf->cbd_datlen);
+		//for (i = 0; i < rbdf->cbd_datlen; i++)
+		//printk(" %02x", buf[i]);
+		printk(" tx sc %04x, rx sc %04x\n",
+		       tbdf->cbd_sc, rbdf->cbd_sc);
+
+		/* To recover from this, we pulse the SCL clock line
+		   manually for 10 more cycles */
+		cp->cp_pbpar &= ~0x00000020;
+		for (i = 0; i < 10; i++) {
+		  cp->cp_pbdat |= 0x00000020;
+		  udelay(10);
+		  cp->cp_pbdat &= ~0x00000020;
+		  udelay(10);
+		}
+		cp->cp_pbpar |= 0x00000020;
+#ifdef DEBUG_SHORT
+		printk("prev write: %s", spbuf);
+#endif
+#ifdef DEBUG_TIMEOUT
+		show_last_ints();
+#endif
+		count = 0;
+		/* Fall through */
+	}
+
+read_out:
+	i2c->i2c_i2mod = 0;
+	tbdf->cbd_sc &= ~BD_SC_CLEARALL;
+	rbdf->cbd_sc &= ~BD_IIC_OV;
+	return count;
+}
+
+ssize_t cpm_iic_write(u_char abyte, dma_addr_t buf, int count)
+{
+	DECLARE_WAITQUEUE(wrwait, current);
+	volatile iic_t *iip = cpm_i2c_8xx.iip;
+	volatile i2c8xx_t *i2c = cpm_i2c_8xx.i2c;
+	volatile cpm8xx_t *cp = cpm_i2c_8xx.cp;
+	volatile cbd_t	*tbdf0, *tbdf1;
+	u_char *tb;
+	dma_addr_t tx_dma;
+	unsigned long orig;
+#ifdef DEBUG_SHORT
+	int i, len = 0;
+#endif
+#ifdef DEBUG_TIMEOUT
+	int save_save_idx;
+#endif
+	/* check for and use a microcode relocation patch */
+	if (cpm_i2c_8xx.reloc) {
+		cpm_reset_iic_params(iip);
+	}
+
+	if (cpm_debug) printk("cpm_iic_write(abyte=0x%x)\n", abyte);
+
+	/* Get a descriptor */
+	tbdf0 = tbdf_cur;
+	/* Get next descriptor */
+	if (tbdf0->cbd_sc & BD_SC_WRAP)
+	        tbdf1 = tbdf_base;
+	else
+	        tbdf1 = tbdf0 + 1;
+
+	/* Bump current and and wrap */
+	if (tbdf1->cbd_sc & BD_SC_WRAP)
+	        tbdf_cur = tbdf_base;
+	else
+	        tbdf_cur = tbdf1 + 1;
+	
+	/* Allocate one transmit message buffer */
+	tb = dma_alloc_coherent(NULL, CPM_WRT_BUF_SZ, &tx_dma, GFP_KERNEL);
+	if (tb == NULL) {
+	  printk(KERN_ERR "cpm_iic_read: allocate failed\n");
+	}
+
+	*tb = abyte;		/* Device address byte w/rw flag */
+
+	//spin_lock_irqsave(&cpm_i2c_8xx.lock, flags);
+	spin_lock_irq(&cpm_i2c_8xx.lock);
+
+	/* Set up 1st descriptor */
+	tbdf0->cbd_datlen = 1;
+	tbdf0->cbd_bufaddr = tx_dma;
+
+	/* Set up 2nd desc */
+	//tbdf1->cbd_bufaddr = __pa(buf);
+	tbdf1->cbd_bufaddr = buf;
+	tbdf1->cbd_datlen = count;
+
+	tbdf1->cbd_sc |= BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST;
+	tbdf0->cbd_sc |= BD_SC_READY | BD_IIC_START;
+
+	make_log(LOG_WRITE_CMD, tbdf0, tbdf1);
+
+	if (cpm_debug)
+	  printk("cpm_iic_write: tbdf0=%p tbdf1=%p sc=%04x %04x abyte=%02x\n",
+		 tbdf0, tbdf1, tbdf0->cbd_sc, tbdf1->cbd_sc, abyte);
+
+	orig = jiffies;         /* Remember start time */
+
+	/* Chip bug, set enable here */
+	i2c->i2c_i2cer = i2c->i2c_i2cer;
+	i2c->i2c_i2cmr = 0x13;	/* Enable some interupts */
+	i2c->i2c_i2mod = 1;	/* Enable */
+	i2c->i2c_i2com = 0x81;	/* Start master */
+#ifdef DEBUG_TIMEOUT
+	save_save_idx = save_idx;
+#endif
+	add_wait_queue(&iic_wr_wait, &wrwait);
+	spin_unlock_irq(&cpm_i2c_8xx.lock);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	/* Wait for IIC transfer */
+	while(1) {
+		if (!(tbdf1->cbd_sc & BD_SC_READY))
+		        break;
+
+		if ((jiffies - orig) >= CPM_TIMEOUT) {
+#ifdef DEBUG_TIMEOUT
+		        printk("cpm_iic_write: timed out tx0 sc %04x, tx1 sc %04x\n",
+			       tbdf0->cbd_sc, tbdf1->cbd_sc);
+			printk("cpm_iic_write: tbdf0=%p tbdf1=%p tbptr=%04x\n",
+			       tbdf0, tbdf1, iip->iic_tbptr);
+			show_last_ints();
+#endif
+			show_log();
+			printk(KERN_DEBUG "cpm_iic_write: timed out wait for complete tbdf0=%p tbdf1=%p tx sc=%04x, tx sc=%04x\n",
+			       tbdf0, tbdf1, tbdf0->cbd_sc, tbdf1->cbd_sc);
+			tbdf0->cbd_sc &= ~BD_SC_CLEARALL;
+			tbdf1->cbd_sc &= ~BD_SC_CLEARALL;
+			/* Restore BD ptr by reading controller reg */
+			tbdf_cur = (cbd_t *)&cp->cp_dpmem[iip->iic_tbptr];
+			i2c->i2c_i2mod = 0;
+			__set_current_state(TASK_RUNNING);
+			remove_wait_queue(&iic_wr_wait, &wrwait);
+			dma_free_coherent(NULL, CPM_WRT_BUF_SZ, tb, tx_dma);
+			return -ETIMEDOUT;
+		}
+		schedule_timeout(CPM_TIMEOUT);
+
+		if (signal_pending(current)) {
+			i2c->i2c_i2mod = 0;
+			__set_current_state(TASK_RUNNING);
+			remove_wait_queue(&iic_wr_wait, &wrwait);
+			dma_free_coherent(NULL, CPM_WRT_BUF_SZ, tb, tx_dma);
+		        return -EIO;
+		}
+	}
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&iic_wr_wait, &wrwait);
+	dma_free_coherent(NULL, CPM_WRT_BUF_SZ, tb, tx_dma);
+
+	make_log(LOG_WRITE_DONE, tbdf0, tbdf1);
+
+	if (cpm_debug) {
+		printk("tx0 sc %04x, tx1 sc %04x\n",
+		       tbdf0->cbd_sc, tbdf1->cbd_sc);
+	}
+
+	if (tbdf0->cbd_sc & BD_SC_NAK) {
+	        if (cpm_debug)
+		        printk("IIC write; no ack abyte=%02x\n", abyte);
+		tbdf_cur = (cbd_t *)&cp->cp_dpmem[iip->iic_tbptr];
+		count = -ENODEV;
+		goto write_out;
+	}
+	  
+	if (tbdf0->cbd_sc & BD_SC_READY) {
+		show_log();
+		printk("IIC write; complete but tbuf ready tbdf0=%p tcur=%p txsc=%04x tbptr=%04x\n", tbdf0, tbdf_cur, tbdf0->cbd_sc, iip->iic_tbptr);
+		tbdf_cur = (cbd_t *)&cp->cp_dpmem[iip->iic_tbptr];
+		count = 0;
+		goto write_out;
+	}
+
+#ifdef DEBUG_SHORT
+	/* Save status of write for later */
+	len = sprintf(spbuf, "cpm_iic_write: wrote %d bytes ", tbdf1->cbd_datlen);
+	//for (i = 0; i < tbdf1->cbd_datlen; i++)
+	//len += sprintf(spbuf+len, " %02x", ((u_char *)buf)[i]);
+	len += sprintf(spbuf+len, "  tx0 sc %04x, tx1 sc %04x idx=%d\n",
+	       tbdf0->cbd_sc, tbdf1->cbd_sc, save_save_idx);
+#endif
+write_out:
+	i2c->i2c_i2mod = 0;
+	tbdf0->cbd_sc &= ~BD_SC_CLEARALL;
+	tbdf1->cbd_sc &= ~BD_SC_CLEARALL;
+
+	return count;
+}
+
+static int cpm_xfer(struct file *file, struct i2c_msg *pmsg, u_char *virt, dma_addr_t dma)
+{
+	int j, ret;
+	u_char addr;
+    
+	if (cpm_debug)
+	        printk("cpm_xfer: "
+		       "addr=0x%x flags=0x%x len=%d virt=%p dma=%x\n",
+		       pmsg->addr, pmsg->flags, pmsg->len, virt, dma);
+
+	addr = pmsg->addr << 1;
+	if (pmsg->flags & I2C_M_RD )
+	        addr |= 1;
+	if (pmsg->flags & I2C_M_REV_DIR_ADDR )
+	        addr ^= 1;
+    
+	if (!(pmsg->flags & I2C_M_NOSTART)) {
+	}
+	if (pmsg->flags & I2C_M_RD ) {
+	        /* read bytes into buffer*/
+	        ret = cpm_iic_read(addr, dma, pmsg->len);
+		if (cpm_debug) {
+		        printk("cpm_xfer: read %d bytes ", ret);
+			for(j = 0; j < ret; j++)
+			        printk("%02x ", virt[j]);
+			printk("\n");
+		}
+		if (ret < pmsg->len ) {
+			return (ret<0)? ret : -EREMOTEIO;
+		}
+	} else {
+	        /* write bytes from buffer */
+	        ret = cpm_iic_write(addr, dma, pmsg->len);
+		if (cpm_debug) {
+		        printk("cpm_xfer: wrote %d bytes ", ret);
+			for(j = 0; j < ret; j++)
+			        printk("%02x ", virt[j]);
+			printk("\n");
+		}
+		if (ret < pmsg->len ) {
+			return (ret<0) ? ret : -EREMOTEIO;
+		}
+	}
+
+	return (ret);
+}
+
+static int cpm_iic_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	DECLARE_WAITQUEUE(cbdwait, current);
+	struct i2c_rdwr_ioctl_data rdwr_arg;
+	struct i2c_msg *rdwr_pa;
+	u8 __user *virt_ptr;
+	dma_addr_t dma_addr;
+	unsigned long orig;
+	int i, res;
+
+	switch(cmd) {
+	case I2C_RDWR:
+	  /* Wait for the controller to become available */
+	  orig = jiffies;     /* Remember start time */
+	  add_wait_queue(&iic_cbd_wait, &cbdwait);
+	  set_current_state(TASK_INTERRUPTIBLE);
+	  while(1) {
+                /* Test and set 'in use' flags, update of 'current'  must be atomic */
+         	spin_lock_irq(&cpm_i2c_8xx.lock);
+	        if (in_use == 0) {
+		        in_use = 1;
+		        spin_unlock_irq(&cpm_i2c_8xx.lock);
+		        break;
+		}
+		spin_unlock_irq(&cpm_i2c_8xx.lock);
+
+	        if ((jiffies - orig) >= CPM_TIMEOUT) {
+			__set_current_state(TASK_RUNNING);
+			remove_wait_queue(&iic_cbd_wait, &cbdwait);
+			printk(KERN_DEBUG "cpm_iic_read: timed out wait for controller\n");
+			return -ETIMEDOUT;
+		}
+		schedule_timeout(CPM_TIMEOUT);
+
+		if (signal_pending(current)) {
+		        __set_current_state(TASK_RUNNING);
+		        remove_wait_queue(&iic_cbd_wait, &cbdwait);
+		        return -EIO;
+		}
+	  }
+
+	  __set_current_state(TASK_RUNNING);
+	  remove_wait_queue(&iic_cbd_wait, &cbdwait);
+
+	  /* Local copy of all args */
+	  if (copy_from_user(&rdwr_arg, 
+			     (struct i2c_rdwr_ioctl_data __user *)arg, 
+			     sizeof(rdwr_arg))) {
+	    res = -EFAULT;
+	    goto rdwr_out;
+	  }
+
+	  /* Put an arbritrary limit on the number of messages that can
+	   * be sent at once */
+	  if (rdwr_arg.nmsgs > I2C_RDRW_IOCTL_MAX_MSGS) {
+	    res = -EINVAL;
+	    goto rdwr_out;
+	  }
+		
+	  /* Buffer for local copy of msgs pointed to by args */
+	  rdwr_pa = (struct i2c_msg *)
+	    kmalloc(rdwr_arg.nmsgs * sizeof(struct i2c_msg), 
+		    GFP_KERNEL);
+	  if (rdwr_pa == NULL) {
+	    res = -ENOMEM;
+	    goto rdwr_out;
+	  }
+
+	  /* Copy header portion of the messages into local buffer */
+	  if (copy_from_user(rdwr_pa, rdwr_arg.msgs,
+			     rdwr_arg.nmsgs * sizeof(struct i2c_msg))) {
+	    kfree(rdwr_pa);
+	    res = -EFAULT;
+	    goto rdwr_out;
+	  }
+	  
+	  res = 0;
+	  /* For each message ... */
+	  for( i=0; i<rdwr_arg.nmsgs; i++ ) {
+	    /* Limit the size of the message to a sane amount */
+	    if (rdwr_pa[i].len > 8192) {
+	      res = -EINVAL;
+	      break;
+	    }
+	    /* Allocate a DMA buffer */
+	    virt_ptr = dma_alloc_coherent(NULL, L1_CACHE_ALIGN(rdwr_pa[i].len), &dma_addr, GFP_KERNEL);
+	    if(virt_ptr == NULL) {
+	      res = -ENOMEM;
+	      break;
+	    }
+	    /* Copy the data buffer portion of the message */
+	    if(copy_from_user(virt_ptr,
+			      rdwr_pa[i].buf,
+			      rdwr_pa[i].len)) {
+	      ++i; /* Needs to be kfreed too */
+	      res = -EFAULT;
+	      break;
+	    }
+	    /* Do the actual transfer */
+	    res = cpm_xfer(file, &rdwr_pa[i], virt_ptr, dma_addr);
+	    if (cpm_debug)
+	      printk(KERN_ERR "i2c_rdwr: cpm_xfer returned %d\n", res);
+
+	    /* If a read, copy the resulting data back */
+	    if( res>=0 && (rdwr_pa[i].flags & I2C_M_RD)) {
+	      if(copy_to_user(rdwr_pa[i].buf,
+			      virt_ptr,
+			      rdwr_pa[i].len)) {
+		res = -EFAULT;
+	      }
+	    }
+	    dma_free_coherent(NULL, L1_CACHE_ALIGN(rdwr_pa[i].len), virt_ptr, dma_addr);
+	  }
+
+	  kfree(rdwr_pa);
+rdwr_out:
+	  in_use = 0;
+	  wake_up_interruptible(&iic_cbd_wait);
+	  schedule();
+	  return res;
+	default:
+	  return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
+static struct file_operations cpm_iic_fops = {
+	owner:		THIS_MODULE,
+	ioctl:		cpm_iic_ioctl,
+	open:		cpm_iic_open,
+	release:	cpm_iic_release,
+};
+
+static struct miscdevice cpm_iic_miscdev = {
+	minor:		CPM_IIC_MINOR,
+	name:		"i2c-0",
+	fops:		&cpm_iic_fops,
+};
+
+static int __init cpm_iic_init(void)
+{
+	volatile iic_t		*iip;
+	volatile i2c8xx_t	*i2c;
+	volatile cbd_t          *bdp;
+	volatile cpm8xx_t       *cp;
+	volatile immap_t        *immap;
+	int j, ret;
+
+	ret = misc_register(&cpm_iic_miscdev);
+	if (ret)
+		return ret;
+
+	cp = cpmp;	/* Get pointer to Communication Processor */
+	immap = (immap_t *)IMAP_ADDR;	/* and to internal registers */
+
+	cpm_i2c_8xx.iip = iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];
+	cpm_i2c_8xx.reloc = 0;
+
+	/* Check for and use a microcode relocation patch.
+	*/
+#if 0
+	if ((cpm_i2c_8xx.reloc = cpm_i2c_8xx.iip->iic_rpbase))
+		cpm_i2c_8xx.iip = (iic_t *)&cp->cp_dpmem[cpm_i2c_8xx.iip->iic_rpbase];
+#endif
+	cpm_debug = 0;
+		
+	cpm_i2c_8xx.i2c = i2c = (i2c8xx_t *)&(immap->im_i2c);
+	cpm_i2c_8xx.cp = cp;
+	cpm_i2c_8xx.lock = SPIN_LOCK_UNLOCKED;
+
+	/* Initialize Port B IIC pins.
+	*/
+	cp->cp_pbpar |= 0x00000030;
+	cp->cp_pbdir |= 0x00000030;
+	cp->cp_pbodr |= 0x00000030;
+
+	/* Allocate space for two transmit and two receive buffer
+	 * descriptors in the DP ram.
+	 */
+	cpm_i2c_8xx.dp_addr = cpm_dpalloc(sizeof(cbd_t) * (CPM_NUM_BDS*2), 8);
+	if (cpm_debug) printk("cpm_iic_init: dp_addr %x\n", cpm_i2c_8xx.dp_addr);
+
+	/* ptr to i2c area */
+	cpm_i2c_8xx.i2c = (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);
+
+	if (cpm_debug) printk("cpm_iic_init() - iip=%p\n",iip);
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
+	iip->iic_tbase = r_tbase = cpm_i2c_8xx.dp_addr;
+	iip->iic_rbase = r_rbase = cpm_i2c_8xx.dp_addr + sizeof(cbd_t)*CPM_NUM_BDS;
+
+	tbdf_cur = tbdf_base = (cbd_t *)&cp->cp_dpmem[iip->iic_tbase];
+	rbdf_cur = rbdf_base = (cbd_t *)&cp->cp_dpmem[iip->iic_rbase];
+
+	bdp = tbdf_cur;
+	for (j=0; j<(CPM_NUM_BDS-1); j++) {
+	  bdp->cbd_sc = 0;
+	  /* bdp->cbd_sc &= ~( BD_SC_LAST | BD_SC_INTRPT | BD_IIC_START); */
+	  bdp++;
+	}
+	bdp->cbd_sc = 0;
+	/* bdp->cbd_sc &= ~( BD_SC_LAST | BD_SC_INTRPT | BD_IIC_START); */
+	bdp->cbd_sc |= BD_SC_WRAP;
+
+	bdp = rbdf_cur;
+	for (j=0; j<(CPM_NUM_BDS-1); j++) {
+	  bdp->cbd_sc = BD_SC_INTRPT;
+	  bdp->cbd_sc &= ~BD_SC_EMPTY;
+	  bdp++;
+	}
+	bdp->cbd_sc = BD_SC_WRAP | BD_SC_INTRPT;
+	bdp->cbd_sc &= ~BD_SC_EMPTY;
+
+	if (cpm_debug)
+	  printk("cpm_iic_init: tbdf_cur=%p rbdf_cur=%p\n", tbdf_cur, rbdf_cur);
+
+	in_use = 0;
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
+	if (cpm_i2c_8xx.reloc == 0) {
+		volatile cpm8xx_t *cp = cpm_i2c_8xx.cp;
+
+		cp->cp_cpcr =
+			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
+		while (cp->cp_cpcr & CPM_CR_FLG);
+	}
+
+	/* Select an arbitrary address.  Just make sure it is unique.
+	*/
+	i2c->i2c_i2add = 0x34;
+
+	/* Make clock run maximum slow.
+	*/
+	i2c->i2c_i2brg = 7;
+
+	/* Disable interrupts.
+	*/
+	i2c->i2c_i2cmr = 0;
+	i2c->i2c_i2cer = 0xff;
+
+	init_waitqueue_head(&iic_rd_wait);
+	init_waitqueue_head(&iic_wr_wait);
+	init_waitqueue_head(&iic_cbd_wait);
+
+	/* Install interrupt handler.
+	*/
+	if (cpm_debug) {
+		printk ("%s[%d] Install ISR for IRQ %d\n",
+			__func__,__LINE__, CPMVEC_I2C);
+	}
+	request_irq(CPMVEC_I2C + CPM_IRQ_OFFSET, cpm_iic_interrupt, 0, "cpm_i2c", (void *)i2c);
+
+	//cpm_debug = 1;
+
+	return(0);
+}
+
+static int
+cpm_iic_release(struct inode *inode, struct file *file)
+{
+  /*
+   * We don't do anything in the open, so don't do anything in the close.
+   * Any operation on the physical device could affect other tasks that 
+   * might be using it.
+   */
+	return(0);
+}
+
+static void __exit cpm_iic_exit(void)
+{
+	misc_deregister(&cpm_iic_miscdev);
+}
+
+module_init(cpm_iic_init);
+module_exit(cpm_iic_exit);
+
+MODULE_AUTHOR("Ken Poole");
+MODULE_DESCRIPTION("MRV LX CPM_i2c Device Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(CPM_IIC_MINOR);

--- /home/cmurch/kernels/linux-2.6.18/include/linux/i2c-dev.h	2006-09-19 23:42:06.000000000 -0400
+++ i2c-dev.h	2006-10-23 16:00:55.000000000 -0400
@@ -19,6 +19,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+/* $Id: i2c-dev.h,v 1.2 2005/02/23 14:50:02 kpoole Exp $ */
+
 #ifndef _LINUX_I2C_DEV_H
 #define _LINUX_I2C_DEV_H
 
@@ -36,6 +38,22 @@
 	union i2c_smbus_data __user *data;
 };
 
+/*
+ * I2C Message - used for pure i2c transaction, also from /dev interface
+ */
+struct i2c_msg {
+	__u16 addr;	/* slave address			*/
+ 	__u16 flags;		
+#define I2C_M_TEN	0x10	/* we have a ten bit chip address	*/
+#define I2C_M_RD	0x01
+#define I2C_M_NOSTART	0x4000
+#define I2C_M_REV_DIR_ADDR	0x2000
+#define I2C_M_IGNORE_NAK	0x1000
+#define I2C_M_NO_RD_ACK		0x0800
+ 	__u16 len;		/* msg length				*/
+ 	__u8 *buf;		/* pointer to msg data			*/
+};
+
 /* This is the structure as used in the I2C_RDWR ioctl call */
 struct i2c_rdwr_ioctl_data {
 	struct i2c_msg __user *msgs;	/* pointers to i2c_msgs */
@@ -44,4 +62,6 @@
 
 #define  I2C_RDRW_IOCTL_MAX_MSGS	42
 
+#define I2C_RDWR      0x0707  /* Combined R/W transfer (one stop only)*/
+
 #endif /* _LINUX_I2C_DEV_H */

--=-JyBpLYAhTGwcXPjAqgwY--
