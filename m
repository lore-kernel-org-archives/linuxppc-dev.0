Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 7645E2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Sep 2004 23:17:57 +1000 (EST)
Received: from [10.1.1.107] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 25 Sep 2004 08:56:18 -0400
Date: Sat, 25 Sep 2004 08:49:53 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0409250834090.3738@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [PATCH] to support choice of 8xx microcode patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   yes, this is a *full* and apparently working source code patch that 
applies cleanly against the latest "bk pull" of linuxppc-2.5.  the 
changes should be obvious.  there's still a lot of cruft in these 
files i'd dearly like to get rid of, but i wanted to keep the changes 
to a minimum for now.

   feedback welcome.  patch is the result of running:

   $ bk -r diffs -u

at the top of the source tree.

rday




===== arch/ppc/8xx_io/Kconfig 1.4 vs edited =====
--- 1.4/arch/ppc/8xx_io/Kconfig	2004-05-27 18:37:33 -04:00
+++ edited/arch/ppc/8xx_io/Kconfig	2004-09-25 06:40:34 -04:00
@@ -140,13 +140,28 @@

  	  If in doubt, say N here.

-config UCODE_PATCH
-	bool "I2C/SPI Microcode Patch"
-	help
-	  Motorola releases microcode updates for their 8xx CPM modules.  The
-	  microcode update file has updates for IIC, SMC and USB.  Currently only
-	  the USB update is available by default, if the MPC8xx USB option is
-	  enabled.  If in doubt, say 'N' here.
+choice
+	prompt "Microcode patches"
+	default NO_UCODE_PATCH
+
+config	NO_UCODE_PATCH
+	bool "None"
+
+config	IIC_SPI_UCODE_PATCH
+	bool "IIC/SPI relocation patch"
+
+config	IIC_SPI_SMC1_UCODE_PATCH
+	bool "IIC/SPI/SMC1 relocation patch"
+
+config	USB_SOF_UCODE_PATCH
+	bool "USB/SOF relocation patch"
+
+endchoice
+
+config	UCODE_PATCH
+	bool
+	depends on !NO_UCODE_PATCH
+	default y

  endmenu

===== arch/ppc/8xx_io/commproc.c 1.16 vs edited =====
--- 1.16/arch/ppc/8xx_io/commproc.c	2004-07-15 19:49:03 -04:00
+++ edited/arch/ppc/8xx_io/commproc.c	2004-09-25 08:05:14 -04:00
@@ -114,6 +114,7 @@
  	commproc = (cpm8xx_t *)&imp->im_cpm;

  #ifdef CONFIG_UCODE_PATCH
+# warning "commproc.c: Processing a microcode patch by doing a reset."
  	/* Perform a reset.
  	*/
  	commproc->cp_cpcr = (CPM_CR_RST | CPM_CR_FLG);
===== arch/ppc/8xx_io/micropatch.c 1.2 vs edited =====
--- 1.2/arch/ppc/8xx_io/micropatch.c	2002-02-05 02:55:41 -05:00
+++ edited/arch/ppc/8xx_io/micropatch.c	2004-09-25 08:12:57 -04:00
@@ -19,18 +19,11 @@
  #include <asm/8xx_immap.h>
  #include <asm/commproc.h>

-/* Define this to get SMC patches as well.  You need to modify the uart
- * driver as well......
-#define USE_SMC_PATCH 1
+/*
+ * IIC/SPI relocation.
   */

-#ifdef CONFIG_USB_MPC8xx
-#define USE_USB_SOF_PATCH
-#endif
-
-#ifdef USE_IIC_PATCH
-#define PATCH_DEFINED
-	/* IIC/SPI */
+#ifdef CONFIG_IIC_SPI_UCODE_PATCH
  uint patch_2000[] = {
  	0x7FFFEFD9,
  	0x3FFD0000,
@@ -183,10 +176,12 @@
  };
  #endif

-#ifdef USE_SMC_PATCH
-#define PATCH_DEFINED
-/* SMC2/IIC/SPI Patch */
-/* This is the area from 0x2000 to 0x23ff.
+/*
+ *  IIC/SPI/SMC1 relocation.
+ */
+
+#ifdef CONFIG_IIC_SPI_SMC1_UCODE_PATCH
+/* This is the area from 0x2000 to 0x24ff.
  */
  uint patch_2000[] = {
  	0x3fff0000,
@@ -602,8 +597,7 @@
  };
  #endif

