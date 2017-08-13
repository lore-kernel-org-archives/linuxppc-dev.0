Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLrB19ZpzDr2n
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:18 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id p13so6785026pfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 2/9] powerpc/powernv: powernv platform is not constrained
 by RMA
Date: Sun, 13 Aug 2017 11:33:39 +1000
Message-Id: <20170813013346.14002-2-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove incorrect comment about real mode address restrictions on
powernv (bare metal), and unnecessary clamping to ppc64_rma_size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index cad6b57ce494..caf60583293a 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -162,12 +162,9 @@ int __init early_init_dt_scan_recoverable_ranges(unsigned long node,
 			sizeof(struct mcheck_recoverable_range);
 
 	/*
-	 * Allocate a buffer to hold the MC recoverable ranges. We would be
-	 * accessing them in real mode, hence it needs to be within
-	 * RMO region.
+	 * Allocate a buffer to hold the MC recoverable ranges.
 	 */
-	mc_recoverable_range =__va(memblock_alloc_base(size, __alignof__(u64),
-							ppc64_rma_size));
+	mc_recoverable_range =__va(memblock_alloc(size, __alignof__(u64)));
 	memset(mc_recoverable_range, 0, size);
 
 	for (i = 0; i < mc_recoverable_range_len; i++) {
-- 
2.13.3
