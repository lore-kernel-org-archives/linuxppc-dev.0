Subject: [PATCH] add mpc8xx watchdog driver
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-hn/IF2lNTqY3CW98nXE9"
Message-Id: <1090589522.3939.5.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Fri, 23 Jul 2004 15:32:02 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-hn/IF2lNTqY3CW98nXE9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tom,

this adds the 2.4 watchdog driver to linuxppc-2.5. The call to
m8xx_wdt_handler_install() is already present in m8xx_setup.c. Please
apply.

Signed-off-by: Andreas Oberritter <obi@saftware.de>

--=-hn/IF2lNTqY3CW98nXE9
Content-Disposition: attachment; filename=watchdog.diff
Content-Type: text/x-patch; name=watchdog.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/23 15:07:22+02:00 obi@pegasos.saftware.de
#   added mpc8xx watchdog driver
#
# drivers/char/watchdog/mpc8xx_wdt.c
#   2004/07/23 15:07:00+02:00 obi@pegasos.saftware.de +0 -0
#   BitKeeper file /home/obi/bk/linuxppc-2.5/drivers/char/watchdog/mpc8xx_wdt.c
#
# arch/ppc/syslib/m8xx_wdt.h
#   2004/07/23 15:06:58+02:00 obi@pegasos.saftware.de +8 -0
#
# arch/ppc/syslib/m8xx_wdt.h
#   2004/07/23 15:06:58+02:00 obi@pegasos.saftware.de +0 -0
#   BitKeeper file /home/obi/bk/linuxppc-2.5/arch/ppc/syslib/m8xx_wdt.h
#
# arch/ppc/syslib/m8xx_wdt.c
#   2004/07/23 15:06:56+02:00 obi@pegasos.saftware.de +110 -0
#
# drivers/char/watchdog/Makefile
#   2004/07/23 15:06:56+02:00 obi@pegasos.saftware.de +1 -0
#   added mpc8xx watchdog driver
#
# drivers/char/watchdog/Kconfig
#   2004/07/23 15:06:56+02:00 obi@pegasos.saftware.de +6 -0
#   added mpc8xx watchdog driver
#
# arch/ppc/syslib/m8xx_wdt.c
#   2004/07/23 15:06:56+02:00 obi@pegasos.saftware.de +0 -0
#   BitKeeper file /home/obi/bk/linuxppc-2.5/arch/ppc/syslib/m8xx_wdt.c
#
# arch/ppc/syslib/Makefile
#   2004/07/23 15:06:56+02:00 obi@pegasos.saftware.de +3 -0
#   added mpc8xx watchdog driver
#
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2004-07-23 15:22:10 +02:00
+++ b/arch/ppc/syslib/Makefile	2004-07-23 15:22:10 +02:00
@@ -36,6 +36,9 @@
 endif
 obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o
 ifeq ($(CONFIG_8xx),y)
+ifdef CONFIG_8xx_WDT
+obj-$(CONFIG_8xx)		+= m8xx_wdt.o
+endif
 obj-$(CONFIG_PCI)		+= qspan_pci.o i8259.o
 endif
 obj-$(CONFIG_PPC_OF)		+= prom_init.o prom.o of_device.o
diff -Nru a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/m8xx_wdt.c	2004-07-23 15:22:10 +02:00
@@ -0,0 +1,110 @@
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
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <asm/8xx_immap.h>
+#include <syslib/m8xx_wdt.h>
+
+static int wdt_timeout;
+
+void m8xx_wdt_reset(void)
+{
+	volatile immap_t *imap = (volatile immap_t *) IMAP_ADDR;
+
+	imap->im_siu_conf.sc_swsr = 0x556c;	/* write magic1 */
+	imap->im_siu_conf.sc_swsr = 0xaa39;	/* write magic2 */
+}
+
+static irqreturn_t m8xx_wdt_interrupt(int irq, void *dev, struct pt_regs *regs)
+{
+	volatile immap_t *imap = (volatile immap_t *) IMAP_ADDR;
+
+	m8xx_wdt_reset();
+
+	imap->im_sit.sit_piscr |= PISCR_PS;	/* clear irq */
+
+	return IRQ_HANDLED;
+}
+
+void __init m8xx_wdt_handler_install(bd_t *binfo)
+{
+	volatile immap_t *imap = (volatile immap_t *) IMAP_ADDR;
+	u32 pitc;
+	u32 sypcr;
+	u32 pitrtclk;
+
+	sypcr = imap->im_siu_conf.sc_sypcr;
+
+	if (!(sypcr & 0x04)) {
+		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n",
+		       sypcr);
+		return;
+	}
+
+	m8xx_wdt_reset();
+
+	printk(KERN_NOTICE
+	       "m8xx_wdt: active wdt found (SWTC: 0x%04X, SWP: 0x%01X)\n",
+	       (sypcr >> 16), sypcr & 0x01);
+
+	wdt_timeout = (sypcr >> 16) & 0xFFFF;
+
+	if (!wdt_timeout)
+		wdt_timeout = 0xFFFF;
+
+	if (sypcr & 0x01)
+		wdt_timeout *= 2048;
+
+	/*
+	 * Fire trigger if half of the wdt ticked down
+	 */
+
+	if (imap->im_sit.sit_rtcsc & RTCSC_38K)
+		pitrtclk = 9600;
+	else
+		pitrtclk = 8192;
+
+	if ((wdt_timeout) > (UINT_MAX / pitrtclk))
+		pitc = wdt_timeout / binfo->bi_intfreq * pitrtclk / 2;
+	else
+		pitc = pitrtclk * wdt_timeout / binfo->bi_intfreq / 2;
+
+	imap->im_sit.sit_pitc = pitc << 16;
+	imap->im_sit.sit_piscr =
+	    (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE;
+
+	if (request_irq(PIT_INTERRUPT, m8xx_wdt_interrupt, 0, "watchdog", NULL))
+		panic("m8xx_wdt: could not allocate watchdog irq!");
+
+	printk(KERN_NOTICE
+	       "m8xx_wdt: keep-alive trigger installed (PITC: 0x%04X)\n", pitc);
+
+	wdt_timeout /= binfo->bi_intfreq;
+}
+
+int m8xx_wdt_get_timeout(void)
+{
+	return wdt_timeout;
+}
+
diff -Nru a/arch/ppc/syslib/m8xx_wdt.h b/arch/ppc/syslib/m8xx_wdt.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/m8xx_wdt.h	2004-07-23 15:22:10 +02:00
@@ -0,0 +1,8 @@
+#ifndef _PPC_SYSLIB_M8XX_WDT_H
+#define _PPC_SYSLIB_M8XX_WDT_H
+
+void m8xx_wdt_handler_install(bd_t *binfo);
+int m8xx_wdt_get_timeout(void);
+void m8xx_wdt_reset(void);
+
+#endif /* _PPC_SYSLIB_M8XX_WDT_H */
diff -Nru a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
--- a/drivers/char/watchdog/Kconfig	2004-07-23 15:22:10 +02:00
+++ b/drivers/char/watchdog/Kconfig	2004-07-23 15:22:10 +02:00
@@ -308,6 +308,12 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called machzwd.

