Return-Path: <kato.takeharu@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 8EFAF67A85
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 00:21:10 +1100 (EST)
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by fgwmail8.fujitsu.co.jp (8.13.3/Fujitsu Gateway)
	id j1SDL7Jc020053 for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Feb 2005 22:21:08 +0900
	(envelope-from kato.takeharu@jp.fujitsu.com)
Message-ID: <42231A9C.2070909@jp.fujitsu.com>
Date: Mon, 28 Feb 2005 22:20:28 +0900
From: Takeharu KATO <kato.takeharu@jp.fujitsu.com>
MIME-Version: 1.0
References: <421CD2B3.4020805@ybb.ne.jp>
	<421CD669.1040002@ybb.ne.jp>	<20050223142720.C13087@cox.net>
	<421F7DF5.3000608@ybb.ne.jp>
In-Reply-To: <421F7DF5.3000608@ybb.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Dear Matt and all:

This is PowerPC e500 part.

Signed-off-by: Takeharu KATO <kato.takeharu@jp.fujitsu.com>

--- linux-2.6.11-rc5.orig/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-02-27 15:27:54.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-02-28 20:51:45.000000000 +0900
@@ -54,6 +54,7 @@

  #include <syslib/ppc85xx_setup.h>

+
  /* ************************************************************************
   *
   * Setup the architecture
@@ -187,6 +188,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_PPC4xx_WATCHDOG
+	{
+	  extern void ppc4xx_wdt_setup_options(char *cmd_line);
+
+	  ppc4xx_wdt_setup_options(cmd_line);
+	}
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
+
  	identify_ppc_sys_by_id(mfspr(SVR));

  	/* setup the PowerPC module struct */
--- linux-2.6.11-rc5.orig/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-02-27 15:31:26.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-02-28 20:51:45.000000000 +0900
@@ -197,6 +197,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_PPC4xx_WATCHDOG
+	{
+	  extern void ppc4xx_wdt_setup_options(char *cmd_line);
+
+	  ppc4xx_wdt_setup_options(cmd_line);
+	}
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
+
  	identify_ppc_sys_by_id(mfspr(SVR));

  	/* setup the PowerPC module struct */
--- linux-2.6.11-rc5.orig/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-27 15:30:26.000000000 
+0900
+++ linux-2.6.11-rc5/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-28 20:51:45.000000000 +0900
@@ -437,6 +437,14 @@ platform_init(unsigned long r3, unsigned
                  strcpy(cmd_line, (char *) (r6 + KERNELBASE));
          }

+#ifdef CONFIG_PPC4xx_WATCHDOG
+	{
+	  extern void ppc4xx_wdt_setup_options(char *cmd_line);
+
+	  ppc4xx_wdt_setup_options(cmd_line);
+	}
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
+
  	identify_ppc_sys_by_id(mfspr(SVR));

          /* setup the PowerPC module struct */
--- linux-2.6.11-rc5.orig/arch/ppc/platforms/85xx/sbc8560.c	2005-02-27 15:31:09.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/platforms/85xx/sbc8560.c	2005-02-28 20:51:45.000000000 +0900
@@ -198,6 +198,14 @@ platform_init(unsigned long r3, unsigned
  		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
  	}

+#ifdef CONFIG_PPC4xx_WATCHDOG
+	{
+	  extern void ppc4xx_wdt_setup_options(char *cmd_line);
+
+	  ppc4xx_wdt_setup_options(cmd_line);
+	}
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
+
  	identify_ppc_sys_by_id(mfspr(SVR));

  	/* setup the PowerPC module struct */
--- linux-2.6.11-rc5.orig/arch/ppc/platforms/85xx/stx_gp3.c	2005-02-27 15:28:44.000000000 +0900
+++ linux-2.6.11-rc5/arch/ppc/platforms/85xx/stx_gp3.c	2005-02-28 20:51:45.000000000 +0900
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

+#ifdef CONFIG_PPC4xx_WATCHDOG
+	{
+	  extern void ppc4xx_wdt_setup_options(char *cmd_line);
+
+	  ppc4xx_wdt_setup_options(cmd_line);
+	}
+#endif  /*  CONFIG_PPC4xx_WATCHDOG  */
+
  	identify_ppc_sys_by_id(mfspr(SVR));

  	/* setup the PowerPC module struct */
