Subject: [PATCH][RFC] I2C support for MPC107 and relatives
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1087207803.7360.83.camel@newt>
References: <1087207803.7360.83.camel@newt>
Content-Type: multipart/mixed; boundary="=-PTy239xbaeEoE6CvIRB+"
Message-Id: <1087208600.7360.102.camel@newt>
Mime-Version: 1.0
Date: Mon, 14 Jun 2004 11:23:20 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-PTy239xbaeEoE6CvIRB+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch is a 2.6 port of my I2C driver for the MPC107 and
relatives. It uses my OCP patch to find the address and IRQ information,
which replaces the direct reading of EPIC registers used in the 2.4
version.

Both of these are against the linux-2.5 tree.

Again, any comments? (I'm away from email midweek, so I may not answer
until Friday.)

- Adrian Cox
Humboldt Solutions Ltd.


--=-PTy239xbaeEoE6CvIRB+
Content-Disposition: attachment; filename=i2c.patch
Content-Type: text/x-patch; name=i2c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/14 10:54:08+01:00 adrian@humboldt.co.uk
#   Add MPC107 I2C interface
#
# drivers/i2c/busses/i2c-mpc107.c
#   2004/06/14 10:53:50+01:00 adrian@humboldt.co.uk +402 -0
#
# drivers/i2c/busses/i2c-mpc107.c
#   2004/06/14 10:53:50+01:00 adrian@humboldt.co.uk +0 -0
#   BitKeeper file /home/adrian/kernels/sa107-2.6/sa107-2/drivers/i2c/busses/i2c-mpc107.c
#
# drivers/i2c/busses/Makefile
#   2004/06/14 10:53:50+01:00 adrian@humboldt.co.uk +1 -0
#   Add MPC107 I2C interface
#
# drivers/i2c/busses/Kconfig
#   2004/06/14 10:53:50+01:00 adrian@humboldt.co.uk +10 -0
#   Add MPC107 I2C interface
#
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jun 14 10:55:04 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jun 14 10:55:04 2004
@@ -396,4 +396,14 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-voodoo3.

+config I2C_MPC107
+	tristate "MPC107/824x"
+	depends on I2C && MPC10X_BRIDGE
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC8245.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mpc107.
+
 endmenu
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Jun 14 10:55:04 2004
+++ b/drivers/i2c/busses/Makefile	Mon Jun 14 10:55:04 2004
@@ -32,6 +32,7 @@
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_MPC107)	+= i2c-mpc107.o

 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/drivers/i2c/busses/i2c-mpc107.c b/drivers/i2c/busses/i2c-mpc107.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-mpc107.c	Mon Jun 14 10:55:04 2004
