Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 07 Jan 2004 11:28:38 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: PATCH: Another mpc8xx watchdog driver !!
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3FFB3696.3010506@tait.co.nz>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_2vDWXtlhLBIO77TfOO+68g)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Boundary_(ID_2vDWXtlhLBIO77TfOO+68g)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Greetings

After looking at several WDT implementations I found that none of them
really fitted my requirements - lean, 'prod' frequency greater than
hardware watchdog period and able to operate on 8xx CPUs with no RTC.

This is the result as applied to 2.4.23.

It is based on the code of Florian Schirmer but using kernel timers
rather than the RTC (as used by the DENX driver). The enable/disable
functions have moved into the ARCH part of the code to hide all the
timer and counter manipulation that allows the timeout period to be set
from the kernel command line.

The API is as per the Linux definition (as already implemented by
Florian Schirmer) so it works with the Busybox watchdog applet for example.

A potential bug (32 bit overflow) has also been fixed - a bit of a hack
(I'm sure there are better ways of doing it) but it works for me - YMMV.

--
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

--Boundary_(ID_2vDWXtlhLBIO77TfOO+68g)
Content-type: text/plain; name=m8xx_wdt.diff
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=m8xx_wdt.diff

diff -purN linux-2.4.23/arch/ppc/kernel/m8xx_setup.c ../packages/linux-2.4.23/arch/ppc/kernel/m8xx_setup.c
--- linux-2.4.23/arch/ppc/kernel/m8xx_setup.c	2003-08-25 23:44:40.000000000 +1200
+++ ../packages/linux-2.4.23/arch/ppc/kernel/m8xx_setup.c	2004-01-07 11:02:49.000000000 +1300
@@ -58,6 +58,7 @@ extern void m8xx_ide_init(void);

 extern unsigned long find_available_memory(void);
 extern void m8xx_cpm_reset(uint);
+extern void m8xx_wdt_handler_install(bd_t *bp);

 void __init
 m8xx_setup_arch(void)
@@ -184,6 +185,12 @@ void __init m8xx_calibrate_decr(void)
 	if (request_irq(DEC_INTERRUPT, timebase_interrupt, 0, "tbint",
 				NULL) != 0)
 		panic("Could not allocate timer IRQ!");
+#ifdef CONFIG_8xx_WDT
+	/* Install watchdog timer handler early because it might be
+	 * already enabled by the bootloader
+	 */
+	m8xx_wdt_handler_install(binfo);
+#endif
 }

 /* The RTC on the MPC8xx is an internal register.
diff -purN linux-2.4.23/arch/ppc/kernel/m8xx_wdt.c ../packages/linux-2.4.23/arch/ppc/kernel/m8xx_wdt.c
--- linux-2.4.23/arch/ppc/kernel/m8xx_wdt.c	1970-01-01 12:00:00.000000000 +1200
+++ ../packages/linux-2.4.23/arch/ppc/kernel/m8xx_wdt.c	2004-01-06 13:28:41.000000000 +1300
@@ -0,0 +1,142 @@
+/*
+ * m8xx_wdt.c - MPC8xx watchdog driver
+ *
+ * Copyright (C) 2002 Florian Schirmer <jolt@tuxbox.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <asm/8xx_immap.h>
+
+static long wdt_timeout;
+static int wdt_period = 60;	/* default 1 minute */
+static int wdt_count;
+struct timer_list wd_timer;	/* structure for timer administration		*/
+static unsigned long wdt_mpc8xx_dummy;
+
+
+
+void m8xx_wdt_reset(void)
+{
+	if (wdt_count >= 0) {
+		wdt_count = wdt_period * HZ / wdt_timeout;	/* convert seconds to WD recharge periods */
+	}
+}
+
+void mpc8xx_wdt_handler_disable(void)
+{
+	wdt_count = wdt_period * HZ / wdt_timeout;
+}
+
+void mpc8xx_wdt_handler_enable(void)
+{
+	wdt_count = -1;		/* allow autonomous operation */
+}
+
+static void m8xx_kick_dog(void)
+{
+	((volatile immap_t *)IMAP_ADDR)->im_siu_conf.sc_swsr = 0x556c;	/* write magic1 */
+	((volatile immap_t *)IMAP_ADDR)->im_siu_conf.sc_swsr = 0xaa39;	/* write magic2 */
+}
+
+static void m8xx_wdt_handler(void)
+{
+
+	if (wdt_count > 0 ) {
+		wdt_count--;
+		m8xx_kick_dog();
+	} else if (wdt_count < 0) {
+		m8xx_kick_dog();
+	}
+
+	wd_timer.expires = jiffies + wdt_timeout;
+	add_timer (&wd_timer);	/* ...re-activate timer */
+}
+
+void __init m8xx_wdt_handler_install(bd_t *binfo)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	u32 sypcr;
+
+	sypcr = imap->im_siu_conf.sc_sypcr;
+
+	if (!(sypcr & 0x04)) {
+		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n", sypcr);
+		return;
+	}
+
+	mpc8xx_wdt_handler_enable();
+	m8xx_kick_dog();
+
+	printk(KERN_NOTICE "m8xx_wdt: active wdt found (SWTC: 0x%04X, SWP: 0x%01X)\n",
+			(sypcr >> 16), sypcr & 0x01);
+
+	wdt_timeout = (sypcr >> 16) & 0xFFFF;
+
+	if (!wdt_timeout)
+		wdt_timeout = 0xFFFF;
+
+	if (sypcr & 0x01)
+		wdt_timeout *= 2048;
+
+
+	/* dodgy scaling here to prevent 32 bit overflow!!  convert count to HZ */
+	wdt_timeout = (wdt_timeout / 1000) * HZ / (binfo->bi_intfreq / 1000) / 2;
+	/*
+	 * Fire trigger if half of the wdt ticked down
+	 */
+
+	init_timer (&wd_timer);			/* initialize timer-structure... */
+	wd_timer.function = m8xx_wdt_handler;
+	wd_timer.data = (unsigned long) &wdt_mpc8xx_dummy;
+	wd_timer.expires = jiffies + wdt_timeout;
+
+	add_timer (&wd_timer);			/* ...and activate timer */
+
+	printk(KERN_NOTICE "m8xx_wdt: keep-alive trigger installed at %d HZ.\n", wdt_timeout);
+}
+
+int m8xx_wdt_get_timeout(void)
+{
+	return wdt_timeout;
+}
+
+int __init m8xx_wdt_setup (char *options)
+{
+	while (options && *options) {
+		if (strncmp (options, "period:", 7) == 0) {
+			options += 7;
+			if (!*options)
+				return 0;
+
+			wdt_period = simple_strtoul (options, &options, 0);
+			printk(KERN_NOTICE "m8xx_wdt: set period to %d.\n", wdt_period);
+			if (*options != ',')
+				return 0;
+			options++;
+		}
+	}
+
+	return 0;
+}
+
+__setup ("m8xx_wdt=", m8xx_wdt_setup);
+
+
diff -purN linux-2.4.23/arch/ppc/kernel/Makefile ../packages/linux-2.4.23/arch/ppc/kernel/Makefile
--- linux-2.4.23/arch/ppc/kernel/Makefile	2003-11-29 07:26:19.000000000 +1300
+++ ../packages/linux-2.4.23/arch/ppc/kernel/Makefile	2004-01-07 11:00:19.000000000 +1300
@@ -64,6 +64,9 @@ obj-$(CONFIG_440GP)		+= ibm440gp_common.
 obj-$(CONFIG_PPC4xx_DMA)	+= ppc4xx_dma.o
 obj-$(CONFIG_PPC4xx_EDMA)	+= ppc4xx_sgdma.o
 obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o
