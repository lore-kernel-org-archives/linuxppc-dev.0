Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGrkF0MB9zF0fM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 01:19:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Don't print hashed pointers in paca dump
Date: Thu, 11 Jan 2018 01:19:46 +1100
Message-Id: <20180110141946.20127-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remember when the biggest problem we had to worry about was hashed
pointers, those were the days.

These were missed in my earlier patch because they don't match "%p",
but the macro is hiding a "%p", so these all end up being hashed,
which is not what we want in xmon. Convert them to "%px".

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b3bb5beec54a..0ddc7ac6c5f1 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2344,10 +2344,10 @@ static void dump_one_paca(int cpu)
 	DUMP(p, kernel_toc, "lx");
 	DUMP(p, kernelbase, "lx");
 	DUMP(p, kernel_msr, "lx");
-	DUMP(p, emergency_sp, "p");
+	DUMP(p, emergency_sp, "px");
 #ifdef CONFIG_PPC_BOOK3S_64
-	DUMP(p, nmi_emergency_sp, "p");
-	DUMP(p, mc_emergency_sp, "p");
+	DUMP(p, nmi_emergency_sp, "px");
+	DUMP(p, mc_emergency_sp, "px");
 	DUMP(p, in_nmi, "x");
 	DUMP(p, in_mce, "x");
 	DUMP(p, hmi_event_available, "x");
@@ -2382,14 +2382,14 @@ static void dump_one_paca(int cpu)
 #endif
 	DUMP(p, dscr_default, "llx");
 #ifdef CONFIG_PPC_BOOK3E
-	DUMP(p, pgd, "p");
-	DUMP(p, kernel_pgd, "p");
-	DUMP(p, tcd_ptr, "p");
-	DUMP(p, mc_kstack, "p");
-	DUMP(p, crit_kstack, "p");
-	DUMP(p, dbg_kstack, "p");
+	DUMP(p, pgd, "px");
+	DUMP(p, kernel_pgd, "px");
+	DUMP(p, tcd_ptr, "px");
+	DUMP(p, mc_kstack, "px");
+	DUMP(p, crit_kstack, "px");
+	DUMP(p, dbg_kstack, "px");
 #endif
-	DUMP(p, __current, "p");
+	DUMP(p, __current, "px");
 	DUMP(p, kstack, "lx");
 	printf(" kstack_base          = 0x%016lx\n", p->kstack & ~(THREAD_SIZE - 1));
 	DUMP(p, stab_rr, "lx");
@@ -2407,7 +2407,7 @@ static void dump_one_paca(int cpu)
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	DUMP(p, core_idle_state_ptr, "p");
+	DUMP(p, core_idle_state_ptr, "px");
 	DUMP(p, thread_idle_state, "x");
 	DUMP(p, thread_mask, "x");
 	DUMP(p, subcore_sibling_mask, "x");
-- 
2.14.3