-#ifdef USE_USB_SOF_PATCH
-#define PATCH_DEFINED
+#ifdef CONFIG_USB_SOF_UCODE_PATCH
  uint patch_2000[] = {
  	0x7fff0000,
  	0x7ffd0000,
@@ -630,14 +624,35 @@
   * with the controller in the reset state.  We enable the processor after
   * we load the patch.
   */
+
+#ifndef CONFIG_UCODE_PATCH
+
+/*
+ *  Um ... why are we defining null patch functions here when this
+ * file won't even be included in the build process unless a patch
+ * is selected?  Seems kind of redundant.
+ */
+
+void
+cpm_load_patch(volatile immap_t *immr)
+{ }
+
+void
+verify_patch(volatile immap_t *immr)
+{ }
+
+#else	/* we have a patch, get to work. */
+
+# warning "micropatch.c: Defining cpm_load_patch() and verify_patch()."
+
  void
  cpm_load_patch(volatile immap_t *immr)
  {
-#ifdef PATCH_DEFINED
  	volatile uint		*dp;
  	volatile cpm8xx_t	*commproc;
  	volatile iic_t		*iip;
  	volatile spi_t		*spp;
+	volatile smc_uart_t	*smp;	/* new for SMC1 relocation */
  	int	i;

  	commproc = (cpm8xx_t *)&immr->im_cpm;
@@ -653,6 +668,17 @@

  	/* Copy the patch into DPRAM.
  	*/
+
+	/*
+	 *   I'm nervous about the assumption that *every* potential 
+	 * patch will always incorporate a patch_2000[] and patch_2f00[]
+	 * array.  It's entirely possible that a patch might include,
+	 * instead, patch_2000[] and patch_2e00[] instead.  I'd be happier
+	 * to see this code spread out across the different choices, with
+	 * each patch choice looking after just its own arrays.  But
+	 * I'll leave this alone for now.
+	 */
+
  	dp = (uint *)(commproc->cp_dpmem);
  	for (i=0; i<(sizeof(patch_2000)/4); i++)
  		*dp++ = patch_2000[i];
@@ -661,29 +687,26 @@
  	for (i=0; i<(sizeof(patch_2f00)/4); i++)
  		*dp++ = patch_2f00[i];

-#ifdef USE_USB_SOF_PATCH
-#if 0 /* usb patch should not relocate iic */
-	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-#define RPBASE 0x0030
-	iip->iic_rpbase = RPBASE;
-
-	/* Put SPI above the IIC, also 32-byte aligned.
-	*/
-	i = (RPBASE + sizeof(iic_t) + 31) & ~31;
-	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
-	spp->spi_rpbase = i;
-#endif
+#ifdef CONFIG_USB_SOF_UCODE_PATCH

  	/* Enable uCode fetches from DPRAM. */
  	commproc->cp_rccr = 0x0009;

  	printk("USB uCode patch installed\n");
-#endif /* USE_USB_SOF_PATCH */

-#if defined(USE_SMC_PATCH) || defined(USE_IIC_PATCH)
+#endif /* CONFIG_USB_SOF_UCODE_PATCH */
+
+#if 	defined(CONFIG_IIC_SPI_UCODE_PATCH) || \
+	defined(CONFIG_IIC_SPI_SMC1_UCODE_PATCH)

  	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-#define RPBASE 0x0400
+
+# if	defined(CONFIG_IIC_SPI_SMC1_UCODE_PATCH)
+# define RPBASE 0x0500	/* SMC1 relocation patch is 1280 bytes long. */
+# else
+# define RPBASE 0x0400
+# endif
+
  	iip->iic_rpbase = RPBASE;

  	/* Put SPI above the IIC, also 32-byte aligned.
@@ -692,7 +715,7 @@
  	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
  	spp->spi_rpbase = i;

-#ifdef USE_SMC_PATCH
+# ifdef CONFIG_IIC_SPI_SMC1_UCODE_PATCH
  	dp = (uint *)&(commproc->cp_dpmem[0x0e00]);
  	for (i=0; i<(sizeof(patch_2e00)/4); i++)
  		*dp++ = patch_2e00[i];
@@ -707,9 +730,15 @@
  	/* Enable uCode fetches from DPRAM.
  	*/
  	commproc->cp_rccr = 3;
-#endif

-#ifdef USE_IIC_PATCH
+	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
+	smp->smc_rpbase = 0x1FC0;
+
+	printk("SMC1 relocated to 0x%x\n", smp->smc_rpbase);
+
+# endif
+
+# ifdef CONFIG_IIC_SPI_UCODE_PATCH
  	/* Enable the traps to get to it.
  	*/
  	commproc->cp_cpmcr1 = 0x802a;
@@ -722,7 +751,7 @@
  	commproc->cp_rccr = 1;

  	printk("I2C uCode patch installed\n");
-#endif
+# endif

  	/* Relocate the IIC and SPI parameter areas.  These have to
  	 * aligned on 32-byte boundaries.
@@ -736,14 +765,12 @@
  	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
  	spp->spi_rpbase = i;

-#endif /* USE_SMC_PATCH || USE_IIC_PATCH */
-#endif /* PATCH_DEFINED */
+#endif /* IIC/SPI or IIC/SPI/SMC1 relocation patch. */
  }

  void
  verify_patch(volatile immap_t *immr)
  {
-#ifdef PATCH_DEFINED
  	volatile uint		*dp;
  	volatile cpm8xx_t	*commproc;
  	int i;
@@ -772,6 +799,5 @@
  		}

  	commproc->cp_rccr = 0x0009;
-#endif /* PATCH_DEFINED */
  }
