Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tX7H26HbszDt0L
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 12:59:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: alistair@popple.id.au
Subject: [PATCH v2] powerpc/powernv: Initialise nest mmu
Date: Mon,  5 Dec 2016 12:59:22 +1100
Message-Id: <1480903162-1986-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

POWER9 contains an off core mmu called the nest mmu (NMMU). This is used
by other hardware units on the chip to translate virtual addresses into
real addresses. The unit attempting an address translation provides the
majority of the context required for the translation request except for
the base address of the partition table (ie. the PTCR) which needs to be
programmed into the NMMU.

This patch adds a call to OPAL to set the PTCR for the nest mmu in
opal_init().

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/opal-api.h            |  3 ++-
 arch/powerpc/include/asm/opal.h                |  7 +++++++
 arch/powerpc/mm/pgtable-radix.c                |  2 ++
 arch/powerpc/mm/pgtable_64.c                   |  7 +++++--
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/opal.c          | 11 +++++++++++
 6 files changed, 28 insertions(+), 3 deletions(-)

v2: Rebased onto powerpc#next.

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57bcab50..a0aa285869b5 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,8 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_NMMU_SET_PTCR			127
+#define OPAL_LAST				127
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5c7db0f1a708..a3f9578614db 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -232,6 +232,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
@@ -310,6 +311,12 @@ static inline int opal_get_async_rc(struct opal_msg msg)
 
 void opal_wake_poller(void);
 
+#ifdef CONFIG_PPC_POWERNV
+extern void powernv_set_ptcr(unsigned long ptcr);
+#else
+static inline void powernv_set_ptcr(unsigned long ptcr) { }
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_OPAL_H */
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 623a0dc9a9fa..8af5ece4d0b3 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -12,6 +12,7 @@
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 
+#include <asm/opal.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/dma.h>
@@ -434,6 +435,7 @@ void radix__mmu_cleanup_all(void)
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr & ~LPCR_UPRT);
 		mtspr(SPRN_PTCR, 0);
+		powernv_set_ptcr(0);
 		radix__flush_tlb_all();
 	}
 }
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 8bca7f58afc4..461c902efbb7 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -44,6 +44,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
+#include <asm/opal.h>
 #include <asm/smp.h>
 #include <asm/machdep.h>
 #include <asm/tlb.h>
@@ -435,7 +436,7 @@ void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 #ifdef CONFIG_PPC_BOOK3S_64
 void __init mmu_partition_table_init(void)
 {
-	unsigned long patb_size = 1UL << PATB_SIZE_SHIFT;
+	unsigned long ptcr, patb_size = 1UL << PATB_SIZE_SHIFT;
 
 	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 36), "Partition table size too large.");
 	partition_tb = __va(memblock_alloc_base(patb_size, patb_size,
@@ -448,7 +449,9 @@ void __init mmu_partition_table_init(void)
 	 * update partition table control register,
 	 * 64 K size.
 	 */
-	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+	ptcr = __pa(partition_tb) | (PATB_SIZE_SHIFT - 12);
+	mtspr(SPRN_PTCR, ptcr);
+	powernv_set_ptcr(ptcr);
 }
 
 void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3aa40f1b20f5..f7c19c9c57ed 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -311,4 +311,5 @@ OPAL_CALL_REAL(opal_rm_int_eoi,			OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL_REAL(opal_rm_int_set_mfrr,		OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 282293572dc8..efc20e93cd36 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -875,6 +875,17 @@ int opal_error_code(int rc)
 	}
 }
 
+void powernv_set_ptcr(unsigned long ptcr)
+{
+	int rc;
+
+	if (firmware_has_feature(FW_FEATURE_OPAL)) {
+		rc = opal_nmmu_set_ptcr(-1UL, ptcr);
+		if (rc != OPAL_SUCCESS || rc != OPAL_UNSUPPORTED)
+			pr_warn("%s: Unable to set nest mmu ptcr\n", __func__);
+	}
+}
+
 EXPORT_SYMBOL_GPL(opal_poll_events);
 EXPORT_SYMBOL_GPL(opal_rtc_read);
 EXPORT_SYMBOL_GPL(opal_rtc_write);
-- 
2.7.4
