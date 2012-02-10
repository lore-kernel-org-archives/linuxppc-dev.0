Return-Path: <amwang@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id CE126B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 16:41:56 +1100 (EST)
From: Cong Wang <amwang@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 05/60] powerpc: remove the second argument of k[un]map_atomic()
Date: Fri, 10 Feb 2012 13:39:26 +0800
Message-Id: <1328852421-19678-6-git-send-email-amwang@redhat.com>
In-Reply-To: <1328852421-19678-1-git-send-email-amwang@redhat.com>
References: <1328852421-19678-1-git-send-email-amwang@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Dave Carroll <dcarroll@astekcorp.com>, Cong Wang <amwang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Avi Kivity <avi@redhat.com>,
 kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cong Wang <amwang@redhat.com>
---
 arch/powerpc/kvm/book3s_pr.c      |    4 ++--
 arch/powerpc/mm/dma-noncoherent.c |    5 ++---
 arch/powerpc/mm/hugetlbpage.c     |    4 ++--
 arch/powerpc/mm/mem.c             |    4 ++--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index e2cfb9e..220fcdf 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -227,14 +227,14 @@ static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 	hpage_offset /= 4;
 
 	get_page(hpage);
-	page = kmap_atomic(hpage, KM_USER0);
+	page = kmap_atomic(hpage);
 
 	/* patch dcbz into reserved instruction, so we trap */
 	for (i=hpage_offset; i < hpage_offset + (HW_PAGE_SIZE / 4); i++)
 		if ((page[i] & 0xff0007ff) == INS_DCBZ)
 			page[i] &= 0xfffffff7;
 
-	kunmap_atomic(page, KM_USER0);
+	kunmap_atomic(page);
 	put_page(hpage);
 }
 
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index 329be36..6747eec 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -365,12 +365,11 @@ static inline void __dma_sync_page_highmem(struct page *page,
 	local_irq_save(flags);
 
 	do {
-		start = (unsigned long)kmap_atomic(page + seg_nr,
-				KM_PPC_SYNC_PAGE) + seg_offset;
+		start = (unsigned long)kmap_atomic(page + seg_nr) + seg_offset;
 
 		/* Sync this buffer segment */
 		__dma_sync((void *)start, seg_size, direction);
-		kunmap_atomic((void *)start, KM_PPC_SYNC_PAGE);
+		kunmap_atomic((void *)start);
 		seg_nr++;
 
 		/* Calculate next buffer segment size */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index a8b3cc7..57c7465 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -910,9 +910,9 @@ void flush_dcache_icache_hugepage(struct page *page)
 		if (!PageHighMem(page)) {
 			__flush_dcache_icache(page_address(page+i));
 		} else {
-			start = kmap_atomic(page+i, KM_PPC_SYNC_ICACHE);
+			start = kmap_atomic(page+i);
 			__flush_dcache_icache(start);
-			kunmap_atomic(start, KM_PPC_SYNC_ICACHE);
+			kunmap_atomic(start);
 		}
 	}
 }
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d974b79..baaafde 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -458,9 +458,9 @@ void flush_dcache_icache_page(struct page *page)
 #endif
 #ifdef CONFIG_BOOKE
 	{
-		void *start = kmap_atomic(page, KM_PPC_SYNC_ICACHE);
+		void *start = kmap_atomic(page);
 		__flush_dcache_icache(start);
-		kunmap_atomic(start, KM_PPC_SYNC_ICACHE);
+		kunmap_atomic(start);
 	}
 #elif defined(CONFIG_8xx) || defined(CONFIG_PPC64)
 	/* On 8xx there is no need to kmap since highmem is not supported */
-- 
1.7.7.6
