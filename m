Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhrB6spSzDrfj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:14 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f2lq055626
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:13 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c361vfp3w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:13 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:12 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 09/17] powerpc/mm: Remove unused flag arg in
 global_invalidates
Date: Wed,  2 Aug 2017 11:10:08 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-10-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index fedb0139524c..5abaed27708b 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -42,7 +42,7 @@ static void *real_vmalloc_addr(void *x)
 }
 
 /* Return 1 if we need to do a global tlbie, 0 if we can use tlbiel */
-static int global_invalidates(struct kvm *kvm, unsigned long flags)
+static int global_invalidates(struct kvm *kvm)
 {
 	int global;
 	int cpu;
@@ -499,7 +499,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	if (v & HPTE_V_VALID) {
 		hpte[0] &= ~cpu_to_be64(HPTE_V_VALID);
 		rb = compute_tlbie_rb(v, pte_r, pte_index);
-		do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags), true);
+		do_tlbies(kvm, &rb, 1, global_invalidates(kvm), true);
 		/*
 		 * The reference (R) and change (C) bits in a HPT
 		 * entry can be set by hardware at any time up until
@@ -549,7 +549,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 
 	if (kvm_is_radix(kvm))
 		return H_FUNCTION;
-	global = global_invalidates(kvm, 0);
+	global = global_invalidates(kvm);
 	for (i = 0; i < 4 && ret == H_SUCCESS; ) {
 		n = 0;
 		for (; i < 4; ++i) {
@@ -709,8 +709,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 			rb = compute_tlbie_rb(v, r, pte_index);
 			hpte[0] = cpu_to_be64((pte_v & ~HPTE_V_VALID) |
 					      HPTE_V_ABSENT);
-			do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags),
-				  true);
+			do_tlbies(kvm, &rb, 1, global_invalidates(kvm), true);
 			/* Don't lose R/C bit updates done by hardware */
 			r |= be64_to_cpu(hpte[1]) & (HPTE_R_R | HPTE_R_C);
 			hpte[1] = cpu_to_be64(r);
-- 
2.13.3
