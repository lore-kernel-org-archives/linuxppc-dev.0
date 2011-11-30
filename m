Return-Path: <geoff@infradead.org>
Message-Id: <7be1bb00d8f566a98d8cc19046f4a33eb45dbbb2.1322615824.git.geoff@infradead.org>
In-Reply-To: <cover.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 5/8] powerpc/ps3: Fix hcall lv1_read_repository_node
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Nov 2011 01:38:50 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The lv1 hcall #91 should be named lv1_read_repository_node, and
not lv1_get_repository_node_value.  Adjust the lv1 hcall table
and all calls.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/include/asm/lv1call.h      |    2 +-
 arch/powerpc/platforms/ps3/repository.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/lv1call.h b/arch/powerpc/include/asm/lv1call.h
index 8481221..233f9ec 100644
--- a/arch/powerpc/include/asm/lv1call.h
+++ b/arch/powerpc/include/asm/lv1call.h
@@ -264,7 +264,7 @@ LV1_CALL(configure_execution_time_variable,             1, 0,  77 )
 LV1_CALL(get_spe_irq_outlet,                            2, 1,  78 )
 LV1_CALL(set_spe_privilege_state_area_1_register,       3, 0,  79 )
 LV1_CALL(create_repository_node,                        6, 0,  90 )
-LV1_CALL(get_repository_node_value,                     5, 2,  91 )
+LV1_CALL(read_repository_node,                          5, 2,  91 )
 LV1_CALL(modify_repository_node_value,                  6, 0,  92 )
 LV1_CALL(remove_repository_node,                        4, 0,  93 )
 LV1_CALL(read_htab_entries,                             2, 5,  95 )
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index ca40f6a..cb68729 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -131,11 +131,11 @@ static int read_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 		lpar_id = id;
 	}
 
-	result = lv1_get_repository_node_value(lpar_id, n1, n2, n3, n4, &v1,
+	result = lv1_read_repository_node(lpar_id, n1, n2, n3, n4, &v1,
 		&v2);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_get_repository_node_value failed: %s\n",
+		pr_debug("%s:%d: lv1_read_repository_node failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 		dump_node_name(lpar_id, n1, n2, n3, n4);
 		return -ENOENT;
-- 
1.7.0.4
