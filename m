Message-ID: <3D6AF592.9090402@dslextreme.com>
Date: Mon, 26 Aug 2002 20:44:18 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Todd Poynor <tpoynor@mvista.com>
Cc: jim <jduey@ccc-dcs.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question about ppc4xx_dma.h
References: <20020820203619.A456239211@server.weathercom.com> <3D62CE63.1030606@dslextreme.com> <3D63EC67.4000302@dslextreme.com> <3D641186.2020800@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------060504090400030007050906"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060504090400030007050906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Todd Poynor wrote:
>
> Noticed that the order of clearing the old transfer mode bits and
> setting the p_dma_ch->mode bits is reversed in the new patch, not sure
> if this causes problems:
>
> +       tmp_cntl |= (p_dma_ch->mode | DMA_CH_ENABLE);
> +
> +       switch (dmanr) {
> +       case 0:
> +               control = mfdcr(DCRN_DMACR0);
> +               control |= tmp_cntl;
> +               control &= ~(DMA_TM_MASK | DMA_TD);     /* clear all
> mode bits */
>
> This seems to set and then clear the p_dma_ch->mode bits in control
> prior to writing to the DMACR, a problem?
>
>
> --
> Todd
>
>
>
>
>

Here is a patch that should address the above issue.  I put in
additional checks for if a the current dma channel is all ready claimed
and if the requestion channel is greater than max dma channels.
dma_enable no longer clears mode bits.   ( TODO: should document 4xx dma
usage)

Armin

--------------060504090400030007050906
Content-Type: text/plain;
 name="dma_fix_0826.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dma_fix_0826.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1140  -> 1.1141
#	arch/ppc/kernel/ppc4xx_dma.c	1.14    -> 1.15
#	include/asm-ppc/ppc4xx_dma.h	1.15    -> 1.16
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/26	armin@essen.mvista.com	1.1141
# fixed enable to allow more than 1 channel support pointed out by Jim Duey
# added check in enable / disable and for chan > MAX
# added in_use field in struct to make sure you can enable a chan twice
# and new return error code
# --------------------------------------------
#
diff -Nru a/arch/ppc/kernel/ppc4xx_dma.c b/arch/ppc/kernel/ppc4xx_dma.c
--- a/arch/ppc/kernel/ppc4xx_dma.c	Mon Aug 26 20:37:25 2002
+++ b/arch/ppc/kernel/ppc4xx_dma.c	Mon Aug 26 20:37:25 2002
@@ -34,6 +34,11 @@
  *
  *  Version 1.2 07/23/02 - Armin
  *  added CE to stuct in get_config
+ *
+ *  Version 1.3 08/21/02 - Armin
+ *  fixed enable to allow more than 1 channel support pointed out by
+ *  Jim Duey
+ *
  *
  */

@@ -136,8 +141,12 @@
 enable_dma(unsigned int dmanr)
 {
 	unsigned int control;
+	unsigned int tmp_cntl = 0;
 	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];

+	if (p_dma_ch->in_use)
+		return DMA_STATUS_CHANNEL_NOTFREE;
+
 	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
 		printk("enable_dma: bad channel: %d\n", dmanr);
 		return DMA_STATUS_BAD_CHANNEL;
@@ -153,15 +162,39 @@
 		set_dst_addr(dmanr, 0);
 	}
 	/* for other xfer modes, the addresses are already set */
-	control = mfdcr(DCRN_DMACR0);
-	control &= ~(DMA_TM_MASK | DMA_TD);	/* clear all mode bits */
-	if (p_dma_ch->mode == DMA_MODE_MM) {
+		if (p_dma_ch->mode == DMA_MODE_MM) {
 		/* software initiated memory to memory */
-		control |= control | DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
+		tmp_cntl |= DMA_ETD_OUTPUT | DMA_TCE_ENABLE;
 	}
-	control |= (p_dma_ch->mode | DMA_CH_ENABLE);
-	mtdcr(DCRN_DMACR0, control);
+	tmp_cntl |= (p_dma_ch->mode | DMA_CH_ENABLE);

+	switch (dmanr) {
+	case 0:
+		control = mfdcr(DCRN_DMACR0);
+		control |= tmp_cntl;
+	       	mtdcr(DCRN_DMACR0, control);
+		break;
+	case 1:
+		control = mfdcr(DCRN_DMACR1);
+		control |= tmp_cntl;
+		mtdcr(DCRN_DMACR1, control);
+		break;
+	case 2:
+		control = mfdcr(DCRN_DMACR2);
+		control |= tmp_cntl;
+		mtdcr(DCRN_DMACR2, control);
+		break;
+	case 3:
+		control = mfdcr(DCRN_DMACR3);
+		control |= tmp_cntl;
+		mtdcr(DCRN_DMACR3, control);
+		break;
+	default:
+#ifdef DEBUG_4xxDMA
+		printk("enable_dma: bad channel: %d\n", dmanr);
+#endif
+	}
+	p_dma_ch->in_use = 1;
 	return DMA_STATUS_GOOD;
 }

