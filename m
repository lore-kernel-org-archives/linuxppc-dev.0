Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BfcZ4413zF3Wt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:10 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id l9-v6so4461726pff.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 01/12] powerpc/64s/hash: Fix stab_rr off by one initialization
Date: Sat, 15 Sep 2018 01:30:45 +1000
Message-Id: <20180914153056.3644-2-npiggin@gmail.com>
In-Reply-To: <20180914153056.3644-1-npiggin@gmail.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This causes SLB alloation to start 1 beyond the start of the SLB.
There is no real problem because after it wraps it stats behaving
properly, it's just surprisig to see when looking at SLB traces.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 9f574e59d178..2f162c6e52d4 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -355,7 +355,7 @@ void slb_initialize(void)
 #endif
 	}
 
-	get_paca()->stab_rr = SLB_NUM_BOLTED;
+	get_paca()->stab_rr = SLB_NUM_BOLTED - 1;
 
 	lflags = SLB_VSID_KERNEL | linear_llp;
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
-- 
2.18.0
