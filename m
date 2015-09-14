Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21ABD1A2C0B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 11:45:06 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v9 4/5] CPM: modify cpm_muram_* functions
Date: Mon, 14 Sep 2015 09:38:19 +0800
Message-ID: <1442194700-6194-4-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
References: <1442194700-6194-1-git-send-email-qiang.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CPM and QE have the same muram, shared the same
muram management functions. Delete cpm_muram_* functions,
using qe_muram_*.

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v9:
	- splitted from patch 3/5, modify cpm muram management functions.

 arch/powerpc/include/asm/cpm.h   |  59 ----------------
 arch/powerpc/include/asm/qe.h    |   8 +++
 arch/powerpc/sysdev/cpm_common.c | 141 +--------------------------------------
 3 files changed, 9 insertions(+), 199 deletions(-)

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index 4398a6c..003a736 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -93,22 +93,6 @@ typedef struct cpm_buf_desc {
  */
 
 #define BD_SC_EMPTY	(0x8000)	/* Receive is empty */
-#define BD_SC_READY	(0x8000)	/* Transmit is ready */
-#define BD_SC_WRAP	(0x2000)	/* Last buffer descriptor */
-#define BD_SC_INTRPT	(0x1000)	/* Interrupt on change */
-#define BD_SC_LAST	(0x0800)	/* Last buffer in frame */
-#define BD_SC_TC	(0x0400)	/* Transmit CRC */
-#define BD_SC_CM	(0x0200)	/* Continuous mode */
-#define BD_SC_ID	(0x0100)	/* Rec'd too many idles */
-#define BD_SC_P		(0x0100)	/* xmt preamble */
-#define BD_SC_BR	(0x0020)	/* Break received */
-#define BD_SC_FR	(0x0010)	/* Framing error */
-#define BD_SC_PR	(0x0008)	/* Parity error */
-#define BD_SC_NAK	(0x0004)	/* NAK - did not respond */
-#define BD_SC_OV	(0x0002)	/* Overrun */
-#define BD_SC_UN	(0x0002)	/* Underrun */
-#define BD_SC_CD	(0x0001)	/* */
-#define BD_SC_CL	(0x0001)	/* Collision */
 
 /* Buffer descriptor control/status used by Ethernet receive.
  * Common to SCC and FCC.
@@ -155,49 +139,6 @@ typedef struct cpm_buf_desc {
  */
 #define BD_I2C_START		(0x0400)
 
-int cpm_muram_init(void);
-
-#if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
-unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
-int cpm_muram_free(unsigned long offset);
-unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
-void __iomem *cpm_muram_addr(unsigned long offset);
-unsigned long cpm_muram_offset(void __iomem *addr);
-dma_addr_t cpm_muram_dma(void __iomem *addr);
-#else
-static inline unsigned long cpm_muram_alloc(unsigned long size,
-					    unsigned long align)
-{
-	return -ENOSYS;
-}
-
-static inline int cpm_muram_free(unsigned long offset)
-{
-	return -ENOSYS;
-}
-
-static inline unsigned long cpm_muram_alloc_fixed(unsigned long offset,
-						  unsigned long size)
-{
-	return -ENOSYS;
-}
-
-static inline void __iomem *cpm_muram_addr(unsigned long offset)
-{
-	return NULL;
-}
-
-static inline unsigned long cpm_muram_offset(void __iomem *addr)
-{
-	return -ENOSYS;
-}
-
-static inline dma_addr_t cpm_muram_dma(void __iomem *addr)
-{
-	return 0;
-}
-#endif /* defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE) */
-
 #ifdef CONFIG_CPM
 int cpm_command(u32 command, u8 opcode);
 #else
diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 3af9033..aee968f 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -189,6 +189,14 @@ static inline int qe_alive_during_sleep(void)
 #endif
 }
 
+/* we actually use qe_muram implementation, define this for convenience */
+#define cpm_muram_init qe_muram_init
+#define cpm_muram_alloc qe_muram_alloc
+#define cpm_muram_alloc_fixed qe_muram_alloc_fixed
+#define cpm_muram_free qe_muram_free
+#define cpm_muram_addr qe_muram_addr
+#define cpm_muram_offset qe_muram_offset
+
 int qe_muram_init(void);
 
 #if defined(CONFIG_QUICC_ENGINE)
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 4f78695..328c3ec 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -27,8 +27,8 @@
 
 #include <asm/udbg.h>
 #include <asm/io.h>
