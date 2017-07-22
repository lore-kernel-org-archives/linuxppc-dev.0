Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqWb2zjYzDqxy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:18:03 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c23so5888008pfe.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:18:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 03/11] powerpc/64s/radix: Remove SLB address limit for
 per-cpu stacks
Date: Sat, 22 Jul 2017 11:17:33 +1000
Message-Id: <20170722011741.13942-4-npiggin@gmail.com>
In-Reply-To: <20170722011741.13942-1-npiggin@gmail.com>
References: <20170722011741.13942-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Radix MMU does not take SLB or TLB interrupts when accessing kernel
linear address. Remove this restriction for radix mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index af23d4b576ec..4ecc4315b308 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -564,6 +564,9 @@ static __init u64 safe_stack_limit(void)
 	/* Other BookE, we assume the first GB is bolted */
 	return 1ul << 30;
 #else
+	if (early_radix_enabled())
+		return ULONG_MAX;
+
 	/* BookS, the first segment is bolted */
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		return 1UL << SID_SHIFT_1T;
-- 
2.11.0
