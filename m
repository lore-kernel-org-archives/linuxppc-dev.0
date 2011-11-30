Return-Path: <geoff@infradead.org>
Message-Id: <da809ff2ee6de9a2930da3c3918a659d05904f5d.1322615824.git.geoff@infradead.org>
In-Reply-To: <cover.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/8] powerpc/ps3: Fix hcall
 lv1_get_virtual_address_space_id_of_ppe
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Nov 2011 01:38:49 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The lv1_get_virtual_address_space_id_of_ppe hcall takes 0, not 1 input
arguments.  Adjust the lv1 hcall table and all calls.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/include/asm/lv1call.h |    2 +-
 arch/powerpc/platforms/ps3/spu.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/lv1call.h b/arch/powerpc/include/asm/lv1call.h
index 807d895..3ddf66c 100644
--- a/arch/powerpc/include/asm/lv1call.h
+++ b/arch/powerpc/include/asm/lv1call.h
@@ -231,7 +231,7 @@ LV1_CALL(allocate_memory,                               4, 2,   0 )
 LV1_CALL(write_htab_entry,                              4, 0,   1 )
 LV1_CALL(construct_virtual_address_space,               3, 2,   2 )
 LV1_CALL(invalidate_htab_entries,                       5, 0,   3 )
-LV1_CALL(get_virtual_address_space_id_of_ppe,           1, 1,   4 )
+LV1_CALL(get_virtual_address_space_id_of_ppe,           0, 1,   4 )
 LV1_CALL(query_logical_partition_address_region_info,   1, 5,   6 )
 LV1_CALL(select_virtual_address_space,                  1, 0,   7 )
 LV1_CALL(pause,                                         1, 0,   9 )
diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index 451fad1..e17fa14 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -154,7 +154,7 @@ static unsigned long get_vas_id(void)
 	u64 id;
 
 	lv1_get_logical_ppe_id(&id);
-	lv1_get_virtual_address_space_id_of_ppe(id, &id);
+	lv1_get_virtual_address_space_id_of_ppe(&id);
 
 	return id;
 }
-- 
1.7.0.4
