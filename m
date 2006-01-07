Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 11:35:26 +1100
Message-Id: <1136594126.4840.167.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH] 2/5 powerpc: Rework PowerMac i2c part 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the continuation of the previous patch. This one removes the old
PowerMac i2c drivers (i2c-keywest and i2c-pmac-smu) and replaces them
both with a single stub driver that uses the new PowerMac low i2c layer.

Now that i2c-keywest is gone, the low-i2c code is extended to support
interrupt driver transfers. All i2c busses now appear as platform
devices. Compatibility with existing drivers should be maintained as the
i2c bus names have been kept identical, except for the SMU bus but in
that later case, all users has been fixed.

With that patch added, matching a device node to an i2c_adapter becomes
trivial.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/i2c/busses/Kconfig
===================================================================
--- linux-work.orig/drivers/i2c/busses/Kconfig	2006-01-06 19:42:48.000000000 +1100
+++ linux-work/drivers/i2c/busses/Kconfig	2006-01-06 19:43:28.000000000 +1100
@@ -236,27 +236,17 @@ config I2C_IXP2000
 	  This support is also available as a module. If so, the module
 	  will be called i2c-ixp2000.
 
-config I2C_KEYWEST
-	tristate "Powermac Keywest I2C interface"
+config I2C_POWERMAC
+	tristate "Powermac I2C interface"
 	depends on I2C && PPC_PMAC
+	default y
 	help
-	  This supports the use of the I2C interface in the combo-I/O
-	  chip on recent Apple machines.  Say Y if you have such a machine.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-keywest.
-
-config I2C_PMAC_SMU
-	tristate "Powermac SMU I2C interface"
-	depends on I2C && PMAC_SMU
-	help
-	  This supports the use of the I2C interface in the SMU
-	  chip on recent Apple machines like the iMac G5.  It is used
-	  among others by the thermal control driver for those machines.
-	  Say Y if you have such a machine.
+	  This exposes the various PowerMac i2c interfaces to the linux i2c
+	  layer and to userland. It is used by various drivers on the powemac
+	  platform, thus should generally be enabled.
 
 	  This support is also available as a module.  If so, the module
-	  will be called i2c-pmac-smu.
+	  will be called i2c-powermac.
 
 config I2C_MPC
 	tristate "MPC107/824x/85xx/52xx"
Index: linux-work/drivers/i2c/busses/Makefile
===================================================================
--- linux-work.orig/drivers/i2c/busses/Makefile	2006-01-06 19:42:48.000000000 +1100
+++ linux-work/drivers/i2c/busses/Makefile	2006-01-06 19:43:28.000000000 +1100
@@ -19,8 +19,7 @@ obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
 obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
 obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
-obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
-obj-$(CONFIG_I2C_PMAC_SMU)	+= i2c-pmac-smu.o
+obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
 obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
 obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
