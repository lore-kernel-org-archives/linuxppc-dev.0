Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id E3B0167A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Mar 2005 23:07:50 +1100 (EST)
Message-ID: <4226FDFF.5080904@jp.fujitsu.com>
Date: Thu, 03 Mar 2005 21:07:27 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
References: <421CD2B3.4020805@ybb.ne.jp>	<421CD669.1040002@ybb.ne.jp>	<20050223142720.C13087@cox.net>	<421F7DF5.3000608@ybb.ne.jp>
	<42231C26.7020508@jp.fujitsu.com>
In-Reply-To: <42231C26.7020508@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 3/3] PowerPC4xx/E500 WatchDogTimerDriver(exception
 handler part)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all:

I fix PowerPC405 exception handling part.
This patch corrects the problem of having not stopped WDT
when the WDT exception is generated.
This patch also stop WDT when the system fall in panic.

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>


--- linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_44x.S	2005-02-27 15:27:46.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/kernel/head_44x.S	2005-03-03 18:09:03.000000000 +0900
@@ -444,8 +444,11 @@ interrupt_base:
  	EXCEPTION(0x1010, FixedIntervalTimer, UnknownException, EXC_XFER_EE)

  	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
+#if defined(CONFIG_PPC4xx_WATCHDOG)
+	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, ppc4xx_wdt_exception)
+#else
  	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, UnknownException)
+#endif

  	/* Data TLB Error Interrupt */
  	START_EXCEPTION(DataTLBError)
diff -uprN linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_4xx.S 
linux-2.6.11-rc5/arch/ppc/kernel/head_4xx.S
--- linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_4xx.S	2005-03-03 18:30:12.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/kernel/head_4xx.S	2005-03-03 18:09:04.000000000 +0900
@@ -477,17 +477,21 @@ label:

  #if 0
  /* NOTE:
- * FIT and WDT handlers are not implemented yet.
+ * FIT handler is not implemented yet.
   */

  /* 0x1010 - Fixed Interval Timer (FIT) Exception
  */
  	STND_EXCEPTION(0x1010,	FITException,		UnknownException)

+#endif
+
  /* 0x1020 - Watchdog Timer (WDT) Exception
  */
-
-	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
+#if defined(CONFIG_PPC4xx_WATCHDOG)
+	CRITICAL_EXCEPTION(0x1020, WDTException, ppc4xx_wdt_exception)
+#else
+ 	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
  #endif

  /* 0x1100 - Data TLB Miss Exception
diff -uprN linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_e500.S 
linux-2.6.11-rc5/arch/ppc/kernel/head_e500.S
--- linux-2.6.11-rc5-ppc4xx/arch/ppc/kernel/head_e500.S	2005-02-27 15:29:39.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/kernel/head_e500.S	2005-03-03 18:09:04.000000000 +0900
@@ -494,8 +494,12 @@ interrupt_base:
  	EXCEPTION(0x3100, FixedIntervalTimer, UnknownException, EXC_XFER_EE)

  	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
+#if defined(CONFIG_PPC4xx_WATCHDOG)
+	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, ppc4xx_wdt_exception)
+#else
  	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, UnknownException)
+#endif
+

  	/* Data TLB Error Interrupt */
  	START_EXCEPTION(DataTLBError)
diff -uprN linux-2.6.11-rc5-ppc4xx/drivers/char/watchdog/ppc4xx_wdt.c 
linux-2.6.11-rc5/drivers/char/watchdog/ppc4xx_wdt.c
--- linux-2.6.11-rc5-ppc4xx/drivers/char/watchdog/ppc4xx_wdt.c	2005-03-03 18:28:33.000000000 +0900
+++ linux-2.6.11-rc5/drivers/char/watchdog/ppc4xx_wdt.c	2005-03-03 20:29:16.946286104 +0900
@@ -66,12 +66,18 @@ static struct watchdog_info ident = {
    .firmware_version =	0, /*  This is filled with PVR in initialization. */
    .identity =		"PPC4xx WDT",
  };
-
+/*
+ *  PowerPC Linux common exception handler
+ */
+extern void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr);
+/*  Panic notifier  */
+extern struct notifier_block *panic_notifier_list;
  /*
   *  External linkage functions
   */
  void ppc4xx_wdt_heartbeat(void);
  void ppc4xx_wdt_setup_options(char *cmd_line);
+void ppc4xx_wdt_exception(struct pt_regs *regs);
  /*
   * Internal linkage functions
   */
@@ -243,7 +249,7 @@ ppc4xx_wdt_heartbeat(void)

    if (!wdt_enable)
      goto out;
-
+
    if  (wdt_heartbeat_count > 0)
      wdt_heartbeat_count--;
    else
@@ -255,6 +261,20 @@ ppc4xx_wdt_heartbeat(void)
    /*  Reset count  */
    ppc_md.heartbeat_count = 0;
  }
+/**
+ *	ppc4xx_wdt_exception:
+ *      WatchDog Exception
+ */
+void
+ppc4xx_wdt_exception(struct pt_regs *regs)
+{
+  wdt_enable=0;
+
+  __ppc4xx_wdt_disable();
+  printk("WDT Exception at PC: %lx, MSR: %lx, vector=%lx    %s\n",
+	 regs->nip, regs->msr, regs->trap, print_tainted());
+  panic(ppc4xx_mkmsg("Initiating system reboot.\n"));
+}
  
  /*
   *	Driver Logic functions
@@ -526,10 +546,9 @@ static int
  ppc4xx_wdt_notify_sys(struct notifier_block *this, unsigned long code,
  	void *unused)
  {
-	if(code==SYS_DOWN || code==SYS_HALT) {
-	  /* Turn the card off */
+	if (code != SYS_POWER_OFF)   /* Turn the card off */
  	  ppc4xx_wdt_stop();
-	}
+	
  	return NOTIFY_DONE;
  }

@@ -572,6 +591,7 @@ ppc4xx_wdt_exit(void)
  {
  	misc_deregister(&ppc4xx_wdt_miscdev);
  	unregister_reboot_notifier(&ppc4xx_wdt_notifier);
+	notifier_chain_unregister(&panic_notifier_list,&ppc4xx_wdt_notifier);
  }

  /**
@@ -592,6 +612,14 @@ ppc4xx_wdt_init(void)
  	  return ret;
  	}

+	/* Register panic notifier  */
+	ret = notifier_chain_register(&panic_notifier_list,&ppc4xx_wdt_notifier);
+	if(ret) {
+	  ppc4xx_wdt_err("Cannot register panic notifier (err=%d)\n", ret);
+	  unregister_reboot_notifier(&ppc4xx_wdt_notifier);
+	  return ret;
+	}
+
  	ret = 0;
  	ppc4xx_wdt_init_device();
  	/* Check that the heartbeat value is within it's range ; if not reset to the default */


-- 
Takeharu KATO
Fujitsu Limited
Email:kato.takeharu at jp.fujitsu.com