@@ -0,0 +1,402 @@
+/*
+ * (C) Copyright 2003-2004
+ * Humboldt Solutions Ltd, adrian@humboldt.co.uk.
+
+ * This is a combined i2c adapter and algorithm driver for Motorola's
+ * MPC107 PowerPC northbridge and related silicon (8240, 8245).
+ *
+ * Release 0.4
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <asm/mpc10x.h>
+#include <asm/ocp.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DPRINTK(args...) printk(KERN_DEBUG __FILE__": " args)
+#else
+#define DPRINTK(args...)
+#endif
+
+
+#define MPC107_I2CADDR  0x00
+#define MPC107_I2CFDR 	0x04
+#define MPC107_I2CCR	0x08
+#define MPC107_I2CSR	0x0c
+#define MPC107_I2CDR	0x10
+
+#define MPC107_CCR_MEN  0x80
+#define MPC107_CCR_MIEN 0x40
+#define MPC107_CCR_MSTA 0x20
+#define MPC107_CCR_MTX  0x10
+#define MPC107_CCR_TXAK 0x08
+#define MPC107_CCR_RSTA 0x04
+
+#define MPC107_CSR_MCF  0x80
+#define MPC107_CSR_MAAS 0x40
+#define MPC107_CSR_MBB  0x20
+#define MPC107_CSR_MAL  0x10
+#define MPC107_CSR_SRW  0x04
+#define MPC107_CSR_MIF  0x02
+#define MPC107_CSR_RXAK 0x01
+
+struct mpc107_i2c {
+	char *base;
+	struct ocp_def *ocpdef;
+	u32 interrupt;
+	wait_queue_head_t queue;
+	struct i2c_adapter adap;
+};
+
+static __inline__ void writeccr(struct mpc107_i2c *i2c, u32 x)
+{
+	writel(x, i2c->base + MPC107_I2CCR);
+}
+
+static irqreturn_t mpc107_i2c_isr(int irq, void *dev_id, struct pt_regs * regs)
+{
+	struct mpc107_i2c *i2c = dev_id;
+	if (readl(i2c->base + MPC107_I2CSR) & MPC107_CSR_MIF) {
+		/* Read again to allow register to stabilise */
+		i2c->interrupt = readl(i2c->base + MPC107_I2CSR);
+		writel(0, i2c->base + MPC107_I2CSR);
+		wake_up_interruptible(&i2c->queue);
+	}
+	return IRQ_HANDLED;
+}
+
+static int i2c_wait(struct mpc107_i2c *i2c, unsigned timeout, int writing)
+{
+	DECLARE_WAITQUEUE(wait, current);
+        unsigned long orig_jiffies = jiffies;
+        u32 x;
+	int result = 0;
+
+	if (i2c->ocpdef->irq == OCP_IRQ_NA) {
+		while(! (readl(i2c->base + MPC107_I2CSR) & MPC107_CSR_MIF)) {
+			schedule();
+			if (orig_jiffies + timeout < jiffies) {
+				DPRINTK("I2C: timeout\n");
+				result = -EIO;
+				break;
+			}
+		}
+		x = readl(i2c->base + MPC107_I2CSR);
+		writel(0, i2c->base + MPC107_I2CSR);
+	} else {
+		add_wait_queue(&i2c->queue, &wait);
+		while ( ! (i2c->interrupt & MPC107_CSR_MIF)) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			if (signal_pending(current)) {
+				DPRINTK("I2C: Interrupted\n");
+				result = -EINTR;
+				break;
+			}
+			if (orig_jiffies + timeout < jiffies) {
+				DPRINTK("I2C: timeout\n");
+				result = -EIO;
+				break;
+			}
+			schedule_timeout(timeout);
+		}
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&i2c->queue, &wait);
+		x = i2c->interrupt;
+		i2c->interrupt = 0;
+	}
+
+	if (result < -0)
+	    return result;
+
+	if (! (x & MPC107_CSR_MCF))
+	{
+	    DPRINTK("I2C: unfinished\n");
+	    return -EIO;
+	}
+
+        if (x & MPC107_CSR_MAL)
+	{
+	    	DPRINTK("I2C: MAL\n");
+                return -EIO;
+	}
+
+        if (writing && (x & MPC107_CSR_RXAK)) {
+                DPRINTK("I2C: No RXAK\n");
+                /* generate stop */
+                writeccr(i2c, MPC107_CCR_MEN);
+                return -EIO;
+        }
+        return 0;
+}
+
+static void mpc107_i2c_start(struct mpc107_i2c *i2c)
+{
+        /* Set clock */
+        writel(0x1031, i2c->base + MPC107_I2CFDR);
+        /* Clear arbitration */
+        writel(0, i2c->base + MPC107_I2CSR);
+       	/* Start with MEN */
+	writeccr(i2c, MPC107_CCR_MEN);
+}
+
+static void mpc107_i2c_stop(struct mpc107_i2c *i2c)
+{
+	writeccr(i2c, MPC107_CCR_MEN);
+}
+
+static int mpc107_write(struct mpc107_i2c *i2c, int target,
+			const u8 *data, int length, int restart)
+{
+        int i;
+        unsigned timeout = HZ;
+    	u32 flags = restart ? MPC107_CCR_RSTA : 0;
+
+	/* Start with MEN */
+	if (! restart)
+		writeccr(i2c, MPC107_CCR_MEN);
+	/* Start as master */
+	writeccr(i2c, MPC107_CCR_MIEN | MPC107_CCR_MEN |
+		      MPC107_CCR_MSTA | MPC107_CCR_MTX | flags);
+	/* Write target byte */
+	writel((target << 1), i2c->base + MPC107_I2CDR);
+
+	if (i2c_wait(i2c, timeout, 1) < 0)
+	    return -1;
+
+        for(i = 0; i < length; i++) {
+	        /* Write data byte */
+	        writel(data[i], i2c->base + MPC107_I2CDR);
+
+	        if (i2c_wait(i2c, timeout, 1) < 0)
+	            return -1;
+        }
+
+        return 0;
+}
+
+static int mpc107_read(struct mpc107_i2c *i2c, int target,
+		       u8 *data, int length, int restart)
+{
+    	unsigned timeout = HZ;
+    	int i;
+    	u32 flags = restart ? MPC107_CCR_RSTA : 0;
+
+	/* Start with MEN */
+	if (! restart)
+		writeccr(i2c, MPC107_CCR_MEN);
+	/* Switch to read - restart */
+	writeccr(i2c, MPC107_CCR_MIEN | MPC107_CCR_MEN | MPC107_CCR_MSTA |
+		      MPC107_CCR_MTX | flags);
+	/* Write target address byte - this time with the read flag set */
+	writel((target << 1) | 1, i2c->base + MPC107_I2CDR);
+
+	if (i2c_wait(i2c, timeout, 0) < 0)
+	    return -1;
+
+	if (length == 1)
+	    writeccr(i2c, MPC107_CCR_MIEN| MPC107_CCR_MEN |
+			  MPC107_CCR_MSTA | MPC107_CCR_TXAK);
+	else
+	    writeccr(i2c, MPC107_CCR_MIEN| MPC107_CCR_MEN | MPC107_CCR_MSTA);
+    	/* Dummy read */
+	readl(i2c->base + MPC107_I2CDR);
+
+	for(i = 0; i < length; i++) {
+		if (i2c_wait(i2c, timeout, 0) < 0)
+			return -1;
+
+		/* Generate txack on next to last byte */
+		if (i == length - 2)
+			writeccr(i2c, MPC107_CCR_MIEN | MPC107_CCR_MEN |
+				      MPC107_CCR_MSTA | MPC107_CCR_TXAK);
+		/* Generate stop on last byte */
+		if (i == length - 1)
+			writeccr(i2c, MPC107_CCR_MIEN | MPC107_CCR_MEN |
+				      MPC107_CCR_TXAK);
+		data[i] = readl(i2c->base + MPC107_I2CDR);
+	}
+
+	return length;
+}
+
+static int mpc107_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
+	                   int num)
+{
+	struct i2c_msg *pmsg;
+	int i;
+	int ret=0;
+        unsigned long orig_jiffies = jiffies;
+	struct mpc107_i2c *i2c = i2c_get_adapdata(adap);
+
+        mpc107_i2c_start(i2c);
+
+	/* Allow bus up to 1s to become not busy */
+	while(readl(i2c->base + MPC107_I2CSR) & MPC107_CSR_MBB) {
+                if (signal_pending(current))
+		{
+			DPRINTK("I2C: Interrupted\n");
+                        return -EINTR;
+		}
+                if (orig_jiffies + HZ < jiffies)
+		{
+		    	printk("I2C: timeout\n");
+                        return -EIO;
+		}
+                schedule();
+        }
+
+	for (i = 0;ret >= 0 && i < num; i++) {
+		pmsg = &msgs[i];
+		DPRINTK("Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		     pmsg->flags & I2C_M_RD ? "read" : "write",
+                     pmsg->len, pmsg->addr, i + 1, num);
+		if (pmsg->flags & I2C_M_RD)
+                        ret = mpc107_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+                else
+                        ret = mpc107_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+        }
+        mpc107_i2c_stop(i2c);
+        return (ret < 0) ? ret : num;
+}
+
+static u32 mpc107_functionality(struct i2c_adapter *adap)
+{
+        return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static struct i2c_algorithm mpc107_algo = {
+	.name = "MPC107 algorithm",
+	.id = I2C_ALGO_MPC107,
+	.master_xfer = mpc107_xfer,
+	.functionality = mpc107_functionality,
+};
+
+static struct i2c_adapter mpc107_ops = {
+	.name = "MPC107 adapter",
+	.id = I2C_ALGO_MPC107 | I2C_HW_MPC107,
+	.algo = &mpc107_algo,
+	.class = I2C_CLASS_HWMON,
+	.timeout = 1,
+	.retries = 1
+};
+
+static int __devinit mpc107_i2c_probe(struct ocp_device *ocp)
+{
+	int result = 0;
+	struct mpc107_i2c *i2c;
+
+	if (!(i2c = kmalloc(sizeof(*i2c), GFP_KERNEL))){
+		return -ENOMEM;
+	}
+	i2c->ocpdef = ocp->def;
+	init_waitqueue_head(&i2c->queue);
+
+	if (! request_mem_region(ocp->def->paddr, MPC10X_EUMB_I2C_SIZE,
+		                 "Motorola MPC107 I2C Controller")) {
+		printk(KERN_ERR "MPC107 I2C - resource unavailable\n");
+		return -ENODEV;
+	}
+
+	i2c->base = ioremap(ocp->def->paddr, MPC10X_EUMB_I2C_SIZE);
+
+	if (! i2c->base) {
+		printk(KERN_ERR "MPC107 I2C - failed to map controller\n");
+		result = -ENOMEM;
+		goto fail_map;
+	}
+
+	if (ocp->def->irq != OCP_IRQ_NA)
+		if ((result = request_irq(ocp->def->irq, mpc107_i2c_isr,
+					  0, "mpc107_i2c", i2c)) < 0) {
+			printk(KERN_ERR "MPC107 I2C - failed to attach interrupt\n");
+			goto fail_irq;
+		}
+
+	i2c->adap = mpc107_ops;
+	i2c_set_adapdata(&i2c->adap, i2c);
+	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+		printk(KERN_ERR "MPC107 I2C - failed to add adapter\n");
+		goto fail_add;
+	}
+	ocp_set_drvdata(ocp, i2c);
+	return result;
+
+fail_add:
+	if (ocp->def->irq != OCP_IRQ_NA)
+		free_irq(ocp->def->irq, 0);
+fail_irq:
+	iounmap(i2c->base);
+fail_map:
+	release_mem_region(ocp->def->paddr, MPC10X_EUMB_I2C_SIZE);
+	kfree(i2c);
+	return result;
+}
+static void __devexit mpc107_i2c_remove(struct ocp_device *ocp)
+{
+	struct mpc107_i2c *i2c = ocp_get_drvdata(ocp);
+	ocp_set_drvdata(ocp, NULL);
+	i2c_del_adapter(&i2c->adap);
+
+	if (ocp->def->irq != OCP_IRQ_NA)
+		free_irq(i2c->ocpdef->irq, i2c);
+	iounmap(i2c->base);
+	release_mem_region(i2c->ocpdef->paddr, MPC10X_EUMB_I2C_SIZE);
+	kfree(i2c);
+}
+
+static struct ocp_device_id mpc107_iic_ids[] __devinitdata =
+{
+	{ .vendor = OCP_VENDOR_MOTOROLA, .function = OCP_FUNC_IIC },
+	{ .vendor = OCP_VENDOR_INVALID }
+};
+
+MODULE_DEVICE_TABLE(ocp, mpc107_iic_ids);
+
+static struct ocp_driver mpc107_iic_driver =
+{
+	.name 		= "iic",
+	.id_table	= mpc107_iic_ids,
+	.probe		= mpc107_i2c_probe,
+	.remove		= __devexit_p(mpc107_i2c_remove)
+};
+
+static int __init iic_init(void)
+{
+	return ocp_register_driver(&mpc107_iic_driver);
+}
+
+static void __exit iic_exit(void)
+{
+	ocp_unregister_driver(&mpc107_iic_driver);
+}
+
+module_init(iic_init);
+module_exit(iic_exit);
+
+
+MODULE_AUTHOR("Adrian Cox <adrian@humboldt.co.uk>");
+MODULE_DESCRIPTION("I2C-Bus adapter for Motorola MPC107 and related bridges");
+MODULE_LICENSE("GPL");

--=-PTy239xbaeEoE6CvIRB+--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