Index: linux-work/drivers/i2c/busses/i2c-keywest.c
===================================================================
--- linux-work.orig/drivers/i2c/busses/i2c-keywest.c	2006-01-06 19:42:48.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,754 +0,0 @@
-/*
-    i2c Support for Apple Keywest I2C Bus Controller
-
-    Copyright (c) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
-
-    Original work by
-    
-    Copyright (c) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Changes:
-
-    2001/12/13 BenH	New implementation
-    2001/12/15 BenH	Add support for "byte" and "quick"
-                        transfers. Add i2c_xfer routine.
-    2003/09/21 BenH	Rework state machine with Paulus help
-    2004/01/21 BenH	Merge in Greg KH changes, polled mode is back
-    2004/02/05 BenH	Merge 64 bits fixes from the g5 ppc64 tree
-
-    My understanding of the various modes supported by keywest are:
-
-     - Dumb mode : not implemented, probably direct tweaking of lines
-     - Standard mode : simple i2c transaction of type
-         S Addr R/W A Data A Data ... T
-     - Standard sub mode : combined 8 bit subaddr write with data read
-         S Addr R/W A SubAddr A Data A Data ... T
-     - Combined mode : Subaddress and Data sequences appended with no stop
-         S Addr R/W A SubAddr S Addr R/W A Data A Data ... T
-
-    Currently, this driver uses only Standard mode for i2c xfer, and
-    smbus byte & quick transfers ; and uses StandardSub mode for
-    other smbus transfers instead of combined as we need that for the
-    sound driver to be happy
-*/
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/pci.h>
-#include <linux/types.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/timer.h>
-#include <linux/spinlock.h>
-#include <linux/completion.h>
-#include <linux/interrupt.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include <asm/pmac_low_i2c.h>
-
-#include "i2c-keywest.h"
-
-#undef POLLED_MODE
-
-/* Some debug macros */
-#define WRONG_STATE(name) do {\
-		pr_debug("KW: wrong state. Got %s, state: %s (isr: %02x)\n", \
-			 name, __kw_state_names[iface->state], isr);	\
-	} while(0)
-
-#ifdef DEBUG
-static const char *__kw_state_names[] = {
-	"state_idle",
-	"state_addr",
-	"state_read",
-	"state_write",
-	"state_stop",
-	"state_dead"
-};
-#endif /* DEBUG */
-
-MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
-MODULE_LICENSE("GPL");
-
-#ifdef POLLED_MODE
-/* Don't schedule, the g5 fan controller is too
- * timing sensitive
- */
-static u8
-wait_interrupt(struct keywest_iface* iface)
-{
-	int i;
-	u8 isr;
-	
-	for (i = 0; i < 200000; i++) {
-		isr = read_reg(reg_isr) & KW_I2C_IRQ_MASK;
-		if (isr != 0)
-			return isr;
-		udelay(10);
-	}
-	return isr;
-}
-#endif /* POLLED_MODE */
-
-static void
-do_stop(struct keywest_iface* iface, int result)
-{
-	write_reg(reg_control, KW_I2C_CTL_STOP);
-	iface->state = state_stop;
-	iface->result = result;
-}
-
-/* Main state machine for standard & standard sub mode */
-static void
-handle_interrupt(struct keywest_iface *iface, u8 isr)
-{
-	int ack;
-	
-	if (isr == 0) {
-		if (iface->state != state_stop) {
-			pr_debug("KW: Timeout !\n");
-			do_stop(iface, -EIO);
-		}
-		if (iface->state == state_stop) {
-			ack = read_reg(reg_status);
-			if (!(ack & KW_I2C_STAT_BUSY)) {
-				iface->state = state_idle;
-				write_reg(reg_ier, 0x00);
-#ifndef POLLED_MODE
-				complete(&iface->complete);
-#endif /* POLLED_MODE */
-			}
-		}
-		return;
-	}
-
-	if (isr & KW_I2C_IRQ_ADDR) {
-		ack = read_reg(reg_status);
-		if (iface->state != state_addr) {
-			write_reg(reg_isr, KW_I2C_IRQ_ADDR);
-			WRONG_STATE("KW_I2C_IRQ_ADDR"); 
-			do_stop(iface, -EIO);
-			return;
-		}
-		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
-			iface->state = state_stop;		     
-			iface->result = -ENODEV;
-			pr_debug("KW: NAK on address\n");
-		} else {
-			/* Handle rw "quick" mode */
-			if (iface->datalen == 0) {
-				do_stop(iface, 0);
-			} else if (iface->read_write == I2C_SMBUS_READ) {
-				iface->state = state_read;
-				if (iface->datalen > 1)
-					write_reg(reg_control, KW_I2C_CTL_AAK);
-			} else {
-				iface->state = state_write;
-				write_reg(reg_data, *(iface->data++));
-				iface->datalen--;
-			}
-		}
-		write_reg(reg_isr, KW_I2C_IRQ_ADDR);
-	}
-
-	if (isr & KW_I2C_IRQ_DATA) {
-		if (iface->state == state_read) {
-			*(iface->data++) = read_reg(reg_data);
-			write_reg(reg_isr, KW_I2C_IRQ_DATA);
-			iface->datalen--;
-			if (iface->datalen == 0)
-				iface->state = state_stop;
-			else if (iface->datalen == 1)
-				write_reg(reg_control, 0);
-		} else if (iface->state == state_write) {
-			/* Check ack status */
-			ack = read_reg(reg_status);
-			if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
-				pr_debug("KW: nack on data write (%x): %x\n",
-				    iface->data[-1], ack);
-				do_stop(iface, -EIO);
-			} else if (iface->datalen) {
-				write_reg(reg_data, *(iface->data++));
-				iface->datalen--;
-			} else {
-				write_reg(reg_control, KW_I2C_CTL_STOP);
-				iface->state = state_stop;
-				iface->result = 0;
-			}
-			write_reg(reg_isr, KW_I2C_IRQ_DATA);
-		} else {
-			write_reg(reg_isr, KW_I2C_IRQ_DATA);
-			WRONG_STATE("KW_I2C_IRQ_DATA"); 
-			if (iface->state != state_stop)
-				do_stop(iface, -EIO);
-		}
-	}
-
-	if (isr & KW_I2C_IRQ_STOP) {
-		write_reg(reg_isr, KW_I2C_IRQ_STOP);
-		if (iface->state != state_stop) {
-			WRONG_STATE("KW_I2C_IRQ_STOP");
-			iface->result = -EIO;
-		}
-		iface->state = state_idle;
-		write_reg(reg_ier, 0x00);
-#ifndef POLLED_MODE
-		complete(&iface->complete);
-#endif /* POLLED_MODE */			
-	}
-
-	if (isr & KW_I2C_IRQ_START)
-		write_reg(reg_isr, KW_I2C_IRQ_START);
-}
-
-#ifndef POLLED_MODE
-
-/* Interrupt handler */
-static irqreturn_t
-keywest_irq(int irq, void *dev_id, struct pt_regs *regs)
-{
-	struct keywest_iface *iface = (struct keywest_iface *)dev_id;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iface->lock, flags);
-	del_timer(&iface->timeout_timer);
-	handle_interrupt(iface, read_reg(reg_isr));
-	if (iface->state != state_idle) {
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
-	}
-	spin_unlock_irqrestore(&iface->lock, flags);
-	return IRQ_HANDLED;
-}
-
-static void
-keywest_timeout(unsigned long data)
-{
-	struct keywest_iface *iface = (struct keywest_iface *)data;
-	unsigned long flags;
-
-	pr_debug("timeout !\n");
-	spin_lock_irqsave(&iface->lock, flags);
-	handle_interrupt(iface, read_reg(reg_isr));
-	if (iface->state != state_idle) {
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
-	}
-	spin_unlock_irqrestore(&iface->lock, flags);
-}
-
-#endif /* POLLED_MODE */
-
-/*
- * SMBUS-type transfer entrypoint
- */
-static s32
-keywest_smbus_xfer(	struct i2c_adapter*	adap,
-			u16			addr,
-			unsigned short		flags,
-			char			read_write,
-			u8			command,
-			int			size,
-			union i2c_smbus_data*	data)
-{
-	struct keywest_chan* chan = i2c_get_adapdata(adap);
-	struct keywest_iface* iface = chan->iface;
-	int len;
-	u8* buffer;
-	u16 cur_word;
-	int rc = 0;
-
-	if (iface->state == state_dead)
-		return -ENXIO;
-		
-	/* Prepare datas & select mode */
-	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
-	switch (size) {
-        case I2C_SMBUS_QUICK:
-	    	len = 0;
-	    	buffer = NULL;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
-	    	break;
-        case I2C_SMBUS_BYTE:
-	    	len = 1;
-	    	buffer = &data->byte;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
-	    	break;
-        case I2C_SMBUS_BYTE_DATA:
-	    	len = 1;
-	    	buffer = &data->byte;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
-	    	break;
-        case I2C_SMBUS_WORD_DATA:
-	    	len = 2;
-	    	cur_word = cpu_to_le16(data->word);
-	    	buffer = (u8 *)&cur_word;
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
-		break;
-        case I2C_SMBUS_BLOCK_DATA:
-	    	len = data->block[0];
-	    	buffer = &data->block[1];
-	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
-		break;
-        default:
-	    	return -1;
-	}
-
-	/* Turn a standardsub read into a combined mode access */
- 	if (read_write == I2C_SMBUS_READ
- 	    && (iface->cur_mode & KW_I2C_MODE_MODE_MASK) == KW_I2C_MODE_STANDARDSUB) {
- 		iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
- 		iface->cur_mode |= KW_I2C_MODE_COMBINED;
- 	}
-
-	/* Original driver had this limitation */
-	if (len > 32)
-		len = 32;
-
-	if (pmac_low_i2c_lock(iface->node))
-		return -ENXIO;
-
-	pr_debug("chan: %d, addr: 0x%x, transfer len: %d, read: %d\n",
-		chan->chan_no, addr, len, read_write == I2C_SMBUS_READ);
-
-	iface->data = buffer;
-	iface->datalen = len;
-	iface->state = state_addr;
-	iface->result = 0;
-	iface->read_write = read_write;
-	
-	/* Setup channel & clear pending irqs */
-	write_reg(reg_isr, read_reg(reg_isr));
-	write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
-	write_reg(reg_status, 0);
-
-	/* Set up address and r/w bit */
-	write_reg(reg_addr,
-		(addr << 1) | ((read_write == I2C_SMBUS_READ) ? 0x01 : 0x00));
-
-	/* Set up the sub address */
-	if ((iface->cur_mode & KW_I2C_MODE_MODE_MASK) == KW_I2C_MODE_STANDARDSUB
-	    || (iface->cur_mode & KW_I2C_MODE_MODE_MASK) == KW_I2C_MODE_COMBINED)
-		write_reg(reg_subaddr, command);
-
-#ifndef POLLED_MODE
-	/* Arm timeout */
-	iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-	add_timer(&iface->timeout_timer);
-#endif
-
-	/* Start sending address & enable interrupt*/
-	write_reg(reg_control, KW_I2C_CTL_XADDR);
-	write_reg(reg_ier, KW_I2C_IRQ_MASK);
-
-#ifdef POLLED_MODE
-	pr_debug("using polled mode...\n");
-	/* State machine, to turn into an interrupt handler */
-	while(iface->state != state_idle) {
-		unsigned long flags;
-
-		u8 isr = wait_interrupt(iface);
-		spin_lock_irqsave(&iface->lock, flags);
-		handle_interrupt(iface, isr);
-		spin_unlock_irqrestore(&iface->lock, flags);
-	}
-#else /* POLLED_MODE */
-	pr_debug("using interrupt mode...\n");
-	wait_for_completion(&iface->complete);	
-#endif /* POLLED_MODE */	
-
-	rc = iface->result;	
-	pr_debug("transfer done, result: %d\n", rc);
-
-	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && read_write == I2C_SMBUS_READ)
-	    	data->word = le16_to_cpu(cur_word);
-	
-	/* Release sem */
-	pmac_low_i2c_unlock(iface->node);
-	
-	return rc;
-}
-
-/*
- * Generic i2c master transfer entrypoint
- */
-static int
-keywest_xfer(	struct i2c_adapter *adap,
-		struct i2c_msg *msgs, 
-		int num)
-{
-	struct keywest_chan* chan = i2c_get_adapdata(adap);
-	struct keywest_iface* iface = chan->iface;
-	struct i2c_msg *pmsg;
-	int i, completed;
-	int rc = 0;
-
-	if (iface->state == state_dead)
-		return -ENXIO;
-
-	if (pmac_low_i2c_lock(iface->node))
-		return -ENXIO;
-
-	/* Set adapter to standard mode */
-	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
-	iface->cur_mode |= KW_I2C_MODE_STANDARD;
-
-	completed = 0;
-	for (i = 0; rc >= 0 && i < num;) {
-		u8 addr;
-		
-		pmsg = &msgs[i++];
-		addr = pmsg->addr;
-		if (pmsg->flags & I2C_M_TEN) {
-			printk(KERN_ERR "i2c-keywest: 10 bits addr not supported !\n");
-			rc = -EINVAL;
-			break;
-		}
-		pr_debug("xfer: chan: %d, doing %s %d bytes to 0x%02x - %d of %d messages\n",
-		     chan->chan_no,
-		     pmsg->flags & I2C_M_RD ? "read" : "write",
-                     pmsg->len, addr, i, num);
-    
-		/* Setup channel & clear pending irqs */
-		write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
-		write_reg(reg_isr, read_reg(reg_isr));
-		write_reg(reg_status, 0);
-		
-		iface->data = pmsg->buf;
-		iface->datalen = pmsg->len;
-		iface->state = state_addr;
-		iface->result = 0;
-		if (pmsg->flags & I2C_M_RD)
-			iface->read_write = I2C_SMBUS_READ;
-		else
-			iface->read_write = I2C_SMBUS_WRITE;
-
-		/* Set up address and r/w bit */
-		if (pmsg->flags & I2C_M_REV_DIR_ADDR)
-			addr ^= 1;		
-		write_reg(reg_addr,
-			(addr << 1) |
-			((iface->read_write == I2C_SMBUS_READ) ? 0x01 : 0x00));
-
-#ifndef POLLED_MODE
-		/* Arm timeout */
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
-#endif
-
-		/* Start sending address & enable interrupt*/
-		write_reg(reg_ier, KW_I2C_IRQ_MASK);
-		write_reg(reg_control, KW_I2C_CTL_XADDR);
-
-#ifdef POLLED_MODE
-		pr_debug("using polled mode...\n");
-		/* State machine, to turn into an interrupt handler */
-		while(iface->state != state_idle) {
-			u8 isr = wait_interrupt(iface);
-			handle_interrupt(iface, isr);
-		}
-#else /* POLLED_MODE */
-		pr_debug("using interrupt mode...\n");
-		wait_for_completion(&iface->complete);	
-#endif /* POLLED_MODE */	
-
-		rc = iface->result;
-		if (rc == 0)
-			completed++;
-		pr_debug("transfer done, result: %d\n", rc);
-	}
-
-	/* Release sem */
-	pmac_low_i2c_unlock(iface->node);
-
-	return completed;
-}
-
-static u32
-keywest_func(struct i2c_adapter * adapter)
-{
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
-}
-
-/* For now, we only handle combined mode (smbus) */
-static struct i2c_algorithm keywest_algorithm = {
-	.smbus_xfer	= keywest_smbus_xfer,
-	.master_xfer	= keywest_xfer,
-	.functionality	= keywest_func,
-};
-
-
-static int
-create_iface(struct device_node *np, struct device *dev)
-{
-	unsigned long steps;
-	unsigned bsteps, tsize, i, nchan;
-	struct keywest_iface* iface;
-	u32 *psteps, *prate, *addrp;
-	int rc;
-
-	if (np->n_intrs < 1) {
-		printk(KERN_ERR "%s: Missing interrupt !\n",
-		       np->full_name);
-		return -ENODEV;
-	}
-	addrp = (u32 *)get_property(np, "AAPL,address", NULL);
-	if (addrp == NULL) {
-		printk(KERN_ERR "%s: Can't find address !\n",
-		       np->full_name);
-		return -ENODEV;
-	}
-
-	if (pmac_low_i2c_lock(np))
-		return -ENODEV;
-
-	psteps = (u32 *)get_property(np, "AAPL,address-step", NULL);
-	steps = psteps ? (*psteps) : 0x10;
-
-	/* Hrm... maybe we can be smarter here */
-	for (bsteps = 0; (steps & 0x01) == 0; bsteps++)
-		steps >>= 1;
-
-	if (np->parent->name[0] == 'u')
-		nchan = 2;
-	else
-		nchan = 1;
-
-	tsize = sizeof(struct keywest_iface) +
-		(sizeof(struct keywest_chan) + 4) * nchan;
-	iface = kzalloc(tsize, GFP_KERNEL);
-	if (iface == NULL) {
-		printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
-		pmac_low_i2c_unlock(np);
-		return -ENOMEM;
-	}
-	spin_lock_init(&iface->lock);
-	init_completion(&iface->complete);
-	iface->node = of_node_get(np);
-	iface->bsteps = bsteps;
-	iface->chan_count = nchan;
-	iface->state = state_idle;
-	iface->irq = np->intrs[0].line;
-	iface->channels = (struct keywest_chan *)
-		(((unsigned long)(iface + 1) + 3UL) & ~3UL);
-	iface->base = ioremap(*addrp, 0x1000);
-	if (!iface->base) {
-		printk(KERN_ERR "i2c-keywest: can't map inteface !\n");
-		kfree(iface);
-		pmac_low_i2c_unlock(np);
-		return -ENOMEM;
-	}
-
-#ifndef POLLED_MODE
-	init_timer(&iface->timeout_timer);
-	iface->timeout_timer.function = keywest_timeout;
-	iface->timeout_timer.data = (unsigned long)iface;
-#endif
-
-	/* Select interface rate */
-	iface->cur_mode = KW_I2C_MODE_100KHZ;
-	prate = (u32 *)get_property(np, "AAPL,i2c-rate", NULL);
-	if (prate) switch(*prate) {
-	case 100:
-		iface->cur_mode = KW_I2C_MODE_100KHZ;
-		break;
-	case 50:
-		iface->cur_mode = KW_I2C_MODE_50KHZ;
-		break;
-	case 25:
-		iface->cur_mode = KW_I2C_MODE_25KHZ;
-		break;
-	default:
-		printk(KERN_WARNING "i2c-keywest: unknown rate %ldKhz, using 100KHz\n",
-		       (long)*prate);
-	}
-	
-	/* Select standard mode by default */
-	iface->cur_mode |= KW_I2C_MODE_STANDARD;
-	
-	/* Write mode */
-	write_reg(reg_mode, iface->cur_mode);
-	
-	/* Switch interrupts off & clear them*/
-	write_reg(reg_ier, 0x00);
-	write_reg(reg_isr, KW_I2C_IRQ_MASK);
-
-#ifndef POLLED_MODE
-	/* Request chip interrupt */	
-	rc = request_irq(iface->irq, keywest_irq, SA_INTERRUPT, "keywest i2c", iface);
-	if (rc) {
-		printk(KERN_ERR "i2c-keywest: can't get IRQ %d !\n", iface->irq);
-		iounmap(iface->base);
-		kfree(iface);
-		pmac_low_i2c_unlock(np);
-		return -ENODEV;
-	}
-#endif /* POLLED_MODE */
-
-	pmac_low_i2c_unlock(np);
-	dev_set_drvdata(dev, iface);
-	
-	for (i=0; i<nchan; i++) {
-		struct keywest_chan* chan = &iface->channels[i];
-		
-		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
-		chan->iface = iface;
-		chan->chan_no = i;
-		chan->adapter.algo = &keywest_algorithm;
-		chan->adapter.algo_data = NULL;
-		chan->adapter.client_register = NULL;
-		chan->adapter.client_unregister = NULL;
-		i2c_set_adapdata(&chan->adapter, chan);
-		chan->adapter.dev.parent = dev;
-
-		rc = i2c_add_adapter(&chan->adapter);
-		if (rc) {
-			printk("i2c-keywest.c: Adapter %s registration failed\n",
-				chan->adapter.name);
-			i2c_set_adapdata(&chan->adapter, NULL);
-		}
-	}
-
-	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",
-		np->parent->name, nchan, nchan > 1 ? "s" : "", bsteps);
-		
-	return 0;
-}
-
-static int
-dispose_iface(struct device *dev)
-{
-	struct keywest_iface *iface = dev_get_drvdata(dev);
-	int i, rc;
-	
-	/* Make sure we stop all activity */
-	if (pmac_low_i2c_lock(iface->node))
-		return -ENODEV;
-
-#ifndef POLLED_MODE
-	spin_lock_irq(&iface->lock);
-	while (iface->state != state_idle) {
-		spin_unlock_irq(&iface->lock);
-		msleep(100);
-		spin_lock_irq(&iface->lock);
-	}
-#endif /* POLLED_MODE */
-	iface->state = state_dead;
-#ifndef POLLED_MODE
-	spin_unlock_irq(&iface->lock);
-	free_irq(iface->irq, iface);
-#endif /* POLLED_MODE */
-
-	pmac_low_i2c_unlock(iface->node);
-
-	/* Release all channels */
-	for (i=0; i<iface->chan_count; i++) {
-		struct keywest_chan* chan = &iface->channels[i];
-		if (i2c_get_adapdata(&chan->adapter) == NULL)
-			continue;
-		rc = i2c_del_adapter(&chan->adapter);
-		i2c_set_adapdata(&chan->adapter, NULL);
-		/* We aren't that prepared to deal with this... */
-		if (rc)
-			printk("i2c-keywest.c: i2c_del_adapter failed, that's bad !\n");
-	}
-	iounmap(iface->base);
-	dev_set_drvdata(dev, NULL);
-	of_node_put(iface->node);
-	kfree(iface);
-
-	return 0;
-}
-
-static int
-create_iface_macio(struct macio_dev* dev, const struct of_device_id *match)
-{
-	return create_iface(dev->ofdev.node, &dev->ofdev.dev);
-}
-
-static int
-dispose_iface_macio(struct macio_dev* dev)
-{
-	return dispose_iface(&dev->ofdev.dev);
-}
-
-static int
-create_iface_of_platform(struct of_device* dev, const struct of_device_id *match)
-{
-	return create_iface(dev->node, &dev->dev);
-}
-
-static int
-dispose_iface_of_platform(struct of_device* dev)
-{
-	return dispose_iface(&dev->dev);
-}
-
-static struct of_device_id i2c_keywest_match[] = 
-{
-	{
-	.type		= "i2c",
-	.compatible	= "keywest"
-	},
-	{},
-};
-
-static struct macio_driver i2c_keywest_macio_driver = 
-{
-	.owner		= THIS_MODULE,
-	.name 		= "i2c-keywest",
-	.match_table	= i2c_keywest_match,
-	.probe		= create_iface_macio,
-	.remove		= dispose_iface_macio
-};
-
-static struct of_platform_driver i2c_keywest_of_platform_driver = 
-{
-	.owner		= THIS_MODULE,
-	.name 		= "i2c-keywest",
-	.match_table	= i2c_keywest_match,
-	.probe		= create_iface_of_platform,
-	.remove		= dispose_iface_of_platform
-};
-
-static int __init
-i2c_keywest_init(void)
-{
-	of_register_driver(&i2c_keywest_of_platform_driver);
-	macio_register_driver(&i2c_keywest_macio_driver);
-
-	return 0;
-}
-
-static void __exit
-i2c_keywest_cleanup(void)
-{
-	of_unregister_driver(&i2c_keywest_of_platform_driver);
-	macio_unregister_driver(&i2c_keywest_macio_driver);
-}
-
-module_init(i2c_keywest_init);
-module_exit(i2c_keywest_cleanup);
Index: linux-work/drivers/i2c/busses/i2c-keywest.h
===================================================================
--- linux-work.orig/drivers/i2c/busses/i2c-keywest.h	2006-01-06 19:42:48.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,108 +0,0 @@
-#ifndef __I2C_KEYWEST_H__
-#define __I2C_KEYWEST_H__
-
-/* The Tumbler audio equalizer can be really slow sometimes */
-#define POLL_TIMEOUT		(2*HZ)
-
-/* Register indices */
-typedef enum {
-	reg_mode = 0,
-	reg_control,
-	reg_status,
-	reg_isr,
-	reg_ier,
-	reg_addr,
-	reg_subaddr,
-	reg_data
-} reg_t;
-
-
-/* Mode register */
-#define KW_I2C_MODE_100KHZ	0x00
-#define KW_I2C_MODE_50KHZ	0x01
-#define KW_I2C_MODE_25KHZ	0x02
-#define KW_I2C_MODE_DUMB	0x00
-#define KW_I2C_MODE_STANDARD	0x04
-#define KW_I2C_MODE_STANDARDSUB	0x08
-#define KW_I2C_MODE_COMBINED	0x0C
-#define KW_I2C_MODE_MODE_MASK	0x0C
-#define KW_I2C_MODE_CHAN_MASK	0xF0
-
-/* Control register */
-#define KW_I2C_CTL_AAK		0x01
-#define KW_I2C_CTL_XADDR	0x02
-#define KW_I2C_CTL_STOP		0x04
-#define KW_I2C_CTL_START	0x08
-
-/* Status register */
-#define KW_I2C_STAT_BUSY	0x01
-#define KW_I2C_STAT_LAST_AAK	0x02
-#define KW_I2C_STAT_LAST_RW	0x04
-#define KW_I2C_STAT_SDA		0x08
-#define KW_I2C_STAT_SCL		0x10
-
-/* IER & ISR registers */
-#define KW_I2C_IRQ_DATA		0x01
-#define KW_I2C_IRQ_ADDR		0x02
-#define KW_I2C_IRQ_STOP		0x04
-#define KW_I2C_IRQ_START	0x08
-#define KW_I2C_IRQ_MASK		0x0F
-
-/* Physical interface */
-struct keywest_iface
-{
-	struct device_node	*node;
-	void __iomem *		base;
-	unsigned		bsteps;
-	int			irq;
-	spinlock_t		lock;
-	struct keywest_chan	*channels;
-	unsigned		chan_count;
-	u8			cur_mode;
-	char			read_write;
-	u8			*data;
-	unsigned		datalen;
-	int			state;
-	int			result;
-	struct timer_list	timeout_timer;
-	struct completion	complete;
-};
-
-enum {
-	state_idle,
-	state_addr,
-	state_read,
-	state_write,
-	state_stop,
-	state_dead
-};
-
-/* Channel on an interface */
-struct keywest_chan
-{
-	struct i2c_adapter	adapter;
-	struct keywest_iface*	iface;
-	unsigned		chan_no;
-};
-
-/* Register access */
-
-static inline u8 __read_reg(struct keywest_iface *iface, reg_t reg)
-{
-	return in_8(iface->base
-		+ (((unsigned)reg) << iface->bsteps));
-}
-
-static inline void __write_reg(struct keywest_iface *iface, reg_t reg, u8 val)
-{
-	out_8(iface->base
-		+ (((unsigned)reg) << iface->bsteps), val);
-	(void)__read_reg(iface, reg_subaddr);
-}
-
-#define write_reg(reg, val)	__write_reg(iface, reg, val) 
-#define read_reg(reg)		__read_reg(iface, reg) 
-
-
-
-#endif /* __I2C_KEYWEST_H__ */
Index: linux-work/drivers/i2c/busses/i2c-pmac-smu.c
===================================================================
--- linux-work.orig/drivers/i2c/busses/i2c-pmac-smu.c	2006-01-06 19:42:48.000000000 +1100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,324 +0,0 @@
-/*
-    i2c Support for Apple SMU Controller
-
-    Copyright (c) 2005 Benjamin Herrenschmidt, IBM Corp.
-                       <benh@kernel.crashing.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-*/
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/i2c.h>
-#include <linux/init.h>
-#include <linux/completion.h>
-#include <linux/device.h>
-#include <asm/prom.h>
-#include <asm/of_device.h>
-#include <asm/smu.h>
-
-static int probe;
-
-MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("I2C driver for Apple's SMU");
-MODULE_LICENSE("GPL");
-module_param(probe, bool, 0);
-
-
-/* Physical interface */
-struct smu_iface
-{
-	struct i2c_adapter	adapter;
-	struct completion	complete;
-	u32			busid;
-};
-
-static void smu_i2c_done(struct smu_i2c_cmd *cmd, void *misc)
-{
-	struct smu_iface	*iface = misc;
-	complete(&iface->complete);
-}
-
-/*
- * SMBUS-type transfer entrypoint
- */
-static s32 smu_smbus_xfer(	struct i2c_adapter*	adap,
-				u16			addr,
-				unsigned short		flags,
-				char			read_write,
-				u8			command,
-				int			size,
-				union i2c_smbus_data*	data)
-{
-	struct smu_iface	*iface = i2c_get_adapdata(adap);
-	struct smu_i2c_cmd	cmd;
-	int			rc = 0;
-	int			read = (read_write == I2C_SMBUS_READ);
-
-	cmd.info.bus = iface->busid;
-	cmd.info.devaddr = (addr << 1) | (read ? 0x01 : 0x00);
-
-	/* Prepare datas & select mode */
-	switch (size) {
-        case I2C_SMBUS_QUICK:
-		cmd.info.type = SMU_I2C_TRANSFER_SIMPLE;
-		cmd.info.datalen = 0;
-	    	break;
-        case I2C_SMBUS_BYTE:
-		cmd.info.type = SMU_I2C_TRANSFER_SIMPLE;
-		cmd.info.datalen = 1;
-		if (!read)
-			cmd.info.data[0] = data->byte;
-	    	break;
-        case I2C_SMBUS_BYTE_DATA:
-		cmd.info.type = SMU_I2C_TRANSFER_STDSUB;
-		cmd.info.datalen = 1;
-		cmd.info.sublen = 1;
-		cmd.info.subaddr[0] = command;
-		cmd.info.subaddr[1] = 0;
-		cmd.info.subaddr[2] = 0;
-		if (!read)
-			cmd.info.data[0] = data->byte;
-	    	break;
-        case I2C_SMBUS_WORD_DATA:
-		cmd.info.type = SMU_I2C_TRANSFER_STDSUB;
-		cmd.info.datalen = 2;
-		cmd.info.sublen = 1;
-		cmd.info.subaddr[0] = command;
-		cmd.info.subaddr[1] = 0;
-		cmd.info.subaddr[2] = 0;
-		if (!read) {
-			cmd.info.data[0] = data->word & 0xff;
-			cmd.info.data[1] = (data->word >> 8) & 0xff;
-		}
-		break;
-	/* Note that these are broken vs. the expected smbus API where
-	 * on reads, the lenght is actually returned from the function,
-	 * but I think the current API makes no sense and I don't want
-	 * any driver that I haven't verified for correctness to go
-	 * anywhere near a pmac i2c bus anyway ...
-	 */
-        case I2C_SMBUS_BLOCK_DATA:
-		cmd.info.type = SMU_I2C_TRANSFER_STDSUB;
-		cmd.info.datalen = data->block[0] + 1;
-		if (cmd.info.datalen > (SMU_I2C_WRITE_MAX + 1))
-			return -EINVAL;
-		if (!read)
-			memcpy(cmd.info.data, data->block, cmd.info.datalen);
-		cmd.info.sublen = 1;
-		cmd.info.subaddr[0] = command;
-		cmd.info.subaddr[1] = 0;
-		cmd.info.subaddr[2] = 0;
-		break;
-	case I2C_SMBUS_I2C_BLOCK_DATA:
-		cmd.info.type = SMU_I2C_TRANSFER_STDSUB;
-		cmd.info.datalen = data->block[0];
-		if (cmd.info.datalen > 7)
-			return -EINVAL;
-		if (!read)
-			memcpy(cmd.info.data, &data->block[1],
-			       cmd.info.datalen);
-		cmd.info.sublen = 1;
-		cmd.info.subaddr[0] = command;
-		cmd.info.subaddr[1] = 0;
-		cmd.info.subaddr[2] = 0;
-		break;
-
-        default:
-	    	return -EINVAL;
-	}
-
-	/* Turn a standardsub read into a combined mode access */
- 	if (read_write == I2C_SMBUS_READ &&
-	    cmd.info.type == SMU_I2C_TRANSFER_STDSUB)
-		cmd.info.type = SMU_I2C_TRANSFER_COMBINED;
-
-	/* Finish filling command and submit it */
-	cmd.done = smu_i2c_done;
-	cmd.misc = iface;
-	rc = smu_queue_i2c(&cmd);
-	if (rc < 0)
-		return rc;
-	wait_for_completion(&iface->complete);
-	rc = cmd.status;
-
-	if (!read || rc < 0)
-		return rc;
-
-	switch (size) {
-        case I2C_SMBUS_BYTE:
-        case I2C_SMBUS_BYTE_DATA:
-		data->byte = cmd.info.data[0];
-	    	break;
-        case I2C_SMBUS_WORD_DATA:
-		data->word = ((u16)cmd.info.data[1]) << 8;
-		data->word |= cmd.info.data[0];
-		break;
-	/* Note that these are broken vs. the expected smbus API where
-	 * on reads, the lenght is actually returned from the function,
-	 * but I think the current API makes no sense and I don't want
-	 * any driver that I haven't verified for correctness to go
-	 * anywhere near a pmac i2c bus anyway ...
-	 */
-        case I2C_SMBUS_BLOCK_DATA:
-	case I2C_SMBUS_I2C_BLOCK_DATA:
-		memcpy(&data->block[0], cmd.info.data, cmd.info.datalen);
-		break;
-	}
-
-	return rc;
-}
-
-static u32
-smu_smbus_func(struct i2c_adapter * adapter)
-{
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
-}
-
-/* For now, we only handle combined mode (smbus) */
-static struct i2c_algorithm smu_algorithm = {
-	.smbus_xfer	= smu_smbus_xfer,
-	.functionality	= smu_smbus_func,
-};
-
-static int create_iface(struct device_node *np, struct device *dev)
-{
-	struct smu_iface* iface;
-	u32 *reg, busid;
-	int rc;
-
-	reg = (u32 *)get_property(np, "reg", NULL);
-	if (reg == NULL) {
-		printk(KERN_ERR "i2c-pmac-smu: can't find bus number !\n");
-		return -ENXIO;
-	}
-	busid = *reg;
-
-	iface = kzalloc(sizeof(struct smu_iface), GFP_KERNEL);
-	if (iface == NULL) {
-		printk(KERN_ERR "i2c-pmac-smu: can't allocate inteface !\n");
-		return -ENOMEM;
-	}
-	init_completion(&iface->complete);
-	iface->busid = busid;
-
-	dev_set_drvdata(dev, iface);
-
-	sprintf(iface->adapter.name, "smu-i2c-%02x", busid);
-	iface->adapter.algo = &smu_algorithm;
-	iface->adapter.algo_data = NULL;
-	iface->adapter.client_register = NULL;
-	iface->adapter.client_unregister = NULL;
-	i2c_set_adapdata(&iface->adapter, iface);
-	iface->adapter.dev.parent = dev;
-
-	rc = i2c_add_adapter(&iface->adapter);
-	if (rc) {
-		printk(KERN_ERR "i2c-pamc-smu.c: Adapter %s registration "
-		       "failed\n", iface->adapter.name);
-		i2c_set_adapdata(&iface->adapter, NULL);
-	}
-
-	if (probe) {
-		unsigned char addr;
-		printk("Probe: ");
-		for (addr = 0x00; addr <= 0x7f; addr++) {
-			if (i2c_smbus_xfer(&iface->adapter,addr,
-					   0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
-				printk("%02x ", addr);
-		}
-		printk("\n");
-	}
-
-	printk(KERN_INFO "SMU i2c bus %x registered\n", busid);
-
-	return 0;
-}
-
-static int dispose_iface(struct device *dev)
-{
-	struct smu_iface *iface = dev_get_drvdata(dev);
-	int rc;
-
-	rc = i2c_del_adapter(&iface->adapter);
-	i2c_set_adapdata(&iface->adapter, NULL);
-	/* We aren't that prepared to deal with this... */
-	if (rc)
-		printk("i2c-pmac-smu.c: Failed to remove bus %s !\n",
-		       iface->adapter.name);
-	dev_set_drvdata(dev, NULL);
-	kfree(iface);
-
-	return 0;
-}
-
-
-static int create_iface_of_platform(struct of_device* dev,
-				    const struct of_device_id *match)
-{
-	struct device_node *node = dev->node;
-
-	if (device_is_compatible(node, "smu-i2c") ||
-	    (node->parent != NULL &&
-	     device_is_compatible(node->parent, "smu-i2c-control")))
-		return create_iface(node, &dev->dev);
-	return -ENODEV;
-}
-
-
-static int dispose_iface_of_platform(struct of_device* dev)
-{
-	return dispose_iface(&dev->dev);
-}
-
-
-static struct of_device_id i2c_smu_match[] =
-{
-	{
-		.compatible	= "smu-i2c",
-	},
-	{
-		.compatible	= "i2c-bus",
-	},
-	{},
-};
-static struct of_platform_driver i2c_smu_of_platform_driver =
-{
-	.name 		= "i2c-smu",
-	.match_table	= i2c_smu_match,
-	.probe		= create_iface_of_platform,
-	.remove		= dispose_iface_of_platform
-};
-
-
-static int __init i2c_pmac_smu_init(void)
-{
-	of_register_driver(&i2c_smu_of_platform_driver);
-	return 0;
-}
-
-
-static void __exit i2c_pmac_smu_cleanup(void)
-{
-	of_unregister_driver(&i2c_smu_of_platform_driver);
-}
-
-module_init(i2c_pmac_smu_init);
-module_exit(i2c_pmac_smu_cleanup);
Index: linux-work/drivers/i2c/busses/i2c-powermac.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/i2c/busses/i2c-powermac.c	2006-01-07 10:53:57.000000000 +1100
@@ -0,0 +1,290 @@
+/*
+    i2c Support for Apple SMU Controller
+
+    Copyright (c) 2005 Benjamin Herrenschmidt, IBM Corp.
+                       <benh@kernel.crashing.org>
+
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
+
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <asm/prom.h>
+#include <asm/pmac_low_i2c.h>
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("I2C driver for Apple PowerMac");
+MODULE_LICENSE("GPL");
+
+/*
+ * SMBUS-type transfer entrypoint
+ */
+static s32 i2c_powermac_smbus_xfer(	struct i2c_adapter*	adap,
+					u16			addr,
+					unsigned short		flags,
+					char			read_write,
+					u8			command,
+					int			size,
+					union i2c_smbus_data*	data)
+{
+	struct pmac_i2c_bus	*bus = i2c_get_adapdata(adap);
+	int			rc = 0;
+	int			read = (read_write == I2C_SMBUS_READ);
+	int			addrdir = (addr << 1) | read;
+	u8			local[2];
+
+	rc = pmac_i2c_open(bus, 0);
+	if (rc)
+		return rc;
+
+	switch (size) {
+        case I2C_SMBUS_QUICK:
+		rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
+		if (rc)
+			goto bail;
+		rc = pmac_i2c_xfer(bus, addrdir, 0, 0, NULL, 0);
+	    	break;
+        case I2C_SMBUS_BYTE:
+		rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
+		if (rc)
+			goto bail;
+		rc = pmac_i2c_xfer(bus, addrdir, 0, 0, &data->byte, 1);
+	    	break;
+        case I2C_SMBUS_BYTE_DATA:
+		rc = pmac_i2c_setmode(bus, read ?
+				      pmac_i2c_mode_combined :
+				      pmac_i2c_mode_stdsub);
+		if (rc)
+			goto bail;
+		rc = pmac_i2c_xfer(bus, addrdir, 1, command, &data->byte, 1);
+	    	break;
+        case I2C_SMBUS_WORD_DATA:
+		rc = pmac_i2c_setmode(bus, read ?
+				      pmac_i2c_mode_combined :
+				      pmac_i2c_mode_stdsub);
+		if (rc)
+			goto bail;
+		if (!read) {
+			local[0] = data->word & 0xff;
+			local[1] = (data->word >> 8) & 0xff;
+		}
+		rc = pmac_i2c_xfer(bus, addrdir, 1, command, local, 2);
+		if (rc == 0 && read) {
+			data->word = ((u16)local[1]) << 8;
+			data->word |= local[0];
+		}
+	    	break;
+
+	/* Note that these are broken vs. the expected smbus API where
+	 * on reads, the lenght is actually returned from the function,
+	 * but I think the current API makes no sense and I don't want
+	 * any driver that I haven't verified for correctness to go
+	 * anywhere near a pmac i2c bus anyway ...
+	 *
+	 * I'm also not completely sure what kind of phases to do between
+	 * the actual command and the data (what I am _supposed_ to do that
+	 * is). For now, I assume writes are a single stream and reads have
+	 * a repeat start/addr phase (but not stop in between)
+	 */
+        case I2C_SMBUS_BLOCK_DATA:
+		rc = pmac_i2c_setmode(bus, read ?
+				      pmac_i2c_mode_combined :
+				      pmac_i2c_mode_stdsub);
+		if (rc)
+			goto bail;
+		rc = pmac_i2c_xfer(bus, addrdir, 1, command, data->block,
+				   data->block[0] + 1);
+
+		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		rc = pmac_i2c_setmode(bus, read ?
+				      pmac_i2c_mode_combined :
+				      pmac_i2c_mode_stdsub);
+		if (rc)
+			goto bail;
+		rc = pmac_i2c_xfer(bus, addrdir, 1, command,
+				   read ? data->block : &data->block[1],
+				   data->block[0]);
+		break;
+
+        default:
+	    	rc = -EINVAL;
+	}
+ bail:
+	pmac_i2c_close(bus);
+	return rc;
+}
+
+/*
+ * Generic i2c master transfer entrypoint. This driver only support single
+ * messages (for "lame i2c" transfers). Anything else should use the smbus
+ * entry point
+ */
+static int i2c_powermac_master_xfer(	struct i2c_adapter *adap,
+					struct i2c_msg *msgs,
+					int num)
+{
+	struct pmac_i2c_bus	*bus = i2c_get_adapdata(adap);
+	int			rc = 0;
+	int			read;
+	int			addrdir;
+
+	if (num != 1)
+		return -EINVAL;
+	if (msgs->flags & I2C_M_TEN)
+		return -EINVAL;
+	read = (msgs->flags & I2C_M_RD) != 0;
+	addrdir = (msgs->addr << 1) | read;
+	if (msgs->flags & I2C_M_REV_DIR_ADDR)
+		addrdir ^= 1;
+
+	rc = pmac_i2c_open(bus, 0);
+	if (rc)
+		return rc;
+	rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
+	if (rc)
+		goto bail;
+	rc = pmac_i2c_xfer(bus, addrdir, 0, 0, msgs->buf, msgs->len);
+ bail:
+	pmac_i2c_close(bus);
+	return rc < 0 ? rc : msgs->len;
+}
+
+static u32 i2c_powermac_func(struct i2c_adapter * adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_I2C;
+}
+
+/* For now, we only handle smbus */
+static struct i2c_algorithm i2c_powermac_algorithm = {
+	.smbus_xfer	= i2c_powermac_smbus_xfer,
+	.master_xfer	= i2c_powermac_master_xfer,
+	.functionality	= i2c_powermac_func,
+};
+
+
+static int i2c_powermac_remove(struct device *dev)
+{
+	struct i2c_adapter	*adapter = dev_get_drvdata(dev);
+	struct pmac_i2c_bus	*bus = i2c_get_adapdata(adapter);
+	int			rc;
+
+	rc = i2c_del_adapter(adapter);
+	pmac_i2c_detach_adapter(bus, adapter);
+	i2c_set_adapdata(adapter, NULL);
+	/* We aren't that prepared to deal with this... */
+	if (rc)
+		printk("i2c-powermac.c: Failed to remove bus %s !\n",
+		       adapter->name);
+	dev_set_drvdata(dev, NULL);
+	kfree(adapter);
+
+	return 0;
+}
+
+
+static int i2c_powermac_probe(struct device *dev)
+{
+	struct pmac_i2c_bus *bus = dev->platform_data;
+	struct device_node *parent = NULL;
+	struct i2c_adapter *adapter;
+	char name[32], *basename;
+	int rc;
+
+	if (bus == NULL)
+		return -EINVAL;
+
+	/* Ok, now we need to make up a name for the interface that will
+	 * match what we used to do in the past, that is basically the
+	 * controller's parent device node for keywest. PMU didn't have a
+	 * naming convention and SMU has a different one
+	 */
+	switch(pmac_i2c_get_type(bus)) {
+	case pmac_i2c_bus_keywest:
+		parent = of_get_parent(pmac_i2c_get_controller(bus));
+		if (parent == NULL)
+			return -EINVAL;
+		basename = parent->name;
+		break;
+	case pmac_i2c_bus_pmu:
+		basename = "pmu";
+		break;
+	case pmac_i2c_bus_smu:
+		/* This is not what we used to do but I'm fixing drivers at
+		 * the same time as this change
+		 */
+		basename = "smu";
+		break;
+	default:
+		return -EINVAL;
+	}
+	snprintf(name, 32, "%s %d", basename, pmac_i2c_get_channel(bus));
+	of_node_put(parent);
+
+	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
+	if (adapter == NULL) {
+		printk(KERN_ERR "i2c-powermac: can't allocate inteface !\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(dev, adapter);
+	strcpy(adapter->name, name);
+	adapter->algo = &i2c_powermac_algorithm;
+	i2c_set_adapdata(adapter, bus);
+	adapter->dev.parent = dev;
+	pmac_i2c_attach_adapter(bus, adapter);
+	rc = i2c_add_adapter(adapter);
+	if (rc) {
+		printk(KERN_ERR "i2c-powermac: Adapter %s registration "
+		       "failed\n", name);
+		i2c_set_adapdata(adapter, NULL);
+		pmac_i2c_detach_adapter(bus, adapter);
+	}
+
+	printk(KERN_INFO "PowerMac i2c bus %s registered\n", name);
+	return rc;
+}
+
+
+static struct device_driver i2c_powermac_driver = {
+	.name = "i2c-powermac",
+	.bus = &platform_bus_type,
+	.probe = i2c_powermac_probe,
+	.remove = i2c_powermac_remove,
+};
+
+static int __init i2c_powermac_init(void)
+{
+	driver_register(&i2c_powermac_driver);
+	return 0;
+}
+
+
+static void __exit i2c_powermac_cleanup(void)
+{
+	driver_unregister(&i2c_powermac_driver);
+}
+
+module_init(i2c_powermac_init);
+module_exit(i2c_powermac_cleanup);
Index: linux-work/arch/powerpc/platforms/powermac/low_i2c.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/low_i2c.c	2006-01-06 19:43:21.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/low_i2c.c	2006-01-07 10:53:21.000000000 +1100
@@ -39,6 +39,10 @@
 #include <linux/pmu.h>
 #include <linux/delay.h>
 #include <linux/completion.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/timer.h>
 #include <asm/keylargo.h>
 #include <asm/uninorth.h>
 #include <asm/io.h>
@@ -63,6 +67,9 @@
 #define DBG_LOW(x...)
 #endif
 
+
+static int pmac_i2c_force_poll = 1;
+
 /*
  * A bus structure. Each bus in the system has such a structure associated.
  */
@@ -80,6 +87,7 @@ struct pmac_i2c_bus
 	struct semaphore	sem;
 	int			opened;
 	int			polled;		/* open mode */
+	struct platform_device	*platform_dev;
 
 	/* ops */
 	int (*open)(struct pmac_i2c_bus *bus);
@@ -101,6 +109,16 @@ struct pmac_i2c_host_kw
 	void __iomem		*base;		/* register base address */
 	int			bsteps;		/* register stepping */
 	int			speed;		/* speed */
+	int			irq;
+	u8			*data;
+	unsigned		len;
+	int			state;
+	int			rw;
+	int			polled;
+	int			result;
+	struct completion	complete;
+	spinlock_t		lock;
+	struct timer_list	timeout_timer;
 };
 
 /* Register indices */
@@ -115,6 +133,8 @@ typedef enum {
 	reg_data
 } reg_t;
 
+/* The Tumbler audio equalizer can be really slow sometimes */
+#define KW_POLL_TIMEOUT		(2*HZ)
 
 /* Mode register */
 #define KW_I2C_MODE_100KHZ	0x00
@@ -158,8 +178,9 @@ enum {
 };
 
 #define WRONG_STATE(name) do {\
-		printk(KERN_DEBUG "KW: wrong state. Got %s, state: %s (isr: %02x)\n", \
-		       name, __kw_state_names[state], isr); \
+		printk(KERN_DEBUG "KW: wrong state. Got %s, state: %s " \
+		       "(isr: %02x)\n",	\
+		       name, __kw_state_names[host->state], isr); \
 	} while(0)
 
 static const char *__kw_state_names[] = {
@@ -171,23 +192,22 @@ static const char *__kw_state_names[] = 
 	"state_dead"
 };
 
-static inline u8 __kw_read_reg(struct pmac_i2c_bus *bus, reg_t reg)
+static inline u8 __kw_read_reg(struct pmac_i2c_host_kw *host, reg_t reg)
 {
-	struct pmac_i2c_host_kw *host = bus->hostdata;
 	return readb(host->base + (((unsigned int)reg) << host->bsteps));
 }
 
-static inline void __kw_write_reg(struct pmac_i2c_bus *bus, reg_t reg, u8 val)
+static inline void __kw_write_reg(struct pmac_i2c_host_kw *host,
+				  reg_t reg, u8 val)
 {
-	struct pmac_i2c_host_kw *host = bus->hostdata;
 	writeb(val, host->base + (((unsigned)reg) << host->bsteps));
-	(void)__kw_read_reg(bus, reg_subaddr);
+	(void)__kw_read_reg(host, reg_subaddr);
 }
 
-#define kw_write_reg(reg, val)	__kw_write_reg(bus, reg, val)
-#define kw_read_reg(reg)	__kw_read_reg(bus, reg)
+#define kw_write_reg(reg, val)	__kw_write_reg(host, reg, val)
+#define kw_read_reg(reg)	__kw_read_reg(host, reg)
 
-static u8 kw_i2c_wait_interrupt(struct pmac_i2c_bus* bus)
+static u8 kw_i2c_wait_interrupt(struct pmac_i2c_host_kw *host)
 {
 	int i, j;
 	u8 isr;
@@ -201,8 +221,8 @@ static u8 kw_i2c_wait_interrupt(struct p
 		 * on udelay nor schedule when in polled mode !
 		 * For now, just use a bogus loop....
 		 */
-		if (bus->polled) {
-			for (j = 1; j < 1000000; j++)
+		if (host->polled) {
+			for (j = 1; j < 100000; j++)
 				mb();
 		} else
 			msleep(1);
@@ -210,86 +230,99 @@ static u8 kw_i2c_wait_interrupt(struct p
 	return isr;
 }
 
-static int kw_i2c_handle_interrupt(struct pmac_i2c_bus *bus, int state, int rw,
-				   int *rc, u8 **data, int *len, u8 isr)
+static void kw_i2c_handle_interrupt(struct pmac_i2c_host_kw *host, u8 isr)
 {
 	u8 ack;
 
 	DBG_LOW("kw_handle_interrupt(%s, isr: %x)\n",
-		__kw_state_names[state], isr);
+		__kw_state_names[host->state], isr);
+
+	if (host->state == state_idle) {
+		printk(KERN_WARNING "low_i2c: Keywest got an out of state"
+		       " interrupt, ignoring\n");
+		kw_write_reg(reg_isr, isr);
+		return;
+	}
 
 	if (isr == 0) {
-		if (state != state_stop) {
+		if (host->state != state_stop) {
 			DBG_LOW("KW: Timeout !\n");
-			*rc = -EIO;
+			host->result = -EIO;
 			goto stop;
 		}
-		if (state == state_stop) {
+		if (host->state == state_stop) {
 			ack = kw_read_reg(reg_status);
-			if (!(ack & KW_I2C_STAT_BUSY)) {
-				state = state_idle;
-				kw_write_reg(reg_ier, 0x00);
-			}
+			if (ack & KW_I2C_STAT_BUSY)
+				kw_write_reg(reg_status, 0);
+			host->state = state_idle;
+			kw_write_reg(reg_ier, 0x00);
+			if (!host->polled)
+				complete(&host->complete);
 		}
-		return state;
+		return;
 	}
 
 	if (isr & KW_I2C_IRQ_ADDR) {
 		ack = kw_read_reg(reg_status);
-		if (state != state_addr) {
+		if (host->state != state_addr) {
 			kw_write_reg(reg_isr, KW_I2C_IRQ_ADDR);
 			WRONG_STATE("KW_I2C_IRQ_ADDR"); 
-			*rc = -EIO;
+			host->result = -EIO;
 			goto stop;
 		}
 		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
-			*rc = -ENODEV;
+			host->result = -ENODEV;
 			DBG_LOW("KW: NAK on address\n");
-			return state_stop;		     
+			host->state = state_stop;
+			return;
 		} else {
-			if (rw) {
-				state = state_read;
-				if (*len > 1)
+			if (host->len == 0) {
+				kw_write_reg(reg_isr, KW_I2C_IRQ_ADDR);
+				goto stop;
+			}
+			if (host->rw) {
+				host->state = state_read;
+				if (host->len > 1)
 					kw_write_reg(reg_control,
 						     KW_I2C_CTL_AAK);
 			} else {
-				state = state_write;
-				kw_write_reg(reg_data, **data);
-				(*data)++; (*len)--;
+				host->state = state_write;
+				kw_write_reg(reg_data, *(host->data++));
+				host->len--;
 			}
 		}
 		kw_write_reg(reg_isr, KW_I2C_IRQ_ADDR);
 	}
 
 	if (isr & KW_I2C_IRQ_DATA) {
-		if (state == state_read) {
-			**data = kw_read_reg(reg_data);
-			(*data)++; (*len)--;
+		if (host->state == state_read) {
+			*(host->data++) = kw_read_reg(reg_data);
+			host->len--;
 			kw_write_reg(reg_isr, KW_I2C_IRQ_DATA);
-			if ((*len) == 0)
-				state = state_stop;
-			else if ((*len) == 1)
+			if (host->len == 0)
+				host->state = state_stop;
+			else if (host->len == 1)
 				kw_write_reg(reg_control, 0);
-		} else if (state == state_write) {
+		} else if (host->state == state_write) {
 			ack = kw_read_reg(reg_status);
 			if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
 				DBG_LOW("KW: nack on data write\n");
-				*rc = -EIO;
+				host->result = -EIO;
 				goto stop;
-			} else if (*len) {
-				kw_write_reg(reg_data, **data);
-				(*data)++; (*len)--;
+			} else if (host->len) {
+				kw_write_reg(reg_data, *(host->data++));
+				host->len--;
 			} else {
 				kw_write_reg(reg_control, KW_I2C_CTL_STOP);
-				state = state_stop;
-				*rc = 0;
+				host->state = state_stop;
+				host->result = 0;
 			}
 			kw_write_reg(reg_isr, KW_I2C_IRQ_DATA);
 		} else {
 			kw_write_reg(reg_isr, KW_I2C_IRQ_DATA);
 			WRONG_STATE("KW_I2C_IRQ_DATA"); 
-			if (state != state_stop) {
-				*rc = -EIO;
+			if (host->state != state_stop) {
+				host->result = -EIO;
 				goto stop;
 			}
 		}
@@ -297,21 +330,54 @@ static int kw_i2c_handle_interrupt(struc
 
 	if (isr & KW_I2C_IRQ_STOP) {
 		kw_write_reg(reg_isr, KW_I2C_IRQ_STOP);
-		if (state != state_stop) {
+		if (host->state != state_stop) {
 			WRONG_STATE("KW_I2C_IRQ_STOP");
-			*rc = -EIO;
+			host->result = -EIO;
 		}
-		return state_idle;
+		host->state = state_idle;
+		if (!host->polled)
+			complete(&host->complete);
 	}
 
 	if (isr & KW_I2C_IRQ_START)
 		kw_write_reg(reg_isr, KW_I2C_IRQ_START);
 
-	return state;
-
+	return;
  stop:
 	kw_write_reg(reg_control, KW_I2C_CTL_STOP);	
-	return state_stop;
+	host->state = state_stop;
+	return;
+}
+
+/* Interrupt handler */
+static irqreturn_t kw_i2c_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct pmac_i2c_host_kw *host = dev_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	del_timer(&host->timeout_timer);
+	kw_i2c_handle_interrupt(host, kw_read_reg(reg_isr));
+	if (host->state != state_idle) {
+		host->timeout_timer.expires = jiffies + KW_POLL_TIMEOUT;
+		add_timer(&host->timeout_timer);
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static void kw_i2c_timeout(unsigned long data)
+{
+	struct pmac_i2c_host_kw *host = (struct pmac_i2c_host_kw *)data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	kw_i2c_handle_interrupt(host, kw_read_reg(reg_isr));
+	if (host->state != state_idle) {
+		host->timeout_timer.expires = jiffies + KW_POLL_TIMEOUT;
+		add_timer(&host->timeout_timer);
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static int kw_i2c_open(struct pmac_i2c_bus *bus)
@@ -332,8 +398,7 @@ static int kw_i2c_xfer(struct pmac_i2c_b
 {
 	struct pmac_i2c_host_kw *host = bus->hostdata;
 	u8 mode_reg = host->speed;
-	int state = state_addr;
-	int rc = 0;
+	int use_irq = host->irq != NO_IRQ && !bus->polled;
 
 	/* Setup mode & subaddress if any */
 	switch(bus->mode) {
@@ -371,18 +436,50 @@ static int kw_i2c_xfer(struct pmac_i2c_b
 	    || (mode_reg & KW_I2C_MODE_MODE_MASK) == KW_I2C_MODE_COMBINED)
 		kw_write_reg(reg_subaddr, subaddr);
 
-	/* Start sending address & disable interrupt*/
-	kw_write_reg(reg_ier, 0 /*KW_I2C_IRQ_MASK*/);
+	/* Prepare for async operations */
+	host->data = data;
+	host->len = len;
+	host->state = state_addr;
+	host->result = 0;
+	host->rw = (addrdir & 1);
+	host->polled = bus->polled;
+
+	/* Enable interrupt if not using polled mode and interrupt is
+	 * available
+	 */
+	if (use_irq) {
+		/* Clear completion */
+		INIT_COMPLETION(host->complete);
+		/* Ack stale interrupts */
+		kw_write_reg(reg_isr, kw_read_reg(reg_isr));
+		/* Arm timeout */
+		host->timeout_timer.expires = jiffies + KW_POLL_TIMEOUT;
+		add_timer(&host->timeout_timer);
+		/* Enable emission */
+		kw_write_reg(reg_ier, KW_I2C_IRQ_MASK);
+	}
+
+	/* Start sending address */
 	kw_write_reg(reg_control, KW_I2C_CTL_XADDR);
 
-	/* State machine, to turn into an interrupt handler in the future */
-	while(state != state_idle) {
-		u8 isr = kw_i2c_wait_interrupt(bus);
-		state = kw_i2c_handle_interrupt(bus, state, addrdir & 1, &rc,
-						&data, &len, isr);
+	/* Wait for completion */
+	if (use_irq)
+		wait_for_completion(&host->complete);
+	else {
+		while(host->state != state_idle) {
+			unsigned long flags;
+
+			u8 isr = kw_i2c_wait_interrupt(host);
+			spin_lock_irqsave(&host->lock, flags);
+			kw_i2c_handle_interrupt(host, isr);
+			spin_unlock_irqrestore(&host->lock, flags);
+		}
 	}
 
-	return rc;
+	/* Disable emission */
+	kw_write_reg(reg_ier, 0);
+
+	return host->result;
 }
 
 static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
@@ -409,6 +506,12 @@ static struct pmac_i2c_host_kw *__init k
 		return NULL;
 	}
 	init_MUTEX(&host->mutex);
+	init_completion(&host->complete);
+	spin_lock_init(&host->lock);
+	init_timer(&host->timeout_timer);
+	host->timeout_timer.function = kw_i2c_timeout;
+	host->timeout_timer.data = (unsigned long)host;
+
 	psteps = (u32 *)get_property(np, "AAPL,address-step", NULL);
 	steps = psteps ? (*psteps) : 0x10;
 	for (host->bsteps = 0; (steps & 0x01) == 0; host->bsteps++)
@@ -427,9 +530,28 @@ static struct pmac_i2c_host_kw *__init k
 		host->speed = KW_I2C_MODE_25KHZ;
 		break;
 	}	
+	if (np->n_intrs > 0)
+		host->irq = np->intrs[0].line;
+	else
+		host->irq = NO_IRQ;
 
-	printk(KERN_INFO "KeyWest i2c @0x%08x %s\n", *addrp, np->full_name);
 	host->base = ioremap((*addrp), 0x1000);
+	if (host->base == NULL) {
+		printk(KERN_ERR "low_i2c: Can't map registers for %s\n",
+		       np->full_name);
+		kfree(host);
+		return NULL;
+	}
+
+	/* Make sure IRA is disabled */
+	kw_write_reg(reg_ier, 0);
+
+	/* Request chip interrupt */
+	if (request_irq(host->irq, kw_i2c_irq, SA_SHIRQ, "keywest i2c", host))
+		host->irq = NO_IRQ;
+
+	printk(KERN_INFO "KeyWest i2c @0x%08x irq %d %s\n",
+	       *addrp, host->irq, np->full_name);
 
 	return host;
 }
@@ -591,7 +713,7 @@ static int pmu_i2c_xfer(struct pmac_i2c_
 		req->nbytes = sizeof(struct pmu_i2c_hdr) + 1;
 		req->done = pmu_i2c_complete;
 		req->arg = &comp;
-		if (!read) {
+		if (!read && len) {
 			memcpy(hdr->data, data, len);
 			req->nbytes += len;
 		}
@@ -637,7 +759,8 @@ static int pmu_i2c_xfer(struct pmac_i2c_
 				       " bytes, expected %d !\n", rlen, len);
 				return -EIO;
 			}
-			memcpy(data, &req->reply[1], len);
+			if (len)
+				memcpy(data, &req->reply[1], len);
 			return 0;
 		}
 	}
@@ -713,6 +836,10 @@ static int smu_i2c_xfer(struct pmac_i2c_
 	int read = addrdir & 1;
 	int rc = 0;
 
+	if ((read && len > SMU_I2C_READ_MAX) ||
+	    ((!read) && len > SMU_I2C_WRITE_MAX))
+		return -EINVAL;
+
 	memset(cmd, 0, sizeof(struct smu_i2c_cmd));
 	cmd->info.bus = bus->channel;
 	cmd->info.devaddr = addrdir;
@@ -740,7 +867,7 @@ static int smu_i2c_xfer(struct pmac_i2c_
 	default:
 		return -EINVAL;
 	}
-	if (!read)
+	if (!read && len)
 		memcpy(cmd->info.data, data, len);
 
 	init_completion(&comp);
@@ -752,7 +879,7 @@ static int smu_i2c_xfer(struct pmac_i2c_
 	wait_for_completion(&comp);
 	rc = cmd->status;
 
-	if (read)
+	if (read && len)
 		memcpy(data, cmd->info.data, len);
 	return rc < 0 ? rc : 0;
 }
@@ -767,7 +894,7 @@ static void __init smu_i2c_probe(void)
 	if (!smu_present())
 		return;
 
-	controller = of_find_node_by_name(NULL, "smu_i2c_control");
+	controller = of_find_node_by_name(NULL, "smu-i2c-control");
 	if (controller == NULL)
 		controller = of_find_node_by_name(NULL, "smu");
 	if (controller == NULL)
@@ -884,6 +1011,13 @@ int pmac_i2c_get_flags(struct pmac_i2c_b
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_get_flags);
 
+int pmac_i2c_get_channel(struct pmac_i2c_bus *bus)
+{
+	return bus->channel;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_get_channel);
+
+
 void pmac_i2c_attach_adapter(struct pmac_i2c_bus *bus,
 			     struct i2c_adapter *adapter)
 {
@@ -906,6 +1040,17 @@ struct i2c_adapter *pmac_i2c_get_adapter
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_get_adapter);
 
+struct pmac_i2c_bus *pmac_i2c_adapter_to_bus(struct i2c_adapter *adapter)
+{
+	struct pmac_i2c_bus *bus;
+
+	list_for_each_entry(bus, &pmac_i2c_busses, link)
+		if (bus->adapter == adapter)
+			return bus;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pmac_i2c_adapter_to_bus);
+
 extern int pmac_i2c_match_adapter(struct device_node *dev,
 				  struct i2c_adapter *adapter)
 {
@@ -956,7 +1101,7 @@ int pmac_i2c_open(struct pmac_i2c_bus *b
 	int rc;
 
 	down(&bus->sem);
-	bus->polled = polled;
+	bus->polled = polled || pmac_i2c_force_poll;
 	bus->opened = 1;
 	bus->mode = pmac_i2c_mode_std;
 	if (bus->open && (rc = bus->open(bus)) != 0) {
@@ -1034,14 +1179,43 @@ int __init pmac_i2c_init(void)
 	kw_i2c_probe();
 
 #ifdef CONFIG_ADB_PMU
+	/* Probe PMU i2c busses */
 	pmu_i2c_probe();
 #endif
 
 #ifdef CONFIG_PMAC_SMU
+	/* Probe SMU i2c busses */
 	smu_i2c_probe();
 #endif
-
 	return 0;
 }
 arch_initcall(pmac_i2c_init);
 
+/* Since pmac_i2c_init can be called too early for the platform device
+ * registration, we need to do it at a later time. In our case, subsys
+ * happens to fit well, though I agree it's a bit of a hack...
+ */
+static int __init pmac_i2c_create_platform_devices(void)
+{
+	struct pmac_i2c_bus *bus;
+	int i = 0;
+
+	/* In the case where we are initialized from smp_init(), we must
+	 * not use the timer (and thus the irq). It's safe from now on
+	 * though
+	 */
+	pmac_i2c_force_poll = 0;
+
+	/* Create platform devices */
+	list_for_each_entry(bus, &pmac_i2c_busses, link) {
+		bus->platform_dev =
+			platform_device_alloc("i2c-powermac", i++);
+		if (bus->platform_dev == NULL)
+			return -ENOMEM;
+		bus->platform_dev->dev.platform_data = bus;
+		platform_device_add(bus->platform_dev);
+	}
+
+	return 0;
+}
+subsys_initcall(pmac_i2c_create_platform_devices);
Index: linux-work/include/asm-powerpc/pmac_low_i2c.h
===================================================================
--- linux-work.orig/include/asm-powerpc/pmac_low_i2c.h	2006-01-06 19:42:48.000000000 +1100
+++ linux-work/include/asm-powerpc/pmac_low_i2c.h	2006-01-07 10:53:21.000000000 +1100
@@ -70,6 +70,7 @@ extern struct device_node *pmac_i2c_get_
 extern struct device_node *pmac_i2c_get_bus_node(struct pmac_i2c_bus *bus);
 extern int pmac_i2c_get_type(struct pmac_i2c_bus *bus);
 extern int pmac_i2c_get_flags(struct pmac_i2c_bus *bus);
+extern int pmac_i2c_get_channel(struct pmac_i2c_bus *bus);
 
 /* i2c layer adapter attach/detach */
 extern void pmac_i2c_attach_adapter(struct pmac_i2c_bus *bus,
@@ -77,6 +78,7 @@ extern void pmac_i2c_attach_adapter(stru
 extern void pmac_i2c_detach_adapter(struct pmac_i2c_bus *bus,
 				    struct i2c_adapter *adapter);
 extern struct i2c_adapter *pmac_i2c_get_adapter(struct pmac_i2c_bus *bus);
+extern struct pmac_i2c_bus *pmac_i2c_adapter_to_bus(struct i2c_adapter *adapter);
 
 /* March a device or bus with an i2c adapter structure, to be used by drivers
  * to match device-tree nodes with i2c adapters during adapter discovery
Index: linux-work/drivers/macintosh/smu.c
===================================================================
--- linux-work.orig/drivers/macintosh/smu.c	2006-01-06 19:42:48.000000000 +1100
+++ linux-work/drivers/macintosh/smu.c	2006-01-06 19:43:28.000000000 +1100
@@ -584,34 +584,14 @@ core_initcall(smu_late_init);
  * sysfs visibility
  */
 
-static void smu_create_i2c(struct device_node *np)
-{
-	char name[32];
-	u32 *reg = (u32 *)get_property(np, "reg", NULL);
-
-	if (reg != NULL) {
-		sprintf(name, "smu-i2c-%02x", *reg);
-		of_platform_device_create(np, name, &smu->of_dev->dev);
-	}
-}
-
 static void smu_expose_childs(void *unused)
 {
-	struct device_node *np, *gp;
+	struct device_node *np;
 
-	for (np = NULL; (np = of_get_next_child(smu->of_node, np)) != NULL;) {
-		if (device_is_compatible(np, "smu-i2c-control")) {
-			gp = NULL;
-			while ((gp = of_get_next_child(np, gp)) != NULL)
-				if (device_is_compatible(gp, "i2c-bus"))
-					smu_create_i2c(gp);
-		} else if (device_is_compatible(np, "smu-i2c"))
-			smu_create_i2c(np);
+	for (np = NULL; (np = of_get_next_child(smu->of_node, np)) != NULL;)
 		if (device_is_compatible(np, "smu-sensors"))
 			of_platform_device_create(np, "smu-sensors",
 						  &smu->of_dev->dev);
-	}
-
 }
 
 static DECLARE_WORK(smu_expose_childs_work, smu_expose_childs, NULL);
Index: linux-work/drivers/macintosh/windfarm_lm75_sensor.c
===================================================================
--- linux-work.orig/drivers/macintosh/windfarm_lm75_sensor.c	2006-01-06 19:42:48.000000000 +1100
+++ linux-work/drivers/macintosh/windfarm_lm75_sensor.c	2006-01-06 19:43:28.000000000 +1100
@@ -21,6 +21,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/sections.h>
+#include <asm/pmac_low_i2c.h>
 
 #include "windfarm.h"
 
@@ -157,53 +158,21 @@ static struct wf_lm75_sensor *wf_lm75_cr
 
 static int wf_lm75_attach(struct i2c_adapter *adapter)
 {
-	u8 bus_id;
-	struct device_node *smu, *bus, *dev;
-
-	/* We currently only deal with LM75's hanging off the SMU
-	 * i2c busses. If we extend that driver to other/older
-	 * machines, we should split this function into SMU-i2c,
-	 * keywest-i2c, PMU-i2c, ...
-	 */
+	struct device_node *busnode, *dev;
+	struct pmac_i2c_bus *bus;
 
 	DBG("wf_lm75: adapter %s detected\n", adapter->name);
 
-	if (strncmp(adapter->name, "smu-i2c-", 8) != 0)
-		return 0;
-	smu = of_find_node_by_type(NULL, "smu");
-	if (smu == NULL)
-		return 0;
-
-	/* Look for the bus in the device-tree */
-	bus_id = (u8)simple_strtoul(adapter->name + 8, NULL, 16);
-
-	DBG("wf_lm75: bus ID is %x\n", bus_id);
-
-	/* Look for sensors subdir */
-	for (bus = NULL;
-	     (bus = of_get_next_child(smu, bus)) != NULL;) {
-		u32 *reg;
-
-		if (strcmp(bus->name, "i2c"))
-			continue;
-		reg = (u32 *)get_property(bus, "reg", NULL);
-		if (reg == NULL)
-			continue;
-		if (bus_id == *reg)
-			break;
-	}
-	of_node_put(smu);
-	if (bus == NULL) {
-		printk(KERN_WARNING "windfarm: SMU i2c bus 0x%x not found"
-		       " in device-tree !\n", bus_id);
-		return 0;
-	}
+	bus = pmac_i2c_adapter_to_bus(adapter);
+	if (bus == NULL)
+		return -ENODEV;
+	busnode = pmac_i2c_get_bus_node(bus);
 
 	DBG("wf_lm75: bus found, looking for device...\n");
 
 	/* Now look for lm75(s) in there */
 	for (dev = NULL;
-	     (dev = of_get_next_child(bus, dev)) != NULL;) {
+	     (dev = of_get_next_child(busnode, dev)) != NULL;) {
 		const char *loc =
 			get_property(dev, "hwsensor-location", NULL);
 		u32 *reg = (u32 *)get_property(dev, "reg", NULL);
@@ -217,9 +186,6 @@ static int wf_lm75_attach(struct i2c_ada
 		else if (device_is_compatible(dev, "ds1775"))
 			wf_lm75_create(adapter, *reg, 1, loc);
 	}
-
-	of_node_put(bus);
-
 	return 0;
 }
 
Index: linux-work/drivers/macintosh/Kconfig
===================================================================
--- linux-work.orig/drivers/macintosh/Kconfig	2006-01-06 19:42:48.000000000 +1100
+++ linux-work/drivers/macintosh/Kconfig	2006-01-07 10:53:19.000000000 +1100
@@ -149,14 +149,14 @@ config MAC_EMUMOUSEBTN
 
 config THERM_WINDTUNNEL
 	tristate "Support for thermal management on Windtunnel G4s"
-	depends on I2C && I2C_KEYWEST && PPC_PMAC && !PPC_PMAC64
+	depends on I2C && I2C_POWERMAC && PPC_PMAC && !PPC_PMAC64
 	help
 	  This driver provides some thermostat and fan control for the desktop
 	  G4 "Windtunnel"
 
 config THERM_ADT746X
 	tristate "Support for thermal mgmnt on laptops with ADT 746x chipset"
-	depends on I2C && I2C_KEYWEST && PPC_PMAC && !PPC_PMAC64
+	depends on I2C && I2C_POWERMAC && PPC_PMAC && !PPC_PMAC64
 	help
 	  This driver provides some thermostat and fan control for the
           iBook G4, and the ATI based aluminium PowerBooks, allowing slighlty
@@ -164,7 +164,7 @@ config THERM_ADT746X
 
 config THERM_PM72
 	tristate "Support for thermal management on PowerMac G5"
-	depends on I2C && I2C_KEYWEST && PPC_PMAC64
+	depends on I2C && I2C_POWERMAC && PPC_PMAC64
 	help
 	  This driver provides thermostat and fan control for the desktop
 	  G5 machines. 
@@ -175,14 +175,14 @@ config WINDFARM
 config WINDFARM_PM81
 	tristate "Support for thermal management on iMac G5"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
-	select I2C_PMAC_SMU
+	select I2C_POWERMAC
 	help
 	  This driver provides thermal control for the iMacG5
 
 config WINDFARM_PM91
 	tristate "Support for thermal management on PowerMac9,1"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
-	select I2C_PMAC_SMU
+	select I2C_POWERMAC
 	help
 	  This driver provides thermal control for the PowerMac9,1
           which is the recent (SMU based) single CPU desktop G5
Index: linux-work/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2006-01-06 19:42:48.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2006-01-06 19:43:28.000000000 +1100
@@ -656,7 +656,7 @@ static int pmac_check_legacy_ioport(unsi
 
 static int __init pmac_declare_of_platform_devices(void)
 {
-	struct device_node *np, *npp;
+	struct device_node *np;
 
 	np = of_find_node_by_name(NULL, "valkyrie");
 	if (np)
@@ -664,22 +664,6 @@ static int __init pmac_declare_of_platfo
 	np = of_find_node_by_name(NULL, "platinum");
 	if (np)
 		of_platform_device_create(np, "platinum", NULL);
-	npp = of_find_node_by_name(NULL, "uni-n");
-	if (npp == NULL)
-		npp = of_find_node_by_name(NULL, "u3");
-	if (npp == NULL)
-		npp = of_find_node_by_name(NULL, "u4");
-	if (npp) {
-		for (np = NULL; (np = of_get_next_child(npp, np)) != NULL;) {
-			if (strncmp(np->name, "i2c", 3) == 0) {
-				of_platform_device_create(np, "uni-n-i2c",
-							  NULL);
-				of_node_put(np);
-				break;
-			}
-		}
-		of_node_put(npp);
-	}
         np = of_find_node_by_type(NULL, "smu");
         if (np) {
 		of_platform_device_create(np, "smu", NULL);
