Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 10A422BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 02:36:13 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 8 Oct 2004 12:36:11 -0400
Date: Fri, 8 Oct 2004 12:29:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0410081226320.24346@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [PATCH] further enhancements to micropatch.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


   - make distinct patches more modular
   - remove apparently redundant IIC/SPI relocation at bottom
   - comment out questionable verify_patch() function for now

 	Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>


===== arch/ppc/8xx_io/micropatch.c 1.3 vs edited =====
--- 1.3/arch/ppc/8xx_io/micropatch.c	2004-10-07 18:28:32 -04:00
+++ edited/arch/ppc/8xx_io/micropatch.c	2004-10-08 12:13:54 -04:00
@@ -621,15 +621,9 @@
  };
  #endif

-/* Load the microcode patch.  This is called early in the CPM initialization
- * with the controller in the reset state.  We enable the processor after
- * we load the patch.
- */
  void
-cpm_load_patch(volatile immap_t *immr)
-{
-#ifdef CONFIG_UCODE_PATCH
-	volatile uint		*dp;
+cpm_load_patch(volatile immap_t *immr) {
+	volatile uint		*dp;		/* Dual-ported RAM. */
  	volatile cpm8xx_t	*commproc;
  	volatile iic_t		*iip;
  	volatile spi_t		*spp;
@@ -638,23 +632,9 @@

  	commproc = (cpm8xx_t *)&immr->im_cpm;

-	/* We work closely with commproc.c.  We know it only allocates
-	 * from data only space.
-	 * For this particular patch, we only use the bottom 512 bytes
-	 * and the upper 256 byte extension.  We will use the space
-	 * starting at 1K for the relocated parameters, as the general
-	 * CPM allocation won't come from that area.
-	 */
+#ifdef CONFIG_USB_SOF_UCODE_PATCH
  	commproc->cp_rccr = 0;

-	/* Copy the patch into DPRAM.
-	 *
-	 * ADDENDUM:  I am somewhat nervous about the next few lines,
-	 * as they imply that *any* patch will *always* consist of at
-	 * least the patch_2000[] and patch_2f00[] arrays, and it's 
-	 * not clear to me that that's true.  More to come here as I
-	 * figure this out.
-	*/
  	dp = (uint *)(commproc->cp_dpmem);
  	for (i=0; i<(sizeof(patch_2000)/4); i++)
  		*dp++ = patch_2000[i];
@@ -663,17 +643,24 @@
  	for (i=0; i<(sizeof(patch_2f00)/4); i++)
  		*dp++ = patch_2f00[i];

-#ifdef CONFIG_USB_SOF_UCODE_PATCH
-
-	/* Enable uCode fetches from DPRAM. */
  	commproc->cp_rccr = 0x0009;

-	printk("USB uCode patch installed\n");
-#endif /* CONFIG_USB_SOF_PATCH */
+	printk("USB SOF microcode patch installed\n");
+#endif /* CONFIG_USB_SOF_UCODE_PATCH */

  #if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
      defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)

+	commproc->cp_rccr = 0;
+
+	dp = (uint *)(commproc->cp_dpmem);
+	for (i=0; i<(sizeof(patch_2000)/4); i++)
+		*dp++ = patch_2000[i];
+
+	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
+	for (i=0; i<(sizeof(patch_2f00)/4); i++)
+		*dp++ = patch_2f00[i];
+
  	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
  # define RPBASE 0x0500
  	iip->iic_rpbase = RPBASE;
@@ -684,63 +671,46 @@
  	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
  	spp->spi_rpbase = i;

+# if defined(CONFIG_I2C_SPI_UCODE_PATCH)
+	commproc->cp_cpmcr1 = 0x802a;
+	commproc->cp_cpmcr2 = 0x8028;
+	commproc->cp_cpmcr3 = 0x802e;
+	commproc->cp_cpmcr4 = 0x802c;
+	commproc->cp_rccr = 1;
+
+	printk("I2C/SPI microcode patch installed.\n");
+# endif /* CONFIG_I2C_SPI_UCODE_PATCH */
+
  # if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
+
  	dp = (uint *)&(commproc->cp_dpmem[0x0e00]);
  	for (i=0; i<(sizeof(patch_2e00)/4); i++)
  		*dp++ = patch_2e00[i];

-	/* Enable the traps to get to it.
-	*/
  	commproc->cp_cpmcr1 = 0x8080;
  	commproc->cp_cpmcr2 = 0x808a;
  	commproc->cp_cpmcr3 = 0x8028;
  	commproc->cp_cpmcr4 = 0x802a;
-
-	/* Enable uCode fetches from DPRAM.
-	*/
  	commproc->cp_rccr = 3;

  	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
  	smp->smc_rpbase = 0x1FC0;

-	printk("I2C/SPI/SMC1 ucode patch installed.\n");
+	printk("I2C/SPI/SMC1 microcode patch installed.\n");
  # endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */

-# if defined(CONFIG_I2C_SPI_UCODE_PATCH)
-	/* Enable the traps to get to it.
-	*/
-	commproc->cp_cpmcr1 = 0x802a;
-	commproc->cp_cpmcr2 = 0x8028;
-	commproc->cp_cpmcr3 = 0x802e;
-	commproc->cp_cpmcr4 = 0x802c;
-
-	/* Enable uCode fetches from DPRAM.
-	*/
-	commproc->cp_rccr = 1;
-
-	printk("I2C/SPI ucode patch installed.\n");
-# endif /* CONFIG_I2C_SPI_UCODE_PATCH */
-
-	/* Relocate the IIC and SPI parameter areas.  These have to
-	 * aligned on 32-byte boundaries.
-	 */
-	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-	iip->iic_rpbase = RPBASE;
-
-	/* Put SPI above the IIC, also 32-byte aligned.
-	*/
-	i = (RPBASE + sizeof(iic_t) + 31) & ~31;
-	spp = (spi_t *)&commproc->cp_dparam[PROFF_SPI];
-	spp->spi_rpbase = i;
-
-#endif
-#endif /* CONFIG_UCODE_PATCH */
+#endif /* some variation of the I2C/SPI patch was selected */
  }

+/*
+ *  Take this entire routine out, since no one calls it and its 
+ * logic is suspect.
+ */
+
+#if 0
  void
  verify_patch(volatile immap_t *immr)
  {
-#ifdef CONFIG_UCODE_PATCH
  	volatile uint		*dp;
  	volatile cpm8xx_t	*commproc;
  	int i;
@@ -769,5 +739,5 @@
  		}

  	commproc->cp_rccr = 0x0009;
-#endif /* CONFIG_UCODE_PATCH */
  }
+#endif
