Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGqbd4Zb5zF0lW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 00:29:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Add RFI flush related fields to paca dump
Date: Thu, 11 Jan 2018 00:28:56 +1100
Message-Id: <20180110132856.12446-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cab24f549e7c..b3bb5beec54a 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2375,6 +2375,10 @@ static void dump_one_paca(int cpu)
 	DUMP(p, slb_cache_ptr, "x");
 	for (i = 0; i < SLB_CACHE_ENTRIES; i++)
 		printf(" slb_cache[%d]:        = 0x%016lx\n", i, p->slb_cache[i]);
+
+	DUMP(p, rfi_flush_fallback_area, "px");
+	DUMP(p, l1d_flush_congruence, "llx");
+	DUMP(p, l1d_flush_sets, "llx");
 #endif
 	DUMP(p, dscr_default, "llx");
 #ifdef CONFIG_PPC_BOOK3E
-- 
2.14.3
