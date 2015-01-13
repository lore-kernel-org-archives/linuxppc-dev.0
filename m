Return-Path: <geoff@infradead.org>
Message-Id: <ee18686aeef86b3d0cefd9db70ee0f6283f4fb2e.1421109719.git.geoff@infradead.org>
In-Reply-To: <cover.1421109719.git.geoff@infradead.org>
References: <cover.1421109719.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/6] powerpc/ps3: Add ps3_mm_set_repository_highmem
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

Add the new routine ps3_mm_set_repository_highmem() that saves highmem info to
the ps3 repository.  Also, move the existing ps3_mm_get_repository_highmem()
routine up in the source file.

This inplementation of ps3_mm_set_repository_highmem() assumes the repository
will have a single highmem region entry (at index 0).

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/mm.c | 68 +++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 0c9f643..04c1b93 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -223,6 +223,44 @@ void ps3_mm_vas_destroy(void)
 	}
 }
 
+static int ps3_mm_get_repository_highmem(struct mem_region *r)
+{
+	int result;
+
+	/* Assume a single highmem region. */
+
+	result = ps3_repository_read_highmem_info(0, &r->base, &r->size);
+
+	if (result)
+		goto zero_region;
+
+	if (!r->base || !r->size) {
+		result = -1;
+		goto zero_region;
+	}
+
+	r->offset = r->base - map.rm.size;
+
+	DBG("%s:%d: Found high region in repository: %llxh %llxh\n",
+	    __func__, __LINE__, r->base, r->size);
+
+	return 0;
+
+zero_region:
+	DBG("%s:%d: No high region in repository.\n", __func__, __LINE__);
+
+	r->size = r->base = r->offset = 0;
+	return result;
+}
+
+static int ps3_mm_set_repository_highmem(const struct mem_region *r)
+{
+	/* Assume a single highmem region. */
+
+	return r ? ps3_repository_write_highmem_info(0, r->base, r->size) :
+		ps3_repository_write_highmem_info(0, 0, 0);
+}
+
 /**
  * ps3_mm_region_create - create a memory region in the vas
  * @r: pointer to a struct mem_region to accept initialized values
@@ -293,36 +331,6 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 	}
 }
 
-static int ps3_mm_get_repository_highmem(struct mem_region *r)
-{
-	int result;
-
-	/* Assume a single highmem region. */
-
-	result = ps3_repository_read_highmem_info(0, &r->base, &r->size);
-
-	if (result)
-		goto zero_region;
-
-	if (!r->base || !r->size) {
-		result = -1;
-		goto zero_region;
-	}
-
-	r->offset = r->base - map.rm.size;
-
-	DBG("%s:%d: Found high region in repository: %llxh %llxh\n",
-	    __func__, __LINE__, r->base, r->size);
-
-	return 0;
-
-zero_region:
-	DBG("%s:%d: No high region in repository.\n", __func__, __LINE__);
-
-	r->size = r->base = r->offset = 0;
-	return result;
-}
-
 /*============================================================================*/
 /* dma routines                                                               */
 /*============================================================================*/
-- 
1.9.1
