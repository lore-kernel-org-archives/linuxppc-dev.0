Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wstMZ6968zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 15:20:26 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L5J3mD146828
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 01:20:24 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7jgv02ee-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 01:20:23 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 23:20:22 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/radix: GR field got removed in ISA 3.0B
Date: Wed, 21 Jun 2017 10:50:12 +0530
Message-Id: <1498022412-30339-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The bit position is now marked reserved. Hence don't set the bit to 1.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 1 -
 arch/powerpc/kvm/book3s_hv.c             | 6 +-----
 arch/powerpc/mm/pgtable-radix.c          | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 77529a3e3811..e28ce2793e7d 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -55,7 +55,6 @@ extern struct patb_entry *partition_tb;
 #define RPDS_MASK	0x1f		/* root page dir. size field */
 
 /* Bits in patb1 field */
-#define PATB_GR		(1UL << 63)	/* guest uses radix; must match HR */
 #define PRTS_MASK	0x1f		/* process table size field */
 #define PRTB_MASK	0x0ffffffffffff000UL
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 42b7a4fd57d9..657729a433f9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3185,7 +3185,7 @@ static void kvmppc_setup_partition_table(struct kvm *kvm)
 	} else {
 		dw0 = PATB_HR | radix__get_tree_size() |
 			__pa(kvm->arch.pgtable) | RADIX_PGD_INDEX_SIZE;
-		dw1 = PATB_GR | kvm->arch.process_table;
+		dw1 = kvm->arch.process_table;
 	}
 
 	mmu_partition_table_set_entry(kvm->arch.lpid, dw0, dw1);
@@ -3840,10 +3840,6 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	if (radix != kvm_is_radix(kvm))
 		return -EINVAL;
 
-	/* GR (guest radix) bit in process_table field must match */
-	if (!!(cfg->process_table & PATB_GR) != radix)
-		return -EINVAL;
-
 	/* Process table size field must be reasonable, i.e. <= 24 */
 	if ((cfg->process_table & PRTS_MASK) > 24)
 		return -EINVAL;
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6e3d1518eef3..338d69a726b2 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -25,7 +25,7 @@
 static int native_register_process_table(unsigned long base, unsigned long pg_sz,
 					 unsigned long table_size)
 {
-	unsigned long patb1 = base | table_size | PATB_GR;
+	unsigned long patb1 = base | table_size;
 
 	partition_tb->patb1 = cpu_to_be64(patb1);
 	return 0;
-- 
2.7.4
