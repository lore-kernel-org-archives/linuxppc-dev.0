Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1846D1A0B54
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:52 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 1 Mar 2016 16:55:50 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 935753578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 17:55:44 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u216tVuM41746486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u216t6Cw015762
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 17:55:07 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: kvm-ppc@vger.kernel.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH kernel v2 3/4] KVM: PPC: Add @offset to kvmppc_spapr_tce_table
Date: Tue,  1 Mar 2016 17:54:39 +1100
Message-Id: <1456815280-38546-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1456815280-38546-1-git-send-email-aik@ozlabs.ru>
References: <1456815280-38546-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enables userspace view of TCE tables to start from non-zero offset
on a bus. This will be used for huge DMA windows.

This only changes the internal structure, the user interface needs to
change in order to use an offset.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/book3s_64_vio_hv.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index edf66f7..2e7c791 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -184,6 +184,7 @@ struct kvmppc_spapr_tce_table {
 	u64 liobn;
 	struct rcu_head rcu;
 	u32 page_shift;
+	u64 offset;		/* in pages */
 	u64 size;		/* window size in pages */
 	struct page *pages[0];
 };
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index c786a58..44be73e 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -75,7 +75,9 @@ long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 	unsigned long mask = (1ULL << stt->page_shift) - 1;
 	unsigned long idx = ioba >> stt->page_shift;
 
-	if ((ioba & mask) || (idx + npages > stt->size) || (idx + npages < idx))
+	if ((ioba & mask) || (idx < stt->offset) ||
+			(idx - stt->offset + npages > stt->size) ||
+			(idx + npages < idx))
 		return H_PARAMETER;
 
 	return H_SUCCESS;
@@ -147,6 +149,7 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 	struct page *page;
 	u64 *tbl;
 
+	idx -= stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = kvmppc_page_address(page);
 
@@ -335,7 +338,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	idx = ioba >> stt->page_shift;
+	idx = (ioba >> stt->page_shift) - stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
-- 
2.5.0.rc3
