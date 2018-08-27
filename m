Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zGsy3tPPzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 13:03:18 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id l9-v6so7018409pff.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 20:03:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/2] powerpc/64s/radix: Explicitly flush ERAT with local LPID
 invalidation
Date: Mon, 27 Aug 2018 13:03:02 +1000
Message-Id: <20180827030302.17541-3-npiggin@gmail.com>
In-Reply-To: <20180827030302.17541-1-npiggin@gmail.com>
References: <20180827030302.17541-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Local radix TLB flush operations that operate on congruence classes
have explicit ERAT flushes for POWER9. The process scoped LPID flush
did not have a flush, so add it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/tlb-radix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index fef3e1eb3a19..4e798f33c530 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -366,6 +366,7 @@ static inline void _tlbiel_lpid_guest(unsigned long lpid, unsigned long ric)
 		__tlbiel_lpid_guest(lpid, set, RIC_FLUSH_TLB);
 
 	asm volatile("ptesync": : :"memory");
+	asm volatile(PPC_INVALIDATE_ERAT : : :"memory");
 }
 
 
-- 
2.18.0
