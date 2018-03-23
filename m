Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406rqy1MLgzF21k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 15:57:18 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2N4s5Rd051283
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:57:15 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvtv807n9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:57:15 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 22:57:14 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mauricfo@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/mm: Fixup tlbie vs store ordering issue on POWER9
Date: Fri, 23 Mar 2018 10:26:27 +0530
In-Reply-To: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180323045627.16800-3-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9, under some circumstances, a broadcast TLB invalidation might complete
before all previous stores have drained, potentially allowing stale stores from
becoming visible after the invalidation. This works around it by doubling up
those TLB invalidations which was verified by HW to be sufficient to close the
risk window.

Fixes: 1a472c9dba6b ("powerpc/mm/radix: Add tlbflush routines")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cputable.h    |  3 ++-
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  3 +++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c    | 11 +++++++++++
 arch/powerpc/mm/hash_native_64.c       | 16 +++++++++++++++-
 arch/powerpc/mm/pgtable_64.c           |  1 +
 arch/powerpc/mm/tlb-radix.c            | 15 +++++++++++++++
 6 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a2c5c95882cf..6c151d2e9bd9 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -203,6 +203,7 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_TLBIE_BUG		LONG_ASM_CONST(0x2000000000000000)
 #define CPU_FTR_POWER9_DD1		LONG_ASM_CONST(0x4000000000000000)
 #define CPU_FTR_POWER9_DD2_1		LONG_ASM_CONST(0x8000000000000000)
 
@@ -465,7 +466,7 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300 | \
-	    CPU_FTR_PKEY)
+	    CPU_FTR_PKEY | CPU_FTR_TLBIE_BUG)
 #define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
 			     (~CPU_FTR_SAO))
 #define CPU_FTRS_POWER9_DD2_0 CPU_FTRS_POWER9
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 5cb4e4687107..62f60778177b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -157,6 +157,9 @@ static void kvmppc_radix_tlbie_page(struct kvm *kvm, unsigned long addr,
 	asm volatile("ptesync": : :"memory");
 	asm volatile(PPC_TLBIE_5(%0, %1, 0, 0, 1)
 		     : : "r" (addr), "r" (kvm->arch.lpid) : "memory");
+	if (cpu_has_feature(CPU_FTR_TLBIE_BUG))
+		asm volatile(PPC_TLBIE_5(%0, %1, 0, 0, 1)
+			     : : "r" (addr), "r" (kvm->arch.lpid) : "memory");
 	asm volatile("ptesync": : :"memory");
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 8888e625a999..aebcb718b614 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -473,6 +473,17 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 			trace_tlbie(kvm->arch.lpid, 0, rbvalues[i],
 				kvm->arch.lpid, 0, 0, 0);
 		}
+
+		if (cpu_has_feature(CPU_FTR_TLBIE_BUG)) {
+			/*
+			 * Need the extra ptesync to make sure we don't
+			 * re-order the tlbie
+			 */
+			asm volatile("ptesync": : :"memory");
+			asm volatile(PPC_TLBIE_5(%0,%1,0,0,0) : :
+				     "r" (rbvalues[0]), "r" (kvm->arch.lpid));
+		}
+
 		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 		kvm->arch.tlbie_lock = 0;
 	} else {
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 993842f1ed60..45b1772d3097 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -201,6 +201,15 @@ static inline unsigned long  ___tlbie(unsigned long vpn, int psize,
 	return va;
 }
 
+static inline void fixup_tlbie(unsigned long vpn, int psize, int apsize, int ssize)
+{
+	if (cpu_has_feature(CPU_FTR_TLBIE_BUG)) {
+		/* Need the extra ptesync to ensure we don't reorder tlbie*/
+		asm volatile("ptesync": : :"memory");
+		___tlbie(vpn, psize, apsize, ssize);
+	}
+}
+
 static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 {
 	unsigned long rb;
@@ -278,6 +287,7 @@ static inline void tlbie(unsigned long vpn, int psize, int apsize,
 		asm volatile("ptesync": : :"memory");
 	} else {
 		__tlbie(vpn, psize, apsize, ssize);
+		fixup_tlbie(vpn, psize, apsize, ssize);
 		asm volatile("eieio; tlbsync; ptesync": : :"memory");
 	}
 	if (lock_tlbie && !use_local)
@@ -771,7 +781,7 @@ static void native_hpte_clear(void)
  */
 static void native_flush_hash_range(unsigned long number, int local)
 {
-	unsigned long vpn;
+	unsigned long vpn = 0;
 	unsigned long hash, index, hidx, shift, slot;
 	struct hash_pte *hptep;
 	unsigned long hpte_v;
@@ -843,6 +853,10 @@ static void native_flush_hash_range(unsigned long number, int local)
 				__tlbie(vpn, psize, psize, ssize);
 			} pte_iterate_hashed_end();
 		}
+		/*
+		 * Just do one more with the last used values.
+		 */
+		fixup_tlbie(vpn, psize, psize, ssize);
 		asm volatile("eieio; tlbsync; ptesync":::"memory");
 
 		if (lock_tlbie)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 28c980eb4422..adf469f312f2 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -481,6 +481,7 @@ void mmu_partition_table_set_entry(unsigned int lpid, unsigned long dw0,
 			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
 		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 0);
 	}
+	/* do we need fixup here ?*/
 	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
 }
 EXPORT_SYMBOL_GPL(mmu_partition_table_set_entry);
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 570fdc7b0e74..264b9e5f97cc 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -151,6 +151,17 @@ static inline void __tlbie_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
+static inline void fixup_tlbie(void)
+{
+	unsigned long pid = 0;
+	unsigned long va = ((1UL << 52) - 1);
+
+	if (cpu_has_feature(CPU_FTR_TLBIE_BUG)) {
+		asm volatile("ptesync": : :"memory");
+		__tlbie_va(va, pid, mmu_get_ap(MMU_PAGE_64K), RIC_FLUSH_TLB);
+	}
+}
+
 /*
  * We use 128 set in radix mode and 256 set in hpt mode.
  */
@@ -184,6 +195,7 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 {
 	asm volatile("ptesync": : :"memory");
 	__tlbie_pid(pid, ric);
+	fixup_tlbie();
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
@@ -237,6 +249,7 @@ static inline void _tlbie_va(unsigned long va, unsigned long pid,
 
 	asm volatile("ptesync": : :"memory");
 	__tlbie_va(va, pid, ap, ric);
+	fixup_tlbie();
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
@@ -248,6 +261,7 @@ static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 	if (also_pwc)
 		__tlbie_pid(pid, RIC_FLUSH_PWC);
 	__tlbie_va_range(start, end, pid, page_size, psize);
+	fixup_tlbie();
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
@@ -465,6 +479,7 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			if (hflush)
 				__tlbie_va_range(hstart, hend, pid,
 						HPAGE_PMD_SIZE, MMU_PAGE_2M);
+			fixup_tlbie();
 			asm volatile("eieio; tlbsync; ptesync": : :"memory");
 		}
 	}
-- 
2.14.3
