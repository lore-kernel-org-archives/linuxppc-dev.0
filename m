Return-Path: <CWernham@Airspan.com>
Message-ID: <41EF8E33.9090909@airspan.com>
Date: Thu, 20 Jan 2005 10:55:47 +0000
From: Colin Wernham <cwernham@airspan.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, mporter@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH]PPC4XX Dma fixes, burst and sg improvements
Reply-To: cwernham@airspan.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have DMA fixes and improvements to the following PPC4XX files [2.6.10]:

ppc4xx_dma.h
ppc4xx_dma.c
ppc4xx_sgdma.c

The fixes/improvements are:

1) Added the missing ppc4xx_clr_dma_status() function,
2) Adding new functions to support enabling/disabling and setting burst 
modes,
3) FIX: ppc4xx_get_channel_config() now memcpy's the existing channel 
config before doing anything, otherwise it returns some uninitialised 
fields.
4) FIX: ppc4xx_get_dma_sgl_residue() now masks out the non-count fields 
when getting the count_left value. There are still problems with this 
function, though.
5) FIX: ppc4xx_alloc_dma_handle() initialises the psgl pointer to NULL 
to cope with the case where the dma_alloc_coherent fails.
6) ppc4xx_alloc_dma_handle() now copies the control count register 
settings for burst mode into the sgl list sgl_control so that all 
scatter/gather entries added later will keep the burst mode settings.
7) For scatter/gather dma the current implementation will interrupt 
after every scatter/gather dma operation. To allow for only interrupting 
on the very last scatter/gather, I've added a new 'int_on_final_sg' 
field to the ppc_dma_ch_t structure which is used in 
ppc4xx_add_dma_sgl() to mask out the interrupt settings on the previous 
scatter/gather entry in the list. IMPORTANT NOTE: All users will have to 
set or clear this new field when using ppc4xx_init_dma_channel() with 
this patch!

Additional Comment:
I also noticed that the ppc4xx_alloc_dma_handle() function includes the 
structure sgl_list_info_t within the dma region allocated for the sgl 
table/list. Ideally, this structure should have it's own dma alloc, and 
a pointer to the sgl table/list region, since the sgl table MUST be 
quad-word aligned for the 440GX DMA controller, otherwise the dma will 
immediately fail with an error (Address Alignment Error, annoyingly the 
exact cause of DMA errors are not indicated anywhere). It is probably 
luck that the existing sgl_list_info_t makes the following sgl 
table/list quad-word aligned.

Signed-off-by: Colin P Wernham <cwernham@airspan.com>

=====================================================================
--- linux-2.6.10/include/asm-ppc/ppc4xx_dma.h	2004-12-24 
21:35:01.000000000 +0000
+++ linux-current/include/asm-ppc/ppc4xx_dma.h	2005-01-19 
10:59:55.000000000 +0000
@@ -137,9 +137,10 @@ extern unsigned long DMA_MODE_WRITE, DMA
  #define DMA_TCE_ENABLE     (1<<(8-DMA_CR_OFFSET))
  #define SET_DMA_TCE(x)     (((x)&0x1)<<(8-DMA_CR_OFFSET))

-#define DMA_DEC            (1<<(2)	/* Address Decrement */
+#define DMA_DEC            (1<<(2))	/* Address Decrement */
  #define SET_DMA_DEC(x)     (((x)&0x1)<<2)
  #define GET_DMA_DEC(x)     (((x)&DMA_DEC)>>2)
+

  /*
   * Transfer Modes
@@ -244,6 +245,14 @@ typedef uint32_t sgl_handle_t;
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
@@ -482,6 +491,7 @@ typedef struct {
  	char td;		/* transfer direction */
  #endif

