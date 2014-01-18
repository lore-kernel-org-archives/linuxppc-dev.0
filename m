Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0150.outbound.protection.outlook.com [207.46.163.150])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 38FEA2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 11:53:25 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/booke64: Guard e6500 tlb handler with
 CONFIG_PPC_FSL_BOOK3E
Date: Fri, 17 Jan 2014 18:53:10 -0600
Message-ID: <1390006390-31024-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

...and make CONFIG_PPC_FSL_BOOK3E conflict with CONFIG_PPC_64K_PAGES.

This fixes a build break with CONFIG_PPC_64K_PAGES on 64-bit book3e,
that was introduced by commit 28efc35fe68dacbddc4b12c2fa8f2df1593a4ad3
("powerpc/e6500: TLB miss handler with hardware tablewalk support").

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig          | 1 +
 arch/powerpc/mm/tlb_low_64e.S | 3 ++-
 arch/powerpc/mm/tlb_nohash.c  | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fa39517..ad912d5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -526,6 +526,7 @@ config PPC_16K_PAGES
 
 config PPC_64K_PAGES
 	bool "64k page size" if 44x || PPC_STD_MMU_64 || PPC_BOOK3E_64
+	depends on !PPC_FSL_BOOK3E
 	select PPC_HAS_HASH_64K if PPC_STD_MMU_64
 
 config PPC_256K_PAGES
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 16250b1..c95eb32 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -240,6 +240,7 @@ itlb_miss_fault_bolted:
 	beq	tlb_miss_common_bolted
 	b	itlb_miss_kernel_bolted
 
+#ifdef CONFIG_PPC_FSL_BOOK3E
 /*
  * TLB miss handling for e6500 and derivatives, using hardware tablewalk.
  *
@@ -409,7 +410,7 @@ itlb_miss_fault_e6500:
 	TLB_MISS_STATS_I(MMSTAT_TLB_MISS_NORM_FAULT)
 	tlb_epilog_bolted
 	b	exc_instruction_storage_book3e
-
+#endif /* CONFIG_PPC_FSL_BOOK3E */
 
 /**********************************************************************
  *                                                                    *
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 735839b..b37a58e 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -557,10 +557,12 @@ static void setup_mmu_htw(void)
 		patch_exception(0x1c0, exc_data_tlb_miss_htw_book3e);
 		patch_exception(0x1e0, exc_instruction_tlb_miss_htw_book3e);
 		break;
+#ifdef CONFIG_PPC_FSL_BOOK3E
 	case PPC_HTW_E6500:
 		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
 		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
 		break;
+#endif
 	}
 	pr_info("MMU: Book3E HW tablewalk %s\n",
 		book3e_htw_mode != PPC_HTW_NONE ? "enabled" : "not supported");
-- 
1.8.3.2
