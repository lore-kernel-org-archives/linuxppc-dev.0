Return-Path: <geoff@infradead.org>
Message-Id: <6796cfa786e8fa7d6b7872a9d2749eca835fccf3.1360810584.git.geoff@infradead.org>
In-Reply-To: <cover.1360810584.git.geoff@infradead.org>
References: <cover.1360810584.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/4] powerpc/ps3: Increase verbosity of htab errors
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Feb 2013 03:03:16 +0000
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/htab.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index d00d7b0..6cc5820 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -27,6 +27,7 @@
 #include <asm/lv1call.h>
 #include <asm/ps3fb.h>
 
+#define PS3_VERBOSE_RESULT
 #include "platform.h"
 
 /**
@@ -75,8 +76,9 @@ static long ps3_hpte_insert(unsigned long hpte_group, unsigned long vpn,
 
 	if (result) {
 		/* all entries bolted !*/
-		pr_info("%s:result=%d vpn=%lx pa=%lx ix=%lx v=%llx r=%llx\n",
-			__func__, result, vpn, pa, hpte_group, hpte_v, hpte_r);
+		pr_info("%s:result=%s vpn=%lx pa=%lx ix=%lx v=%llx r=%llx\n",
+			__func__, ps3_result(result), vpn, pa, hpte_group,
+			hpte_v, hpte_r);
 		BUG();
 	}
 
@@ -125,8 +127,8 @@ static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				       &hpte_rs);
 
 	if (result) {
-		pr_info("%s: res=%d read vpn=%lx slot=%lx psize=%d\n",
-			__func__, result, vpn, slot, psize);
+		pr_info("%s: result=%s read vpn=%lx slot=%lx psize=%d\n",
+			__func__, ps3_result(result), vpn, slot, psize);
 		BUG();
 	}
 
@@ -170,8 +172,8 @@ static void ps3_hpte_invalidate(unsigned long slot, unsigned long vpn,
 	result = lv1_write_htab_entry(PS3_LPAR_VAS_ID_CURRENT, slot, 0, 0);
 
 	if (result) {
-		pr_info("%s: res=%d vpn=%lx slot=%lx psize=%d\n",
-			__func__, result, vpn, slot, psize);
+		pr_info("%s: result=%s vpn=%lx slot=%lx psize=%d\n",
+			__func__, ps3_result(result), vpn, slot, psize);
 		BUG();
 	}
 
-- 
1.7.9.5
