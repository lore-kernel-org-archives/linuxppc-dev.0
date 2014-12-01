Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63F4E1A09B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Dec 2014 16:55:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/xmon: Cleanup the breakpoint flags
Date: Mon,  1 Dec 2014 16:55:25 +1100
Message-Id: <1417413325-7584-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop BP_IABR_TE, which though used, does not do anything useful. Rename
BP_IABR to BP_CIABR. Renumber the flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)


This is on top of Anshuman's v4 of CIABR breakpoint support.

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 820dc135f040..dfe337238699 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -94,10 +94,9 @@ struct bpt {
 };
 
 /* Bits in bpt.enabled */
-#define BP_IABR_TE	1		/* IABR translation enabled */
-#define BP_IABR		2
-#define BP_TRAP		8
-#define BP_DABR		0x10
+#define BP_CIABR	1
+#define BP_TRAP		2
+#define BP_DABR		4
 
 #define NBPTS	256
 static struct bpt bpts[NBPTS];
@@ -772,7 +771,7 @@ static void insert_bpts(void)
 
 	bp = bpts;
 	for (i = 0; i < NBPTS; ++i, ++bp) {
-		if ((bp->enabled & (BP_TRAP|BP_IABR)) == 0)
+		if ((bp->enabled & (BP_TRAP|BP_CIABR)) == 0)
 			continue;
 		if (mread(bp->address, &bp->instr[0], 4) != 4) {
 			printf("Couldn't read instruction at %lx, "
@@ -787,7 +786,7 @@ static void insert_bpts(void)
 			continue;
 		}
 		store_inst(&bp->instr[0]);
-		if (bp->enabled & BP_IABR)
+		if (bp->enabled & BP_CIABR)
 			continue;
 		if (mwrite(bp->address, &bpinstr, 4) != 4) {
 			printf("Couldn't write instruction at %lx, "
@@ -822,7 +821,7 @@ static void remove_bpts(void)
 
 	bp = bpts;
 	for (i = 0; i < NBPTS; ++i, ++bp) {
-		if ((bp->enabled & (BP_TRAP|BP_IABR)) != BP_TRAP)
+		if ((bp->enabled & (BP_TRAP|BP_CIABR)) != BP_TRAP)
 			continue;
 		if (mread(bp->address, &instr, 4) == 4
 		    && instr == bpinstr
@@ -1217,7 +1216,7 @@ bpt_cmds(void)
 			break;
 		}
 		if (iabr) {
-			iabr->enabled &= ~(BP_IABR | BP_IABR_TE);
+			iabr->enabled &= ~BP_CIABR;
 			iabr = NULL;
 		}
 		if (!scanhex(&a))
@@ -1226,7 +1225,7 @@ bpt_cmds(void)
 			break;
 		bp = new_breakpoint(a);
 		if (bp != NULL) {
-			bp->enabled |= BP_IABR | BP_IABR_TE;
+			bp->enabled |= BP_CIABR;
 			iabr = bp;
 		}
 		break;
@@ -1283,7 +1282,7 @@ bpt_cmds(void)
 				if (!bp->enabled)
 					continue;
 				printf("%2x %s   ", BP_NUM(bp),
-				    (bp->enabled & BP_IABR)? "inst": "trap");
+				    (bp->enabled & BP_CIABR) ? "inst": "trap");
 				xmon_print_symbol(bp->address, "  ", "\n");
 			}
 			break;
-- 
1.9.1
