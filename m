Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35Zv0HlCzDrdP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:17:42 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id k15so14390969pgr.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:17:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 4/9] powerpc/pseries: lift RTAS limit for radix
Date: Fri, 22 Dec 2017 21:17:11 +1000
Message-Id: <20171222111716.13101-5-npiggin@gmail.com>
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

With the previous patch to switch to 64-bit mode after returning from
RTAS and before doing any memory accesses, the RMA limit need not be
clamped to 1GB to avoid RTAS bugs.

Keep the 1GB limit for older firmware (although this is more of a kernel
concern than RTAS), and remove it starting with POWER9.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6606216f1992..b8c49e6623ae 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -623,23 +623,10 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 */
 	BUG_ON(first_memblock_base != 0);
 
-	if (!early_cpu_has_feature(CPU_FTR_HVMODE)) {
-		/*
-		 * Radix mode guests are not limited by RMA / VRMA addressing.
-		 *
-		 * We do clamp addresses to 1GB to avoid some funky things
-		 * such as RTAS bugs.
-		 */
-		ppc64_rma_size = 0x40000000;
-		/*
-		 * Finally limit subsequent allocations. We really don't want
-		 * to limit the memblock allocations to rma_size. FIXME!! should
-		 * we even limit at all ?
-		 */
-		memblock_set_current_limit(first_memblock_base + first_memblock_size);
-	} else {
-		ppc64_rma_size = ULONG_MAX;
-	}
+	/*
+	 * Radix mode is not limited by RMA / VRMA addressing.
+	 */
+	ppc64_rma_size = ULONG_MAX;
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-- 
2.15.0
