Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTqr94NwzzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 10:16:57 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTqr84XZrz9s7N
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 10:16:56 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dri-devel@lists.freedesktop.org
Cc: "Y . C . Chen" <yc_chen@aspeedtech.com>, airlied@redhat.com,
 eich@suse.come, linuxppc-dev@ozlabs.org
Subject: [PATCH 08/12] drm/ast: Factor mmc_test code in POST code
Date: Fri, 24 Feb 2017 09:53:53 +1100
Message-Id: <20170223225357.9572-8-benh@kernel.crashing.org>
In-Reply-To: <20170223225357.9572-1-benh@kernel.crashing.org>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's a some duplication for what's essentially copies of
two loops, so factor it. The upcoming AST2500 POST code adds
more of them. Also cleanup return types for the test functions,
most of them return a boolean, some return a u32.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

v2. - Keep the split between the "test" and "test2" functions
      as they have a different exit condition in the loop and
      a different return type.
    - Fix the return types accross the call chain
---
 drivers/gpu/drm/ast/ast_post.c | 82 ++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index e802450..c55067c 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -445,85 +445,65 @@ static const u32 pattern[8] = {
 	0x7C61D253
 };
 
-static int mmc_test_burst(struct ast_private *ast, u32 datagen)
+static bool mmc_test(struct ast_private *ast, u32 datagen, u8 test_ctl)
 {
 	u32 data, timeout;
 
 	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, 0x000000c1 | (datagen << 3));
+	ast_moutdwm(ast, 0x1e6e0070, (datagen << 3) | test_ctl);
 	timeout = 0;
 	do {
 		data = ast_mindwm(ast, 0x1e6e0070) & 0x3000;
-		if (data & 0x2000) {
-			return 0;
-		}
+		if (data & 0x2000)
+			return false;
 		if (++timeout > TIMEOUT) {
 			ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-			return 0;
+			return false;
 		}
 	} while (!data);
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	return 1;
+	ast_moutdwm(ast, 0x1e6e0070, 0x0);
+	return true;
 }
 
-static int mmc_test_burst2(struct ast_private *ast, u32 datagen)
+static u32 mmc_test2(struct ast_private *ast, u32 datagen, u8 test_ctl)
 {
 	u32 data, timeout;
 
 	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000041 | (datagen << 3));
+	ast_moutdwm(ast, 0x1e6e0070, (datagen << 3) | test_ctl);
 	timeout = 0;
 	do {
 		data = ast_mindwm(ast, 0x1e6e0070) & 0x1000;
 		if (++timeout > TIMEOUT) {
 			ast_moutdwm(ast, 0x1e6e0070, 0x0);
-			return -1;
+			return 0xffffffff;
 		}
 	} while (!data);
 	data = ast_mindwm(ast, 0x1e6e0078);
 	data = (data | (data >> 16)) & 0xffff;
-	ast_moutdwm(ast, 0x1e6e0070, 0x0);
+	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
 	return data;
 }
 
-static int mmc_test_single(struct ast_private *ast, u32 datagen)
+
+static bool mmc_test_burst(struct ast_private *ast, u32 datagen)
 {
-	u32 data, timeout;
+	return mmc_test(ast, datagen, 0xc1);
+}
 
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, 0x000000c5 | (datagen << 3));
-	timeout = 0;
-	do {
-		data = ast_mindwm(ast, 0x1e6e0070) & 0x3000;
-		if (data & 0x2000)
-			return 0;
-		if (++timeout > TIMEOUT) {
-			ast_moutdwm(ast, 0x1e6e0070, 0x0);
-			return 0;
-		}
-	} while (!data);
-	ast_moutdwm(ast, 0x1e6e0070, 0x0);
-	return 1;
+static u32 mmc_test_burst2(struct ast_private *ast, u32 datagen)
+{
+	return mmc_test2(ast, datagen, 0x41);
 }
 
-static int mmc_test_single2(struct ast_private *ast, u32 datagen)
+static bool mmc_test_single(struct ast_private *ast, u32 datagen)
 {
-	u32 data, timeout;
+	return mmc_test(ast, datagen, 0xc5);
+}
 
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000000);
-	ast_moutdwm(ast, 0x1e6e0070, 0x00000005 | (datagen << 3));
-	timeout = 0;
-	do {
-		data = ast_mindwm(ast, 0x1e6e0070) & 0x1000;
-		if (++timeout > TIMEOUT) {
-			ast_moutdwm(ast, 0x1e6e0070, 0x0);
-			return -1;
-		}
-	} while (!data);
-	data = ast_mindwm(ast, 0x1e6e0078);
-	data = (data | (data >> 16)) & 0xffff;
-	ast_moutdwm(ast, 0x1e6e0070, 0x0);
-	return data;
+static u32 mmc_test_single2(struct ast_private *ast, u32 datagen)
+{
+	return mmc_test2(ast, datagen, 0x05);
 }
 
 static int cbr_test(struct ast_private *ast)
@@ -601,16 +581,16 @@ static u32 cbr_scan2(struct ast_private *ast)
 	return data2;
 }
 
-static u32 cbr_test3(struct ast_private *ast)
+static bool cbr_test3(struct ast_private *ast)
 {
 	if (!mmc_test_burst(ast, 0))
-		return 0;
+		return false;
 	if (!mmc_test_single(ast, 0))
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
-static u32 cbr_scan3(struct ast_private *ast)
+static bool cbr_scan3(struct ast_private *ast)
 {
 	u32 patcnt, loop;
 
@@ -621,9 +601,9 @@ static u32 cbr_scan3(struct ast_private *ast)
 				break;
 		}
 		if (loop == 2)
-			return 0;
+			return false;
 	}
-	return 1;
+	return true;
 }
 
 static bool finetuneDQI_L(struct ast_private *ast, struct ast2300_dram_param *param)
-- 
2.9.3
