Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp11.mail.mci.yahoo.co.jp (ybbsmtp11.mail.mci.yahoo.co.jp
	[210.80.241.185]) by ozlabs.org (Postfix) with SMTP id 8295C679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 06:59:58 +1000 (EST)
Message-ID: <427BDBCF.8030908@ybb.ne.jp>
Date: Sat, 07 May 2005 06:04:15 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42797FDE.7080909@ybb.ne.jp>
	<905bacf60cf1e3167d4f42dba31c9d4f@freescale.com>
In-Reply-To: <905bacf60cf1e3167d4f42dba31c9d4f@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar:

> 
> Sorry, I think Matt and I have been busy with normal "work".  I'll take 
> a look at this in the next week.  If you can update the patches to 
> something current that would help (but is not critical).
> 
I updated the patch to current linus-git kernel(pulled in 2005/05/05 
JST). Please use this for your testing.

This is architecture dependent part.
I'll re-test this patch in the next week.

Signed-off-by: kato.takeharu@jp.fujitsu.com

diff -Nupr linux-2.6.orig/arch/ppc/kernel/head_44x.S 
linux-2.6/arch/ppc/kernel/head_44x.S
--- linux-2.6.orig/arch/ppc/kernel/head_44x.S	2005-05-06 
05:03:55.000000000 +0900
+++ linux-2.6/arch/ppc/kernel/head_44x.S	2005-05-07 05:03:24.000000000 +0900
@@ -448,8 +448,11 @@ interrupt_base:
  	EXCEPTION(0x1010, FixedIntervalTimer, UnknownException, EXC_XFER_EE)

  	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
+#if defined(CONFIG_BOOKE_WDT)
+	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, booke_wdt_exception)
+#else
  	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, UnknownException)
+#endif  /*  CONFIG_BOOKE_WDT  */

  	/* Data TLB Error Interrupt */
  	START_EXCEPTION(DataTLBError)
diff -Nupr linux-2.6.orig/arch/ppc/kernel/head_4xx.S 
linux-2.6/arch/ppc/kernel/head_4xx.S
--- linux-2.6.orig/arch/ppc/kernel/head_4xx.S	2005-05-06 
05:03:55.000000000 +0900
+++ linux-2.6/arch/ppc/kernel/head_4xx.S	2005-05-07 05:03:24.000000000 +0900
@@ -430,27 +430,24 @@ label:

  /* 0x1000 - Programmable Interval Timer (PIT) Exception */
  	START_EXCEPTION(0x1000, Decrementer)
-	NORMAL_EXCEPTION_PROLOG
-	lis	r0,TSR_PIS@h
-	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_LITE(0x1000, timer_interrupt)
+	b    DecrementerHandler

  #if 0
  /* NOTE:
- * FIT and WDT handlers are not implemented yet.
+ * FIT handler is not implemented yet.
   */

  /* 0x1010 - Fixed Interval Timer (FIT) Exception
  */
  	STND_EXCEPTION(0x1010,	FITException,		UnknownException)

-/* 0x1020 - Watchdog Timer (WDT) Exception
-*/
-
-	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
  #endif

+/* 0x1020 - Watchdog Timer (WDT) Exception
+ */
+	START_EXCEPTION(0x1020, WDTException)
+	b    WatchDogHandler
+
  /* 0x1100 - Data TLB Miss Exception
   * As the name implies, translation is not in the MMU, so search the
   * page tables and fix it.  The only purpose of this function is to
@@ -732,6 +729,13 @@ label:
  		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
  		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)

+DecrementerHandler:
+	NORMAL_EXCEPTION_PROLOG
+	lis    r0,TSR_PIS@h
+	mtspr    SPRN_TSR,r0        /* Clear the PIT exception */
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_LITE(0x1000, timer_interrupt)
+
  /*
   * The other Data TLB exceptions bail out to this point
   * if they can't resolve the lightweight TLB fault.
@@ -804,6 +808,19 @@ finish_tlb_load:
  	PPC405_ERR77_SYNC
  	rfi			/* Should sync shadow TLBs */
  	b	.		/* prevent prefetch past rfi */
