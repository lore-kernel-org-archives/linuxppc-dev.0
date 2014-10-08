Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 737F31A1791
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 19:55:30 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v4 11/16] powerpc/mm: Add hooks for cxl
Date: Wed,  8 Oct 2014 19:55:00 +1100
Message-Id: <1412758505-23495-12-git-send-email-mikey@neuling.org>
In-Reply-To: <1412758505-23495-1-git-send-email-mikey@neuling.org>
References: <1412758505-23495-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds hooks into the core powerpc mm code for cxl.

The core powerpc code sometimes uses local tlbie. Unfortunately this won't
work with the current cxl driver as it relies on snooping tlbie broadcasts.

The cxl hardware can have TLB entries invalidated via MMIO but this is not
currently supported by the driver. In future we can make local tlbie smarter so
that it invalidates cxl contexts via MMIO when it needs to but for now we have
this workaround.

This workaround checks for any active cxl contexts and if so, disables local
tlbie.

This also adds a hook for when SLBs are invalidated. This ensures any
corresponding SLBs in cxl are also invalidated at the same time. This is
required for segment demotion.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/mm/copro_fault.c    | 2 ++
 arch/powerpc/mm/hash_native_64.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index f2aa5a8..0f9939e 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -26,6 +26,7 @@
 #include <asm/reg.h>
 #include <asm/copro.h>
 #include <asm/spu.h>
+#include <misc/cxl.h>
 
 /*
  * This ought to be kept in sync with the powerpc specific do_page_fault
@@ -143,5 +144,6 @@ void copro_flush_all_slbs(struct mm_struct *mm)
 #ifdef CONFIG_SPU_BASE
 	spu_flush_all_slbs(mm);
 #endif
+	cxl_slbia(mm);
 }
 EXPORT_SYMBOL_GPL(copro_flush_all_slbs);
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index afc0a82..ae4962a 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -29,6 +29,8 @@
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
 
+#include <misc/cxl.h>
+
 #ifdef DEBUG_LOW
 #define DBG_LOW(fmt...) udbg_printf(fmt)
 #else
@@ -149,9 +151,11 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 static inline void tlbie(unsigned long vpn, int psize, int apsize,
 			 int ssize, int local)
 {
-	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
+	unsigned int use_local;
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 
+	use_local = local && mmu_has_feature(MMU_FTR_TLBIEL) && !cxl_ctx_in_use();
+
 	if (use_local)
 		use_local = mmu_psize_defs[psize].tlbiel;
 	if (lock_tlbie && !use_local)
-- 
1.9.1
