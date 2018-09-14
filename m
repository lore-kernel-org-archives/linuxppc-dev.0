Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfd16DNyzF3XG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:33 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id b129-v6so4558091pga.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 10/12] powerpc/64s: xmon do not dump hash fields when using
 radix mode
Date: Sat, 15 Sep 2018 01:30:54 +1000
Message-Id: <20180914153056.3644-11-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 323aac8321fa..5dec84aba59e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2378,30 +2378,32 @@ static void dump_one_paca(int cpu)
 	DUMP(p, cpu_start, "%#-*x");
 	DUMP(p, kexec_state, "%#-*x");
 #ifdef CONFIG_PPC_BOOK3S_64
-	for (i = 0; i < SLB_NUM_BOLTED; i++) {
-		u64 esid, vsid;
+	if (!early_radix_enabled()) {
+		for (i = 0; i < SLB_NUM_BOLTED; i++) {
+			u64 esid, vsid;
 
-		if (!p->slb_shadow_ptr)
-			continue;
+			if (!p->slb_shadow_ptr)
+				continue;
 
-		esid = be64_to_cpu(p->slb_shadow_ptr->save_area[i].esid);
-		vsid = be64_to_cpu(p->slb_shadow_ptr->save_area[i].vsid);
+			esid = be64_to_cpu(p->slb_shadow_ptr->save_area[i].esid);
+			vsid = be64_to_cpu(p->slb_shadow_ptr->save_area[i].vsid);
 
-		if (esid || vsid) {
-			printf(" %-*s[%d] = 0x%016llx 0x%016llx\n",
-			       22, "slb_shadow", i, esid, vsid);
+			if (esid || vsid) {
+				printf(" %-*s[%d] = 0x%016llx 0x%016llx\n",
+				       22, "slb_shadow", i, esid, vsid);
+			}
 		}
-	}
-	DUMP(p, vmalloc_sllp, "%#-*x");
-	DUMP(p, stab_rr, "%#-*x");
-	DUMP(p, slb_used_bitmap, "%#-*x");
-	DUMP(p, slb_kern_bitmap, "%#-*x");
+		DUMP(p, vmalloc_sllp, "%#-*x");
+		DUMP(p, stab_rr, "%#-*x");
+		DUMP(p, slb_used_bitmap, "%#-*x");
+		DUMP(p, slb_kern_bitmap, "%#-*x");
 
-	if (!early_cpu_has_feature(CPU_FTR_ARCH_300)) {
-		DUMP(p, slb_cache_ptr, "%#-*x");
-		for (i = 0; i < SLB_CACHE_ENTRIES; i++)
-			printf(" %-*s[%d] = 0x%016x\n",
-			       22, "slb_cache", i, p->slb_cache[i]);
+		if (!early_cpu_has_feature(CPU_FTR_ARCH_300)) {
+			DUMP(p, slb_cache_ptr, "%#-*x");
+			for (i = 0; i < SLB_CACHE_ENTRIES; i++)
+				printf(" %-*s[%d] = 0x%016x\n",
+				       22, "slb_cache", i, p->slb_cache[i]);
+		}
 	}
 
 	DUMP(p, rfi_flush_fallback_area, "%-*px");
-- 
2.18.0
