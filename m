Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bGyy5FDQzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 23:58:18 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id k19-v6so1788881pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 06:58:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s/radix: tlb do not flush on page size when fullmm
Date: Wed, 25 Jul 2018 23:58:06 +1000
Message-Id: <20180725135806.29648-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the mm is being torn down there will be a full PID flush so
there is no need to flush the TLB on page size changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/tlb.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 5d3107f2b014..d1b3dc4a6a0a 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -84,6 +84,9 @@ static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
+	if (tlb->fullmm)
+		return;
+
 	if (!tlb->page_size)
 		tlb->page_size = page_size;
 	else if (tlb->page_size != page_size) {
-- 
2.17.0