+# PowerPC Architecture
+
+config 8xx_WDT
+	tristate "MPC8xx Watchdog Timer"
+	depends on WATCHDOG && 8xx
+
 # MIPS Architecture

 config INDYDOG
diff -Nru a/drivers/char/watchdog/Makefile b/drivers/char/watchdog/Makefile
--- a/drivers/char/watchdog/Makefile	2004-07-23 15:22:10 +02:00
+++ b/drivers/char/watchdog/Makefile	2004-07-23 15:22:10 +02:00
@@ -36,3 +36,4 @@
 obj-$(CONFIG_PCIPCWATCHDOG) += pcwd_pci.o
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
+obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
diff -Nru a/drivers/char/watchdog/mpc8xx_wdt.c b/drivers/char/watchdog/mpc8xx_wdt.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/watchdog/mpc8xx_wdt.c	2004-07-23 15:22:10 +02:00
@@ -0,0 +1,173 @@
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
+ */
+
+#include <linux/config.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <asm/8xx_immap.h>
+#include <asm/uaccess.h>
+#include <syslib/m8xx_wdt.h>
+
+static unsigned long wdt_opened;
+static int wdt_status;
+
+static void mpc8xx_wdt_handler_disable(void)
+{
+	volatile immap_t *imap = (volatile immap_t *) IMAP_ADDR;
+
+	imap->im_sit.sit_piscr &= ~(PISCR_PIE | PISCR_PTE);
+
+	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler deactivated\n");
+}
+
+static void mpc8xx_wdt_handler_enable(void)
+{
+	volatile immap_t *imap = (volatile immap_t *) IMAP_ADDR;
+
+	imap->im_sit.sit_piscr |= PISCR_PIE | PISCR_PTE;
+
+	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler activated\n");
+}
+
+static int mpc8xx_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &wdt_opened))
+		return -EBUSY;
+
+	m8xx_wdt_reset();
+	mpc8xx_wdt_handler_disable();
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
+	clear_bit(0, &wdt_opened);
+
+	return 0;
+}
+
+static ssize_t mpc8xx_wdt_write(struct file *file, const char *data, size_t len, loff_t * ppos)
+{
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (len)
+		m8xx_wdt_reset();
+
+	return len;
+}
+
+static int mpc8xx_wdt_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	int timeout;
+	static struct watchdog_info info = {
+		.options = WDIOF_KEEPALIVEPING,
+		.firmware_version = 0,
+		.identity = "MPC8xx watchdog",
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
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
+	case WDIOC_GETTEMP:
+		return -EOPNOTSUPP;
+
+	case WDIOC_SETOPTIONS:
+		return -EOPNOTSUPP;
+
+	case WDIOC_KEEPALIVE:
+		m8xx_wdt_reset();
+		wdt_status |= WDIOF_KEEPALIVEPING;
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		return -EOPNOTSUPP;
+
+	case WDIOC_GETTIMEOUT:
+		timeout = m8xx_wdt_get_timeout();
+		if (put_user(timeout, (int *)arg))
+			return -EFAULT;
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+static struct file_operations mpc8xx_wdt_fops = {
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
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
+	return misc_register(&mpc8xx_wdt_miscdev);
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
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

--=-hn/IF2lNTqY3CW98nXE9--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
