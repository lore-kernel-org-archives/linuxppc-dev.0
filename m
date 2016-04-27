Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwFD36RM5zDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 08:35:47 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, geert@linux-m68k.org, deller@gmx.de,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
 dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 16/16] char/genrtc: remove the rest of the driver
Date: Thu, 28 Apr 2016 00:34:30 +0200
Message-Id: <1461796470-1291527-17-git-send-email-arnd@arndb.de>
In-Reply-To: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No architecture uses the genrtc driver any more, so let's kill it off
for good. This now also includes asm-generic/rtc.h, which is otherwise
completely unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/Kconfig      |  26 ---
 drivers/char/Makefile     |   1 -
 drivers/char/genrtc.c     | 539 ----------------------------------------------
 include/asm-generic/rtc.h |  51 -----
 4 files changed, 617 deletions(-)
 delete mode 100644 drivers/char/genrtc.c
 delete mode 100644 include/asm-generic/rtc.h

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a81f0eb9f71e..0d40fbd21c26 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -325,32 +325,6 @@ config JS_RTC
 	  To compile this driver as a module, choose M here: the
 	  module will be called js-rtc.
 
-config OLD_GEN_RTC
-	tristate "Generic /dev/rtc emulation"
-	depends on RTC!=y
-	depends on BROKEN
-	---help---
-	  If you say Y here and create a character special file /dev/rtc with
-	  major number 10 and minor number 135 using mknod ("man mknod"), you
-	  will get access to the real time clock (or hardware clock) built
-	  into your computer.
-
-	  It reports status information via the file /proc/driver/rtc and its
-	  behaviour is set by various ioctls on /dev/rtc. If you enable the
-	  "extended RTC operation" below it will also provide an emulation
-	  for RTC_UIE which is required by some programs and may improve
-	  precision in some cases.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called genrtc.
-
-config GEN_RTC_X
-	bool "Extended RTC operation"
-	depends on GEN_RTC
-	help
-	  Provides an emulation for RTC_UIE which is required by some programs
-	  and may improve precision of the generic RTC support in some cases.
-
 config EFI_RTC
 	bool "EFI Real Time Clock Services"
 	depends on IA64
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index fc0905aa7373..f33f5e35df9c 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -25,7 +25,6 @@ obj-$(CONFIG_APPLICOM)		+= applicom.o
 obj-$(CONFIG_SONYPI)		+= sonypi.o
 obj-$(CONFIG_RTC)		+= rtc.o
 obj-$(CONFIG_HPET)		+= hpet.o
-obj-$(CONFIG_OLD_GEN_RTC)	+= genrtc.o
 obj-$(CONFIG_EFI_RTC)		+= efirtc.o
 obj-$(CONFIG_DS1302)		+= ds1302.o
 obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