-
+#endif /* CONFIG_UCODE_PATCH */
===== drivers/serial/cpm_uart/cpm_uart_core.c 1.5 vs edited =====
--- 1.5/drivers/serial/cpm_uart/cpm_uart_core.c	2004-07-15 19:29:21 -04:00
+++ edited/drivers/serial/cpm_uart/cpm_uart_core.c	2004-09-25 08:04:08 -04:00
@@ -743,6 +743,21 @@
  	pinfo->smcup->smc_rbase = (u_char *)pinfo->rx_bd_base - DPRAM_BASE;
  	pinfo->smcup->smc_tbase = (u_char *)pinfo->tx_bd_base - DPRAM_BASE;

+/*
+ *  Apparently, include the following for ANY patch that is relocating SMC1.
+ */
+
+#if defined(CONFIG_IIC_SPI_SMC1_UCODE_PATCH)
+# warning "cpm_uart_core.c: Processing IIC/SPI/SMC1 ucode patch."
+
+	up->smc_rbptr = pinfo->smcup->smc_rbase;
+	up->smc_tbptr = pinfo->smcup->smc_tbase;
+	up->smc_rstate = 0;
+	up->smc_tstate = 0;
+	up->smc_brkcr = 1;              /* number of break chars */
+	up->smc_brkec = 0;
+#endif
+
  	/* Set up the uart parameters in the
  	 * parameter ram.
  	 */
===== drivers/serial/cpm_uart/cpm_uart_cpm1.c 1.5 vs edited =====
--- 1.5/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2004-07-19 12:47:25 -04:00
+++ edited/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2004-09-25 07:05:55 -04:00
@@ -194,8 +194,20 @@
  	cpm_uart_nr = 0;
  #ifdef CONFIG_SERIAL_CPM_SMC1
  	cpm_uart_ports[UART_SMC1].smcp = &cpmp->cp_smc[0];
+
+	/*
+	 *  Make the following change for any patch that relocates SMC1.
+	 */
+
+# if defined(CONFIG_IIC_SPI_SMC1_UCODE_PATCH)
+#  warning "cpm_uart_cpm1.c: Processing I2C/SPI/SMC1 ucode patch."
+	cpm_uart_ports[UART_SMC1].smcup =
+	    (smc_uart_t *) & cpmp->cp_dparam[0x3C0];  /* new address */
+# else
  	cpm_uart_ports[UART_SMC1].smcup =
  	    (smc_uart_t *) & cpmp->cp_dparam[PROFF_SMC1];
+# endif
+
  	cpm_uart_ports[UART_SMC1].port.mapbase =
  	    (unsigned long)&cpmp->cp_smc[0];
  	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
===== include/asm-ppc/commproc.h 1.14 vs edited =====
--- 1.14/include/asm-ppc/commproc.h	2004-07-15 19:49:03 -04:00
+++ edited/include/asm-ppc/commproc.h	2004-09-25 06:26:10 -04:00
@@ -145,6 +145,8 @@
  	ushort	smc_brkec;	/* rcv'd break condition counter */
  	ushort	smc_brkcr;	/* xmt break count register */
  	ushort	smc_rmask;	/* Temporary bit mask */
+	char	res1[8];	/* Reserved */
+	ushort	smc_rpbase;	/* Relocation pointer */
  } smc_uart_t;

  /* Function code bits.
