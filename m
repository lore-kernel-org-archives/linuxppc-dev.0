Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 8546067A67
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 15:56:02 +1100 (EST)
Message-ID: <422E81AC.6010201@jp.fujitsu.com>
Date: Wed, 09 Mar 2005 13:55:08 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: ppcembed <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-2022-JP
Subject: [PATCH] WDT Driver for Book-E [1/2]  Architecture specific part.
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

I performed minor cleanups which Josh pointed out.
It has been fine-tuned that it suits current linux-2.6.11(linus-tree).
（These changes has been performed on architecture specific part.）.

I tested the driver on PowerPC440GP(ebony) again and I confirmed
that the driver work.

At first, I post the architecture specific part with this mail.

Please apply.

Regards,

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>

diff -Nupr linux-2.6.11/arch/ppc/kernel/head_44x.S linux-2.6.11-wdt/arch/ppc/kernel/head_44x.S
--- linux-2.6.11/arch/ppc/kernel/head_44x.S	2005-03-09 12:55:02.725778464 +0900
+++ linux-2.6.11-wdt/arch/ppc/kernel/head_44x.S	2005-03-09 13:07:38.355905224 +0900
@@ -444,8 +444,11 @@ interrupt_base:
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
diff -Nupr linux-2.6.11/arch/ppc/kernel/head_4xx.S linux-2.6.11-wdt/arch/ppc/kernel/head_4xx.S
--- linux-2.6.11/arch/ppc/kernel/head_4xx.S	2005-03-09 12:58:03.942229376 +0900
+++ linux-2.6.11-wdt/arch/ppc/kernel/head_4xx.S	2005-03-09 13:07:38.357904920 +0900
@@ -469,27 +469,24 @@ label:

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
@@ -771,6 +768,13 @@ label:
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
@@ -843,6 +847,19 @@ finish_tlb_load:
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
+	EXC_XFER_TEMPLATE(booke_wdt_exception, 0x1022, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+
+#else
+	EXC_XFER_TEMPLATE(UnknownException, 0x1022, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
+#endif  /*  CONFIG_BOOKE_WDT  */
+

 /* extern void giveup_fpu(struct task_struct *prev)
  *
diff -Nupr linux-2.6.11/arch/ppc/kernel/head_e500.S linux-2.6.11-wdt/arch/ppc/kernel/head_e500.S
--- linux-2.6.11/arch/ppc/kernel/head_e500.S	2005-03-09 12:57:14.058812808 +0900
+++ linux-2.6.11-wdt/arch/ppc/kernel/head_e500.S	2005-03-09 13:07:38.357904920 +0900
@@ -494,8 +494,11 @@ interrupt_base:
 	EXCEPTION(0x3100, FixedIntervalTimer, UnknownException, EXC_XFER_EE)

 	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
+#if defined(CONFIG_BOOKE_WDT)
+	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, booke_wdt_exception)
+#else
 	CRITICAL_EXCEPTION(0x3200, WatchdogTimer, UnknownException)
+#endif  /*  CONFIG_BOOKE_WDT  */

 	/* Data TLB Error Interrupt */
 	START_EXCEPTION(DataTLBError)
diff -Nupr linux-2.6.11/arch/ppc/kernel/time.c linux-2.6.11-wdt/arch/ppc/kernel/time.c
diff -Nupr linux-2.6.11/arch/ppc/platforms/85xx/mpc8540_ads.c linux-2.6.11-wdt/arch/ppc/platforms/85xx/mpc8540_ads.c
--- linux-2.6.11/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-03-09 12:55:23.468625072 +0900
+++ linux-2.6.11-wdt/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-03-09 13:07:38.358904768 +0900
@@ -187,6 +187,14 @@ platform_init(unsigned long r3, unsigned
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
 	identify_ppc_sys_by_id(mfspr(SVR));

 	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.11/arch/ppc/platforms/85xx/mpc8560_ads.c linux-2.6.11-wdt/arch/ppc/platforms/85xx/mpc8560_ads.c
--- linux-2.6.11/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-03-09 12:59:02.157379328 +0900
+++ linux-2.6.11-wdt/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-03-09 13:07:38.358904768 +0900
@@ -197,6 +197,14 @@ platform_init(unsigned long r3, unsigned
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
 	identify_ppc_sys_by_id(mfspr(SVR));

 	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.11/arch/ppc/platforms/85xx/mpc85xx_cds_common.c linux-2.6.11-wdt/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- linux-2.6.11/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-09 12:57:51.908058848 +0900
+++ linux-2.6.11-wdt/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-09 13:07:38.359904616 +0900
@@ -448,6 +448,14 @@ platform_init(unsigned long r3, unsigned
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
 	identify_ppc_sys_by_id(mfspr(SVR));

 	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.11/arch/ppc/platforms/85xx/mpc85xx_cds_common.c.orig linux-2.6.11-wdt/arch/ppc/platforms/85xx/mpc85xx_cds_common.c.orig
diff -Nupr linux-2.6.11/arch/ppc/platforms/85xx/sbc8560.c linux-2.6.11-wdt/arch/ppc/platforms/85xx/sbc8560.c
--- linux-2.6.11/arch/ppc/platforms/85xx/sbc8560.c	2005-03-09 12:58:37.742091016 +0900
+++ linux-2.6.11-wdt/arch/ppc/platforms/85xx/sbc8560.c	2005-03-09 13:07:38.360904464 +0900
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
 	identify_ppc_sys_by_id(mfspr(SVR));

 	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.11/arch/ppc/platforms/85xx/stx_gp3.c linux-2.6.11-wdt/arch/ppc/platforms/85xx/stx_gp3.c
--- linux-2.6.11/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-09 12:56:20.477958336 +0900
+++ linux-2.6.11-wdt/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-09 13:07:38.361904312 +0900
@@ -349,6 +349,14 @@ platform_init(unsigned long r3, unsigned
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
 	identify_ppc_sys_by_id(mfspr(SVR));

 	/* setup the PowerPC module struct */
diff -Nupr linux-2.6.11/arch/ppc/platforms/85xx/stx_gp3.c.orig linux-2.6.11-wdt/arch/ppc/platforms/85xx/stx_gp3.c.orig
diff -Nupr linux-2.6.11/arch/ppc/syslib/open_pic.c linux-2.6.11-wdt/arch/ppc/syslib/open_pic.c
diff -Nupr linux-2.6.11/arch/ppc/syslib/ppc4xx_setup.c linux-2.6.11-wdt/arch/ppc/syslib/ppc4xx_setup.c
--- linux-2.6.11/arch/ppc/syslib/ppc4xx_setup.c	2005-03-09 12:54:06.589312504 +0900
+++ linux-2.6.11-wdt/arch/ppc/syslib/ppc4xx_setup.c	2005-03-09 13:07:38.361904312 +0900
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
