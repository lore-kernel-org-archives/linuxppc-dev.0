Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id EE63E2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 23:22:45 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 6 Oct 2004 09:22:41 -0400
Date: Wed, 6 Oct 2004 09:15:56 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0410060908520.8324@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [PATCH] 2.6.9(?) kernel, replacing ucode patch infrastructure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   ok, one more time, here's a patch that should apply cleanly to the 
latest bk repo for linuxppc-2.5.  the purpose is to create a cleaner 
and more extensible microcode patch infrastructure, so that all you 
need to do is *select* the 8xx-relevant patch you want from the config 
menu under "MPC8xx" options.

   NOTE.  Really.  NOTE:  There's a *lot* more cleanup that I'm going 
to add on top of *this* patch.  There's redundant code that's still 
there, there's mystery code, there's more patches that can be added to 
the choice menu and so on.  But I would prefer to have *this* patch 
applied first.  As it stands, it's been tested with just relocating 
SMC1, and also with relocating SMC1 while allocating SCC3 to ethernet. 
Both appear to work fine.

   Also, this patch should make *no* difference to anyone who's not 
selecting a ucode patch.  In that sense, it should be safe.  In short, 
don't criticize niggling details in what follows; all of that will be 
cleaned up in short order.  This just provides what I think is the 
bare minimum to get the infrastructure in place.


 	Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>


===== arch/ppc/8xx_io/Kconfig 1.4 vs edited =====
--- 1.4/arch/ppc/8xx_io/Kconfig	2004-05-27 18:37:33 -04:00
+++ edited/arch/ppc/8xx_io/Kconfig	2004-10-06 08:44:22 -04:00
@@ -140,13 +140,36 @@ config 8xx_CPU6

  	  If in doubt, say N here.

-config UCODE_PATCH
-	bool "I2C/SPI Microcode Patch"
+choice
+	prompt "Microcode patch selection"
+	default NO_UCODE_PATCH
+	help
+	  Help not implemented yet, coming soon.
+
+config NO_UCODE_PATCH
+	bool "None"
+
+config USB_SOF_UCODE_PATCH
+	bool "USB SOF patch"
+	help
+	  Help not implemented yet, coming soon.
+
+config I2C_SPI_UCODE_PATCH
+	bool "I2C/SPI relocation patch"
  	help
-	  Motorola releases microcode updates for their 8xx CPM modules.  The
-	  microcode update file has updates for IIC, SMC and USB.  Currently only
-	  the USB update is available by default, if the MPC8xx USB option is
-	  enabled.  If in doubt, say 'N' here.
+	  Help not implemented yet, coming soon.
+
+config I2C_SPI_SMC1_UCODE_PATCH
+	bool "I2C/SPI/SMC1 relocation patch"
+	help
+	  Help not implemented yet, coming soon.
+
+endchoice
+
+config UCODE_PATCH
+	bool
+	default y
+	depends on !NO_UCODE_PATCH

  endmenu

===== arch/ppc/8xx_io/micropatch.c 1.2 vs edited =====
--- 1.2/arch/ppc/8xx_io/micropatch.c	2002-02-05 02:55:41 -05:00
+++ edited/arch/ppc/8xx_io/micropatch.c	2004-10-06 08:41:43 -04:00
@@ -19,18 +19,12 @@
  #include <asm/8xx_immap.h>
  #include <asm/commproc.h>

-/* Define this to get SMC patches as well.  You need to modify the uart
- * driver as well......
-#define USE_SMC_PATCH 1
+/*
+ * I2C/SPI relocation patch arrays.
   */

-#ifdef CONFIG_USB_MPC8xx
-#define USE_USB_SOF_PATCH
-#endif
+#ifdef CONFIG_I2C_SPI_UCODE_PATCH