+	char int_on_final_sg;/* for scatter/gather - only interrupt on last sg */
  } ppc_dma_ch_t;

  /*
@@ -545,6 +555,9 @@ extern int ppc4xx_delete_dma_sgl_element
  extern int ppc4xx_alloc_dma_handle(sgl_handle_t *, unsigned int, 
unsigned int);
  extern void ppc4xx_free_dma_handle(sgl_handle_t);
  extern int ppc4xx_get_dma_status(void);
+extern int ppc4xx_enable_burst(unsigned int);
+extern int ppc4xx_disable_burst(unsigned int);
+extern int ppc4xx_set_burst_size(unsigned int, unsigned int);
  extern void ppc4xx_set_src_addr(int dmanr, phys_addr_t src_addr);
  extern void ppc4xx_set_dst_addr(int dmanr, phys_addr_t dst_addr);
  extern void ppc4xx_enable_dma(unsigned int dmanr);
=====================================================================
--- linux-2.6.10/arch/ppc/syslib/ppc4xx_dma.c	2004-12-24 
21:35:40.000000000 +0000
+++ linux-current/arch/ppc/syslib/ppc4xx_dma.c	2005-01-19 
15:34:30.000000000 +0000
@@ -512,6 +512,8 @@ ppc4xx_get_channel_config(unsigned int d
  		return DMA_STATUS_BAD_CHANNEL;
  	}

+	memcpy(p_dma_ch, &dma_channels[dmanr], sizeof (ppc_dma_ch_t));
+
  #if DCRN_POL > 0
  	polarity = mfdcr(DCRN_POL);
  #else
@@ -604,6 +606,84 @@ ppc4xx_get_peripheral_width(unsigned int
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
+	mtdcr(DCRN_DMASR, ((u32)DMA_CH0_ERR | (u32)DMA_CS0 | (u32)DMA_TS0) >> 
dmanr);
+	return DMA_STATUS_GOOD;
+}
+
+/*
+ * Enables the burst on the channel (BTEN bit in the control/count 
register)
+ * Note:
+ * For scatter/gather dma, this function MUST be called before the
+ * ppc4xx_alloc_dma_handle() func as the chan count register is copied 
into the
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
+ * Disables the burst on the channel (BTEN bit in the control/count 
register)
+ * Note:
+ * For scatter/gather dma, this function MUST be called before the
+ * ppc4xx_alloc_dma_handle() func as the chan count register is copied 
into the
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
+ * ppc4xx_alloc_dma_handle() func as the chan count register is copied 
into the
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
@@ -622,3 +702,7 @@ EXPORT_SYMBOL(ppc4xx_get_dma_residue);
  EXPORT_SYMBOL(ppc4xx_enable_dma_interrupt);
  EXPORT_SYMBOL(ppc4xx_disable_dma_interrupt);
  EXPORT_SYMBOL(ppc4xx_get_dma_status);
+EXPORT_SYMBOL(ppc4xx_clr_dma_status);
+EXPORT_SYMBOL(ppc4xx_enable_burst);
+EXPORT_SYMBOL(ppc4xx_disable_burst);
+EXPORT_SYMBOL(ppc4xx_set_burst_size);
=====================================================================
--- linux-2.6.10/arch/ppc/syslib/ppc4xx_sgdma.c	2004-12-24 
21:35:18.000000000 +0000
+++ linux-current/arch/ppc/syslib/ppc4xx_sgdma.c	2005-01-19 
15:07:47.000000000 +0000
@@ -120,6 +120,12 @@ ppc4xx_add_dma_sgl(sgl_handle_t handle,
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
@@ -217,7 +223,7 @@ ppc4xx_get_dma_sgl_residue(sgl_handle_t
  	}

  	sgl_addr = (ppc_sgl_t *) __va(mfdcr(DCRN_ASG0 + (psgl->dmanr * 0x8)));
-	count_left = mfdcr(DCRN_DMACT0 + (psgl->dmanr * 0x8));
+	count_left = mfdcr(DCRN_DMACT0 + (psgl->dmanr * 0x8)) & SG_COUNT_MASK;

  	if (!sgl_addr) {
  		printk("ppc4xx_get_dma_sgl_residue: sgl addr register is null\n");
@@ -351,10 +357,11 @@ ppc4xx_delete_dma_sgl_element(sgl_handle
  int
  ppc4xx_alloc_dma_handle(sgl_handle_t * phandle, unsigned int mode, 
unsigned int dmanr)
  {
-	sgl_list_info_t *psgl;
+	sgl_list_info_t *psgl=NULL;
  	dma_addr_t dma_addr;
  	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
  	uint32_t sg_command;
+	uint32_t ctc_settings;
  	void *ret;

  	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
@@ -412,6 +419,11 @@ ppc4xx_alloc_dma_handle(sgl_handle_t * p
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
=====================================================================
