Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwx9H2J4szF1Wc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 12:37:55 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id f23-v6so406984plr.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 17:37:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/10] powerpc/mm/slice: remove dead code
Date: Wed,  7 Mar 2018 11:37:15 +1000
Message-Id: <20180307013718.13749-8-npiggin@gmail.com>
In-Reply-To: <20180307013718.13749-1-npiggin@gmail.com>
References: <20180307013718.13749-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code is never compiled in, and it gets broken by the next
patch, so remove it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 4b2fd37b727a..c4cb4de1fab5 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -803,12 +803,6 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	}
 #endif
 
-#if 0 /* too verbose */
-	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
-		 mm, addr, len);
-	slice_print_mask(" mask", &mask);
-	slice_print_mask(" available", &available);
-#endif
 	return !slice_check_range_fits(mm, &available, addr, len);
 }
 #endif
-- 
2.16.1
