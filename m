Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp16.mail.mci.yahoo.co.jp (ybbsmtp16.mail.mci.yahoo.co.jp
	[210.80.241.190]) by ozlabs.org (Postfix) with SMTP id 2745567A6E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Feb 2005 06:35:24 +1100 (EST)
Message-ID: <421F7DF5.3000608@ybb.ne.jp>
Date: Sat, 26 Feb 2005 04:35:17 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <421CD2B3.4020805@ybb.ne.jp> <421CD669.1040002@ybb.ne.jp>
	<20050223142720.C13087@cox.net>
In-Reply-To: <20050223142720.C13087@cox.net>
Content-Type: multipart/mixed; boundary="------------040008080100030708040802"
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040008080100030708040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt

> Are you looking for the old "ppc405 watchdog" driver that simply
> hooked into the generic PPC heartbeat facility? Or are you looking
> for a driver that utilizes the 4xx/booke hardware watchdog facility?
> 
After all, I wrote watch dog driver for PowerPC 4xx using 4xx/book-e 
watchdog facility and generic PPC heartbeat mechanism.

On second thought, I found that these are almost same.
As far as I think generic PPC heartbeat mechanism is more preferable
for embedded systems from memory consumption view at least.

Using generic PPC heartbeat mechanism can make the driver simple and small.
And more, this approach can achieve following profits:

1) The approach may not need modification in low-exception handling routines
(in arch/ppc/kernel/head_XXX).
2) The approach can achieve compatibility with old-driver.

Any way, I attached current version of my patch.
Please take a look on the patch.

P.S.
I found critical interrupt relevant trivial bug in 
arch/ppc/kernel/head_booke.h.
CRITICAL_EXCEPTION macro in the file use transfer_to_handler_full and
ret_from_except_full.
IMHO, The correct code is that this macro should use 
crit_transfer_to_handler, ret_from_crit_exc instead, isn't it?

Regards,

-- 
Takeharu KATO

--------------040008080100030708040802
Content-Type: text/plain;
 name="ppc4xx_wdt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc4xx_wdt.patch"

diff -uprN linux-2.6.11-rc4.orig/arch/ppc/kernel/head_44x.S linux-2.6.11-rc4/arch/ppc/kernel/head_44x.S
--- linux-2.6.11-rc4.orig/arch/ppc/kernel/head_44x.S	2005-02-22 12:59:33.000000000 +0900
+++ linux-2.6.11-rc4/arch/ppc/kernel/head_44x.S	2005-02-26 02:48:31.000000000 +0900
@@ -444,8 +444,13 @@ interrupt_base:
 	EXCEPTION(0x1010, FixedIntervalTimer, UnknownException, EXC_XFER_EE)
 
 	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
+#if defined(CONFIG_PPC4xx_WATCHDOG) && !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, ppc4xx_wdt_interrupt)
+#else
 	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, UnknownException)
+#endif
+
+
 
 	/* Data TLB Error Interrupt */
 	START_EXCEPTION(DataTLBError)
diff -uprN linux-2.6.11-rc4.orig/arch/ppc/kernel/head_4xx.S linux-2.6.11-rc4/arch/ppc/kernel/head_4xx.S
--- linux-2.6.11-rc4.orig/arch/ppc/kernel/head_4xx.S	2005-02-22 12:59:33.000000000 +0900
+++ linux-2.6.11-rc4/arch/ppc/kernel/head_4xx.S	2005-02-26 02:48:31.000000000 +0900
@@ -477,19 +477,23 @@ label:
 
 #if 0
 /* NOTE:
- * FIT and WDT handlers are not implemented yet.
+ * FIT handlers are not implemented yet.
  */
 
 /* 0x1010 - Fixed Interval Timer (FIT) Exception
 */
 	STND_EXCEPTION(0x1010,	FITException,		UnknownException)
 
+#endif
+
 /* 0x1020 - Watchdog Timer (WDT) Exception
 */
-
+#if defined(CONFIG_PPC4xx_WATCHDOG) && !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+	CRITICAL_EXCEPTION(0x1020, WDTException, ppc4xx_wdt_interrupt)
+#else
 	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
 #endif
-
+	
 /* 0x1100 - Data TLB Miss Exception
  * As the name implies, translation is not in the MMU, so search the
  * page tables and fix it.  The only purpose of this function is to
diff -uprN linux-2.6.11-rc4.orig/arch/ppc/kernel/head_booke.h linux-2.6.11-rc4/arch/ppc/kernel/head_booke.h
--- linux-2.6.11-rc4.orig/arch/ppc/kernel/head_booke.h	2005-02-22 12:59:33.000000000 +0900
+++ linux-2.6.11-rc4/arch/ppc/kernel/head_booke.h	2005-02-26 01:01:11.000000000 +0900
@@ -194,8 +194,8 @@ label:
 	CRITICAL_EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
-			  NOCOPY, transfer_to_handler_full, \
-			  ret_from_except_full)
+			  NOCOPY, crit_transfer_to_handler, \
+			  ret_from_crit_exc)
 
 #define MCHECK_EXCEPTION(n, label, hdlr)			\
 	START_EXCEPTION(label);					\
diff -uprN linux-2.6.11-rc4.orig/arch/ppc/syslib/ppc4xx_setup.c linux-2.6.11-rc4/arch/ppc/syslib/ppc4xx_setup.c
--- linux-2.6.11-rc4.orig/arch/ppc/syslib/ppc4xx_setup.c	2005-02-22 12:59:33.000000000 +0900
+++ linux-2.6.11-rc4/arch/ppc/syslib/ppc4xx_setup.c	2005-02-26 01:01:15.000000000 +0900
@@ -48,9 +48,11 @@
 extern void abort(void);
 extern void ppc4xx_find_bridges(void);
 
+#ifdef CONFIG_PPC4xx_WATCHDOG
 extern void ppc4xx_wdt_heartbeat(void);
 extern int wdt_enable;
 extern unsigned long wdt_period;
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
 
 /* Global Variables */
 bd_t __res;
