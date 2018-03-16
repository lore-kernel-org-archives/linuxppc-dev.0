Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402jHB5h3mzF09b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 22:03:02 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id q83so2264666wme.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 04:03:02 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 19/19] ppc64: Handle %p format in DUMPPTR() function-like macro
Date: Fri, 16 Mar 2018 12:02:24 +0100
Message-Id: <20180316110224.12260-20-malat@debian.org>
In-Reply-To: <20180316110224.12260-1-malat@debian.org>
References: <20180316110224.12260-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC      arch/powerpc/xmon/xmon.o
../arch/powerpc/xmon/xmon.c: In function ‘dump_one_paca’:
../arch/powerpc/xmon/xmon.c:2339:9: error: '#' flag used with ‘%p’ gnu_printf format [-Werror=format=]
  printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
         ^
../arch/powerpc/xmon/xmon.c:2347:2: note: in expansion of macro ‘DUMP’
  DUMP(p, emergency_sp, "px");

while at it fix warning reported by checkpatch:

WARNING: macros should not use a trailing semicolon

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a87f14a24849..edd7ea85272f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2337,17 +2337,20 @@ static void dump_one_paca(int cpu)
 
 #define DUMP(paca, name, format) \
 	printf(" %-*s = %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
-		offsetof(struct paca_struct, name));
+		offsetof(struct paca_struct, name))
+#define DUMPPTR(paca, name, format) \
+	printf(" %-*s = %-*"format"\t(0x%lx)\n", 20, #name, 18, paca->name, \
+		offsetof(struct paca_struct, name))
 
 	DUMP(p, lock_token, "x");
 	DUMP(p, paca_index, "x");
 	DUMP(p, kernel_toc, "llx");
 	DUMP(p, kernelbase, "llx");
 	DUMP(p, kernel_msr, "llx");
-	DUMP(p, emergency_sp, "px");
+	DUMPPTR(p, emergency_sp, "p");
 #ifdef CONFIG_PPC_BOOK3S_64
-	DUMP(p, nmi_emergency_sp, "px");
-	DUMP(p, mc_emergency_sp, "px");
+	DUMPPTR(p, nmi_emergency_sp, "p");
+	DUMPPTR(p, mc_emergency_sp, "p");
 	DUMP(p, in_nmi, "x");
 	DUMP(p, in_mce, "x");
 	DUMP(p, hmi_event_available, "x");
@@ -2376,7 +2379,7 @@ static void dump_one_paca(int cpu)
 	for (i = 0; i < SLB_CACHE_ENTRIES; i++)
 		printf(" slb_cache[%d]:        = 0x%016x\n", i, p->slb_cache[i]);
 
-	DUMP(p, rfi_flush_fallback_area, "px");
+	DUMPPTR(p, rfi_flush_fallback_area, "p");
 #endif
 	DUMP(p, dscr_default, "llx");
 #ifdef CONFIG_PPC_BOOK3E
@@ -2387,7 +2390,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, crit_kstack, "px");
 	DUMP(p, dbg_kstack, "px");
 #endif
-	DUMP(p, __current, "px");
+	DUMPPTR(p, __current, "p");
 	DUMP(p, kstack, "llx");
 	printf(" kstack_base          = 0x%016llx\n", p->kstack & ~(THREAD_SIZE - 1));
 	DUMP(p, stab_rr, "llx");
@@ -2405,7 +2408,7 @@ static void dump_one_paca(int cpu)
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	DUMP(p, core_idle_state_ptr, "px");
+	DUMPPTR(p, core_idle_state_ptr, "p");
 	DUMP(p, thread_idle_state, "x");
 	DUMP(p, thread_mask, "x");
 	DUMP(p, subcore_sibling_mask, "x");
-- 
2.11.0
