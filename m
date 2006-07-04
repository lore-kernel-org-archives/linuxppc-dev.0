Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB82B67B9B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:19:02 +1000 (EST)
Subject: [PATCH] powerpc: Add support for briq front panel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:18:50 +1000
Message-Id: <1151986731.13828.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the driver for the Briq front panel. This is a cleaned up
version of a driver that has been floating around for some time now,
initially written by Karsten Jeppesen <karsten@jeppesens.com> and
cleaned up by jk and myself.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/drivers/char/Kconfig
===================================================================
--- linux-irq-work.orig/drivers/char/Kconfig	2006-07-01 13:51:17.000000000 +1000
+++ linux-irq-work/drivers/char/Kconfig	2006-07-04 13:58:02.000000000 +1000
@@ -495,6 +495,20 @@
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.
 
+config BRIQ_PANEL
+	tristate 'Total Impact briQ front panel driver'
+	---help---
+	  The briQ is a small footprint CHRP computer with a frontpanel VFD, a
+	  tristate led and two switches. It is the size of a CDROM drive.
+
+	  If you have such one and want anything showing on the VFD then you
+	  must answer Y here.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called briq_panel.
+
+	  It's safe to say N here.
+
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
Index: linux-irq-work/drivers/char/Makefile
===================================================================
--- linux-irq-work.orig/drivers/char/Makefile	2006-07-01 13:51:17.000000000 +1000
+++ linux-irq-work/drivers/char/Makefile	2006-07-04 13:58:02.000000000 +1000
@@ -51,6 +51,7 @@
 obj-$(CONFIG_VIOTAPE)		+= viotape.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
 obj-$(CONFIG_SGI_MBCS)		+= mbcs.o
+obj-$(CONFIG_BRIQ_PANEL)	+= briq_panel.o
 
 obj-$(CONFIG_PRINTER)		+= lp.o
 obj-$(CONFIG_TIPAR)		+= tipar.o
