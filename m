Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id BDC3567A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 20:38:22 +1100 (EST)
Message-ID: <42282C7F.4010407@jp.fujitsu.com>
Date: Fri, 04 Mar 2005 18:38:07 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <4226FF62.30007@jp.fujitsu.com>	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>	<42272B69.8000303@ybb.ne.jp>
	<20050303101146.A8869@cox.net>
In-Reply-To: <20050303101146.A8869@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] WDT Driver for Book-E [1/2] Architecture specific part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt and Kurmar:

I performed name-cleanup in the driver.

Moreover, I tested this driver with PowerPC405GPr(Sycamore)
in addition to PowerPC440GP(ebony)/MPC8555(MPC8555-CDS).

This driver consist of two patches as follows:

1) Architecture specific part(booke_wdt-arch.patch)
This is the architecture specific part of the driver.
It contains WDT exception handlers
and kernel command line processing
routines.

2) Device driver part(booke_wdt-drv.patch)
This is the core of this WDT
driver.

At first, I post the architecture specific part with this mail.

Please apply.

Regards,

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>

--- linux-2.6.11/arch/ppc/kernel/head_44x.S	2005-03-04 17:12:42.944450424 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/kernel/head_44x.S	2005-03-04 13:21:31.000000000 +0900
@@ -444,8 +444,12 @@ interrupt_base:
  	EXCEPTION(0x1010, FixedIntervalTimer, UnknownException, EXC_XFER_EE)

  	/* Watchdog Timer Interrupt */
-	/* TODO: Add watchdog support */
+#if defined(CONFIG_BOOKE_WDT)
+	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, booke_wdt_exception)
+#else
  	CRITICAL_EXCEPTION(0x1020, WatchdogTimer, UnknownException)
+#endif  /*  CONFIG_BOOKE_WDT  */
+	

  	/* Data TLB Error Interrupt */
  	START_EXCEPTION(DataTLBError)
--- linux-2.6.11/arch/ppc/kernel/head_4xx.S	2005-03-04 17:16:48.089182760 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/kernel/head_4xx.S	2005-03-04 13:21:31.000000000 +0900
@@ -469,27 +469,23 @@ label:

  /* 0x1000 - Programmable Interval Timer (PIT) Exception */
  	START_EXCEPTION(0x1000, Decrementer)
-	NORMAL_EXCEPTION_PROLOG
-	lis	r0,TSR_PIS@h
-	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_LITE(0x1000, timer_interrupt)
-
+	b	DecrementerHandler
  #if 0
  /* NOTE:
- * FIT and WDT handlers are not implemented yet.
+ * FIT handler are not implemented yet.
   */

  /* 0x1010 - Fixed Interval Timer (FIT) Exception
  */
  	STND_EXCEPTION(0x1010,	FITException,		UnknownException)

-/* 0x1020 - Watchdog Timer (WDT) Exception
-*/
-
-	CRITICAL_EXCEPTION(0x1020, WDTException, UnknownException)
  #endif

+  /* 0x1020 - Watchdog Timer (WDT) Exception
+  */
+	START_EXCEPTION(0x1020, WDTException)
+	b	WatchDogHandler
+
  /* 0x1100 - Data TLB Miss Exception
   * As the name implies, translation is not in the MMU, so search the
   * page tables and fix it.  The only purpose of this function is to
@@ -771,6 +767,14 @@ label:
  		(MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
  		NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)

+
+DecrementerHandler:
+	NORMAL_EXCEPTION_PROLOG
+	lis	r0,TSR_PIS@h
+	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_LITE(0x1000, timer_interrupt)
+
  /*
   * The other Data TLB exceptions bail out to this point
   * if they can't resolve the lightweight TLB fault.
@@ -844,6 +848,19 @@ finish_tlb_load:
  	rfi			/* Should sync shadow TLBs */
  	b	.		/* prevent prefetch past rfi */

+/*
+ * WatchDog Exception
+ */
+WatchDogHandler:
+	CRITICAL_EXCEPTION_PROLOG;
+	addi	r3,r1,STACK_FRAME_OVERHEAD;
+#if defined(CONFIG_BOOKE_WDT)
+	EXC_XFER_TEMPLATE(booke_wdt_exception, 0x1022, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, 
crit_transfer_to_handler, ret_from_crit_exc)
+
+#else
+	EXC_XFER_TEMPLATE(UnknownException, 0x1022, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)),NOCOPY, 
crit_transfer_to_handler, ret_from_crit_exc)
+#endif  /*  CONFIG_BOOKE_WDT  */
+
  /* extern void giveup_fpu(struct task_struct *prev)
   *
   * The PowerPC 4xx family of processors do not have an FPU, so this just
--- linux-2.6.11/arch/ppc/kernel/head_e500.S	2005-03-04 17:15:36.641044528 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/kernel/head_e500.S	2005-03-04 13:21:31.000000000 +0900
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
--- linux-2.6.11/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-03-04 17:13:11.927044400 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-03-04 13:21:31.000000000 +0900
@@ -54,6 +54,7 @@

  #include <syslib/ppc85xx_setup.h>

+
  /* ************************************************************************
   *
   * Setup the architecture
@@ -187,6 +188,14 @@ platform_init(unsigned long r3, unsigned
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
--- linux-2.6.11/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-03-04 17:17:54.566076736 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-03-04 13:21:31.000000000 +0900
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
--- linux-2.6.11/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-04 17:16:27.056380232 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-03-04 
13:21:31.000000000 +0900
@@ -437,6 +437,14 @@ platform_init(unsigned long r3, unsigned
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
--- linux-2.6.11/arch/ppc/platforms/85xx/sbc8560.c	2005-03-04 17:17:22.985877656 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/sbc8560.c	2005-03-04 13:21:31.000000000 +0900
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
--- linux-2.6.11/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-04 17:14:12.883777568 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/platforms/85xx/stx_gp3.c	2005-03-04 13:21:31.000000000 +0900
@@ -68,6 +68,7 @@ unsigned long isa_mem_base = 0;
  unsigned long pci_dram_offset = 0;
  #endif

+
  /* Internal interrupts are all Level Sensitive, and Positive Polarity */
  static u8 gp3_openpic_initsenses[] __initdata = {
  	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
@@ -357,6 +358,14 @@ platform_init(unsigned long r3, unsigned
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
--- linux-2.6.11/arch/ppc/syslib/ppc4xx_setup.c	2005-03-04 17:10:56.867576560 +0900
+++ linux-2.6.11-booke-wdt/arch/ppc/syslib/ppc4xx_setup.c	2005-03-04 13:21:31.000000000 +0900
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

@@ -319,3 +307,5 @@ void platform_machine_check(struct pt_re
  #endif

  }
+
+
