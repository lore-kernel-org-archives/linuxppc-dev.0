Return-Path: <galak@kernel.crashing.org>
Date: Thu, 24 Jan 2008 22:45:10 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] bootwrapper: Add find_node_by_compatible
Message-ID: <Pine.LNX.4.64.0801242244490.22024@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the ability to find a device node by just what its compatible with.
This is useful in cases that we don't have a prop to find the node with.

---
 arch/powerpc/boot/libfdt-wrapper.c |    9 +++++++++
 arch/powerpc/boot/ops.h            |   11 +++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
index 97af36c..59016be 100644
--- a/arch/powerpc/boot/libfdt-wrapper.c
+++ b/arch/powerpc/boot/libfdt-wrapper.c
@@ -133,6 +133,14 @@ static void *fdt_wrapper_find_node_by_prop_value(const void *prev,
 	return offset_devp(offset);
 }

+static void *fdt_wrapper_find_node_by_compatible(const void *prev,
+						 const char *val)
+{
+	int offset = fdt_node_offset_by_compatible(fdt, devp_offset_find(prev),
+	                                           val);
+	return offset_devp(offset);
+}
+
 static char *fdt_wrapper_get_path(const void *devp, char *buf, int len)
 {
 	int rc;
@@ -164,6 +172,7 @@ void fdt_init(void *blob)
 	dt_ops.get_parent = fdt_wrapper_get_parent;
 	dt_ops.create_node = fdt_wrapper_create_node;
 	dt_ops.find_node_by_prop_value = fdt_wrapper_find_node_by_prop_value;
+	dt_ops.find_node_by_compatible = fdt_wrapper_find_node_by_compatible;
 	dt_ops.get_path = fdt_wrapper_get_path;
 	dt_ops.finalize = fdt_wrapper_finalize;

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 5872ef1..4b0544b 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -46,6 +46,8 @@ struct dt_ops {
 	void *(*find_node_by_prop_value)(const void *prev,
 	                                 const char *propname,
 	                                 const char *propval, int proplen);
+	void *(*find_node_by_compatible)(const void *prev,
+	                                 const char *compat);
 	unsigned long (*finalize)(void);
 	char *(*get_path)(const void *phandle, char *buf, int len);
 };
@@ -172,6 +174,15 @@ static inline void *find_node_by_alias(const char *alias)
 	return NULL;
 }

+static inline void *find_node_by_compatible(const void *prev,
+                                            const char *compat)
+{
+	if (dt_ops.find_node_by_compatible)
+		return dt_ops.find_node_by_compatible(prev, compat);
+
+	return NULL;
+}
+
 void dt_fixup_memory(u64 start, u64 size);
 void dt_fixup_cpu_clocks(u32 cpufreq, u32 tbfreq, u32 busfreq);
 void dt_fixup_clock(const char *path, u32 freq);
-- 
1.5.3.7