+/*
+ * WatchDog Exception
+ */
+WatchDogHandler:
+	CRITICAL_EXCEPTION_PROLOG;
+	addi    r3,r1,STACK_FRAME_OVERHEAD;
+#if defined(CONFIG_BOOKE_WDT)
+	EXC_XFER_TEMPLATE(booke_wdt_exception, 0x1022, (MSR_KERNEL & 
~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, crit_transfer_to_handler, 
ret_from_crit_exc)
+
+#else
+	EXC_XFER_TEMPLATE(UnknownException, 0x1022, (MSR_KERNEL & 
~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, crit_transfer_to_handler, 
ret_from_crit_exc)
+#endif  /*  CONFIG_BOOKE_WDT  */
+

  /* extern void giveup_fpu(struct task_struct *prev)
   *
diff -Nupr linux-2.6.orig/arch/ppc/kernel/head_fsl_booke.S 
linux-2.6/arch/ppc/kernel/head_fsl_booke.S
--- linux-2.6.orig/arch/ppc/kernel/head_fsl_booke.S	2005-05-06 
05:03:55.000000000 +0900
+++ linux-2.6/arch/ppc/kernel/head_fsl_booke.S	2005-05-07 
05:05:06.000000000 +0900
@@ -526,8 +526,11 @@ interrupt_base:
  	EXCEPTION(0x3100, FixedIntervalTimer, UnknownException, EXC_XFER_EE)

  	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
-	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, UnknownException)
+#if defined(CONFIG_BOOKE_WDT)
+	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, booke_wdt_exception)
+#else
+ 	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, UnknownException)
+#endif  /*  CONFIG_BOOKE_WDT  */

  	/* Data TLB Error Interrupt */
  	START_EXCEPTION(DataTLBError)
diff -Nupr linux-2.6.orig/arch/ppc/platforms/85xx/mpc8540_ads.c 
linux-2.6/arch/ppc/platforms/85xx/mpc8540_ads.c
--- linux-2.6.orig/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-05-06 
05:03:57.000000000 +0900
+++ linux-2.6/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-05-07 
05:08:39.000000000 +0900
@@ -187,6 +187,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_BOOKE_WDT
+	{
+	  extern void booke_wdt_setup_options(char *cmd_line);
+
+	  booke_wdt_setup_options(cmd_line);
+	}
+#endif  /*  CONFIG_BOOKE_WDT  */
+
  	identify_ppc_sys_by_id(mfspr(SPRN_SVR));

  	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.orig/arch/ppc/platforms/85xx/mpc8560_ads.c 
linux-2.6/arch/ppc/platforms/85xx/mpc8560_ads.c
--- linux-2.6.orig/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-05-06 
05:03:57.000000000 +0900
+++ linux-2.6/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-05-07 
05:09:12.000000000 +0900
@@ -183,6 +183,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_BOOKE_WDT
+      {
+        extern void booke_wdt_setup_options(char *cmd_line);
+
+        booke_wdt_setup_options(cmd_line);
+      }
+#endif  /*  CONFIG_BOOKE_WDT  */
+
  	identify_ppc_sys_by_id(mfspr(SPRN_SVR));

  	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.orig/arch/ppc/platforms/85xx/mpc85xx_cds_common.c 
linux-2.6/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- linux-2.6.orig/arch/ppc/platforms/85xx/mpc85xx_cds_common.c 
2005-05-06 05:03:57.000000000 +0900
+++ linux-2.6/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-05-07 
05:07:59.000000000 +0900
@@ -432,6 +432,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_BOOKE_WDT
+      {
+        extern void booke_wdt_setup_options(char *cmd_line);
+
+        booke_wdt_setup_options(cmd_line);
+      }
+#endif  /*  CONFIG_BOOKE_WDT  */
+
  	identify_ppc_sys_by_id(mfspr(SPRN_SVR));

  	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.orig/arch/ppc/platforms/85xx/sbc8560.c 
linux-2.6/arch/ppc/platforms/85xx/sbc8560.c
--- linux-2.6.orig/arch/ppc/platforms/85xx/sbc8560.c	2005-05-06 
05:03:57.000000000 +0900
+++ linux-2.6/arch/ppc/platforms/85xx/sbc8560.c	2005-05-07 
05:06:59.000000000 +0900
@@ -198,6 +198,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_BOOKE_WDT
+     {
+       extern void booke_wdt_setup_options(char *cmd_line);
+
+       booke_wdt_setup_options(cmd_line);
+     }
+#endif  /*  CONFIG_BOOKE_WDT  */
+
  	identify_ppc_sys_by_id(mfspr(SPRN_SVR));

  	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.orig/arch/ppc/platforms/85xx/stx_gp3.c 
linux-2.6/arch/ppc/platforms/85xx/stx_gp3.c
--- linux-2.6.orig/arch/ppc/platforms/85xx/stx_gp3.c	2005-05-06 
05:03:57.000000000 +0900
+++ linux-2.6/arch/ppc/platforms/85xx/stx_gp3.c	2005-05-07 
05:10:12.000000000 +0900
@@ -331,6 +331,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_BOOKE_WDT
+      {
+        extern void booke_wdt_setup_options(char *cmd_line);
+
+        booke_wdt_setup_options(cmd_line);
+      }
+#endif  /*  CONFIG_BOOKE_WDT  */
+
  	identify_ppc_sys_by_id(mfspr(SPRN_SVR));

  	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.orig/arch/ppc/syslib/ppc4xx_setup.c 
linux-2.6/arch/ppc/syslib/ppc4xx_setup.c
--- linux-2.6.orig/arch/ppc/syslib/ppc4xx_setup.c	2005-05-06 
05:03:58.000000000 +0900
+++ linux-2.6/arch/ppc/syslib/ppc4xx_setup.c	2005-05-07 
05:03:25.000000000 +0900
@@ -48,10 +48,6 @@
  extern void abort(void);
  extern void ppc4xx_find_bridges(void);

-extern void ppc4xx_wdt_heartbeat(void);
-extern int wdt_enable;
-extern unsigned long wdt_period;
-
  /* Global Variables */
  bd_t __res;

@@ -257,22 +253,14 @@ ppc4xx_init(unsigned long r3, unsigned l
  		*(char *) (r7 + KERNELBASE) = 0;
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}
-#if defined(CONFIG_PPC405_WDT)
-/* Look for wdt= option on command line */
-	if (strstr(cmd_line, "wdt=")) {
-		int valid_wdt = 0;
-		char *p, *q;
-		for (q = cmd_line; (p = strstr(q, "wdt=")) != 0;) {
-			q = p + 4;
-			if (p > cmd_line && p[-1] != ' ')
-				continue;
-			wdt_period = simple_strtoul(q, &q, 0);
-			valid_wdt = 1;
-			++q;
-		}
-		wdt_enable = valid_wdt;
-	}
-#endif
+
+#ifdef CONFIG_BOOKE_WDT
+     {
+       extern void booke_wdt_setup_options(char *cmd_line);
+
+       booke_wdt_setup_options(cmd_line);
+     }
+#endif  /*  CONFIG_BOOKE_WDT  */

  	/* Initialize machine-dependent vectors */
