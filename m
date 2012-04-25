Return-Path: <geoff@infradead.org>
Message-Id: <6750edbd8d6d1d72365e29e58b05f164bc23755a.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 04/10] powerpc/ps3: Add highmem repository read routines
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: Geoff Levand <geoff@infradead.org>
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

Add repository helper routines to read highmem region info.

Bootloaders that preallocate highmem regions must place the
region info into the repository at these well known nodes.
These routines allow second stage kernles to read the region
info from those nodes.

Signed-off-by: Andre Heider <a.heider@gmail.com>
CC: Nathan Whitehorn <nwhitehorn@freebsd.org>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/platform.h   |    7 ++++
 arch/powerpc/platforms/ps3/repository.c |   66 +++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index 4012a86..d71329a 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -188,6 +188,13 @@ int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size);
 int ps3_repository_read_region_total(u64 *region_total);
 int ps3_repository_read_mm_info(u64 *rm_base, u64 *rm_size,
 	u64 *region_total);
+int ps3_repository_read_highmem_region_count(unsigned int *region_count);
+int ps3_repository_read_highmem_base(unsigned int region_index,
+	u64 *highmem_base);
+int ps3_repository_read_highmem_size(unsigned int region_index,
+	u64 *highmem_size);
+int ps3_repository_read_highmem_info(unsigned int region_index,
+	u64 *highmem_base, u64 *highmem_size);
 
 int ps3_repository_write_highmem_region_count(unsigned int region_count);
 int ps3_repository_write_highmem_base(unsigned int region_index,
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index c73f3a6..9b47ba7 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -779,6 +779,72 @@ int ps3_repository_read_mm_info(u64 *rm_base, u64 *rm_size, u64 *region_total)
 }
 
 /**
+ * ps3_repository_read_highmem_region_count - Read the number of highmem regions
+ *
+ * Bootloaders must arrange the repository nodes such that regions are indexed
+ * with a region_index from 0 to region_count-1.
+ */
+
+int ps3_repository_read_highmem_region_count(unsigned int *region_count)
+{
+	int result;
+	u64 v1 = 0;
+
+	result = read_node(PS3_LPAR_ID_CURRENT,
+		make_first_field("highmem", 0),
+		make_field("region", 0),
+		make_field("count", 0),
+		0,
+		&v1, NULL);
+	*region_count = v1;
+	return result;
+}
+
+
+int ps3_repository_read_highmem_base(unsigned int region_index,
+	u64 *highmem_base)
+{
+	return read_node(PS3_LPAR_ID_CURRENT,
+		make_first_field("highmem", 0),
+		make_field("region", region_index),
+		make_field("base", 0),
+		0,
+		highmem_base, NULL);
+}
+
+int ps3_repository_read_highmem_size(unsigned int region_index,
+	u64 *highmem_size)
+{
+	return read_node(PS3_LPAR_ID_CURRENT,
+		make_first_field("highmem", 0),
+		make_field("region", region_index),
+		make_field("size", 0),
+		0,
+		highmem_size, NULL);
+}
+
+/**
+ * ps3_repository_read_highmem_info - Read high memory region info
+ * @region_index: Region index, {0,..,region_count-1}.
+ * @highmem_base: High memory base address.
+ * @highmem_size: High memory size.
+ *
+ * Bootloaders that preallocate highmem regions must place the
+ * region info into the repository at these well known nodes.
+ */
+
+int ps3_repository_read_highmem_info(unsigned int region_index,
+	u64 *highmem_base, u64 *highmem_size)
+{
+	int result;
+
+	*highmem_base = 0;
+	result = ps3_repository_read_highmem_base(region_index, highmem_base);
+	return result ? result
+		: ps3_repository_read_highmem_size(region_index, highmem_size);
+}
+
+/**
  * ps3_repository_read_num_spu_reserved - Number of physical spus reserved.
  * @num_spu: Number of physical spus.
  */
-- 
1.7.9.5
