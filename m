Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 13/63] powerpc: Make cache info device tree accesses endian
 safe
Date: Wed,  7 Aug 2013 02:01:30 +1000
Message-Id: <1375804940-22050-14-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/setup_64.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b3b5fd3..00dfcc5 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -305,14 +305,14 @@ static void __init initialize_cache_info(void)
 		 * d-cache and i-cache sizes... -Peter
 		 */
 		if (num_cpus == 1) {
-			const u32 *sizep, *lsizep;
+			const __be32 *sizep, *lsizep;
 			u32 size, lsize;
 
 			size = 0;
 			lsize = cur_cpu_spec->dcache_bsize;
 			sizep = of_get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
-				size = *sizep;
+				size = be32_to_cpu(*sizep);
 			lsizep = of_get_property(np, "d-cache-block-size",
 						 NULL);
 			/* fallback if block size missing */
@@ -321,7 +321,7 @@ static void __init initialize_cache_info(void)
 							 "d-cache-line-size",
 							 NULL);
 			if (lsizep != NULL)
-				lsize = *lsizep;
+				lsize = be32_to_cpu(*lsizep);
 			if (sizep == NULL || lsizep == NULL)
 				DBG("Argh, can't find dcache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
@@ -335,7 +335,7 @@ static void __init initialize_cache_info(void)
 			lsize = cur_cpu_spec->icache_bsize;
 			sizep = of_get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
-				size = *sizep;
+				size = be32_to_cpu(*sizep);
 			lsizep = of_get_property(np, "i-cache-block-size",
 						 NULL);
 			if (lsizep == NULL)
@@ -343,7 +343,7 @@ static void __init initialize_cache_info(void)
 							 "i-cache-line-size",
 							 NULL);
 			if (lsizep != NULL)
-				lsize = *lsizep;
+				lsize = be32_to_cpu(*lsizep);
 			if (sizep == NULL || lsizep == NULL)
 				DBG("Argh, can't find icache properties ! "
 				    "sizep: %p, lsizep: %p\n", sizep, lsizep);
-- 
1.8.1.2
