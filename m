Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 11C42DF08E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 02:39:08 +1000 (EST)
Date: Fri, 23 May 2008 20:39:06 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 7/7] [POWERPC] qe_lib: switch to the cpm_muram implementation
Message-ID: <20080523163906.GG16137@polina.dev.rtsoft.ru>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080523163811.GA12181@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is very trivial patch. We're transitioning to the cpm_muram_*
calls. That's it.

Less trivial changes:
- BD_SC_* defines were defined in the cpm.h and qe.h, so to avoid redefines
  we remove BD_SC from the qe.h and use cpm.h along with cpm_muram_*
  prototypes;
- qe_muram_dump was unused and thus removed;
- added some code to the cpm_common.c to support legacy QE bindings
  (data-only node name).
- For convenience, define qe_* calls to cpm_*. So drivers need not to be
  changed.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/Makefile     |    1 +
 arch/powerpc/sysdev/cpm_common.c |   16 +++++-
 arch/powerpc/sysdev/qe_lib/qe.c  |   92 --------------------------------------
 include/asm-powerpc/cpm.h        |    1 +
 include/asm-powerpc/qe.h         |   36 +++-----------
 5 files changed, 23 insertions(+), 123 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 2bfbb39..16a0ed2 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -42,6 +42,7 @@ endif
 ifeq ($(ARCH),powerpc)
 obj-$(CONFIG_CPM)		+= cpm_common.o
 obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o
+obj-$(CONFIG_QUICC_ENGINE)	+= cpm_common.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o cpm1.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index cb7df2d..9b75d16 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -85,9 +85,13 @@ int __init cpm_muram_init(void)
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
 	if (!np) {
-		printk(KERN_ERR "Cannot find CPM muram data node");
-		ret = -ENODEV;
-		goto out;
+		/* try legacy bindings */
+		np = of_find_node_by_name(NULL, "data-only");
+		if (!np) {
+			printk(KERN_ERR "Cannot find CPM muram data node");
+			ret = -ENODEV;
+			goto out;
+		}
 	}
 
 	muram_pbase = of_translate_address(np, zero);
@@ -189,6 +193,12 @@ void __iomem *cpm_muram_addr(unsigned long offset)
 }
 EXPORT_SYMBOL(cpm_muram_addr);
 
