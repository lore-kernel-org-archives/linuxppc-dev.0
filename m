Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 2FD4C67A80
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Feb 2005 02:07:26 +1100 (EST)
Date: Mon, 31 Jan 2005 08:07:23 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050131080723.A24772@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cwernham@airspan.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] PPC4xx DMA fixes, burst, and sg improvements
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This fixes several issues with the PPC4xx DMA library as well as
adding support for bursting and some improvements to SG handling.

Signed-off-by: Colin Wernham <cwernham@airspan.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/syslib/ppc4xx_dma.c 1.10 vs edited =====
--- 1.10/arch/ppc/syslib/ppc4xx_dma.c	2005-01-07 22:44:28 -07:00
+++ edited/arch/ppc/syslib/ppc4xx_dma.c	2005-01-31 07:48:12 -07:00
@@ -512,6 +512,8 @@
 		return DMA_STATUS_BAD_CHANNEL;
 	}
 
+	memcpy(p_dma_ch, &dma_channels[dmanr], sizeof (ppc_dma_ch_t));
+ 
 #if DCRN_POL > 0
 	polarity = mfdcr(DCRN_POL);
 #else
@@ -604,6 +606,84 @@
 	return (GET_DMA_PW(control));
 }
 
+/*
+ * Clears the channel status bits
+ */
+int 
+ppc4xx_clr_dma_status(unsigned int dmanr)
+{
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk(KERN_ERR "ppc4xx_clr_dma_status: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+	mtdcr(DCRN_DMASR, ((u32)DMA_CH0_ERR | (u32)DMA_CS0 | (u32)DMA_TS0) >> dmanr);
+	return DMA_STATUS_GOOD;
+}
+
+/*
+ * Enables the burst on the channel (BTEN bit in the control/count register)
+ * Note:
+ * For scatter/gather dma, this function MUST be called before the 
+ * ppc4xx_alloc_dma_handle() func as the chan count register is copied into the
+ * sgl list and used as each sgl element is added.
+ */
+int
+ppc4xx_enable_burst(unsigned int dmanr)
+{
+	unsigned int ctc;
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk(KERN_ERR "ppc4xx_enable_burst: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+        ctc = mfdcr(DCRN_DMACT0 + (dmanr * 0x8)) | DMA_CTC_BTEN;
+	mtdcr(DCRN_DMACT0 + (dmanr * 0x8), ctc);
+	return DMA_STATUS_GOOD;
+}
+/*
+ * Disables the burst on the channel (BTEN bit in the control/count register)
+ * Note:
+ * For scatter/gather dma, this function MUST be called before the 
+ * ppc4xx_alloc_dma_handle() func as the chan count register is copied into the
+ * sgl list and used as each sgl element is added.
+ */
+int 
+ppc4xx_disable_burst(unsigned int dmanr)
+{
+	unsigned int ctc;
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk(KERN_ERR "ppc4xx_disable_burst: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+	ctc = mfdcr(DCRN_DMACT0 + (dmanr * 0x8)) &~ DMA_CTC_BTEN;
+	mtdcr(DCRN_DMACT0 + (dmanr * 0x8), ctc);
+	return DMA_STATUS_GOOD;
+}
+/*
+ * Sets the burst size (number of peripheral widths) for the channel 
+ * (BSIZ bits in the control/count register))
+ * must be one of:
+ *    DMA_CTC_BSIZ_2
+ *    DMA_CTC_BSIZ_4
+ *    DMA_CTC_BSIZ_8
+ *    DMA_CTC_BSIZ_16
+ * Note:
+ * For scatter/gather dma, this function MUST be called before the 
+ * ppc4xx_alloc_dma_handle() func as the chan count register is copied into the
+ * sgl list and used as each sgl element is added.
+ */
+int 
+ppc4xx_set_burst_size(unsigned int dmanr, unsigned int bsize)
+{
+	unsigned int ctc;
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk(KERN_ERR "ppc4xx_set_burst_size: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+	ctc = mfdcr(DCRN_DMACT0 + (dmanr * 0x8)) &~ DMA_CTC_BSIZ_MSK;
+	ctc |= (bsize & DMA_CTC_BSIZ_MSK);
+	mtdcr(DCRN_DMACT0 + (dmanr * 0x8), ctc);
+	return DMA_STATUS_GOOD;
+}
 
 EXPORT_SYMBOL(ppc4xx_init_dma_channel);
 EXPORT_SYMBOL(ppc4xx_get_channel_config);
@@ -622,3 +702,7 @@
 EXPORT_SYMBOL(ppc4xx_enable_dma_interrupt);
 EXPORT_SYMBOL(ppc4xx_disable_dma_interrupt);
 EXPORT_SYMBOL(ppc4xx_get_dma_status);
+EXPORT_SYMBOL(ppc4xx_clr_dma_status);
+EXPORT_SYMBOL(ppc4xx_enable_burst);
+EXPORT_SYMBOL(ppc4xx_disable_burst);
+EXPORT_SYMBOL(ppc4xx_set_burst_size);
===== arch/ppc/syslib/ppc4xx_sgdma.c 1.1 vs edited =====
--- 1.1/arch/ppc/syslib/ppc4xx_sgdma.c	2004-08-07 15:02:29 -07:00
+++ edited/arch/ppc/syslib/ppc4xx_sgdma.c	2005-01-31 07:48:17 -07:00
@@ -120,6 +120,12 @@
 		psgl->ptail = psgl->phead;
 		psgl->ptail_dma = psgl->phead_dma;
 	} else {
+		if(p_dma_ch->int_on_final_sg) {
+			/* mask out all dma interrupts, except error, on tail 
+			before adding new tail. */
+			psgl->ptail->control_count &=
+				~(SG_TCI_ENABLE | SG_ETI_ENABLE);
+		}
 		psgl->ptail->next = psgl->ptail_dma + sizeof(ppc_sgl_t);
 		psgl->ptail++;
 		psgl->ptail_dma += sizeof(ppc_sgl_t);
@@ -160,7 +166,7 @@
 	p_dma_ch = &dma_channels[psgl->dmanr];
 	psgl->ptail->control_count &= ~SG_LINK;	/* make this the last dscrptr */
 	sg_command = mfdcr(DCRN_ASGC);
-
+  
 	ppc4xx_set_sg_addr(psgl->dmanr, psgl->phead_dma);
 
 	sg_command |= SSG_ENABLE(psgl->dmanr);
@@ -217,7 +223,7 @@
 	}
 
 	sgl_addr = (ppc_sgl_t *) __va(mfdcr(DCRN_ASG0 + (psgl->dmanr * 0x8)));
-	count_left = mfdcr(DCRN_DMACT0 + (psgl->dmanr * 0x8));
+	count_left = mfdcr(DCRN_DMACT0 + (psgl->dmanr * 0x8)) & SG_COUNT_MASK;
 
 	if (!sgl_addr) {
 		printk("ppc4xx_get_dma_sgl_residue: sgl addr register is null\n");
@@ -351,10 +357,11 @@
 int
 ppc4xx_alloc_dma_handle(sgl_handle_t * phandle, unsigned int mode, unsigned int dmanr)
 {
-	sgl_list_info_t *psgl;
+	sgl_list_info_t *psgl=NULL;
 	dma_addr_t dma_addr;
 	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
 	uint32_t sg_command;
+	uint32_t ctc_settings;
 	void *ret;
 
 	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
@@ -412,6 +419,11 @@
 	mtdcr(DCRN_ASGC, sg_command);
 	psgl->sgl_control = SG_ERI_ENABLE | SG_LINK;
 
+	/* keep control count register settings */
+	ctc_settings = mfdcr(DCRN_DMACT0 + (dmanr * 0x8)) 
+		& (DMA_CTC_BSIZ_MSK | DMA_CTC_BTEN); /*burst mode settings*/
+	psgl->sgl_control |= ctc_settings;
+ 
 	if (p_dma_ch->int_enable) {
 		if (p_dma_ch->tce_enable)
 			psgl->sgl_control |= SG_TCI_ENABLE;
===== include/asm-ppc/ppc4xx_dma.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/ppc4xx_dma.h	2004-08-07 15:02:29 -07:00
+++ edited/include/asm-ppc/ppc4xx_dma.h	2005-01-31 07:48:06 -07:00
@@ -137,9 +137,10 @@
 #define DMA_TCE_ENABLE     (1<<(8-DMA_CR_OFFSET))
 #define SET_DMA_TCE(x)     (((x)&0x1)<<(8-DMA_CR_OFFSET))
 
-#define DMA_DEC            (1<<(2)	/* Address Decrement */
+#define DMA_DEC            (1<<(2))	/* Address Decrement */
 #define SET_DMA_DEC(x)     (((x)&0x1)<<2)
 #define GET_DMA_DEC(x)     (((x)&DMA_DEC)>>2)
+    
 
 /*
  * Transfer Modes
@@ -244,6 +245,14 @@
 #define DMA_SG2            (1<<5)
 #define DMA_SG3            (1<<4)
 
+/* DMA Channel Count Register */
+#define DMA_CTC_BTEN     (1<<23)    /* Burst Enable/Disable bit */
+#define DMA_CTC_BSIZ_MSK (3<<21)    /* Mask of the Burst size bits */
+#define DMA_CTC_BSIZ_2   (0)
+#define DMA_CTC_BSIZ_4   (1<<21)
+#define DMA_CTC_BSIZ_8   (2<<21)
+#define DMA_CTC_BSIZ_16  (3<<21)
+
 /*
  * DMA SG Command Register
  */
@@ -482,6 +491,7 @@
 	char td;		/* transfer direction */
 #endif
 
+	char int_on_final_sg;/* for scatter/gather - only interrupt on last sg */
 } ppc_dma_ch_t;
 
 /*
@@ -545,6 +555,9 @@
 extern int ppc4xx_alloc_dma_handle(sgl_handle_t *, unsigned int, unsigned int);
 extern void ppc4xx_free_dma_handle(sgl_handle_t);
 extern int ppc4xx_get_dma_status(void);
+extern int ppc4xx_enable_burst(unsigned int);
+extern int ppc4xx_disable_burst(unsigned int);
+extern int ppc4xx_set_burst_size(unsigned int, unsigned int);
 extern void ppc4xx_set_src_addr(int dmanr, phys_addr_t src_addr);
 extern void ppc4xx_set_dst_addr(int dmanr, phys_addr_t dst_addr);
 extern void ppc4xx_enable_dma(unsigned int dmanr);
