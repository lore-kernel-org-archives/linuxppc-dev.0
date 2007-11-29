Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AD184DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 07:20:08 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lATKK26m014086
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 13:20:03 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: fix guts_set_dmacr() and add guts_set_pmuxcr_dma() to
	immap_86xx.h
Date: Thu, 29 Nov 2007 14:19:57 -0600
Message-Id: <11963675973785-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated guts_set_dmacr() to enumerate the DMA controllers at 0, instead of 1,
so that it now matches other related functions.  Added function
guts_set_pmuxcr_dma() to set the external DMA control bits in the PMUXCR
register of the global utilities structure.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Changing the behavior of guts_set_dmacr() is okay because no one uses that
function yet.

This patch is for Kumar's for-2.6.25 branch.

 include/asm-powerpc/immap_86xx.h |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/immap_86xx.h b/include/asm-powerpc/immap_86xx.h
index 0ad4e65..0f165e5 100644
--- a/include/asm-powerpc/immap_86xx.h
+++ b/include/asm-powerpc/immap_86xx.h
@@ -89,14 +89,14 @@ struct ccsr_guts {
  * them.
  *
  * guts: Pointer to GUTS structure
- * co: The DMA controller (1 or 2)
+ * co: The DMA controller (0 or 1)
  * ch: The channel on the DMA controller (0, 1, 2, or 3)
  * device: The device to set as the source (CCSR_GUTS_DMACR_DEV_xx)
  */
 static inline void guts_set_dmacr(struct ccsr_guts __iomem *guts,
 	unsigned int co, unsigned int ch, unsigned int device)
 {
-	unsigned int shift = 16 + (8 * (2 - co) + 2 * (3 - ch));
+	unsigned int shift = 16 + (8 * (1 - co) + 2 * (3 - ch));
 
 	clrsetbits_be32(&guts->dmacr, 3 << shift, device << shift);
 }
@@ -118,6 +118,27 @@ static inline void guts_set_dmacr(struct ccsr_guts __iomem *guts,
 #define CCSR_GUTS_PMUXCR_DMA1_0		0x00000002
 #define CCSR_GUTS_PMUXCR_DMA1_3		0x00000001
 
+/*
+ * Set the DMA external control bits in the GUTS
+ *
+ * The DMA external control bits in the PMUXCR are only meaningful for
+ * channels 0 and 3.  Any other channels are ignored.
+ *
+ * guts: Pointer to GUTS structure
+ * co: The DMA controller (0 or 1)
+ * ch: The channel on the DMA controller (0, 1, 2, or 3)
+ * value: the new value for the bit (0 or 1)
+ */
+static inline void guts_set_pmuxcr_dma(struct ccsr_guts __iomem *guts,
+	unsigned int co, unsigned int ch, unsigned int value)
+{
+	if ((ch == 0) || (ch == 3)) {
+		unsigned int shift = 2 * (co + 1) - (ch & 1) - 1;
+
+		clrsetbits_be32(&guts->pmuxcr, 1 << shift, value << shift);
+	}
+}
+
 #define CCSR_GUTS_CLKDVDR_PXCKEN	0x80000000
 #define CCSR_GUTS_CLKDVDR_SSICKEN	0x20000000
 #define CCSR_GUTS_CLKDVDR_PXCKINV	0x10000000
-- 
1.5.2.4
