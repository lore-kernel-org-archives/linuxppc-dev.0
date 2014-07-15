Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB5321A038F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:43 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:25:43 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 456D92CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:40 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F92v3B1704394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:02:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9PdJI026046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:25:39 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 06/13] KVM: PPC: Add @offset to kvmppc_spapr_tce_table
Date: Tue, 15 Jul 2014 19:25:26 +1000
Message-Id: <1405416333-12477-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables guest visible TCE tables to start from non-zero offset
on a bus. This will be used for VFIO support.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/book3s_64_vio_hv.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index d3a154c..ed96b09 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -181,6 +181,7 @@ struct kvmppc_spapr_tce_table {
 	struct kvm *kvm;
 	u64 liobn;
 	u32 page_shift;
+	u64 offset;		/* in pages */
 	u64 size;		/* in pages */
 	struct page *pages[0];
 };
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index fadfacb..a3a6597 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -74,7 +74,8 @@ long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 	unsigned long mask = (1 << IOMMU_PAGE_SHIFT_4K) - 1;
 	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
 
-	if ((ioba & mask) || (stt->size + npages <= idx))
+	if ((ioba & mask) || (idx < stt->offset) ||
+			(stt->offset + stt->size + npages <= idx))
 		return H_PARAMETER;
 
 	return H_SUCCESS;
@@ -146,6 +147,7 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 	struct page *page;
 	u64 *tbl;
 
+	idx -= stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = kvmppc_page_address(page);
 
@@ -351,6 +353,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		return ret;
 
 	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
+	idx -= stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
-- 
2.0.0
