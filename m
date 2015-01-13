Return-Path: <geoff@infradead.org>
Message-Id: <3deced9919246f281e48f1258885937f11a4b4ee.1421109719.git.geoff@infradead.org>
In-Reply-To: <cover.1421109719.git.geoff@infradead.org>
References: <cover.1421109719.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/6] powerpc/ps3: Write highmem info to repository
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Jan 2015 01:00:20 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Nathan Whitehorn <nwhitehorn@freebsd.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add calls to the ps3_mm_set_repository_highmem() routine when the ps3
r1 highmem region is either created or destroyed.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/mm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 04c1b93..b0f3466 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -329,6 +329,7 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 		r->size = r->base = r->offset = 0;
 		map.total = map.rm.size;
 	}
+	ps3_mm_set_repository_highmem(NULL);
 }
 
 /*============================================================================*/
@@ -1218,8 +1219,12 @@ void __init ps3_mm_init(void)
 
 	/* Check if we got the highmem region from an earlier boot step */
 
-	if (ps3_mm_get_repository_highmem(&map.r1))
-		ps3_mm_region_create(&map.r1, map.total - map.rm.size);
+	if (ps3_mm_get_repository_highmem(&map.r1)) {
+		result = ps3_mm_region_create(&map.r1, map.total - map.rm.size);
+
+		if (!result)
+			ps3_mm_set_repository_highmem(&map.r1);
+	}
 
 	/* correct map.total for the real total amount of memory we use */
 	map.total = map.rm.size + map.r1.size;
-- 
1.9.1
