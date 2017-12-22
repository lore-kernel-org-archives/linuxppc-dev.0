Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35Zm3NHhzF0Bf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:17:36 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id d21so12732117pll.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:17:36 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/9] powerpc/pseries: radix is not subject to RMA limit,
 remove it
Date: Fri, 22 Dec 2017 21:17:09 +1000
Message-Id: <20171222111716.13101-3-npiggin@gmail.com>
In-Reply-To: <20171222111716.13101-1-npiggin@gmail.com>
References: <20171222111716.13101-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The radix guest is not subject to the paravirtualized HPT VRMA limit,
so remove that from ppc64_rma_size calculation for that platform.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index d73816960825..6606216f1992 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -625,15 +625,12 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 
 	if (!early_cpu_has_feature(CPU_FTR_HVMODE)) {
 		/*
-		 * We limit the allocation that depend on ppc64_rma_size
-		 * to first_memblock_size. We also clamp it to 1GB to
-		 * avoid some funky things such as RTAS bugs.
+		 * Radix mode guests are not limited by RMA / VRMA addressing.
 		 *
-		 * On radix config we really don't have a limitation
-		 * on real mode access. But keeping it as above works
-		 * well enough.
+		 * We do clamp addresses to 1GB to avoid some funky things
+		 * such as RTAS bugs.
 		 */
-		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+		ppc64_rma_size = 0x40000000;
 		/*
 		 * Finally limit subsequent allocations. We really don't want
 		 * to limit the memblock allocations to rma_size. FIXME!! should
-- 
2.15.0
