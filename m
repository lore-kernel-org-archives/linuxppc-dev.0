Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdghF5RgwzDvjg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 13:37:01 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au,
 stewart@linux.vnet.ibm.com, bsingharora@gmail.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v3] powerpc/powernv: Initialise nest mmu
Date: Wed, 14 Dec 2016 13:36:51 +1100
Message-Id: <1481683011-12819-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 contains an off core mmu called the nest mmu (NMMU). This is
used by other hardware units on the chip to translate virtual
addresses into real addresses. The unit attempting an address
translation provides the majority of the context required for the
translation request except for the base address of the partition table
(ie. the PTCR) which needs to be programmed into the NMMU.

This patch adds a call to OPAL to set the PTCR for the nest mmu in
opal_init().

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

Differences from v2:
 * Rename powernv_set_ptcr() to powernv_set_nmmu_ptcr() as suggested by Aneesh
 * Fix a logic error/typo when checking the opal call return code

Michael the skiboot fix to stop this breaking in mambo has been posted
(see http://patchwork.ozlabs.org/patch/702564/). Will let you know
when it has gone upstream.

 arch/powerpc/include/asm/opal-api.h            |  3 ++-
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/mm/pgtable-radix.c                |  8 ++++++--
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/opal.c          | 11 +++++++++++
 arch/powerpc/platforms/powernv/powernv.h       |  6 ++++++
 6 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..a0aa285 100644
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
index e958b70..b61c3d3 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -229,6 +229,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);

 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 688b545..d5e868b 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -18,6 +18,7 @@
 #include <asm/machdep.h>
 #include <asm/mmu.h>
 #include <asm/firmware.h>
+#include <platforms/powernv/powernv.h>

 #include <trace/events/thp.h>

@@ -177,7 +178,7 @@ static void __init radix_init_pgtable(void)

 static void __init radix_init_partition_table(void)
 {
-	unsigned long rts_field;
+	unsigned long rts_field, ptcr;

 	rts_field = radix__get_tree_size();

@@ -193,7 +194,9 @@ static void __init radix_init_partition_table(void)
 	 * update partition table control register,
 	 * 64 K size.
 	 */
-	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+	ptcr = __pa(partition_tb) | (PATB_SIZE_SHIFT - 12);
+	mtspr(SPRN_PTCR, ptcr);
+	powernv_set_nmmu_ptcr(ptcr);
 }

 void __init radix_init_native(void)
@@ -408,6 +411,7 @@ void radix__mmu_cleanup_all(void)
 		lpcr = mfspr(SPRN_LPCR);
 		mtspr(SPRN_LPCR, lpcr & ~LPCR_UPRT);
 		mtspr(SPRN_PTCR, 0);
+		powernv_set_nmmu_ptcr(0);
 		radix__flush_tlb_all();
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 44d2d84..894639b 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -308,4 +308,5 @@ OPAL_CALL(opal_int_set_cppr,			OPAL_INT_SET_CPPR);
 OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 6c9a65b..773077e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -885,6 +885,17 @@ int opal_error_code(int rc)
 	}
 }

+void powernv_set_nmmu_ptcr(unsigned long ptcr)
+{
+	int rc;
+
+	if (firmware_has_feature(FW_FEATURE_OPAL)) {
+		rc = opal_nmmu_set_ptcr(-1UL, ptcr);
+		if (rc != OPAL_SUCCESS && rc != OPAL_UNSUPPORTED)
+			pr_warn("%s: Unable to set nest mmu ptcr\n", __func__);
+	}
+}
+
 EXPORT_SYMBOL_GPL(opal_poll_events);
 EXPORT_SYMBOL_GPL(opal_rtc_read);
 EXPORT_SYMBOL_GPL(opal_rtc_write);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index da7c843..c49a2b0 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -9,6 +9,12 @@ static inline void pnv_smp_init(void) { }

 struct pci_dev;

+#ifdef CONFIG_PPC_POWERNV
+extern void powernv_set_nmmu_ptcr(unsigned long ptcr);
+#else
+static inline void powernv_set_nmmu_ptcr(unsigned long ptcr) { }
+#endif
+
 #ifdef CONFIG_PCI
 extern void pnv_pci_init(void);
 extern void pnv_pci_shutdown(void);
--
2.1.4