-#include <asm/rheap.h>
 #include <asm/cpm.h>
+#include <asm/qe.h>
 
 #include <mm/mmu_decl.h>
 
@@ -65,151 +65,12 @@ void __init udbg_init_cpm(void)
 }
 #endif
 
-static spinlock_t cpm_muram_lock;
-static rh_block_t cpm_boot_muram_rh_block[16];
-static rh_info_t cpm_muram_info;
 static u8 __iomem *muram_vbase;
 static phys_addr_t muram_pbase;
 
 /* Max address size we deal with */
 #define OF_MAX_ADDR_CELLS	4
 
-int cpm_muram_init(void)
-{
-	struct device_node *np;
-	struct resource r;
-	u32 zero[OF_MAX_ADDR_CELLS] = {};
-	resource_size_t max = 0;
-	int i = 0;
-	int ret = 0;
-
-	if (muram_pbase)
-		return 0;
-
-	spin_lock_init(&cpm_muram_lock);
-	/* initialize the info header */
-	rh_init(&cpm_muram_info, 1,
-	        sizeof(cpm_boot_muram_rh_block) /
-	        sizeof(cpm_boot_muram_rh_block[0]),
-	        cpm_boot_muram_rh_block);
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
-	if (!np) {
-		/* try legacy bindings */
-		np = of_find_node_by_name(NULL, "data-only");
-		if (!np) {
-			printk(KERN_ERR "Cannot find CPM muram data node");
-			ret = -ENODEV;
-			goto out;
-		}
-	}
-
-	muram_pbase = of_translate_address(np, zero);
-	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
-		printk(KERN_ERR "Cannot translate zero through CPM muram node");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	while (of_address_to_resource(np, i++, &r) == 0) {
-		if (r.end > max)
-			max = r.end;
-
-		rh_attach_region(&cpm_muram_info, r.start - muram_pbase,
-				 resource_size(&r));
-	}
-
-	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
-	if (!muram_vbase) {
-		printk(KERN_ERR "Cannot map CPM muram");
-		ret = -ENOMEM;
-	}
-
-out:
-	of_node_put(np);
-	return ret;
-}
-
-/**
- * cpm_muram_alloc - allocate the requested size worth of multi-user ram
- * @size: number of bytes to allocate
- * @align: requested alignment, in bytes
- *
- * This function returns an offset into the muram area.
- * Use cpm_dpram_addr() to get the virtual address of the area.
- * Use cpm_muram_free() to free the allocation.
- */
-unsigned long cpm_muram_alloc(unsigned long size, unsigned long align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_muram_lock, flags);
-	cpm_muram_info.alignment = align;
-	start = rh_alloc(&cpm_muram_info, size, "commproc");
-	memset(cpm_muram_addr(start), 0, size);
-	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(cpm_muram_alloc);
-
-/**
- * cpm_muram_free - free a chunk of multi-user ram
- * @offset: The beginning of the chunk as returned by cpm_muram_alloc().
- */
-int cpm_muram_free(unsigned long offset)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_muram_lock, flags);
-	ret = rh_free(&cpm_muram_info, offset);
-	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(cpm_muram_free);
-
-/**
- * cpm_muram_alloc_fixed - reserve a specific region of multi-user ram
- * @offset: the offset into the muram area to reserve
- * @size: the number of bytes to reserve
- *
- * This function returns "start" on success, -ENOMEM on failure.
- * Use cpm_dpram_addr() to get the virtual address of the area.
- * Use cpm_muram_free() to free the allocation.
- */
-unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&cpm_muram_lock, flags);
-	cpm_muram_info.alignment = 1;
-	start = rh_alloc_fixed(&cpm_muram_info, offset, size, "commproc");
-	spin_unlock_irqrestore(&cpm_muram_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(cpm_muram_alloc_fixed);
-
-/**
- * cpm_muram_addr - turn a muram offset into a virtual address
- * @offset: muram offset to convert
- */
-void __iomem *cpm_muram_addr(unsigned long offset)
-{
-	return muram_vbase + offset;
-}
-EXPORT_SYMBOL(cpm_muram_addr);
-
-unsigned long cpm_muram_offset(void __iomem *addr)
-{
-	return addr - (void __iomem *)muram_vbase;
-}
-EXPORT_SYMBOL(cpm_muram_offset);
-
 /**
  * cpm_muram_dma - turn a muram virtual address into a DMA address
  * @offset: virtual address from cpm_muram_addr() to convert
-- 
2.1.0.27.g96db324
