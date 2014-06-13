Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52F3F1A055C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 17:23:28 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 13 Jun 2014 17:23:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A6A942CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 17:23:24 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5D7N8Cd9175480
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 17:23:09 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5D7NNNM013264
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 17:23:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: BOOK3S: HV: Use base page size when comparing
 against slb value
Date: Fri, 13 Jun 2014 12:53:10 +0530
Message-Id: <1402644190-15604-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With guest supporting Multiple page size per segment (MPSS),
hpte_page_size returns actual page size used. Add a new function to
return base page size and use that to compare against the the page size
calculated from SLB

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 19 +++++++++++++++++--
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 34422be566ce..3d0f3fb9c6b6 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -202,8 +202,10 @@ static inline unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	return rb;
 }
 
-static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
+static inline unsigned long __hpte_page_size(unsigned long h, unsigned long l,
+					     bool is_base_size)
 {
+
 	int size, a_psize;
 	/* Look at the 8 bit LP value */
 	unsigned int lp = (l >> LP_SHIFT) & ((1 << LP_BITS) - 1);
@@ -218,14 +220,27 @@ static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
 				continue;
 
 			a_psize = __hpte_actual_psize(lp, size);
-			if (a_psize != -1)
+			if (a_psize != -1) {
+				if (is_base_size)
+					return 1ul << mmu_psize_defs[size].shift;
 				return 1ul << mmu_psize_defs[a_psize].shift;
+			}
 		}
 
 	}
 	return 0;
 }
 
+static inline unsigned long hpte_page_size(unsigned long h, unsigned long l)
+{
+	return __hpte_page_size(h, l, 0);
+}
+
+static inline unsigned long hpte_base_page_size(unsigned long h, unsigned long l)
+{
+	return __hpte_page_size(h, l, 1);
+}
+
 static inline unsigned long hpte_rpn(unsigned long ptel, unsigned long psize)
 {
 	return ((ptel & HPTE_R_RPN) & ~(psize - 1)) >> PAGE_SHIFT;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index f53cf2eae36a..7ff45ed27c65 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1567,7 +1567,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 				goto out;
 			}
 			if (!rma_setup && is_vrma_hpte(v)) {
-				unsigned long psize = hpte_page_size(v, r);
+				unsigned long psize = hpte_base_page_size(v, r);
 				unsigned long senc = slb_pgsize_encoding(psize);
 				unsigned long lpcr;
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 87624ab5ba82..c6aca75b8376 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -839,7 +839,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 			 * to check against the actual page size.
 			 */
 			if ((v & valid) && (v & mask) == val &&
-			    hpte_page_size(v, r) == (1ul << pshift))
+			    hpte_base_page_size(v, r) == (1ul << pshift))
 				/* Return with the HPTE still locked */
 				return (hash << 3) + (i >> 1);
 
-- 
1.9.1
