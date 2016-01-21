Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D9C21A0019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:29 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 21 Jan 2016 18:16:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6CC5A2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:25 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L8FtRc33620030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:16:03 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L8Frxn007996
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 19:15:53 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 3/4] KVM: PPC: Add @offset to kvmppc_spapr_tce_table
Date: Thu, 21 Jan 2016 19:15:25 +1100
Message-Id: <1453364126-22527-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_host.h | 1 +
 arch/powerpc/kvm/book3s_64_vio_hv.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index a4ed9f5..8769f91 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -185,6 +185,7 @@ struct kvmppc_spapr_tce_table {
 	u64 liobn;
 	struct rcu_head rcu;
 	u32 page_shift;
+	u64 offset;		/* in pages */
 	u64 size;		/* in pages */
 	struct page *pages[0];
 };
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 01ef9f9..0e66459 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -75,7 +75,8 @@ long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 	unsigned long mask = ~((1ULL << stt->page_shift) - 1);
 	unsigned long idx = ioba >> stt->page_shift;
 
-	if ((ioba & ~mask) || (idx + npages > stt->size))
+	if ((ioba & ~mask) || (idx < stt->offset) ||
+			(idx - stt->offset + npages > stt->size))
 		return H_PARAMETER;
 
 	return H_SUCCESS;
@@ -147,6 +148,7 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
 	struct page *page;
 	u64 *tbl;
 
+	idx -= stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = kvmppc_page_address(page);
 
@@ -324,7 +326,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	if (ret != H_SUCCESS)
 		return ret;
 
-	idx = ioba >> stt->page_shift;
+	idx = (ioba >> stt->page_shift) - stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	tbl = (u64 *)page_address(page);
 
-- 
2.5.0.rc3