-#ifdef USE_IIC_PATCH
-#define PATCH_DEFINED
-	/* IIC/SPI */
  uint patch_2000[] = {
  	0x7FFFEFD9,
  	0x3FFD0000,
@@ -183,11 +177,12 @@ uint patch_2f00[] = {
  };
  #endif

-#ifdef USE_SMC_PATCH
-#define PATCH_DEFINED
-/* SMC2/IIC/SPI Patch */
-/* This is the area from 0x2000 to 0x23ff.
-*/
+/*
+ * I2C/SPI/SMC1 relocation patch arrays.
+ */
+
+#ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
+
  uint patch_2000[] = {
  	0x3fff0000,
  	0x3ffd0000,
@@ -511,8 +506,6 @@ uint patch_2000[] = {
  	0x6079e2bb
  };

-	/* This is from 0x2f00 to 0x2fff
-	*/
  uint patch_2f00[] = {
  	0x30303030,
  	0x3e3e3434,
@@ -581,8 +574,6 @@ uint patch_2f00[] = {
  };

  uint patch_2e00[] = {
-	/* This is from 0x2e00 to 0x2e3c
-	*/
  	0x27eeeeee,
  	0xeeeeeeee,
  	0xeeeeeeee,
@@ -602,8 +593,12 @@ uint patch_2e00[] = {
  };
  #endif

-#ifdef USE_USB_SOF_PATCH
-#define PATCH_DEFINED
+/*
+ *  USB SOF patch arrays.
+ */
+
+#ifdef CONFIG_USB_SOF_UCODE_PATCH
+
  uint patch_2000[] = {
  	0x7fff0000,
  	0x7ffd0000,
@@ -633,11 +628,12 @@ uint patch_2f00[] = {
  void
  cpm_load_patch(volatile immap_t *immr)
  {
-#ifdef PATCH_DEFINED
+#ifdef CONFIG_UCODE_PATCH
  	volatile uint		*dp;
  	volatile cpm8xx_t	*commproc;
  	volatile iic_t		*iip;
  	volatile spi_t		*spp;
+	volatile smc_uart_t	*smp;
  	int	i;

  	commproc = (cpm8xx_t *)&immr->im_cpm;
@@ -652,6 +648,12 @@ cpm_load_patch(volatile immap_t *immr)
  	commproc->cp_rccr = 0;

  	/* Copy the patch into DPRAM.
+	 *
+	 * ADDENDUM:  I am somewhat nervous about the next few lines,
+	 * as they imply that *any* patch will *always* consist of at
+	 * least the patch_2000[] and patch_2f00[] arrays, and it's 
+	 * not clear to me that that's true.  More to come here as I
+	 * figure this out.
  	*/
  	dp = (uint *)(commproc->cp_dpmem);
  	for (i=0; i<(sizeof(patch_2000)/4); i++)
@@ -661,29 +663,19 @@ cpm_load_patch(volatile immap_t *immr)
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
+#endif /* CONFIG_USB_SOF_PATCH */

-#if defined(USE_SMC_PATCH) || defined(USE_IIC_PATCH)
+#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
+    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)

  	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-#define RPBASE 0x0400
+# define RPBASE 0x0500
  	iip->iic_rpbase = RPBASE;

  	/* Put SPI above the IIC, also 32-byte aligned.
@@ -692,7 +684,7 @@ cpm_load_patch(volatile immap_t *immr)
  	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
  	spp->spi_rpbase = i;

-#ifdef USE_SMC_PATCH
+# if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
  	dp = (uint *)&(commproc->cp_dpmem[0x0e00]);
  	for (i=0; i<(sizeof(patch_2e00)/4); i++)
  		*dp++ = patch_2e00[i];
@@ -707,9 +699,14 @@ cpm_load_patch(volatile immap_t *immr)
  	/* Enable uCode fetches from DPRAM.
  	*/
  	commproc->cp_rccr = 3;
-#endif

-#ifdef USE_IIC_PATCH
+	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
+	smp->smc_rpbase = 0x1FC0;
+
+	printk("I2C/SPI/SMC1 ucode patch installed.\n");
+# endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */
+
+# if defined(CONFIG_I2C_SPI_UCODE_PATCH)
  	/* Enable the traps to get to it.
  	*/
  	commproc->cp_cpmcr1 = 0x802a;
@@ -721,8 +718,8 @@ cpm_load_patch(volatile immap_t *immr)
  	*/
  	commproc->cp_rccr = 1;

-	printk("I2C uCode patch installed\n");
-#endif
+	printk("I2C/SPI ucode patch installed.\n");
+# endif /* CONFIG_I2C_SPI_UCODE_PATCH */

  	/* Relocate the IIC and SPI parameter areas.  These have to
  	 * aligned on 32-byte boundaries.
@@ -736,14 +733,14 @@ cpm_load_patch(volatile immap_t *immr)
  	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
  	spp->spi_rpbase = i;

-#endif /* USE_SMC_PATCH || USE_IIC_PATCH */
-#endif /* PATCH_DEFINED */
+#endif
+#endif /* CONFIG_UCODE_PATCH */
  }

  void
  verify_patch(volatile immap_t *immr)
  {
-#ifdef PATCH_DEFINED
+#ifdef CONFIG_UCODE_PATCH
  	volatile uint		*dp;
  	volatile cpm8xx_t	*commproc;
  	int i;
@@ -772,6 +769,5 @@ verify_patch(volatile immap_t *immr)
  		}

  	commproc->cp_rccr = 0x0009;
-#endif /* PATCH_DEFINED */
+#endif /* CONFIG_UCODE_PATCH */
  }
-
===== drivers/serial/cpm_uart/cpm_uart_core.c 1.5 vs edited =====
--- 1.5/drivers/serial/cpm_uart/cpm_uart_core.c	2004-07-15 19:29:21 -04:00
+++ edited/drivers/serial/cpm_uart/cpm_uart_core.c	2004-10-06 08:50:03 -04:00
@@ -743,6 +743,19 @@ static void cpm_uart_init_smc(struct uar
  	pinfo->smcup->smc_rbase = (u_char *)pinfo->rx_bd_base - DPRAM_BASE;
  	pinfo->smcup->smc_tbase = (u_char *)pinfo->tx_bd_base - DPRAM_BASE;

+/*
+ *  In case SMC1 is being relocated...
+ */
+#if defined (CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
+	up->smc_rbptr = pinfo->smcup->smc_rbase;
+	up->smc_tbptr = pinfo->smcup->smc_tbase;
+	up->smc_rstate = 0;
+	up->smc_tstate = 0;
+	up->smc_brkcr = 1;              /* number of break chars */
+	up->smc_brkec = 0;
+#endif
+
+
  	/* Set up the uart parameters in the
  	 * parameter ram.
  	 */
===== drivers/serial/cpm_uart/cpm_uart_cpm1.c 1.5 vs edited =====
--- 1.5/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2004-07-19 12:47:25 -04:00
+++ edited/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2004-10-06 08:50:16 -04:00
@@ -194,8 +194,16 @@ int cpm_uart_init_portdesc(void)
  	cpm_uart_nr = 0;
  #ifdef CONFIG_SERIAL_CPM_SMC1
  	cpm_uart_ports[UART_SMC1].smcp = &cpmp->cp_smc[0];
+/*
+ *  Is SMC1 being relocated?
+ */
+# ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
+	cpm_uart_ports[UART_SMC1].smcup =
+	    (smc_uart_t *) & cpmp->cp_dparam[0x3C0];
+# else
  	cpm_uart_ports[UART_SMC1].smcup =
  	    (smc_uart_t *) & cpmp->cp_dparam[PROFF_SMC1];
+# endif
  	cpm_uart_ports[UART_SMC1].port.mapbase =
  	    (unsigned long)&cpmp->cp_smc[0];
  	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
===== include/asm-ppc/commproc.h 1.14 vs edited =====
--- 1.14/include/asm-ppc/commproc.h	2004-07-15 19:49:03 -04:00
+++ edited/include/asm-ppc/commproc.h	2004-10-06 07:48:03 -04:00
@@ -145,6 +145,8 @@ typedef struct smc_uart {
  	ushort	smc_brkec;	/* rcv'd break condition counter */
  	ushort	smc_brkcr;	/* xmt break count register */
  	ushort	smc_rmask;	/* Temporary bit mask */
+	char	smc_res1[8];	/* Reserved: 0x34..0x3b */
+	ushort	smc_rpbase;	/* Relocation pointer */
  } smc_uart_t;

  /* Function code bits.