@@ -169,6 +202,15 @@
 disable_dma(unsigned int dmanr)
 {
 	unsigned int control;
+	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	if (!p_dma_ch->in_use)
+		return DMA_STATUS_CHANNEL_NOTFREE;
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("enable_dma: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}

 	switch (dmanr) {
 	case 0:
@@ -196,6 +238,7 @@
 		printk("disable_dma: bad channel: %d\n", dmanr);
 #endif
 	}
+	p_dma_ch->in_use = 0;
 }

 /*
@@ -348,6 +391,12 @@
 set_dma_addr(unsigned int dmanr, phys_addr_t addr)
 {
 	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];
+
+	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
+		printk("enable_dma: bad channel: %d\n", dmanr);
+		return DMA_STATUS_BAD_CHANNEL;
+	}
+
 #ifdef DEBUG_4xxDMA
 	{
 		int error = 0;
@@ -495,7 +544,7 @@
 	unsigned int control;
 	ppc_dma_ch_t *p_dma_ch = &dma_channels[dmanr];

-	p_dma_ch->int_enable = TRUE;
+	p_dma_ch->int_enable = FALSE;
 	switch (dmanr) {
 	case 0:
 		control = mfdcr(DCRN_DMACR0);
@@ -545,11 +594,11 @@
 	DMA_MODE_READ = (unsigned long) DMA_TD;	/* Peripheral to Memory */
 	DMA_MODE_WRITE = 0;	/* Memory to Peripheral */

-#ifdef DEBUG_4xxDMA
 	if (!p_init) {
 		printk("hw_init_dma_channel: NULL p_init\n");
 		return DMA_STATUS_NULL_POINTER;
 	}
+#ifdef DEBUG_4xxDMA
 	if (dmanr >= MAX_PPC4xx_DMA_CHANNELS) {
 		printk("hw_init_dma_channel: bad channel %d\n", dmanr);
 		return DMA_STATUS_BAD_CHANNEL;
diff -Nru a/include/asm-ppc/ppc4xx_dma.h b/include/asm-ppc/ppc4xx_dma.h
--- a/include/asm-ppc/ppc4xx_dma.h	Mon Aug 26 20:37:25 2002
+++ b/include/asm-ppc/ppc4xx_dma.h	Mon Aug 26 20:37:25 2002
@@ -26,6 +26,10 @@
  *    moved scatter/gather inline code to ppc4xx_sgdma.c
  *    added three new extern proto types for the STBxxxx API's
  *
+ *    version 1.4: 08/26/02 - Armin
+ *    added in_use field for when a channel is claimed
+ *    added new return code *_NOTFREE
+ *
  */

 #ifdef __KERNEL__
@@ -57,6 +61,7 @@
 #define DMA_STATUS_OUT_OF_MEMORY	5
 #define DMA_STATUS_SGL_LIST_EMPTY	6
 #define DMA_STATUS_GENERAL_ERROR	7
+#define DMA_STATUS_CHANNEL_NOTFREE	8

 #define DMA_CHANNEL_BUSY		0x80000000

@@ -411,7 +416,9 @@
 #endif

 typedef struct {
-
+	bool in_use;	/* set when channel is being used, clr when
+			   avaliable
+			 */
 	/*
 	 * Valid polarity settings:
 	 *   DMAReq0_ActiveLow

--------------060504090400030007050906
Content-Type: application/x-gunzip;
 name="dma_fix_0826.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dma_fix_0826.patch.gz"

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
njWDeeZfmG0QvdoTAAA=
--------------060504090400030007050906--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