diff --git a/drivers/char/genrtc.c b/drivers/char/genrtc.c
deleted file mode 100644
index 4f943759d376..000000000000
--- a/drivers/char/genrtc.c
+++ /dev/null
@@ -1,539 +0,0 @@
-/*
- *	Real Time Clock interface for
- *		- q40 and other m68k machines,
- *		- HP PARISC machines
- *		- PowerPC machines
- *      emulate some RTC irq capabilities in software
- *
- *      Copyright (C) 1999 Richard Zidlicky
- *
- *	based on Paul Gortmaker's rtc.c device and
- *           Sam Creasey Generic rtc driver
- *
- *	This driver allows use of the real time clock (built into
- *	nearly all computers) from user space. It exports the /dev/rtc
- *	interface supporting various ioctl() and also the /proc/driver/rtc
- *	pseudo-file for status information.
- *
- *	The ioctls can be used to set the interrupt behaviour where
- *	supported.
- *
- *	The /dev/rtc interface will block on reads until an interrupt
- *	has been received. If a RTC interrupt has already happened,
- *	it will output an unsigned long and then block. The output value
- *	contains the interrupt status in the low byte and the number of
- *	interrupts since the last read in the remaining high bytes. The
- *	/dev/rtc interface can also be used with the select(2) call.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
-
- *      1.01 fix for 2.3.X                    rz@linux-m68k.org
- *      1.02 merged with code from genrtc.c   rz@linux-m68k.org
- *      1.03 make it more portable            zippel@linux-m68k.org
- *      1.04 removed useless timer code       rz@linux-m68k.org
- *      1.05 portable RTC_UIE emulation       rz@linux-m68k.org
- *      1.06 set_rtc_time can return an error trini@kernel.crashing.org
- *      1.07 ported to HP PARISC (hppa)	      Helge Deller <deller@gmx.de>
- */
-
-#define RTC_VERSION	"1.07"
-
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/errno.h>
-#include <linux/miscdevice.h>
-#include <linux/fcntl.h>
-
-#include <linux/rtc.h>
-#include <linux/init.h>
-#include <linux/poll.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/mutex.h>
-#include <linux/workqueue.h>
-
-#include <asm/uaccess.h>
-#include <asm/rtc.h>
-
-/*
- *	We sponge a minor off of the misc major. No need slurping
- *	up another valuable major dev number for this. If you add
- *	an ioctl, make sure you don't conflict with SPARC's RTC
- *	ioctls.
- */
-
-static DEFINE_MUTEX(gen_rtc_mutex);
-static DECLARE_WAIT_QUEUE_HEAD(gen_rtc_wait);
-
-/*
- *	Bits in gen_rtc_status.
- */
-
-#define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
-
-static unsigned char gen_rtc_status;	/* bitmapped status byte.	*/
-static unsigned long gen_rtc_irq_data;	/* our output to the world	*/
-
-/* months start at 0 now */
-static unsigned char days_in_mo[] =
-{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
-
-static int irq_active;
-
-#ifdef CONFIG_GEN_RTC_X
-static struct work_struct genrtc_task;
-static struct timer_list timer_task;
-
-static unsigned int oldsecs;
-static int lostint;
-static unsigned long tt_exp;
-
-static void gen_rtc_timer(unsigned long data);
-
-static volatile int stask_active;              /* schedule_work */
-static volatile int ttask_active;              /* timer_task */
-static int stop_rtc_timers;                    /* don't requeue tasks */
-static DEFINE_SPINLOCK(gen_rtc_lock);
-
-static void gen_rtc_interrupt(unsigned long arg);
-
-/*
- * Routine to poll RTC seconds field for change as often as possible,
- * after first RTC_UIE use timer to reduce polling
- */
-static void genrtc_troutine(struct work_struct *work)
-{
-	unsigned int tmp = get_rtc_ss();
-	
-	if (stop_rtc_timers) {
-		stask_active = 0;
-		return;
-	}
-
-	if (oldsecs != tmp){
-		oldsecs = tmp;
-
-		timer_task.function = gen_rtc_timer;
-		timer_task.expires = jiffies + HZ - (HZ/10);
-		tt_exp=timer_task.expires;
-		ttask_active=1;
-		stask_active=0;
-		add_timer(&timer_task);
-
-		gen_rtc_interrupt(0);
-	} else if (schedule_work(&genrtc_task) == 0)
-		stask_active = 0;
-}
-
-static void gen_rtc_timer(unsigned long data)
-{
-	lostint = get_rtc_ss() - oldsecs ;
-	if (lostint<0) 
-		lostint = 60 - lostint;
-	if (time_after(jiffies, tt_exp))
-		printk(KERN_INFO "genrtc: timer task delayed by %ld jiffies\n",
-		       jiffies-tt_exp);
-	ttask_active=0;
-	stask_active=1;
-	if ((schedule_work(&genrtc_task) == 0))
-		stask_active = 0;
-}
-
-/* 
- * call gen_rtc_interrupt function to signal an RTC_UIE,
- * arg is unused.
- * Could be invoked either from a real interrupt handler or
- * from some routine that periodically (eg 100HZ) monitors
- * whether RTC_SECS changed
- */
-static void gen_rtc_interrupt(unsigned long arg)
-{
-	/*  We store the status in the low byte and the number of
-	 *	interrupts received since the last read in the remainder
-	 *	of rtc_irq_data.  */
-
-	gen_rtc_irq_data += 0x100;
-	gen_rtc_irq_data &= ~0xff;
-	gen_rtc_irq_data |= RTC_UIE;
-
-	if (lostint){
-		printk("genrtc: system delaying clock ticks?\n");
-		/* increment count so that userspace knows something is wrong */
-		gen_rtc_irq_data += ((lostint-1)<<8);
-		lostint = 0;
-	}
-
-	wake_up_interruptible(&gen_rtc_wait);
-}
-
-/*
- *	Now all the various file operations that we export.
- */
-static ssize_t gen_rtc_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
-{
-	unsigned long data;
-	ssize_t retval;
-
-	if (count != sizeof (unsigned int) && count != sizeof (unsigned long))
-		return -EINVAL;
-
-	if (file->f_flags & O_NONBLOCK && !gen_rtc_irq_data)
-		return -EAGAIN;
-
-	retval = wait_event_interruptible(gen_rtc_wait,
-			(data = xchg(&gen_rtc_irq_data, 0)));
-	if (retval)
-		goto out;
-
-	/* first test allows optimizer to nuke this case for 32-bit machines */
-	if (sizeof (int) != sizeof (long) && count == sizeof (unsigned int)) {
-		unsigned int uidata = data;
-		retval = put_user(uidata, (unsigned int __user *)buf) ?:
-			sizeof(unsigned int);
-	}
-	else {
-		retval = put_user(data, (unsigned long __user *)buf) ?:
-			sizeof(unsigned long);
-	}
-out:
-	return retval;
-}
-
-static unsigned int gen_rtc_poll(struct file *file,
-				 struct poll_table_struct *wait)
-{
-	poll_wait(file, &gen_rtc_wait, wait);
-	if (gen_rtc_irq_data != 0)
-		return POLLIN | POLLRDNORM;
-	return 0;
-}
-
-#endif
-
-/*
- * Used to disable/enable interrupts, only RTC_UIE supported
- * We also clear out any old irq data after an ioctl() that
- * meddles with the interrupt enable/disable bits.
- */
-
-static inline void gen_clear_rtc_irq_bit(unsigned char bit)
-{
-#ifdef CONFIG_GEN_RTC_X
-	stop_rtc_timers = 1;
-	if (ttask_active){
-		del_timer_sync(&timer_task);
-		ttask_active = 0;
-	}
-	while (stask_active)
-		schedule();
-
-	spin_lock(&gen_rtc_lock);
-	irq_active = 0;
-	spin_unlock(&gen_rtc_lock);
-#endif
-}
-
-static inline int gen_set_rtc_irq_bit(unsigned char bit)
-{
-#ifdef CONFIG_GEN_RTC_X
-	spin_lock(&gen_rtc_lock);
-	if ( !irq_active ) {
-		irq_active = 1;
-		stop_rtc_timers = 0;
-		lostint = 0;
-		INIT_WORK(&genrtc_task, genrtc_troutine);
-		oldsecs = get_rtc_ss();
-		init_timer(&timer_task);
-
-		stask_active = 1;
-		if (schedule_work(&genrtc_task) == 0){
-			stask_active = 0;
-		}
-	}
-	spin_unlock(&gen_rtc_lock);
-	gen_rtc_irq_data = 0;
-	return 0;
-#else
-	return -EINVAL;
-#endif
-}
-
-static int gen_rtc_ioctl(struct file *file,
-			 unsigned int cmd, unsigned long arg)
-{
-	struct rtc_time wtime;
-	struct rtc_pll_info pll;
-	void __user *argp = (void __user *)arg;
-
-	switch (cmd) {
-
-	case RTC_PLL_GET:
-	    if (get_rtc_pll(&pll))
-	 	    return -EINVAL;
-	    else
-		    return copy_to_user(argp, &pll, sizeof pll) ? -EFAULT : 0;
-
-	case RTC_PLL_SET:
-		if (!capable(CAP_SYS_TIME))
-			return -EACCES;
-		if (copy_from_user(&pll, argp, sizeof(pll)))
-			return -EFAULT;
-	    return set_rtc_pll(&pll);
-
-	case RTC_UIE_OFF:	/* disable ints from RTC updates.	*/
-		gen_clear_rtc_irq_bit(RTC_UIE);
-		return 0;
-
-	case RTC_UIE_ON:	/* enable ints for RTC updates.	*/
-	        return gen_set_rtc_irq_bit(RTC_UIE);
-
-	case RTC_RD_TIME:	/* Read the time/date from RTC	*/
-		/* this doesn't get week-day, who cares */
-		memset(&wtime, 0, sizeof(wtime));
-		get_rtc_time(&wtime);
-
-		return copy_to_user(argp, &wtime, sizeof(wtime)) ? -EFAULT : 0;
-
-	case RTC_SET_TIME:	/* Set the RTC */
-	    {
-		int year;
-		unsigned char leap_yr;
-
-		if (!capable(CAP_SYS_TIME))
-			return -EACCES;
-
-		if (copy_from_user(&wtime, argp, sizeof(wtime)))
-			return -EFAULT;
-
-		year = wtime.tm_year + 1900;
-		leap_yr = ((!(year % 4) && (year % 100)) ||
-			   !(year % 400));
-
-		if ((wtime.tm_mon < 0 || wtime.tm_mon > 11) || (wtime.tm_mday < 1))
-			return -EINVAL;
-
-		if (wtime.tm_mday < 0 || wtime.tm_mday >
-		    (days_in_mo[wtime.tm_mon] + ((wtime.tm_mon == 1) && leap_yr)))
-			return -EINVAL;
-
-		if (wtime.tm_hour < 0 || wtime.tm_hour >= 24 ||
-		    wtime.tm_min < 0 || wtime.tm_min >= 60 ||
-		    wtime.tm_sec < 0 || wtime.tm_sec >= 60)
-			return -EINVAL;
-
-		return set_rtc_time(&wtime);
-	    }
-	}
-
-	return -EINVAL;
-}
-
-static long gen_rtc_unlocked_ioctl(struct file *file, unsigned int cmd,
-				   unsigned long arg)
-{
-	int ret;
-
-	mutex_lock(&gen_rtc_mutex);
-	ret = gen_rtc_ioctl(file, cmd, arg);
-	mutex_unlock(&gen_rtc_mutex);
-
-	return ret;
-}
-
-/*
- *	We enforce only one user at a time here with the open/close.
- *	Also clear the previous interrupt data on an open, and clean
- *	up things on a close.
- */
-
-static int gen_rtc_open(struct inode *inode, struct file *file)
-{
-	mutex_lock(&gen_rtc_mutex);
-	if (gen_rtc_status & RTC_IS_OPEN) {
-		mutex_unlock(&gen_rtc_mutex);
-		return -EBUSY;
-	}
-
-	gen_rtc_status |= RTC_IS_OPEN;
-	gen_rtc_irq_data = 0;
-	irq_active = 0;
-	mutex_unlock(&gen_rtc_mutex);
-
-	return 0;
-}
-
-static int gen_rtc_release(struct inode *inode, struct file *file)
-{
-	/*
-	 * Turn off all interrupts once the device is no longer
-	 * in use and clear the data.
-	 */
-
-	gen_clear_rtc_irq_bit(RTC_PIE|RTC_AIE|RTC_UIE);
-
-	gen_rtc_status &= ~RTC_IS_OPEN;
-	return 0;
-}
-
-
-#ifdef CONFIG_PROC_FS
-
-/*
- *	Info exported via "/proc/driver/rtc".
- */
-
-static int gen_rtc_proc_show(struct seq_file *m, void *v)
-{
-	struct rtc_time tm;
-	unsigned int flags;
-	struct rtc_pll_info pll;
-
-	flags = get_rtc_time(&tm);
-
-	seq_printf(m,
-		     "rtc_time\t: %02d:%02d:%02d\n"
-		     "rtc_date\t: %04d-%02d-%02d\n"
-		     "rtc_epoch\t: %04u\n",
-		     tm.tm_hour, tm.tm_min, tm.tm_sec,
-		     tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, 1900);
-
-	tm.tm_hour = tm.tm_min = tm.tm_sec = 0;
-
-	seq_puts(m, "alarm\t\t: ");
-	if (tm.tm_hour <= 24)
-		seq_printf(m, "%02d:", tm.tm_hour);
-	else
-		seq_puts(m, "**:");
-
-	if (tm.tm_min <= 59)
-		seq_printf(m, "%02d:", tm.tm_min);
-	else
-		seq_puts(m, "**:");
-
-	if (tm.tm_sec <= 59)
-		seq_printf(m, "%02d\n", tm.tm_sec);
-	else
-		seq_puts(m, "**\n");
-
-	seq_printf(m,
-		     "DST_enable\t: %s\n"
-		     "BCD\t\t: %s\n"
-		     "24hr\t\t: %s\n"
-		     "square_wave\t: %s\n"
-		     "alarm_IRQ\t: %s\n"
-		     "update_IRQ\t: %s\n"
-		     "periodic_IRQ\t: %s\n"
-		     "periodic_freq\t: %ld\n"
-		     "batt_status\t: %s\n",
-		     (flags & RTC_DST_EN) ? "yes" : "no",
-		     (flags & RTC_DM_BINARY) ? "no" : "yes",
-		     (flags & RTC_24H) ? "yes" : "no",
-		     (flags & RTC_SQWE) ? "yes" : "no",
-		     (flags & RTC_AIE) ? "yes" : "no",
-		     irq_active ? "yes" : "no",
-		     (flags & RTC_PIE) ? "yes" : "no",
-		     0L /* freq */,
-		     (flags & RTC_BATT_BAD) ? "bad" : "okay");
-	if (!get_rtc_pll(&pll))
-	    seq_printf(m,
-			 "PLL adjustment\t: %d\n"
-			 "PLL max +ve adjustment\t: %d\n"
-			 "PLL max -ve adjustment\t: %d\n"
-			 "PLL +ve adjustment factor\t: %d\n"
-			 "PLL -ve adjustment factor\t: %d\n"
-			 "PLL frequency\t: %ld\n",
-			 pll.pll_value,
-			 pll.pll_max,
-			 pll.pll_min,
-			 pll.pll_posmult,
-			 pll.pll_negmult,
-			 pll.pll_clock);
-	return 0;
-}
-
-static int gen_rtc_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, gen_rtc_proc_show, NULL);
-}
-
-static const struct file_operations gen_rtc_proc_fops = {
-	.open		= gen_rtc_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init gen_rtc_proc_init(void)
-{
-	struct proc_dir_entry *r;
-
-	r = proc_create("driver/rtc", 0, NULL, &gen_rtc_proc_fops);
-	if (!r)
-		return -ENOMEM;
-	return 0;
-}
-#else
-static inline int gen_rtc_proc_init(void) { return 0; }
-#endif /* CONFIG_PROC_FS */
-
-
-/*
- *	The various file operations we support.
- */
-
-static const struct file_operations gen_rtc_fops = {
-	.owner		= THIS_MODULE,
-#ifdef CONFIG_GEN_RTC_X
-	.read		= gen_rtc_read,
-	.poll		= gen_rtc_poll,
-#endif
-	.unlocked_ioctl	= gen_rtc_unlocked_ioctl,
-	.open		= gen_rtc_open,
-	.release	= gen_rtc_release,
-	.llseek		= noop_llseek,
-};
-
-static struct miscdevice rtc_gen_dev =
-{
-	.minor		= RTC_MINOR,
-	.name		= "rtc",
-	.fops		= &gen_rtc_fops,
-};
-
-static int __init rtc_generic_init(void)
-{
-	int retval;
-
-	printk(KERN_INFO "Generic RTC Driver v%s\n", RTC_VERSION);
-
-	retval = misc_register(&rtc_gen_dev);
-	if (retval < 0)
-		return retval;
-
-	retval = gen_rtc_proc_init();
-	if (retval) {
-		misc_deregister(&rtc_gen_dev);
-		return retval;
-	}
-
-	return 0;
-}
-
-static void __exit rtc_generic_exit(void)
-{
-	remove_proc_entry ("driver/rtc", NULL);
-	misc_deregister(&rtc_gen_dev);
-}
-
-
-module_init(rtc_generic_init);
-module_exit(rtc_generic_exit);
-
-MODULE_AUTHOR("Richard Zidlicky");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(RTC_MINOR);
diff --git a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
deleted file mode 100644
index 4fcff22cd707..000000000000
--- a/include/asm-generic/rtc.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* 
- * include/asm-generic/rtc.h
- *
- * Author: Tom Rini <trini@mvista.com>
- *
- * Based on:
- * drivers/char/rtc.c
- *
- * Please read the COPYING file for all license details.
- */
-
-#ifndef __ASM_RTC_H__
-#define __ASM_RTC_H__
-
-#include <linux/rtc.h>
-
-#ifndef get_rtc_time
-#include <linux/mc146818rtc.h>
-#define get_rtc_time mc146818_get_time
-#define set_rtc_time mc146818_set_time
-#endif
-
-#define RTC_PIE 0x40		/* periodic interrupt enable */
-#define RTC_AIE 0x20		/* alarm interrupt enable */
-#define RTC_UIE 0x10		/* update-finished interrupt enable */
-
-/* some dummy definitions */
-#define RTC_BATT_BAD 0x100	/* battery bad */
-#define RTC_SQWE 0x08		/* enable square-wave output */
-#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
-#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
-#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
-
-static inline unsigned int get_rtc_ss(void)
-{
-	struct rtc_time h;
-
-	get_rtc_time(&h);
-	return h.tm_sec;
-}
-
-static inline int get_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-static inline int set_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-
-#endif /* __ASM_RTC_H__ */
-- 
2.7.0
