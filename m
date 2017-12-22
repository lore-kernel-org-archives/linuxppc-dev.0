Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35Zy1StWzF0Bf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:17:46 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id l24so15186172pfj.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:17:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 5/9] powerpc/pseries: lift RTAS limit for hash
Date: Fri, 22 Dec 2017 21:17:12 +1000
Message-Id: <20171222111716.13101-6-npiggin@gmail.com>
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
 arch/powerpc/mm/hash_utils_64.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8922e069b073..3c1bc1e6fa91 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1830,11 +1830,13 @@ void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 * non-virtualized 64-bit hash MMU systems don't have a limitation
 	 * on real mode access.
 	 *
-	 * We also clamp it to 1G to avoid some funky things
-	 * such as RTAS bugs etc...
+	 * For guests on platforms before POWER9, we clamp the it limit to 1G
+	 * to avoid some funky things such as RTAS bugs etc...
 	 */
 	if (!early_cpu_has_feature(CPU_FTR_HVMODE)) {
-		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+		ppc64_rma_size = first_memblock_size;
+		if (!early_cpu_has_feature(CPU_FTR_ARCH_300))
+			ppc64_rma_size = min_t(u64, ppc64_rma_size, 0x40000000);
 
 		/* Finally limit subsequent allocations */
 		memblock_set_current_limit(ppc64_rma_size);
-- 
2.15.0