Index: linux-irq-work/drivers/char/briq_panel.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-irq-work/drivers/char/briq_panel.c	2006-07-04 14:01:38.000000000 +1000
@@ -0,0 +1,267 @@
+/*
+ * Drivers for the Total Impact PPC based computer "BRIQ"
+ * by Dr. Karsten Jeppesen
+ *
+ */
+
+#include <linux/module.h>
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/tty.h>
+#include <linux/timer.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+
+#define		BRIQ_PANEL_MINOR	156
+#define		BRIQ_PANEL_VFD_IOPORT	0x0390
+#define		BRIQ_PANEL_LED_IOPORT	0x0398
+#define		BRIQ_PANEL_VER		"1.1 (04/20/2002)"
+#define		BRIQ_PANEL_MSG0		"Loading Linux"
+
+static int		vfd_is_open;
+static unsigned char	vfd[40];
+static int		vfd_cursor;
+static unsigned char	ledpb, led;
+
+static void update_vfd(void)
+{
+	int	i;
+
+	/* cursor home */
+	outb(0x02, BRIQ_PANEL_VFD_IOPORT);
+	for (i=0; i<20; i++)
+		outb(vfd[i], BRIQ_PANEL_VFD_IOPORT + 1);
+
+	/* cursor to next line */
+	outb(0xc0, BRIQ_PANEL_VFD_IOPORT);
+	for (i=20; i<40; i++)
+		outb(vfd[i], BRIQ_PANEL_VFD_IOPORT + 1);
+
+}
+
+static void set_led(char state)
+{
+	if (state == 'R')
+		led = 0x01;
+	else if (state == 'G')
+		led = 0x02;
+	else if (state == 'Y')
+		led = 0x03;
+	else if (state == 'X')
+		led = 0x00;
+	outb(led, BRIQ_PANEL_LED_IOPORT);
+}
+
+static int briq_panel_open(struct inode *ino, struct file *filep)
+{
+	/* enforce single access */
+	if (vfd_is_open)
+		return -EBUSY;
+	vfd_is_open = 1;
+
+	return 0;
+}
+
+static int briq_panel_release(struct inode *ino, struct file *filep)
+{
+	if (!vfd_is_open)
+		return -ENODEV;
+
+	vfd_is_open = 0;
+
+	return 0;
+}
+
+static ssize_t briq_panel_read(struct file *file, char *buf, size_t count,
+			 loff_t *ppos)
+{
+	unsigned short c;
+	unsigned char cp;
+
+	/*  Can't seek (pread) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (!vfd_is_open)
+		return -ENODEV;
+
+	c = (inb(BRIQ_PANEL_LED_IOPORT) & 0x000c) | (ledpb & 0x0003);
+	set_led(' ');
+	/* upper button released */
+	if ((!(ledpb & 0x0004)) && (c & 0x0004)) {
+		cp = ' ';
+		ledpb = c;
+		if (copy_to_user(buf, &cp, 1))
+			return -EFAULT;
+		return 1;
+	}
+	/* lower button released */
+	else if ((!(ledpb & 0x0008)) && (c & 0x0008)) {
+		cp = '\r';
+		ledpb = c;
+		if (copy_to_user(buf, &cp, 1))
+			return -EFAULT;
+		return 1;
+	} else {
+		ledpb = c;
+		return 0;
+	}
+}
+
+static void scroll_vfd( void )
+{
+	int	i;
+
+	for (i=0; i<20; i++) {
+		vfd[i] = vfd[i+20];
+		vfd[i+20] = ' ';
+	}
+	vfd_cursor = 20;
+}
+
+static ssize_t briq_panel_write(struct file *file, const char *buf, size_t len,
+			  loff_t *ppos)
+{
+	size_t indx = len;
+	int i, esc = 0;
+
+#if 0	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+#endif
+
+	if (!vfd_is_open)
+		return -EBUSY;
+
+	for (;;) {
+		if (!indx)
+			break;
+		if (esc) {
+			set_led(*buf);
+			esc = 0;
+		} else if (*buf == 27) {
+			esc = 1;
+		} else if (*buf == 12) {
+			/* do a form feed */
+			for (i=0; i<40; i++)
+				vfd[i] = ' ';
+			vfd_cursor = 0;
+		} else if (*buf == 10) {
+			if (vfd_cursor < 20)
+				vfd_cursor = 20;
+			else if (vfd_cursor < 40)
+				vfd_cursor = 40;
+			else if (vfd_cursor < 60)
+				vfd_cursor = 60;
+			if (vfd_cursor > 59)
+				scroll_vfd();
+		} else {
+			/* just a character */
+			if (vfd_cursor > 39)
+				scroll_vfd();
+			vfd[vfd_cursor++] = *buf;
+		}
+		indx--;
+		buf++;
+	}
+	update_vfd();
+
+	return len;
+}
+
+static struct file_operations briq_panel_fops = {
+	.owner		= THIS_MODULE,
+	.read		= briq_panel_read,
+	.write		= briq_panel_write,
+	.open		= briq_panel_open,
+	.release	= briq_panel_release,
+};
+
+static struct miscdevice briq_panel_miscdev = {
+	BRIQ_PANEL_MINOR,
+	"briq_panel",
+	&briq_panel_fops
+};
+
+static int __init briq_panel_init(void)
+{
+	struct device_node *root = find_path_device("/");
+	char *machine;
+	int i;
+
+	machine = get_property(root, "model", NULL);
+	if (!machine || strncmp(machine, "TotalImpact,BRIQ-1", 18) != 0)
+		return -ENODEV;
+
+	printk(KERN_INFO
+		"briq_panel: v%s Dr. Karsten Jeppesen (kj@totalimpact.com)\n",
+		BRIQ_PANEL_VER);
+
+	if (!request_region(BRIQ_PANEL_VFD_IOPORT, 4, "BRIQ Front Panel"))
+		return -EBUSY;
+
+	if (!request_region(BRIQ_PANEL_LED_IOPORT, 2, "BRIQ Front Panel")) {
+		release_region(BRIQ_PANEL_VFD_IOPORT, 4);
+		return -EBUSY;
+	}
+	ledpb = inb(BRIQ_PANEL_LED_IOPORT) & 0x000c;
+
+	if (misc_register(&briq_panel_miscdev) < 0) {
+		release_region(BRIQ_PANEL_VFD_IOPORT, 4);
+		release_region(BRIQ_PANEL_LED_IOPORT, 2);
+		return -EBUSY;
+	}
+
+	outb(0x38, BRIQ_PANEL_VFD_IOPORT);	/* Function set */
+	outb(0x01, BRIQ_PANEL_VFD_IOPORT);	/* Clear display */
+	outb(0x0c, BRIQ_PANEL_VFD_IOPORT);	/* Display on */
+	outb(0x06, BRIQ_PANEL_VFD_IOPORT);	/* Entry normal */
+	for (i=0; i<40; i++)
+		vfd[i]=' ';
+#ifndef MODULE
+	vfd[0] = 'L';
+	vfd[1] = 'o';
+	vfd[2] = 'a';
+	vfd[3] = 'd';
+	vfd[4] = 'i';
+	vfd[5] = 'n';
+	vfd[6] = 'g';
+	vfd[7] = ' ';
+	vfd[8] = '.';
+	vfd[9] = '.';
+	vfd[10] = '.';
+#endif /* !MODULE */
+
+	update_vfd();
+
+	return 0;
+}
+
+static void __exit briq_panel_exit(void)
+{
+	misc_deregister(&briq_panel_miscdev);
+	release_region(BRIQ_PANEL_VFD_IOPORT, 4);
+	release_region(BRIQ_PANEL_LED_IOPORT, 2);
+}
+
+module_init(briq_panel_init);
+module_exit(briq_panel_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karsten Jeppesen <karsten@jeppesens.com>");
+MODULE_DESCRIPTION("Driver for the Total Impact briQ front panel");
