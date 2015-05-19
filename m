Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12D6E1A05FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:08 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 01/19] powerpc/copro: Fix faulting kernel segments
Date: Tue, 19 May 2015 21:22:18 +1000
Message-Id: <1432034556-32400-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1432034556-32400-1-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes calculating the key bits (KP and KS) in the SLB VSID for kernel
mappings.

I'm not CCing this to stable as there are no uses of this currently.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/mm/copro_fault.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index f031a47..7a71d7f 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(copro_handle_mm_fault);
 
 int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 {
-	u64 vsid;
+	u64 vsid, vsidkey;
 	int psize, ssize;
 
 	switch (REGION_ID(ea)) {
@@ -109,6 +109,7 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 		psize = get_slice_psize(mm, ea);
 		ssize = user_segment_size(ea);
 		vsid = get_vsid(mm->context.id, ea, ssize);
+		vsidkey = SLB_VSID_USER;
 		break;
 	case VMALLOC_REGION_ID:
 		pr_devel("%s: 0x%llx -- VMALLOC_REGION_ID\n", __func__, ea);
@@ -118,19 +119,21 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 			psize = mmu_io_psize;
 		ssize = mmu_kernel_ssize;
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
+		vsidkey = SLB_VSID_KERNEL;
 		break;
 	case KERNEL_REGION_ID:
 		pr_devel("%s: 0x%llx -- KERNEL_REGION_ID\n", __func__, ea);
 		psize = mmu_linear_psize;
 		ssize = mmu_kernel_ssize;
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
+		vsidkey = SLB_VSID_KERNEL;
 		break;
 	default:
 		pr_debug("%s: invalid region access at %016llx\n", __func__, ea);
 		return 1;
 	}
 
-	vsid = (vsid << slb_vsid_shift(ssize)) | SLB_VSID_USER;
+	vsid = (vsid << slb_vsid_shift(ssize)) | vsidkey;
 
 	vsid |= mmu_psize_defs[psize].sllp |
 		((ssize == MMU_SEGSIZE_1T) ? SLB_VSID_B_1T : 0);
-- 
2.1.0