+unsigned long cpm_muram_offset(void __iomem *addr)
+{
+	return addr - (void __iomem *)muram_vbase;
+}
+EXPORT_SYMBOL(cpm_muram_offset);
+
 /**
  * cpm_muram_dma - turn a muram virtual address into a DMA address
  * @offset: virtual address from cpm_muram_addr() to convert
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index cff550e..28e05df 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -35,7 +35,6 @@
 #include <asm/rheap.h>
 
 static void qe_snums_init(void);
-static void qe_muram_init(void);
 static int qe_sdma_init(void);
 
 static DEFINE_SPINLOCK(qe_lock);
@@ -325,97 +324,6 @@ static int qe_sdma_init(void)
 	return 0;
 }
 
-/*
- * muram_alloc / muram_free bits.
- */
-static DEFINE_SPINLOCK(qe_muram_lock);
-
-/* 16 blocks should be enough to satisfy all requests
- * until the memory subsystem goes up... */
-static rh_block_t qe_boot_muram_rh_block[16];
-static rh_info_t qe_muram_info;
-
-static void qe_muram_init(void)
-{
-	struct device_node *np;
-	const u32 *address;
-	u64 size;
-	unsigned int flags;
-
-	/* initialize the info header */
-	rh_init(&qe_muram_info, 1,
-		sizeof(qe_boot_muram_rh_block) /
-		sizeof(qe_boot_muram_rh_block[0]), qe_boot_muram_rh_block);
-
-	/* Attach the usable muram area */
-	/* XXX: This is a subset of the available muram. It
-	 * varies with the processor and the microcode patches activated.
-	 */
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe-muram-data");
-	if (!np) {
-		np = of_find_node_by_name(NULL, "data-only");
-		if (!np) {
-			WARN_ON(1);
-			return;
-		}
-	}
-
-	address = of_get_address(np, 0, &size, &flags);
-	WARN_ON(!address);
-
-	of_node_put(np);
-	if (address)
-		rh_attach_region(&qe_muram_info, *address, (int)size);
-}
-
-/* This function returns an index into the MURAM area.
- */
-unsigned long qe_muram_alloc(int size, int align)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&qe_muram_lock, flags);
-	start = rh_alloc_align(&qe_muram_info, size, align, "QE");
-	spin_unlock_irqrestore(&qe_muram_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(qe_muram_alloc);
-
-int qe_muram_free(unsigned long offset)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&qe_muram_lock, flags);
-	ret = rh_free(&qe_muram_info, offset);
-	spin_unlock_irqrestore(&qe_muram_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(qe_muram_free);
-
-/* not sure if this is ever needed */
-unsigned long qe_muram_alloc_fixed(unsigned long offset, int size)
-{
-	unsigned long start;
-	unsigned long flags;
-
-	spin_lock_irqsave(&qe_muram_lock, flags);
-	start = rh_alloc_fixed(&qe_muram_info, offset, size, "commproc");
-	spin_unlock_irqrestore(&qe_muram_lock, flags);
-
-	return start;
-}
-EXPORT_SYMBOL(qe_muram_alloc_fixed);
-
-void qe_muram_dump(void)
-{
-	rh_dump(&qe_muram_info);
-}
-EXPORT_SYMBOL(qe_muram_dump);
-
 /* The maximum number of RISCs we support */
 #define MAX_QE_RISC     2
 
diff --git a/include/asm-powerpc/cpm.h b/include/asm-powerpc/cpm.h
index ede38ff..63a5533 100644
--- a/include/asm-powerpc/cpm.h
+++ b/include/asm-powerpc/cpm.h
@@ -96,6 +96,7 @@ unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
 int cpm_muram_free(unsigned long offset);
 unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
 void __iomem *cpm_muram_addr(unsigned long offset);
+unsigned long cpm_muram_offset(void __iomem *addr);
 dma_addr_t cpm_muram_dma(void __iomem *addr);
 int cpm_command(u32 command, u8 opcode);
 
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index 832f3c8..181f309 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -17,6 +17,7 @@
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
+#include <asm/cpm.h>
 #include <asm/immap_qe.h>
 
 #define QE_NUM_OF_SNUM	28
@@ -118,20 +119,13 @@ unsigned int qe_get_brg_clk(void);
 int qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int multiplier);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
-unsigned long qe_muram_alloc(int size, int align);
-int qe_muram_free(unsigned long offset);
-unsigned long qe_muram_alloc_fixed(unsigned long offset, int size);
-void qe_muram_dump(void);
-
-static inline void __iomem *qe_muram_addr(unsigned long offset)
-{
-	return (void __iomem *)&qe_immr->muram[offset];
-}
-
-static inline unsigned long qe_muram_offset(void __iomem *addr)
-{
-	return addr - (void __iomem *)qe_immr->muram;
-}
+/* we actually use cpm_muram implementation, define this for convenience */
+#define qe_muram_init cpm_muram_init
+#define qe_muram_alloc cpm_muram_alloc
+#define qe_muram_alloc_fixed cpm_muram_alloc_fixed
+#define qe_muram_free cpm_muram_free
+#define qe_muram_addr cpm_muram_addr
+#define qe_muram_offset cpm_muram_offset
 
 /* Structure that defines QE firmware binary files.
  *
@@ -198,20 +192,6 @@ struct qe_bd {
 #define BD_STATUS_MASK	0xffff0000
 #define BD_LENGTH_MASK	0x0000ffff
 
-#define BD_SC_EMPTY	0x8000	/* Receive is empty */
-#define BD_SC_READY	0x8000	/* Transmit is ready */
-#define BD_SC_WRAP	0x2000	/* Last buffer descriptor */
-#define BD_SC_INTRPT	0x1000	/* Interrupt on change */
-#define BD_SC_LAST	0x0800	/* Last buffer in frame */
-#define BD_SC_CM	0x0200	/* Continous mode */
-#define BD_SC_ID	0x0100	/* Rec'd too many idles */
-#define BD_SC_P		0x0100	/* xmt preamble */
-#define BD_SC_BR	0x0020	/* Break received */
-#define BD_SC_FR	0x0010	/* Framing error */
-#define BD_SC_PR	0x0008	/* Parity error */
-#define BD_SC_OV	0x0002	/* Overrun */
-#define BD_SC_CD	0x0001	/* ?? */
-
 /* Alignment */
 #define QE_INTR_TABLE_ALIGN	16	/* ??? */
 #define QE_ALIGNMENT_OF_BD	8
-- 
1.5.5.1
