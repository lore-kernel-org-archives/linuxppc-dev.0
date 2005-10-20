Return-Path: <galak@freescale.com>
Date: Thu, 20 Oct 2005 11:44:03 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510201143370.8879@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: some prom.c cleanups
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On !CONFIG_PPC_MULTIPLATFORM _machine is defined as 0.  This is ok, but
we can't assign a value to _machine then.

We may not have CONFIG_PCI available, so only build in support for
find_parent_pci_resource(), request_OF_resource(), release_OF_resource()
if PCI is enabled.  This is probably not the long term fix but works out
for now.

Make reg_property64 contain 64-bit elements on a 32-bit machine.

Mark the deprecated prom.c functions as __deprecated.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 3f11459b85450aa70da16ab1b1c82ef29498ef1a
tree 8b625ab8868872bf5b909d0d55dd704604858048
parent e597837e138d9526562a68ec2f3c77a47ce1045e
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 20 Oct 2005 11:41:18 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 20 Oct 2005 11:41:18 -0500

 arch/powerpc/kernel/prom.c |    4 ++++
 include/asm-powerpc/prom.h |   14 +++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1133,8 +1133,10 @@ static int __init early_init_dt_scan_cho
 #ifdef CONFIG_PPC64
 	systemcfg->platform = *prop;
 #else
+#ifdef CONFIG_PPC_MULTIPLATFORM
 	_machine = *prop;
 #endif
+#endif
 
 #ifdef CONFIG_PPC64
 	/* check if iommu is forced on or off */
@@ -1971,6 +1973,7 @@ bus_space_to_resource_flags(unsigned int
 	}
 }
 
+#ifdef CONFIG_PCI
 static struct resource *find_parent_pci_resource(struct pci_dev* pdev,
 						 struct address_range *range)
 {
@@ -2123,3 +2126,4 @@ int release_OF_resource(struct device_no
 	return 0;
 }
 EXPORT_SYMBOL(release_OF_resource);
+#endif /* CONFIG_PCI */
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -104,8 +104,8 @@ struct reg_property32 {
 };
 
 struct reg_property64 {
-	unsigned long address;
-	unsigned long size;
+	u64 address;
+	u64 size;
 };
 
 struct property {
@@ -155,12 +155,12 @@ static inline void set_node_proc_entry(s
 
 
 /* OBSOLETE: Old style node lookup */
-extern struct device_node *find_devices(const char *name);
-extern struct device_node *find_type_devices(const char *type);
-extern struct device_node *find_path_device(const char *path);
-extern struct device_node *find_compatible_devices(const char *type,
+extern __deprecated struct device_node *find_devices(const char *name);
+extern __deprecated struct device_node *find_type_devices(const char *type);
+extern __deprecated struct device_node *find_path_device(const char *path);
+extern __deprecated struct device_node *find_compatible_devices(const char *type,
 						   const char *compat);
-extern struct device_node *find_all_nodes(void);
+extern __deprecated struct device_node *find_all_nodes(void);
 
 /* New style node lookup */
 extern struct device_node *of_find_node_by_name(struct device_node *from,
