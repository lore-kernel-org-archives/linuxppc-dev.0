Return-Path: <geoff@infradead.org>
Message-Id: <5eea9062c9b96ef12a417959990c20b334b016e1.1421109719.git.geoff@infradead.org>
In-Reply-To: <cover.1421109719.git.geoff@infradead.org>
References: <cover.1421109719.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/6] powerpc/ps3: Add empty repository highmem routines
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

To avoid the need for preprocessor conditionals in C source files add a set of
empty inline repository highmem write routines to platform.h that are used when
CONFIG_PS3_REPOSITORY_WRITE is not defined.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/platform.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index d71329a..1809cfc 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -196,6 +196,7 @@ int ps3_repository_read_highmem_size(unsigned int region_index,
 int ps3_repository_read_highmem_info(unsigned int region_index,
 	u64 *highmem_base, u64 *highmem_size);
 
+#if defined (CONFIG_PS3_REPOSITORY_WRITE)
 int ps3_repository_write_highmem_region_count(unsigned int region_count);
 int ps3_repository_write_highmem_base(unsigned int region_index,
 	u64 highmem_base);
@@ -204,6 +205,18 @@ int ps3_repository_write_highmem_size(unsigned int region_index,
 int ps3_repository_write_highmem_info(unsigned int region_index,
 	u64 highmem_base, u64 highmem_size);
 int ps3_repository_delete_highmem_info(unsigned int region_index);
+#else
+static inline int ps3_repository_write_highmem_region_count(
+	unsigned int region_count) {return 0;}
+static inline int ps3_repository_write_highmem_base(unsigned int region_index,
+	u64 highmem_base) {return 0;}
+static inline int ps3_repository_write_highmem_size(unsigned int region_index,
+	u64 highmem_size) {return 0;}
+static inline int ps3_repository_write_highmem_info(unsigned int region_index,
+	u64 highmem_base, u64 highmem_size) {return 0;}
+static inline int ps3_repository_delete_highmem_info(unsigned int region_index)
+	{return 0;}
+#endif
 
 /* repository pme info */
 
-- 
1.9.1
