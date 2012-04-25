Return-Path: <geoff@infradead.org>
Message-Id: <07c044c86e05818c2d5e99b8ff881e2e4543c6ad.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 02/10] powerpc/ps3: Add PS3 repository write support
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

Add a new config option CONFIG_PS3_REPOSITORY_WRITE that
conditionally builds in support to create, write and delete
nodes in the PS3 system repository.

This support will allow Linux based bootloaders to manage data
in the system repository for use by later boot stages,

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/Kconfig      |   13 +++++++
 arch/powerpc/platforms/ps3/repository.c |   58 +++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index 476d9d9..4210aaa 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -88,6 +88,19 @@ config PS3_SYS_MANAGER
 	  This support is required for system control.  In
 	  general, all users will say Y or M.
 
+config PS3_REPOSITORY_WRITE
+	bool "PS3 Repository write support" if PS3_ADVANCED
+	depends on PPC_PS3
+	default n
+	help
+	  Enables support for writing to the PS3 System Repository.
+
+	  This support is intended for bootloaders that need to store data
+	  in the repository for later boot stages.
+
+	  If in doubt, say N here and reduce the size of the kernel by a
+	  small amount.
+
 config PS3_STORAGE
 	depends on PPC_PS3
 	tristate
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 7bdfea3..b31142c 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -1002,6 +1002,64 @@ int ps3_repository_read_lpm_privileges(unsigned int be_index, u64 *lpar,
 			    lpar, rights);
 }
 
+#if defined(CONFIG_PS3_REPOSITORY_WRITE)
+
+static int create_node(u64 n1, u64 n2, u64 n3, u64 n4, u64 v1, u64 v2)
+{
+	int result;
+
+	dump_node(0, n1, n2, n3, n4, v1, v2);
+
+	result = lv1_create_repository_node(n1, n2, n3, n4, v1, v2);
+
+	if (result) {
+		pr_devel("%s:%d: lv1_create_repository_node failed: %s\n",
+			__func__, __LINE__, ps3_result(result));
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int delete_node(u64 n1, u64 n2, u64 n3, u64 n4)
+{
+	int result;
+
+	dump_node(0, n1, n2, n3, n4, 0, 0);
+
+	result = lv1_delete_repository_node(n1, n2, n3, n4);
+
+	if (result) {
+		pr_devel("%s:%d: lv1_delete_repository_node failed: %s\n",
+			__func__, __LINE__, ps3_result(result));
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static int write_node(u64 n1, u64 n2, u64 n3, u64 n4, u64 v1, u64 v2)
+{
+	int result;
+
+	result = create_node(n1, n2, n3, n4, v1, v2);
+
+	if (!result)
+		return 0;
+
+	result = lv1_write_repository_node(n1, n2, n3, n4, v1, v2);
+
+	if (result) {
+		pr_devel("%s:%d: lv1_write_repository_node failed: %s\n",
+			__func__, __LINE__, ps3_result(result));
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+#endif /* defined(CONFIG_PS3_WRITE_REPOSITORY) */
+
 #if defined(DEBUG)
 
 int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
-- 
1.7.9.5
