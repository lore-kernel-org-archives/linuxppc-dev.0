Return-Path: <geoff@infradead.org>
Message-Id: <79f2a81bf117ffea757b0f298467333cf4e835a8.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 03/10] powerpc/ps3: Add highmem repository write routines
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Apr 2012 19:19:34 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Nathan Whitehorn <nwhitehorn@freebsd.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add routines to allow Linux based bootloaders to create and/or
modify highmem region info in the PS3 system repository where
it can be retrived by later boot stages.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/platform.h   |    9 ++++
 arch/powerpc/platforms/ps3/repository.c |   74 +++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index 1a633ed..4012a86 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -189,6 +189,15 @@ int ps3_repository_read_region_total(u64 *region_total);
 int ps3_repository_read_mm_info(u64 *rm_base, u64 *rm_size,
 	u64 *region_total);
 
+int ps3_repository_write_highmem_region_count(unsigned int region_count);
+int ps3_repository_write_highmem_base(unsigned int region_index,
+	u64 highmem_base);
+int ps3_repository_write_highmem_size(unsigned int region_index,
+	u64 highmem_size);
+int ps3_repository_write_highmem_info(unsigned int region_index,
+	u64 highmem_base, u64 highmem_size);
+int ps3_repository_delete_highmem_info(unsigned int region_index);
+
 /* repository pme info */
 
 int ps3_repository_read_num_be(unsigned int *num_be);
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index b31142c..c73f3a6 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -1058,6 +1058,80 @@ static int write_node(u64 n1, u64 n2, u64 n3, u64 n4, u64 v1, u64 v2)
 	return 0;
 }
 
+int ps3_repository_write_highmem_region_count(unsigned int region_count)
+{
+	int result;
+	u64 v1 = (u64)region_count;
+
+	result = write_node(
+		make_first_field("highmem", 0),
+		make_field("region", 0),
+		make_field("count", 0),
+		0,
+		v1, 0);
+	return result;
+}
+
+int ps3_repository_write_highmem_base(unsigned int region_index,
+	u64 highmem_base)
+{
+	return write_node(
+		make_first_field("highmem", 0),
+		make_field("region", region_index),
+		make_field("base", 0),
+		0,
+		highmem_base, 0);
+}
+
+int ps3_repository_write_highmem_size(unsigned int region_index,
+	u64 highmem_size)
+{
+	return write_node(
+		make_first_field("highmem", 0),
+		make_field("region", region_index),
+		make_field("size", 0),
+		0,
+		highmem_size, 0);
+}
+
+int ps3_repository_write_highmem_info(unsigned int region_index,
+	u64 highmem_base, u64 highmem_size)
+{
+	int result;
+
+	result = ps3_repository_write_highmem_base(region_index, highmem_base);
+	return result ? result
+		: ps3_repository_write_highmem_size(region_index, highmem_size);
+}
+
+static int ps3_repository_delete_highmem_base(unsigned int region_index)
+{
+	return delete_node(
+		make_first_field("highmem", 0),
+		make_field("region", region_index),
+		make_field("base", 0),
+		0);
+}
+
+static int ps3_repository_delete_highmem_size(unsigned int region_index)
+{
+	return delete_node(
+		make_first_field("highmem", 0),
+		make_field("region", region_index),
+		make_field("size", 0),
+		0);
+}
+
+int ps3_repository_delete_highmem_info(unsigned int region_index)
+{
+	int result;
+
+	result = ps3_repository_delete_highmem_base(region_index);
+	result += ps3_repository_delete_highmem_size(region_index);
+
+	return result ? -1 : 0;
+}
+
 #endif /* defined(CONFIG_PS3_WRITE_REPOSITORY) */
 
 #if defined(DEBUG)
-- 
1.7.9.5
