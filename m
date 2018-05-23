Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rW4d4mv6zF0wk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 21:48:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: malat@debian.org
Subject: [PATCH 2/2] powerpc/xmon: Realign paca dump fields
Date: Wed, 23 May 2018 21:48:37 +1000
Message-Id: <20180523114837.6980-2-mpe@ellerman.id.au>
In-Reply-To: <20180523114837.6980-1-mpe@ellerman.id.au>
References: <20180523114837.6980-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've added some fields with longer names since we originally wrote
this, so the fields are no longer lined up. Adjust the widths to make
it all look nice again, eg:

  0:mon> dp
  paca for cpu 0x0 @ c000000001fa0000:
   possible                  = yes
   ...
   slb_shadow            [0] = 0xc000000008000000 0x400ea1b217000500
   slb_shadow            [1] = 0xd000000008000001 0x400d43642f000510
   ...
   rfi_flush_fallback_area   = c0000000fff80000   (0xcc8)
   ...
   accounting.starttime_user = 0x51582f07         (0xae8)

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a81aa3afd87e..421c3a9aa734 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2345,12 +2345,12 @@ static void dump_one_paca(int cpu)
 
 	printf("paca for cpu 0x%x @ %px:\n", cpu, p);
 
-	printf(" %-*s = %s\n", 20, "possible", cpu_possible(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 20, "present", cpu_present(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 20, "online", cpu_online(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 25, "possible", cpu_possible(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 25, "present", cpu_present(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 25, "online", cpu_online(cpu) ? "yes" : "no");
 
 #define DUMP(paca, name, format)				\
-	printf(" %-*s = "format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
+	printf(" %-*s = "format"\t(0x%lx)\n", 25, #name, 18, paca->name, \
 		offsetof(struct paca_struct, name));
 
 	DUMP(p, lock_token, "%#-*x");
@@ -2381,14 +2381,15 @@ static void dump_one_paca(int cpu)
 		vsid = be64_to_cpu(p->slb_shadow_ptr->save_area[i].vsid);
 
 		if (esid || vsid) {
-			printf(" slb_shadow[%d]:       = 0x%016llx 0x%016llx\n",
-				i, esid, vsid);
+			printf(" %-*s[%d] = 0x%016llx 0x%016llx\n",
+			       22, "slb_shadow", i, esid, vsid);
 		}
 	}
 	DUMP(p, vmalloc_sllp, "%#-*x");
 	DUMP(p, slb_cache_ptr, "%#-*x");
 	for (i = 0; i < SLB_CACHE_ENTRIES; i++)
-		printf(" slb_cache[%d]:        = 0x%016x\n", i, p->slb_cache[i]);
+		printf(" %-*s[%d] = 0x%016x\n",
+		       22, "slb_cache", i, p->slb_cache[i]);
 
 	DUMP(p, rfi_flush_fallback_area, "%-*px");
 #endif
@@ -2403,7 +2404,7 @@ static void dump_one_paca(int cpu)
 #endif
 	DUMP(p, __current, "%-*px");
 	DUMP(p, kstack, "%#-*llx");
-	printf(" kstack_base          = 0x%016llx\n", p->kstack & ~(THREAD_SIZE - 1));
+	printf(" %-*s = 0x%016llx\n", 25, "kstack_base", p->kstack & ~(THREAD_SIZE - 1));
 	DUMP(p, stab_rr, "%#-*llx");
 	DUMP(p, saved_r1, "%#-*llx");
 	DUMP(p, trap_save, "%#-*x");
-- 
2.14.1
