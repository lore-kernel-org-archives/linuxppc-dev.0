Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wB6nN4MjpzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 10:35:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xmon: Deindent the SLB dumping logic
Date: Mon, 24 Apr 2017 10:35:14 +1000
Message-Id: <1492994114-13797-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the code that dumps SLB entries uses a double-nested if. This
means the actual dumping logic is a bit squashed. Deindent it by using
continue.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

Found lying around in an old tree of mine :}

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 16321ad9e70c..199ba2663f21 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3070,23 +3070,28 @@ void dump_segments(void)
 	for (i = 0; i < mmu_slb_size; i++) {
 		asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
 		asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (i));
-		if (esid || vsid) {
-			printf("%02d %016lx %016lx", i, esid, vsid);
-			if (esid & SLB_ESID_V) {
-				llp = vsid & SLB_VSID_LLP;
-				if (vsid & SLB_VSID_B_1T) {
-					printf("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx \n",
-						GET_ESID_1T(esid),
-						(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T,
-						llp);
-				} else {
-					printf(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx \n",
-						GET_ESID(esid),
-						(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT,
-						llp);
-				}
-			} else
-				printf("\n");
+
+		if (!esid && !vsid)
+			continue;
+
+		printf("%02d %016lx %016lx", i, esid, vsid);
+
+		if (!(esid & SLB_ESID_V)) {
+			printf("\n");
+			continue;
+		}
+
+		llp = vsid & SLB_VSID_LLP;
+		if (vsid & SLB_VSID_B_1T) {
+			printf("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx \n",
+				GET_ESID_1T(esid),
+				(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T,
+				llp);
+		} else {
+			printf(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx \n",
+				GET_ESID(esid),
+				(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT,
+				llp);
 		}
 	}
 }
-- 
2.7.4
