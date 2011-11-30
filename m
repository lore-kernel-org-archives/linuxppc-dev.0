Return-Path: <geoff@infradead.org>
Message-Id: <0b0c0efa6cca6e5e169b4b3e81373a3bab75716a.1322615824.git.geoff@infradead.org>
In-Reply-To: <cover.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 6/8] powerpc/ps3: Fix pr_debug build warnings
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

Fix some PS3 build warnings when DEBUG is defined.

Fixes warnings like these:

  format '%lx' expects type 'long unsigned int', but argument 7 has type 'u64'

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/repository.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index cb68729..2ce2782 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -1050,7 +1050,7 @@ int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
 
 		pr_debug("%s:%d (%u:%u) reg_type %u, bus_addr %lxh, len %lxh\n",
 			__func__, __LINE__, repo->bus_index, repo->dev_index,
-			reg_type, bus_addr, len);
+			reg_type, (unsigned long)bus_addr, (unsigned long)len);
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
@@ -1077,8 +1077,9 @@ static int dump_stor_dev_info(struct ps3_repository_device *repo)
 
 	pr_debug("%s:%d  (%u:%u): port %lu, blk_size %lu, num_blocks "
 		 "%lu, num_regions %u\n",
-		 __func__, __LINE__, repo->bus_index, repo->dev_index, port,
-		 blk_size, num_blocks, num_regions);
+		 __func__, __LINE__, repo->bus_index, repo->dev_index,
+		(unsigned long)port, (unsigned long)blk_size,
+		(unsigned long)num_blocks, num_regions);
 
 	for (region_index = 0; region_index < num_regions; region_index++) {
 		unsigned int region_id;
@@ -1096,7 +1097,8 @@ static int dump_stor_dev_info(struct ps3_repository_device *repo)
 
 		pr_debug("%s:%d (%u:%u) region_id %u, start %lxh, size %lxh\n",
 			__func__, __LINE__, repo->bus_index, repo->dev_index,
-			region_id, region_start, region_size);
+			region_id, (unsigned long)region_start,
+			(unsigned long)region_size);
 	}
 
 out:
@@ -1136,7 +1138,7 @@ static int dump_device_info(struct ps3_repository_device *repo,
 
 		pr_debug("%s:%d  (%u:%u): dev_type %u, dev_id %lu\n", __func__,
 			__LINE__, repo->bus_index, repo->dev_index,
-			repo->dev_type, repo->dev_id);
+			repo->dev_type, (unsigned long)repo->dev_id);
 
 		ps3_repository_dump_resource_info(repo);
 
@@ -1193,7 +1195,7 @@ int ps3_repository_dump_bus_info(void)
 
 		pr_debug("%s:%d bus_%u: bus_type %u, bus_id %lu, num_dev %u\n",
 			__func__, __LINE__, repo.bus_index, repo.bus_type,
-			repo.bus_id, num_dev);
+			(unsigned long)repo.bus_id, num_dev);
 
 		dump_device_info(&repo, num_dev);
 	}
-- 
1.7.0.4