+ifdef CONFIG_8xx_WDT
+obj-y				+= m8xx_wdt.o
+endif
 ifeq ($(CONFIG_8xx),y)
 obj-$(CONFIG_PCI)		+= qspan_pci.o
 ifndef CONFIG_MATH_EMULATION
diff -purN linux-2.4.23/drivers/char/Config.in ../packages/linux-2.4.23/drivers/char/Config.in
--- linux-2.4.23/drivers/char/Config.in	2003-11-29 07:26:20.000000000 +1300
+++ ../packages/linux-2.4.23/drivers/char/Config.in	2004-01-07 11:05:38.000000000 +1300
@@ -257,6 +257,9 @@ if [ "$CONFIG_WATCHDOG" != "n" ]; then
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
    dep_tristate '  AMD 766/768 TCO Timer/Watchdog' CONFIG_AMD7XX_TCO $CONFIG_EXPERIMENTAL
+   if [ "$CONFIG_8xx" = "y" ]; then
+      tristate '  MPC8xx Watchdog Timer' CONFIG_8xx_WDT
+   fi
 fi
 endmenu

diff -purN linux-2.4.23/drivers/char/Makefile ../packages/linux-2.4.23/drivers/char/Makefile
--- linux-2.4.23/drivers/char/Makefile	2003-11-29 07:26:20.000000000 +1300
+++ ../packages/linux-2.4.23/drivers/char/Makefile	2004-01-07 10:59:14.000000000 +1300
@@ -305,6 +305,7 @@ obj-$(CONFIG_SCx200_WDT) += scx200_wdt.o
 obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
 obj-$(CONFIG_AMD7XX_TCO) += amd7xx_tco.o
+obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o

 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -purN linux-2.4.23/drivers/char/mpc8xx_wdt.c ../packages/linux-2.4.23/drivers/char/mpc8xx_wdt.c
--- linux-2.4.23/drivers/char/mpc8xx_wdt.c	1970-01-01 12:00:00.000000000 +1200
+++ ../packages/linux-2.4.23/drivers/char/mpc8xx_wdt.c	2004-01-05 16:47:22.000000000 +1300
@@ -0,0 +1,174 @@
+/*
+ * mpc8xx_wdt.c - MPC8xx watchdog userspace interface
+ *
+ * Copyright (C) 2002 Florian Schirmer <jolt@tuxbox.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Modified Jan 2004 robin.gilks@tait.co.nz
+ * - to use kernel timer not RTC
+ * - to allow period greater than hadware watchdog period
+ * - to minimise hooks into the rest of the code
+ */
+
+
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <asm/8xx_immap.h>
+#include <asm/uaccess.h>
+
+extern int m8xx_wdt_get_timeout(void);
+extern void m8xx_wdt_reset(void);
+extern void mpc8xx_wdt_handler_disable(void);
+extern void mpc8xx_wdt_handler_enable(void);
+
+static struct semaphore wdt_sem;
+static int wdt_status;
+
+static struct watchdog_info ident = {
+	.identity = "MPC8xx watchdog",
+	.options = WDIOF_KEEPALIVEPING,
+};
+
+
+static int mpc8xx_wdt_open(struct inode *inode, struct file *file)
+{
+	switch (MINOR(inode->i_rdev)) {
+	case WATCHDOG_MINOR:
+		if (down_trylock(&wdt_sem))
+			return -EBUSY;
+
+		m8xx_wdt_reset();
+		mpc8xx_wdt_handler_disable();
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int mpc8xx_wdt_release(struct inode *inode, struct file *file)
+{
+	m8xx_wdt_reset();
+
+#if !defined(CONFIG_WATCHDOG_NOWAYOUT)
+	mpc8xx_wdt_handler_enable();
+#endif
+
+	up(&wdt_sem);
+
+	return 0;
+}
+
+static ssize_t mpc8xx_wdt_write(struct file *file, const char *data,
+				size_t len, loff_t * ppos)
+{
+	/* Can't seek (pwrite) on this device */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (!len)
+		return 0;
+
+	m8xx_wdt_reset();
+
+	return 1;
+}
+
+static int mpc8xx_wdt_ioctl(struct inode *inode, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((void *)arg, &ident, sizeof(ident)))
+			return -EFAULT;
+		break;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		if (put_user(wdt_status, (int *)arg))
+			return -EFAULT;
+		wdt_status &= ~WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_KEEPALIVE:
+		m8xx_wdt_reset();
+		wdt_status |= WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_GETTIMEOUT:
+	{
+		int timeout = m8xx_wdt_get_timeout();
+		if (put_user(timeout, (int *)arg))
+			return -EFAULT;
+		break;
+	}
+
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static struct file_operations mpc8xx_wdt_fops = {
+	.owner = THIS_MODULE,
+	.write = mpc8xx_wdt_write,
+	.ioctl = mpc8xx_wdt_ioctl,
+	.open = mpc8xx_wdt_open,
+	.release = mpc8xx_wdt_release,
+};
+
+static struct miscdevice mpc8xx_wdt_miscdev = {
+	.minor = WATCHDOG_MINOR,
+	.name = "watchdog",
+	.fops = &mpc8xx_wdt_fops,
+};
+
+static int __init mpc8xx_wdt_init(void)
+{
+	int ret;
+
+	sema_init(&wdt_sem, 1);
+
+	if ((ret = misc_register(&mpc8xx_wdt_miscdev))) {
+		printk(KERN_WARNING "mpc8xx_wdt: could not register userspace interface\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit mpc8xx_wdt_exit(void)
+{
+	misc_deregister(&mpc8xx_wdt_miscdev);
+
+	m8xx_wdt_reset();
+	mpc8xx_wdt_handler_enable();
+}
+
+module_init(mpc8xx_wdt_init);
+module_exit(mpc8xx_wdt_exit);
+
+MODULE_AUTHOR("Florian Schirmer <jolt@tuxbox.org>");
+MODULE_DESCRIPTION("MPC8xx watchdog driver");
+MODULE_LICENSE("GPL");

--Boundary_(ID_2vDWXtlhLBIO77TfOO+68g)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
