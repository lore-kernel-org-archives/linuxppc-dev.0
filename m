Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 1319C67A83
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 15:57:51 +1100 (EST)
Message-ID: <422E821E.5000905@jp.fujitsu.com>
Date: Wed, 09 Mar 2005 13:57:02 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: ppcembed <linuxppc-embedded@ozlabs.org>,
	mporter@kernel.crashing.org, kumar.gala@freescale.com,
	jwboyer@jdub.homelinux.org
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] WDT Driver for Book-E [2/2] Device driver part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt,Kurmar and Josh:

I post the device driver part with this mail.

Please apply.

Regards,

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>

--- linux-2.6.11/drivers/char/watchdog/Kconfig	2005-03-09 12:56:45.428165328 +0900
+++ linux-2.6.11-wdt/drivers/char/watchdog/Kconfig	2005-03-09 13:07:53.668577344 +0900
@@ -346,6 +346,13 @@ config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx

+config BOOKE_WDT
+    bool "Book E(PowerPC 4xx/e500) Watchdog Timer"
+    depends on WATCHDOG && ( 4xx || E500 )
+    ---help---
+      This is the driver for the watchdog timers on
+      PowerPC 4xx and PowerPC e500.
+
 # MIPS Architecture

 config INDYDOG
--- linux-2.6.11/drivers/char/watchdog/Makefile	2005-03-09 12:57:07.855755816 +0900
+++ linux-2.6.11-wdt/drivers/char/watchdog/Makefile	2005-03-09 13:07:53.681575368 +0900
@@ -39,3 +39,4 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
--- linux-2.6.11/drivers/char/watchdog/booke_wdt.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.11-wdt/drivers/char/watchdog/booke_wdt.c	2005-03-09 13:07:53.684574912 +0900
@@ -0,0 +1,628 @@
+/*
+ *    Copyright (c) 2005 Fujitsu Limited
+ *
+ *    Module name: booke_wdt.c
+ *    Author:      Takeharu KATO<kato.takeharu@jp.fujitsu.com>
+ *
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License
+ *    as published by the Free Software Foundation; either version 2
+ *    of the License, or (at your option) any later version.
+ *
+ *    Neither Takeharu KATO nor Fujitsu Ltd. admit liability nor provide
+ *    warranty for any of this software.
+ *
+ *    Description:
+ *     Watchdog driver for PowerPC Book E (PowerPC 4xx series processors and
+ *     PowerPC e500 series processors).
+ *     Derived from drivers/char/watchdog/wdt.c by Alan cox
+ *              and  drivers/char/watchdog/ppc405_wdt.c by Armin Kuster.
+ *     PPC4xx WDT operation is driverd from Appendix of
+ *     PowerPC Embedded Processors Application Note
+ *      ``PowerPC 40x Watch Dog Timer'' published from IBM.
+ *     This driver is written according to ``PowerPC e500 Core Complex
+ *     Reference Manual'' for e500 part.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/capability.h>
+#include <linux/string.h>
+#include <linux/ptrace.h>
+#include <asm/reg.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include "booke_wdt.h"
+
+/* micro seconds per one milli-second(used to calculatewatchdog
+ * counter to be set). */
+#define US_PER_MS 1000
+/*  Calculate watchdog count   */
+#define calculate_wdt_count(t) ((((unsigned long)(t))*HZ)/1000)
+
+int wdt_enable=0;             /* WDT start on boot  */
+int wdt_period=WDT_TIMO;       /* Time out in ms */
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+/*
+ * Global variables
+ */
+static int wdt_count = 0;            /* WDT intrrupt counter to be reloaded */
+static volatile int wdt_heartbeat_count = 0;  /* WDT intrrupt counter(compatible mode)*/
+static unsigned long driver_state; /* Driver status (see: booke_wdt.h) */
+/*
+ *  Identifier for this watchdog
+ */
+static struct watchdog_info ident = {
+  .options=WDIOF_SETTIMEOUT|WDIOF_KEEPALIVEPING|WDIOF_MAGICCLOSE,
+  .firmware_version =    0, /*  This is filled with PVR in initialization. */
+  .identity =        "Book E(PPC 4xx/e500) WDT",
+};
+
+/*
+ *  PowerPC Linux common exception handler
+ */
+extern void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr);
+/*  Panic notifier  */
+extern struct notifier_block *panic_notifier_list;
+/*
+ *    Watchdog operations on PPC4xx/e500 MPU
+ */
+/**
+ *      __booke_wdt_setup_val
+ *      Enable Watchdog, sets up passed in values for TCR[WP],
+ *      TCR[WRC]
+ *
+ *    @period:    Input Watchdog Period - TCR[WP]
+ *                      0...2^17(PPC405) or 2^21(PPC440/e500) clocks
+ *                      1...2^21(PPC405) or 2^25(PPC440/e500) clocks
+ *                      2...2^25(PPC405) or 2^29(PPC440/e500) clocks
+ *                      3...2^25(PPC405) or 2^29(PPC440/e500) clocks
+ *    @reset:         Watchdog reset control - TCR[WRC]
+ *                      0 = No reset
+ *                      1 = PPC Core reset only
+ *                      2 = PPC Chip reset
+ *                      3 = System reset
+ *     Note: The meaning of period number is differ PPC405 from PPC440.
+ *           Current version assume that this function called with
+ *           WRC_NONE as reset, if someone who want to remove this
+ *           constraint, please note that when we disable WDT, we should
+ *           set WRC with WRC_NONE and s/he should also  modify
+ *           disable/enable_wdt function.
+ *
+ */
+static __inline__ void
+__booke_wdt_setup_val(int period,int reset)
+{
+  unsigned long val;
+
+  /*  Set up TCR  */
+  val=wdt_calculate_tcr(period,reset)| mfspr(SPRN_TCR);
+  /*  Disable WDT  */
+  val &= ~(TCR_WIE);
+
+  mtspr(SPRN_TCR,val);
+}
+/**
+ *      __booke_wdt_enable
+ *      Enable Watchdog
+ */
+static __inline__ void
+__booke_wdt_enable(void)
+{
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|TCR_WIE));
+}
+/**
+ *      __booke_wdt_disable
+ *      Disable Watchdog
+ */
+static __inline__ void
+__booke_wdt_disable(void)
+{
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(TCR_WIE))));
+}
+/**
+ *      __booke_wdt_is_enabled
+ *      Check whether Watchdog is enabled.
+ */
+static __inline__ int
+__booke_wdt_is_enabled(void)
+{
+  return (mfspr(SPRN_TCR) & TCR_WIE);
+}
+/**
+ *      __booke_wdt_clear_init_stat
+ *      Clear interrupt status of watchdog to ping it.
+ */
+static __inline__ void
+__booke_wdt_clear_int_stat(void)
+{
+  mtspr(SPRN_TSR, (TSR_ENW|TSR_WIS));
+}
+/**
+ *    __booke_wdt_set_timeout:
+ *    @t:    the new time out value that needs to be set.
+ *
+ *    Set a new time out value for the watchdog device.
+ *
+ */
+static __inline__ void
+__booke_wdt_set_timeout(int t)
+{
+  wdt_count=calculate_wdt_count(t);
+  return;
+}
+
+/*
+ * Driver specific functions
+ */
+
+/**
+ *   booke_wdt_setup_options
+ *   @cmd_line : a pointer to kernel command line.
+ *
+ */
+void
+booke_wdt_setup_options(char *cmd_line)
+{
+/*
+ * Look for wdt= option on command line
+ */
+  if (strstr(cmd_line, "wdt=")) {
+    int valid_wdt = 0;
+    char *p, *q;
+
+    for (q = cmd_line; (p = strstr(q, "wdt=")) != 0;) {
+      q = p + 4;
+      if (p > cmd_line && p[-1] != ' ')
+    continue;
+      wdt_period = simple_strtoul(q, &q, 0);
+      valid_wdt = 1;
+      ++q;
+    }
+    wdt_enable = valid_wdt;
+  }
+  return;
+}
+/**
+ *    booke_wdt_heartbeat:
+ *      Ping routine called from kernel.
+ */
+void
+booke_wdt_heartbeat(void)
+{
+  /* Disable watchdog */
+  __booke_wdt_disable();
+
+  /* Write a watchdog value */
+  __booke_wdt_clear_int_stat();
+
+  if (!wdt_enable)
+    goto out;
+
+  if  (wdt_heartbeat_count > 0)
+    wdt_heartbeat_count--;
+  else
+    panic(booke_mkmsg("Initiating system reboot.\n"));
+
+  /* Enable watchdog */
+  __booke_wdt_enable();
+ out:
+  /*  Reset count  */
+  ppc_md.heartbeat_count = 0;
+}
+/**
+ *    booke_wdt_exception:
+ *      WatchDog Exception handler for PPC4xx/e500.
+ *      @regs : A registers information.
+ */
+void
+booke_wdt_exception(struct pt_regs *regs)
+{
+
+  wdt_enable=0;
+  __booke_wdt_disable();
+  printk("WDT Exception at PC: %lx, MSR: %lx, vector=%lx    %s\n",
+     regs->nip, regs->msr, regs->trap, print_tainted());
+  panic(booke_mkmsg("Initiating system reboot.\n"));
+}
+/*
+ *    Driver Logic functions
+ */
+static __inline__ int
+booke_wdt_is_enabled(void)
+{
+  return  __booke_wdt_is_enabled();
+}
+/**
+ *    booke_wdt_start:
+ *
+ *    Start the watchdog driver.
+ */
+static __inline__ int
+booke_wdt_start(void)
+{
+
+  __booke_wdt_enable();
+  return 0;
+}
+
+/**
+ *    booke_wdt_stop:
+ *
+ *    Stop the watchdog driver.
+ */
+static __inline__ int
+booke_wdt_stop (void)
+{
+
+  __booke_wdt_disable();
+  return 0;
+}
+/**
+ *    booke_wdt_ping:
+ *
+ *    Reload counter one with the watchdog heartbeat. We don't bother reloading
+ *    the cascade counter.
+ */
+static __inline__ int
+booke_wdt_ping(void)
+{
+
+  /* Disable watchdog */
+  __booke_wdt_disable();
+  /* Write a watchdog value */
+  __booke_wdt_clear_int_stat();
+  /*  Reset count  */
+  wdt_heartbeat_count=wdt_count;
+  /* Enable watchdog */
+  __booke_wdt_enable();
+
+  return 0;
+}
+/**
+ *    booke_wdt_set_timeout:
+ *    @t:        the new timeout value that needs to be set.
+ *
+ *    Set a new time out value for the watchdog device.
+ *      If the heartbeat value is incorrect we keep the old value
+ *      and return -EINVAL. If successfull we return 0.
+ */
+static __inline__ int
+booke_wdt_set_timeout(int t)
+{
+
+  if ((t < WDT_HEARTBEAT_MIN) || (t > WDT_HEARTBEAT_MAX))
+    return -EINVAL;
+
+  wdt_period = t;
+  __booke_wdt_set_timeout(t);
+  wdt_heartbeat_count=wdt_count;
+  booke_wdt_dbg("The WDT counter set %d.\n",wdt_count);
+
+  return 0;
+}
+
+/**
+ *    booke_wdt_get_status:
+ *    @status: the new status.
+ *
+ *    Return the enable/disable card status.
+ */
+static __inline__ int
+booke_wdt_get_status(int *status)
+{
+
+  if (wdt_enable)
+      *status = WDIOS_ENABLECARD;
+  else
+      *status = WDIOS_DISABLECARD;
+
+  return 0;
+}
+/*
+ *    Kernel Interfaces
+ */
+/**
+ *    booke_wdt_init_device:
+ *
+ *      Initilize PowerPC 4xx/e500 family Watch Dog facility.
+ */
+static void
+booke_wdt_init_device(void)
+{
+
+    /* Hardware WDT provided by the processor.
+     * So, we set firmware version as processor version number.
+     */
+    ident.firmware_version=mfspr(PVR);
+    __booke_wdt_setup_val(WDT_WP,WRC_NONE);
+}
+/**
+ *    booke_wdt_write:
+ *    @file: file handle to the watchdog
+ *    @buf: buffer to write (unused as data does not matter here
+ *    @count: count of bytes
+ *    @ppos: pointer to the position to write. No seeks allowed
+ *
+ *    A write to a watchdog device is defined as a keepalive signal. Any
+ *    write of data will do, as we we don't define content meaning expept
+ *      'V' character. It is performed as a sign to set stop-on-close mode.
+ */
+
+static ssize_t
+booke_wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+  size_t i;
+
+  if (!nowayout) {
+    /* In case it was set long ago */
+    clear_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+
+    for (i = 0; i < count; i++) {
+      char c;
+
+      if (get_user(c, buf + i))
+	return -EFAULT;
+
+      if (c == 'V') {
+	set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+      }
+    }
+  }
+  booke_wdt_ping();
+
+  return count;
+}
+
+/**
+ *    booke_wdt_ioctl:
+ *    @inode: inode of the device
+ *    @file: file handle to the device
+ *    @cmd: watchdog command
+ *    @arg: argument pointer
+ *
+ */
+static int
+booke_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+    unsigned long arg)
+{
+    int new_timeout;
+    int status;
+
+    if (!capable(CAP_SYS_ADMIN))
+        return -EPERM;  /*  It may be too strict manner.  */
+    switch(cmd)
+    {
+    default:
+        return -ENOIOCTLCMD;
+    case WDIOC_GETSUPPORT:
+        if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof(struct watchdog_info)))
+            return -EFAULT;
+        else
+            break;
+    case WDIOC_GETSTATUS:
+        booke_wdt_get_status(&status);
+        return put_user(status,(int *)arg);
+    case WDIOC_KEEPALIVE:
+        booke_wdt_ping();
+        break;
+    case WDIOC_SETTIMEOUT:
+        if (get_user(new_timeout, (int *)arg))
+            return -EFAULT;
+        if (booke_wdt_set_timeout(new_timeout))
+            return -EINVAL;
+        booke_wdt_ping();
+        break;
+    case WDIOC_GETTIMEOUT:
+        return put_user(wdt_period, (int *)arg);
+    case WDIOC_SETOPTIONS:
+        if (get_user(status, (int *)arg))
+            return -EFAULT;
+        /*  Return -EINVAL when the driver can not figure out
+         *  what it should do. Unknown cases are just ignored.
+         */
+        if ( (status & (WDIOS_DISABLECARD|WDIOS_ENABLECARD))
+             == (WDIOS_DISABLECARD|WDIOS_ENABLECARD) )
+            return -EINVAL;
+        if (status & WDIOS_DISABLECARD) {
+            wdt_enable = 0;
+            booke_wdt_stop();
+            booke_wdt_info("Watchdog timer is disabled\n");
+        }
+        if (status & WDIOS_ENABLECARD) {
+            wdt_enable = 1;
+            booke_wdt_start();
+            booke_wdt_info("Watchdog timer is enabled\n");
+        }
+        break;
+    }
+    return 0;
+}
+/**
+ *    booke_wdt_open:
+ *    @inode: inode of device
+ *    @file: file handle to device
+ *
+ *    The watchdog device has been opened. The watchdog device is single
+ *    open and start the WDT timer.
+ */
+static int
+booke_wdt_open(struct inode *inode, struct file *file)
+{
+    if (!capable(CAP_SYS_ADMIN))
+        return -EPERM;
+
+    if (test_and_set_bit(WDT_STATE_OPEN, &driver_state))
+        return -EBUSY;
+    /*
+     * Activate
+     */
+    booke_wdt_start();
+    wdt_enable=1;
+
+    if (nowayout)
+      set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+
+    return 0;
+}
+
+/**
+ *    booke_wdt_release:
+ *    @inode: inode to board
+ *    @file: file handle to board
+ *
+ */
+static int
+booke_wdt_release(struct inode *inode, struct file *file)
+{
+  if (test_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state)) {
+      booke_wdt_info("WDT device is stopped.\n");
+    booke_wdt_stop();
+    wdt_enable=0;
+  } else {
+    if ( (booke_wdt_is_enabled()) && (!nowayout) ) {
+      booke_wdt_info("WDT device may be closed unexpectedly.  WDT will not stop!\n");
+      booke_wdt_ping();
+    }
+  }
+  clear_bit(WDT_STATE_OPEN, &driver_state);
+
+  return 0;
+}
+/**
+ *    notify_sys:
+ *    @this: our notifier block
+ *    @code: the event being reported
+ *    @unused: unused
+ *    Note: This function assume that the panic notifier is called with CODE=0
+ *          (see panic function in kernel/panic.c).
+ */
+static int
+booke_wdt_notify_sys(struct notifier_block *this, unsigned long code,
+    void *unused)
+{
+
+    if (code != SYS_POWER_OFF)   /* Turn the card off */
+      booke_wdt_stop();
+
+    return NOTIFY_DONE;
+}
+
+static struct file_operations booke_wdt_fops = {
+    .owner        = THIS_MODULE,
+    .llseek        = no_llseek,
+    .write        = booke_wdt_write,
+    .ioctl        = booke_wdt_ioctl,
+    .open        = booke_wdt_open,
+    .release    = booke_wdt_release,
+};
+
+static struct miscdevice booke_wdt_miscdev = {
+    .minor    = WATCHDOG_MINOR,
+    .name    = "watchdog",
+    .fops    = &booke_wdt_fops,
+};
+
+/*
+ *    The WDT card needs to know about shutdowns in order to
+ *    turn WDT off.
+ */
+
+static struct notifier_block booke_wdt_notifier = {
+    .notifier_call = booke_wdt_notify_sys,
+};
+
+/**
+ *    cleanup_module:
+ *
+ *    If your watchdog is set to continue ticking on close and you unload
+ *    it, well it keeps ticking.  You just have to load a new
+ *    module in 60 seconds or reboot.
+ *      This behavior(more over the comments as above) is borrowed from
+ *      Alan cox's driver.
+ */
+
+static void __exit
+booke_wdt_exit(void)
+{
+    misc_deregister(&booke_wdt_miscdev);
+    unregister_reboot_notifier(&booke_wdt_notifier);
+    notifier_chain_unregister(&panic_notifier_list,&booke_wdt_notifier);
+}
+
+/**
+ *     booke_wdt_init:
+ *
+ *    Set up the WDT relevant timer facility.
+ */
+
+static int __init
+booke_wdt_init(void)
+{
+    int ret;
+    unsigned long flags;
+
+    ret = register_reboot_notifier(&booke_wdt_notifier);
+    if(ret) {
+      booke_wdt_err("Cannot register reboot notifier (err=%d)\n", ret);
+      return ret;
+    }
+
+    /* Register panic notifier  */
+    ret = notifier_chain_register(&panic_notifier_list,&booke_wdt_notifier);
+    if(ret) {
+      booke_wdt_err("Cannot register panic notifier (err=%d)\n", ret);
+      unregister_reboot_notifier(&booke_wdt_notifier);
+      return ret;
+    }
+
+    ret = 0;
+    booke_wdt_init_device();
+    /* Check that the heartbeat value is within it's range ; if not reset to the default */
+    if (booke_wdt_set_timeout(wdt_period)) {
+      if (wdt_period)
+        booke_wdt_info("The heartbeat value must be %d < wdt_period < %d, using %d\n",WDT_HEARTBEAT_MIN,WDT_HEARTBEAT_MAX,WDT_TIMO);
+      booke_wdt_set_timeout(WDT_TIMO);
+    }
+
+    local_irq_save(flags); /* Prevent timer interrupt */
+    ppc_md.heartbeat_count = 0;
+    ppc_md.heartbeat=booke_wdt_heartbeat;
+    local_irq_restore(flags);
+
+    booke_wdt_info("Book E(PPC 4xx/e500) Watchdog Driver. period=%d ms (nowayout=%d)\n",wdt_period, nowayout);
+
+    ret = misc_register(&booke_wdt_miscdev);
+    if (ret) {
+      booke_wdt_err("Cannot register miscdev on minor=%d (err=%d)\n",
+            WATCHDOG_MINOR, ret);
+        goto outmisc;
+    }
+
+    if (wdt_enable) {
+      booke_wdt_info("WDT start on boot.\n");
+      booke_wdt_start();
+    }
+out:
+    return ret;
+outmisc:
+    unregister_reboot_notifier(&booke_wdt_notifier);
+    local_irq_save(flags);
+    ppc_md.heartbeat=NULL;
+    ppc_md.heartbeat_count = 0;
+    local_irq_restore(flags);
+    goto out;
+}
+
+device_initcall(booke_wdt_init);
--- linux-2.6.11/drivers/char/watchdog/booke_wdt.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.11-wdt/drivers/char/watchdog/booke_wdt.h	2005-03-09 13:07:53.685574760 +0900
@@ -0,0 +1,110 @@
+/*
+ *
+ *    Copyright (c) 2004 Fujitsu Limited
+ *
+ *    Module name: booke_wdt.h
+ *    Author:      Takeharu KATO<kato.takeharu@jp.fujitsu.com>
+ *    Description:
+ *      Header file for PowerPC Book E(PPC 4xx/e500) watchdog driver.
+ *
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License
+ *    as published by the Free Software Foundation; either version 2
+ *    of the License, or (at your option) any later version.
+ *
+ *    Neither Takeharu KATO nor Fujitsu Ltd. admit liability nor provide
+ *    warranty for any of this software.
+ *
+ */
+#ifndef _DRIVERS_CHAR_WATCHDOG_BOOKE_WDT_H
+#define _DRIVERS_CHAR_WATCHDOG_BOOKE_WDT_H
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/watchdog.h>
+#include <asm/reg_booke.h>
+
+/*
+ *  Driver state flags(bit position)
+ */
+#define WDT_STATE_OPEN                  0   /* driver is opend  */
+#define WDT_STATE_STOP_ON_CLOSE         1   /* Stop with close is expected */
+/*
+ * Configurations
+ */
+#define WDT_TIMO           60000    /* Default timeout = 60000 ms(1min) */
+#define WDT_HEARTBEAT_MIN  100      /* Minimum timeout = 100 ms */
+#define WDT_HEARTBEAT_MAX  600000   /* Maximum timeout = 600000ms(1hour) */
+#ifdef __KERNEL__
+//#define BOOKE_WDT_DEBUG                     /*  Debug switch */
+
+/*  Watchdog timer periods can be set on PPC 4xx cpus. */
+#if defined(CONFIG_4xx)
+/*
+ *  For PowerPC 4xx
+ */
+#define WDT_WP0               0
+#define WDT_WP1               1
+#define WDT_WP2               2
+#define WDT_WP3               3
+#define wdt_calculate_tcr(period,reset) ( TCR_WP(period) | TCR_WRC(reset) )
+#else
+#if defined(CONFIG_E500)
+/*
+ *  For e500 CPU
+ *  Actually, e500 can arbitrary periods can be set,
+ *  But this driver uses fix period value as same as PPC440
+ *  on purpose for simplicity.
+ *  Following values split into WP and WP_EXT parts in booke_wdt.c.
+ */
+#define WDT_WP0               21
+#define WDT_WP1               25
+#define WDT_WP2               29
+#define WDT_WP3               33
+#define WDT_TCR_WP_BITLEN      2 /*  2bit length  */
+#define WDT_TCR_WP_BITMSK     ((1<<(WDT_TCR_WP_BITLEN))-1)  /*  mask  */
+#define WDT_TCR_WPEXT_BITMSK  0xf  /*  4bit length  */
+#define WDT_TCR_WPEXT_SHIFT   17
+#define WDT_WPEXT_VAL(period) (((period)>>WDT_TCR_WP_BITLEN)&    \
+			       (WDT_TCR_WPEXT_BITMSK))
+#define wdt_calculate_tcr(period,reset) \
+                         ( TCR_WP((period)&(WDT_TCR_WP_BITMSK))  |\
+			   TCR_WRC((reset))                      |\
+		   ( WDT_WPEXT_VAL(period) << WDT_TCR_WPEXT_SHIFT))
+#else
+#error "Book E WDT detects invalid configuration(Unknown CPU)"
+#endif  /*  CONFIG_E500  */
+#endif  /*  CONFIG_4xx   */
+/*
+ *  WP relevant values used in our driver.
+ *  Note:WDT period must be more than HZ(Timer ticks)
+ */
+#define WDT_WP                 WDT_WP3
+
+/*
+ *  IOCTL commands for comaptiblity for old driver
+ */
+#define WDIOC_GETPERIOD         WDIOC_GETTIMEOUT
+#define WDIOC_SETPERIOD         WDIOC_SETTIMEOUT
+
+/*
+ *  output messages
+ */
+#define __BOOKE_WDT_MSG "BookE-WDT : "
+#define booke_mkmsg(str) __BOOKE_WDT_MSG str
+#define booke_wdt_info(fmt,arg...) \
+    printk(KERN_INFO __BOOKE_WDT_MSG fmt,##arg)
+#define booke_wdt_note(fmt,arg...) \
+    printk(KERN_NOTICE __BOOKE_WDT_MSG fmt,##arg)
+#define booke_wdt_err(fmt,arg...) \
+    printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
+#if defined(BOOKE_WDT_DEBUG)
+#define booke_wdt_dbg(fmt,arg...) \
+    printk(KERN_ALERT __BOOKE_WDT_MSG fmt,##arg)
+#else
+#define booke_wdt_dbg(fmt,arg...) \
+        do{}while(0)
+#endif  /*  WDT_DEBUG  */
+
+#endif  /* __KERNEL__  */
+#endif  /*  _DRIVERS_CHAR_WATCHDOG_BOOKE_WDT_H  */