@@ -257,7 +259,7 @@ ppc4xx_init(unsigned long r3, unsigned l
 		*(char *) (r7 + KERNELBASE) = 0;
 		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
 	}
-#if defined(CONFIG_PPC405_WDT)
+#ifdef CONFIG_PPC4xx_WATCHDOG
 /* Look for wdt= option on command line */
 	if (strstr(cmd_line, "wdt=")) {
 		int valid_wdt = 0;
@@ -272,7 +274,7 @@ ppc4xx_init(unsigned long r3, unsigned l
 		}
 		wdt_enable = valid_wdt;
 	}
-#endif
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
 
 	/* Initialize machine-dependent vectors */
 
@@ -287,9 +289,9 @@ ppc4xx_init(unsigned long r3, unsigned l
 
 	ppc_md.calibrate_decr = ppc4xx_calibrate_decr;
 
-#ifdef CONFIG_PPC405_WDT
+#ifdef CONFIG_PPC4xx_WATCHDOG_COMPAT
 	ppc_md.heartbeat = ppc4xx_wdt_heartbeat;
-#endif
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
 	ppc_md.heartbeat_count = 0;
 
 	ppc_md.find_end_of_memory = ppc4xx_find_end_of_memory;
diff -uprN linux-2.6.11-rc4.orig/drivers/char/watchdog/Kconfig linux-2.6.11-rc4/drivers/char/watchdog/Kconfig
--- linux-2.6.11-rc4.orig/drivers/char/watchdog/Kconfig	2005-02-22 12:58:29.000000000 +0900
+++ linux-2.6.11-rc4/drivers/char/watchdog/Kconfig	2005-02-26 02:48:42.000000000 +0900
@@ -346,6 +346,25 @@ config 8xx_WDT
 	tristate "MPC8xx Watchdog Timer"
 	depends on WATCHDOG && 8xx
 
+config PPC4xx_WATCHDOG
+	bool "Watchdog on PowerPC 4xx series"
+	depends on WATCHDOG && 4xx
+	---help---
+	  This is the driver for the hardware watchdog timers present on
+	  PowerPC 4xx series(PPC405GP/GPr,PPC440GP/GX).
+config PPC4xx_WATCHDOG_COMPAT
+	bool "Enable Compatibility with old ppc405 driver."
+	depends on PPC4xx_WATCHDOG
+	---help---
+	  If you want send acks to WDT with timer interrupt, turn on this 
+	  option.
+	  
+          This option changes behaviors of the driver to old ppc405 software 
+	  watch dog driver did. Strictly speaking, it may not have the 
+	  complete compatibility with ppc405 software WDT. It does not
+	  use WDT exception in PowerPC 4xx. 
+
+
 # MIPS Architecture
 
 config INDYDOG
diff -uprN linux-2.6.11-rc4.orig/drivers/char/watchdog/Makefile linux-2.6.11-rc4/drivers/char/watchdog/Makefile
--- linux-2.6.11-rc4.orig/drivers/char/watchdog/Makefile	2005-02-22 12:58:30.000000000 +0900
+++ linux-2.6.11-rc4/drivers/char/watchdog/Makefile	2005-02-26 01:01:20.000000000 +0900
@@ -39,3 +39,4 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.
 obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
 obj-$(CONFIG_8xx_WDT) += mpc8xx_wdt.o
+obj-$(CONFIG_PPC4xx_WATCHDOG)   += ppc4xx_wdt.o
\ No newline at end of file
diff -uprN linux-2.6.11-rc4.orig/drivers/char/watchdog/ppc4xx_wdt.c linux-2.6.11-rc4/drivers/char/watchdog/ppc4xx_wdt.c
--- linux-2.6.11-rc4.orig/drivers/char/watchdog/ppc4xx_wdt.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.11-rc4/drivers/char/watchdog/ppc4xx_wdt.c	2005-02-26 02:48:42.000000000 +0900
@@ -0,0 +1,717 @@
+/*
+ *
+ *    Copyright (c) 2004 Fujitsu Limited
+ *
+ *    Module name: ppc4xx_wdt.c
+ *    Author:      Takeharu KATO<kato.takeharu@jp.fujitsu.com>
+ *    Description:
+ *      Watchdog driver for PowerPC 4xx-based processors.
+ *      Derived from drivers/char/watchdog/wdt.c by Alan cox
+ *              and  drivers/char/watchdog/ppc405_wdt.c by Armin Kuster.
+ *
+ *     PPC4xx WDT operation is driverd from Appendix of 
+ *      PowerPC Embedded Processors Application Note
+ *      ``PowerPC 40x Watch Dog Timer'' published from IBM.
+ */
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/capability.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#if defined(CONFIG_440GP)
+#include <syslib/ibm440gp_common.h>
+#endif  /*  CONFIG_440GP  */
+#if defined(CONFIG_440GX)
+#include <syslib/ibm440gx_common.h>
+#endif  /*  CONFIG_440GX  */
+#include "ppc4xx_wdt.h"
+
+/* micro seconds per one milli-second(used to calculatewatchdog 
+ * counter to be set. */
+#define US_PER_MS 1000  
+/*  MHz in Hz  */
+#define MHZ  1000000
+/*
+ * External linkage
+ */
+int wdt_enable=0;                  /* WDT start on boot  */
+int wdt_period = WD_TIMO;          /* Time out in ms(see: ppc4xx_wdt.h) */
+/*
+ * Global variables
+ */
+static int wdt_count = 0;            /* WDT intrrupt counter to be reloaded */
+static volatile int wdt_heartbeat_count = 0;  /* WDT intrrupt counter(compatible mode)*/
+static unsigned long driver_state; /* Driver status (see: ppc4xx_wdt.h) */
+void ppc4xx_wdt_heartbeat(void);
+/*
+ * Internal linkage functions
+ */
+static __inline__ void __ppc4xx_wdt_setup_val(int period,int reset);
+static __inline__ void __ppc4xx_wdt_enable(void);
+static __inline__ void __ppc4xx_wdt_disable(void);
+static __inline__ int  __ppc4xx_wdt_is_enabled(void);
+static __inline__ void __ppc4xx_wdt_clear_int_stat(void);
+static __inline__ void __ppc4xx_wdt_set_timeout(int t);
+#if !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+static unsigned long cpu_clock=0;    /* To store cpu_clock */
+#if defined(CONFIG_40x)
+static __inline__ int  __ppc40x_get_cpu_clock(void);
+#endif  /*  CONFIG_40x  */
+#if defined(CONFIG_44x)
+static __inline__ int  __ppc44x_get_cpu_clock(void);
+#endif  /*  CONFIG_44x  */
+static __inline__ void  __ppc4xx_get_cpu_clock(void);
+#endif  /*  CONFIG_PPC4xx_WATCHDOG_COMPAT  */
+static __inline__ void ppc4xx_wdt_init_device(void);
+static __inline__ int  ppc4xx_wdt_is_enabled(void);
+static __inline__ int  ppc4xx_wdt_start(void);
+static __inline__ int  ppc4xx_wdt_stop(void);
+static __inline__ int  ppc4xx_wdt_ping(void);
+static __inline__ int  ppc4xx_wdt_set_timeout(int t);
+static __inline__ int  ppc4xx_wdt_get_status(int *status);
+static ssize_t ppc4xx_wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos);
+static int ppc4xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,unsigned long arg);
+static int ppc4xx_wdt_open(struct inode *inode, struct file *file);
+static int ppc4xx_wdt_release(struct inode *inode, struct file *file);
+static int ppc4xx_wdt_notify_sys(struct notifier_block *this, unsigned long code,void *unused);
+static int __init ppc4xx_wdt_init(void);
+static void __exit ppc4xx_wdt_exit(void);
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+static int nowayout = 1;
+#else
+static int nowayout = 0;
+#endif
+
+/*
+ *	Watchdog operations on PPC4xx MPU
+ */
+#if !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+#if defined(CONFIG_40x)
+/**
+ *      __ppc40x_get_cpu_clock
+ *      Get CPU clock of PPC405 family
+ */
+static __inline__ int 
+__ppc40x_get_cpu_clock(void)
+{
+  bd_t *bip = &__res;
+
+  return  (bip->bi_tbfreq);
+}
+#endif  /*  CONFIG_40x  */
+
+#if defined(CONFIG_44x)
+/**
+ *      ppc44x_get_cpu_clock
+ *      Get CPU clock of PPC440 family
+ */
+static __inline__ int 
+__ppc44x_get_cpu_clock(void)
+{
+  struct ibm44x_clocks clocks;
+
+  /* Note:
+   * Following functions are assigned in init section.
+   * So we keep cpu_clocks in this module.
+   */
+#if defined(CONFIG_440GX)
+  ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+#else
+#if defined(CONFIG_440GP)
+  ibm440gp_get_clocks(&clocks, 33333333, 6 * 1843200);
+#endif
+#endif
+  
+  return clocks.cpu;
+}
+#endif  /*  CONFIG_44x  */
+#endif  /*   !CONFIG_PPC4xx_WATCHDOG_COMPAT  */
+/**
+ *      ppc4xx_get_cpu_clock
+ *      Get CPU clock of PPC4xx family
+ */
+#if !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+static __inline__ void
+__ppc4xx_get_cpu_clock(void)
+{
+	if (!cpu_clock)
+#if defined(CONFIG_40x)
+		cpu_clock = __ppc40x_get_cpu_clock();
+#else
+#if defined(CONFIG_44x)
+	        cpu_clock =  __ppc44x_get_cpu_clock();
+#else
+#error "PPC4xx WDT Detect invalid configuration(Unknown CPU)"
+#endif  /*  CONFIG_44x  */
+#endif  /*  CONFIG_40x  */
+  return;
+}
+#else
+#define __ppc4xx_get_cpu_clock() do{}while(0)
+#endif  /*  CONFIG_PPC4xx_WATCHDOG_COMPAT  */
+/**
+ *      __ppc4xx_wdt_setup_val
+ *      Enable 4xx Watchdog, sets up passed in values for TCR[WP],
+ *      TCR[WRC]
+ *   
+ *	@period:	Input Watchdog Period - TCR[WP]
+ *                      0 = 2^17 clocks
+ *                      1 = 2^21 clocks
+ *                      2 = 2^25 clocks
+ *                      3 = 2^29 clocks
+ *      @reset:         Watchdog reset control - TCR[WRC]
+ *                      0 = No reset
+ *                      1 = PPC Core reset only
+ *                      2 = PPC Chip reset
+ *                      3 = System reset
+ *     Note: The meaning of period number is differ PPC440GP from PPC440GX.
+ */
+static __inline__ void
+__ppc4xx_wdt_setup_val(int period,int reset)
+{
+  unsigned long val;
+  
+  /*  Set up TCR  */
+  val=period<<WDT_TCR_WP_SHIFT|reset<<WDT_TCR_WRC_SHIFT|mfspr(SPRN_TCR);
+  /*  Disable WDT  */
+  val &= ~(WDT_TCR_WDT_ENABLE);
+  
+  mtspr(SPRN_TCR,val);
+}
+/**
+ *      __ppc4xx_wdt_enable
+ *      Enable 4xx Watchdog
+ */
+static __inline__ void
+__ppc4xx_wdt_enable(void)
+{
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)|WDT_TCR_WDT_ENABLE));
+}
+/**
+ *      __ppc4xx_wdt_disable
+ *      Disable 4xx Watchdog
+ */
+static __inline__ void
+__ppc4xx_wdt_disable(void)
+{
+  mtspr(SPRN_TCR,(mfspr(SPRN_TCR)&(~(WDT_TCR_WDT_ENABLE))));
+}
+/**
+ *      __ppc4xx_wdt_is_enabled
+ *      Check whether 4xx Watchdog is enabled.
+ */
+static __inline__ int
+__ppc4xx_wdt_is_enabled(void)
+{
+  return (mfspr(SPRN_TCR) & WDT_TCR_WDT_ENABLE);
+}
+/**
+ *      __ppc4xx_wdt_clear_init_stat
+ *      Clear interrupt status of PPC4xx Watchdog to ping it.
+ */
+static __inline__ void
+__ppc4xx_wdt_clear_int_stat(void)
+{
+  mtspr(SPRN_TSR, (TSR_ENW|TSR_WIS));
+}
+/**
+ *	__ppc4xx_wdt_set_timeout:
+ *	@t:	the new time out value that needs to be set.
+ *
+ *	Set a new time out value for the watchdog device. 
+ *
+ */
+static __inline__ void
+__ppc4xx_wdt_set_timeout(int t)
+{
+#if !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+  unsigned long tmp;
+  unsigned long div;
+
+  /*  Parameter check must be performed in wdt_set_timeout.  */  
+  ppc4xx_wdt_dbg("clock : %d\n",cpu_clock);
+  tmp=t*US_PER_MS; /*  in us */
+
+  /* Note:
+   * On  PowerPC 4xx processor, WatchDogTimer exception is occur according to
+   * Time Base bit tansition 0 -> 1. In other word, Time Base bit tansition 
+   * 1 -> 0 does not cause the exception. The is the reason why the divisor
+   * as follows should be multiplied by 2.
+   */
+  div=( (WDT_CLK_PER_INT_WP_VAL/(cpu_clock/MHZ)) * 2);
+  ppc4xx_wdt_dbg("div : %lu\n",div);
+  tmp /= div;
+  wdt_count=tmp;
+#else
+  wdt_count=t;  /*  Assume 1ms tick */
+#endif
+  return;
+}
+/*
+ * Driver specific functions
+ */
+/**
+ *	ppc4xx_wdt_heartbeat:
+ *      Ping routine called from kernel.
+ */
+void 
+ppc4xx_wdt_heartbeat(void)
+{
+  /* Disable watchdog */
+  __ppc4xx_wdt_disable();
+
+  /* Write a watchdog value */
+  __ppc4xx_wdt_clear_int_stat();
+  
+  if (!wdt_enable) 
+    goto out;
+
+#if defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+  if  (wdt_heartbeat_count > 0)
+    wdt_heartbeat_count--;
+  else
+    panic(ppc4xx_mkmsg("Initiating system reboot.\n"));
+#endif /*  CONFIG_PPC4xx_WATCHDOG_COMPAT  */
+  /* Enable watchdog */
+  __ppc4xx_wdt_enable();
+ out:
+  /*  Reset count  */
+  ppc_md.heartbeat_count = 0;
+}
+/**
+ *	ppc4xx_wdt_interrupt:
+ *      Watchdog interrupt handler.
+ */
+void
+ppc4xx_wdt_interrupt(struct pt_regs *regs)
+{
+  unsigned long status=mfspr(SPRN_TSR);
+  unsigned long flags;
+
+  if (status & (TSR_WIS|TSR_ENW)){
+	  /* Disable watchdog */
+	  __ppc4xx_wdt_disable();
+
+	  __ppc4xx_wdt_clear_int_stat();
+	  local_irq_save(flags);
+#if !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+    if (wdt_heartbeat_count) {
+      --wdt_heartbeat_count;
+    } else {
+#ifdef ONLY_TESTING
+      ppc4xx_wdt_crit("Would Reboot by application failure.\n");
+#else
+#ifdef SOFTWARE_REBOOT
+      ppc4xx_wdt_crit("Initiating system reboot.\n");
+      machine_restart(NULL);
+#else
+      panic(ppc4xx_mkmsg("Initiating system reboot.\n"));
+#endif  /*   SOFTWARE_REBOOT  */
+#endif  /*   ONLY_TESTING  */
+    }   /*  Time out  */
+#endif  /*   !CONFIG_PPC4xx_WATCHDOG_COMPAT  */
+    local_irq_restore(flags);
+    /* Enable watchdog */
+    __ppc4xx_wdt_enable();
+  }
+  return;
+}
+
+/*
+ *	Driver Logic functions
+ */
+static __inline__ int
+ppc4xx_wdt_is_enabled(void)
+{
+  return  __ppc4xx_wdt_is_enabled();
+}
+/**
+ *	ppc4xx_wdt_start:
+ *
+ *	Start the watchdog driver.
+ */
+static __inline__ int 
+ppc4xx_wdt_start(void)
+{
+  __ppc4xx_wdt_enable();
+  return 0;
+}
+
+/**
+ *	ppc4xx_wdt_stop:
+ *
+ *	Stop the watchdog driver.
+ */
+static __inline__ int 
+ppc4xx_wdt_stop (void)
+{
+  __ppc4xx_wdt_disable();
+  return 0;
+}
+/**
+ *	ppc4xx_wdt_ping:
+ *
+ *	Reload counter one with the watchdog heartbeat. We don't bother reloading
+ *	the cascade counter.
+ */
+static __inline__ int 
+ppc4xx_wdt_ping(void)
+{
+  /* Disable watchdog */
+  __ppc4xx_wdt_disable();
+  /* Write a watchdog value */
+  __ppc4xx_wdt_clear_int_stat();
+  /*  Reset count  */
+  wdt_heartbeat_count=wdt_count;
+  /* Enable watchdog */
+  __ppc4xx_wdt_enable();
+
+  return 0;
+}
+/**
+ *	ppc4xx_wdt_set_timeout:
+ *	@t:		the new timeout value that needs to be set.
+ *
+ *	Set a new time out value for the watchdog device. 
+ *      If the heartbeat value is incorrect we keep the old value 
+ *      and return -EINVAL. If successfull we
+ *	return 0.
+ */
+static __inline__ int 
+ppc4xx_wdt_set_timeout(int t)
+{
+  if ((t < WDT_HEARTBEAT_MIN) || (t > WDT_HEARTBEAT_MAX))
+    return -EINVAL;
+
+  wdt_period = t;
+  __ppc4xx_wdt_set_timeout(t);
+  wdt_heartbeat_count=wdt_count;
+  ppc4xx_wdt_dbg("The WDT counter set %d.\n",wdt_count);
+
+  return 0;
+}
+
+/**
+ *	ppc4xx_wdt_get_status:
+ *	@status: the new status.
+ *
+ *	Return the enable/disable card status.
+ */
+static __inline__ int 
+ppc4xx_wdt_get_status(int *status)
+{
+  if (wdt_enable)
+	  *status = WDIOS_ENABLECARD;
+  else
+	  *status = WDIOS_DISABLECARD;
+
+  return 0;
+}
+/*
+ *	Kernel Interfaces
+ */
+/**
+ *	ppc4xx_wdt_init_device:
+ *
+ *      Initilize PowerPC 4xx family Watch Dog facility.
+ */
+static void
+ppc4xx_wdt_init_device(void)
+{
+        __ppc4xx_get_cpu_clock();
+	__ppc4xx_wdt_setup_val(WDT_WP,WDT_RESET_NONE);
+}
+/**
+ *	ppc4xx_wdt_write:
+ *	@file: file handle to the watchdog
+ *	@buf: buffer to write (unused as data does not matter here
+ *	@count: count of bytes
+ *	@ppos: pointer to the position to write. No seeks allowed
+ *
+ *	A write to a watchdog device is defined as a keepalive signal. Any
+ *	write of data will do, as we we don't define content meaning expept
+ *      'V' character. It is performed as a sign to set stop-on-close mode.
+ */
+
+static ssize_t 
+ppc4xx_wdt_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+  size_t i;
+
+    if (!nowayout) {
+      /* In case it was set long ago */
+      clear_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+
+      for (i = 0; i < count; i++) {
+	char c;
+
+	if (get_user(c, buf + i))
+	  return -EFAULT;
+
+	if (c == 'V') {
+	  set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+	}
+      }
+    }
+    ppc4xx_wdt_ping();
+
+  return count;
+}
+static struct watchdog_info ident = {
+  .options=WDIOF_SETTIMEOUT|WDIOF_KEEPALIVEPING|WDIOF_MAGICCLOSE,
+  .firmware_version =	1,
+  .identity =		"PPC4xx WDT",
+};
+
+/**
+ *	ppc4xx_wdt_ioctl:
+ *	@inode: inode of the device
+ *	@file: file handle to the device
+ *	@cmd: watchdog command
+ *	@arg: argument pointer
+ *
+ */
+static int 
+ppc4xx_wdt_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+	unsigned long arg)
+{
+	int new_timeout;
+	int status;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;  /*  It may be too strict manner.  */
+	switch(cmd)
+	{
+	default:
+		return -ENOIOCTLCMD;
+	case WDIOC_GETSUPPORT:
+		if (copy_to_user((struct watchdog_info *)arg, &ident, sizeof(struct watchdog_info)))
+			return -EFAULT;
+		else
+			break;
+	case WDIOC_GETSTATUS:
+		ppc4xx_wdt_get_status(&status);
+		return put_user(status,(int *)arg);
+	case WDIOC_KEEPALIVE:
+		ppc4xx_wdt_ping();
+		break;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_timeout, (int *)arg))
+			return -EFAULT;
+		if (ppc4xx_wdt_set_timeout(new_timeout))
+			return -EINVAL;
+		ppc4xx_wdt_ping();
+		break;
+	case WDIOC_GETTIMEOUT:
+		return put_user(wdt_period, (int *)arg);
+	case WDIOC_SETOPTIONS:
+		if (get_user(status, (int *)arg))
+			return -EFAULT;
+		/*  Return -EINVAL when the driver can not figure out 
+		 *  what it should do. Unknown cases are just ignored.
+		 */
+		if ( (status & (WDIOS_DISABLECARD|WDIOS_ENABLECARD)) 
+		     == (WDIOS_DISABLECARD|WDIOS_ENABLECARD) )
+			return -EINVAL;
+		if (status & WDIOS_DISABLECARD) {
+			wdt_enable = 0;
+			ppc4xx_wdt_stop();
+			ppc4xx_wdt_note("Watchdog timer is disabled\n");
+		}
+		if (status & WDIOS_ENABLECARD) {
+			wdt_enable = 1;
+			ppc4xx_wdt_start();
+			ppc4xx_wdt_note("Watchdog timer is enabled\n");
+		}
+		break;
+	}
+	return 0;
+}
+/**
+ *	ppc4xx_wdt_open:
+ *	@inode: inode of device
+ *	@file: file handle to device
+ *
+ *	The watchdog device has been opened. The watchdog device is single
+ *	open and start the WDT timer.
+ */
+static int 
+ppc4xx_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(WDT_STATE_OPEN, &driver_state))
+		return -EBUSY;
+	/*
+	 * Activate
+	 */
+	ppc4xx_wdt_start();
+	wdt_enable=1;
+
+	if (nowayout)
+	  set_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state);
+
+	return 0;
+}
+
+/**
+ *	ppc4xx_wdt_release:
+ *	@inode: inode to board
+ *	@file: file handle to board
+ *
+ */
+static int
+ppc4xx_wdt_release(struct inode *inode, struct file *file)
+{
+  if (test_bit(WDT_STATE_STOP_ON_CLOSE, &driver_state)) {
+      ppc4xx_wdt_note("WDT device is stopped.\n");
+    ppc4xx_wdt_stop();
+    wdt_enable=0;
+  } else {
+    if ( (ppc4xx_wdt_is_enabled()) && (!nowayout) ) {
+      ppc4xx_wdt_note("WDT device may be closed unexpectedly.  WDT will not stop!\n");
+      ppc4xx_wdt_ping();
+    }
+  }
+  clear_bit(WDT_STATE_OPEN, &driver_state);
+
+  return 0;
+}
+/**
+ *	notify_sys:
+ *	@this: our notifier block
+ *	@code: the event being reported
+ *	@unused: unused
+ *
+ */
+
+static int 
+ppc4xx_wdt_notify_sys(struct notifier_block *this, unsigned long code,
+	void *unused)
+{
+	if(code==SYS_DOWN || code==SYS_HALT) {
+	  /* Turn the card off */
+	  ppc4xx_wdt_stop();
+	}
+	return NOTIFY_DONE;
+}
+
+static struct file_operations ppc4xx_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.write		= ppc4xx_wdt_write,
+	.ioctl		= ppc4xx_wdt_ioctl,
+	.open		= ppc4xx_wdt_open,
+	.release	= ppc4xx_wdt_release,
+};
+
+static struct miscdevice ppc4xx_wdt_miscdev = {
+	.minor	= WATCHDOG_MINOR,
+	.name	= "watchdog",
+	.fops	= &ppc4xx_wdt_fops,
+};
+
+/*
+ *	The WDT card needs to know about shutdowns in order to
+ *	turn WDT off.
+ */
+
+static struct notifier_block ppc4xx_wdt_notifier = {
+	.notifier_call = ppc4xx_wdt_notify_sys,
+};
+
+/**
+ *	cleanup_module:
+ *
+ *	If your watchdog is set to continue ticking on close and you unload
+ *	it, well it keeps ticking.  You just have to load a new
+ *	module in 60 seconds or reboot.
+ *      This behavior(more over the comments as above) is borrowed from
+ *      Alan cox's driver.
+ */
+
+static void __exit 
+ppc4xx_wdt_exit(void)
+{
+	misc_deregister(&ppc4xx_wdt_miscdev);
+	unregister_reboot_notifier(&ppc4xx_wdt_notifier);
+}
+
+/**
+ * 	ppc4xx_wdt_init:
+ *
+ *	Set up the WDT relevant timer facility. 
+ */
+
+static int __init 
+ppc4xx_wdt_init(void)
+{
+	int ret;
+
+	ret = register_reboot_notifier(&ppc4xx_wdt_notifier);
+	if(ret) {
+	  ppc4xx_wdt_err("Cannot register reboot notifier (err=%d)\n", ret);
+	  return ret;
+	}
+
+	ret = 0;
+	ppc4xx_wdt_init_device();
+	/* Check that the heartbeat value is within it's range ; if not reset to the default */
+	if (ppc4xx_wdt_set_timeout(wdt_period)) {
+	  ppc4xx_wdt_set_timeout(WD_TIMO);
+	  ppc4xx_wdt_info("The heartbeat value must be 0<wdt_period<65536, using %d\n",WD_TIMO);
+	}
+	
+#if defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+	{
+		unsigned long flags;
+
+		local_irq_save(flags); /* Prevent timer interrupt */
+		ppc_md.heartbeat_count = 0;	
+		ppc_md.heartbeat=ppc4xx_wdt_heartbeat;
+		local_irq_restore(flags);
+	}
+#endif  /*  CONFIG_PPC4xx_WATCHDOG_COMPAT  */
+
+	ppc4xx_wdt_info("PowerPC 4xx Watchdog Driver. period=%d ms (nowayout=%d)\n",wdt_period, nowayout);
+
+	ret = misc_register(&ppc4xx_wdt_miscdev);
+	if (ret) {
+	  ppc4xx_wdt_err("Cannot register miscdev on minor=%d (err=%d)\n",
+			WATCHDOG_MINOR, ret);
+		goto outmisc;
+	}
+
+	if (wdt_enable) {
+	  ppc4xx_wdt_info("WDT start on boot.\n");
+	  ppc4xx_wdt_start();
+	}
+out:
+	return ret;
+outmisc:
+	unregister_reboot_notifier(&ppc4xx_wdt_notifier);
+#if defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+	{
+		unsigned long flags;
+
+		local_irq_save(flags);
+		ppc_md.heartbeat=NULL;
+		ppc_md.heartbeat_count = 0;
+		local_irq_restore(flags);
+	}
+#endif
+	goto out;
+}
+
+module_init(ppc4xx_wdt_init);
+module_exit(ppc4xx_wdt_exit);
+
+MODULE_AUTHOR("Takeharu KATO");
+MODULE_DESCRIPTION("Driver for PPC4xx watchdog cards.");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_LICENSE("GPL");
diff -uprN linux-2.6.11-rc4.orig/drivers/char/watchdog/ppc4xx_wdt.h linux-2.6.11-rc4/drivers/char/watchdog/ppc4xx_wdt.h
--- linux-2.6.11-rc4.orig/drivers/char/watchdog/ppc4xx_wdt.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.11-rc4/drivers/char/watchdog/ppc4xx_wdt.h	2005-02-26 02:48:42.000000000 +0900
@@ -0,0 +1,131 @@
+/*
+ *
+ *    Copyright (c) 2004 Fujitsu Limited
+ *
+ *    Module name: ppc4xx_wdt.h
+ *    Author:      Takeharu KATO<kato.takeharu@jp.fujitsu.com>
+ *    Description:
+ *      Header file for PPC4xx watchdog driver.
+ */
+#ifndef _ARCH_PPC_SYSLIB_PPC4XX_WDT_H
+#define _ARCH_PPC_SYSLIB_PPC4XX_WDT_H
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ptrace.h>
+#include <linux/watchdog.h>
+
+/*
+ *  Driver behavior flags(bit position)
+ */
+#define WDT_STATE_OPEN                  0   /* driver is opend  */
+#define WDT_STATE_STOP_ON_CLOSE         1   /* Stop with close is expected */
+#define WDT_STATE_COMPAT_MODE           2   /* Monta Vista Linux Comaptible  */
+/*
+ *  For comaptible mode
+ */
+#define WDIOC_GETPERIOD         WDIOC_GETTIMEOUT
+#define WDIOC_SETPERIOD         WDIOC_SETTIMEOUT
+/*
+ * Configurations
+ */
+#define WD_TIMO            60000	/* Default timeout = 60000 ms(1min) */
+#define WDT_HEARTBEAT_MIN  100          /* Minimum timeout = 100 ms */
+#define WDT_HEARTBEAT_MAX  600000       /* Maximum timeout = 600000ms(1hour) */
+#ifdef __KERNEL__
+//#define WDT_DEBUG              /*  Debug switch */
+/*
+ *  Reset type
+ */
+#define WDT_RESET_NONE     0
+#define WDT_RESET_CORE     1
+#define WDT_RESET_CHIP     2
+#define WDT_RESET_SYS      3
+/*
+ *   Bit positions in  TCR register on PPC4xx series.
+ */
+#define WDT_TCR_WP_BIT     1   /*  WP  bit in TCR (bit[0..1])   */
+#define WDT_TCR_WRC_BIT    3   /*  WRC bit in TCR (bit[2..3])   */
+#define WDT_TCR_WIE_BIT    4   /*  WIE bit in TCR (bit[4])      */
+/*
+ *  TCR[WP] relevant definitions
+ */
+#define WDT_TCR_WP_SHIFT       (31 - WDT_TCR_WP_BIT)
+#define WDT_TCR_WRC_SHIFT      (31 - WDT_TCR_WRC_BIT)
+#define WDT_TCR_WIE_SHIFT      (31 - WDT_TCR_WIE_BIT)
+#define WDT_TCR_WDT_ENABLE     (1<<WDT_TCR_WIE_SHIFT)
+/*  MASK value to obatain TCR[WP]  */
+#define WDT_TCR_WP_MASK        (3<<(WDT_TCR_WP_SHIFT))
+
+/*  Watchdog timer periods can be set on PPC4xx cpus. */
+#define WDT_WP0               0
+#define WDT_WP1               1
+#define WDT_WP2               2
+#define WDT_WP3               3
+
+/*  Immediate values of TCR[WP] */
+/*  2^17 clocks period  */
+#define WDT_TCR_WP_VAL0        (0<<(WDT_TCR_WP_SHIFT))
+/*  2^21 clocks period  */
+#define WDT_TCR_WP_VAL1        (1<<(WDT_TCR_WP_SHIFT))
+/*  2^25 clocks period  */
+#define WDT_TCR_WP_VAL2        (2<<(WDT_TCR_WP_SHIFT))
+/*  2^29 clocks period  */
+#define WDT_TCR_WP_VAL3        (3<<(WDT_TCR_WP_SHIFT)) 
+
+/*  Clock periods expressed with power of 2 for each value. */
+#if defined(CONFIG_44x)
+#define WDT_CLK_POW_WP_VAL0  21  /*  2^17 clocks period  */
+#define WDT_CLK_POW_WP_VAL1  25  /*  2^21 clocks period  */
+#define WDT_CLK_POW_WP_VAL2  29  /*  2^25 clocks period  */
+#define WDT_CLK_POW_WP_VAL3  33  /*  2^29 clocks period  */
+#else
+#if defined(CONFIG_40x)
+#define WDT_CLK_POW_WP_VAL0  17  /*  2^17 clocks period  */
+#define WDT_CLK_POW_WP_VAL1  21  /*  2^21 clocks period  */
+#define WDT_CLK_POW_WP_VAL2  25  /*  2^25 clocks period  */
+#define WDT_CLK_POW_WP_VAL3  29  /*  2^29 clocks period  */
+#else
+#error "PPC4xx WDT Detect invalid configuration(Unknown CPU)"
+#endif
+#endif
+/*
+ *  WP relevant values used in our driver.
+ */
+#if !defined(CONFIG_PPC4xx_WATCHDOG_COMPAT)
+#define WDT_WP                 WDT_WP0
+#define WDT_WP_VAL             WDT_TCR_WP_VAL0
+#define WDT_CLK_POW_WP_VAL     WDT_CLK_POW_WP_VAL0
+#define WDT_CLK_PER_INT_WP_VAL ((1UL)<<WDT_CLK_POW_WP_VAL)
+#else
+/*
+ *  WDT period must be more than HZ(Timer ticks)
+ */
+#define WDT_WP                 WDT_WP3
+#define WDT_WP_VAL             WDT_TCR_WP_VAL3
+#define WDT_CLK_POW_WP_VAL     WDT_CLK_POW_WP_VAL3
+#define WDT_CLK_PER_INT_WP_VAL ((1UL)<<WDT_CLK_POW_WP_VAL)
+#endif
+/*
+ *  output messages
+ */
+#define __PPC4xx_WDT_MSG "PPC4xx WDT : "
+#define ppc4xx_mkmsg(str) __PPC4xx_WDT_MSG str
+#define ppc4xx_wdt_info(fmt,arg...) \
+	printk(KERN_INFO __PPC4xx_WDT_MSG fmt,##arg)
+#define ppc4xx_wdt_note(fmt,arg...) \
+	printk(KERN_NOTICE __PPC4xx_WDT_MSG fmt,##arg)
+#define ppc4xx_wdt_err(fmt,arg...) \
+	printk(KERN_ALERT __PPC4xx_WDT_MSG fmt,##arg)
+#define ppc4xx_wdt_crit(fmt,arg...) \
+	printk(KERN_ALERT __PPC4xx_WDT_MSG fmt,##arg)
+#if defined(WDT_DEBUG)
+#define ppc4xx_wdt_dbg(fmt,arg...) \
+	printk(KERN_ALERT __PPC4xx_WDT_MSG fmt,##arg)
+#else
+#define ppc4xx_wdt_dbg(fmt,arg...) \
+        do{}while(0)
+#endif  /*  WDT_DEBUG  */
+
+void ppc4xx_wdt_interrupt(struct pt_regs *regs);
+#endif  /* __KERNEL__  */
+#endif  /*  _ARCH_PPC_SYSLIB_PPC4XX_WDT_H  */

--------------040008080100030708040802--
