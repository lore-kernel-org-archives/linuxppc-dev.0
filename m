Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 20:53:06 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: pcibus_to_node fixes
Message-ID: <20060610105305.GM23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


of_node_to_nid returns -1 if the associativity cannot be found. This
means pcibus_to_cpumask has to be careful not to pass a negative index into
node_to_cpumask.

Since pcibus_to_node could be used a lot, and of_node_to_nid is slow (it
walks a list doing strcmps), lets also cache the node in the
pci_controller struct.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/pci_64.c
===================================================================
--- build.orig/arch/powerpc/kernel/pci_64.c	2006-06-10 11:45:51.000000000 +1000
+++ build/arch/powerpc/kernel/pci_64.c	2006-06-10 11:45:54.000000000 +1000
@@ -227,8 +227,10 @@ struct pci_controller * pcibios_alloc_co
 	pci_setup_pci_controller(phb);
 	phb->arch_data = dev;
 	phb->is_dynamic = mem_init_done;
-	if (dev)
+	if (dev) {
+		PHB_SET_NODE(phb, of_node_to_nid(dev));
 		add_linux_pci_domain(dev, phb);
+	}
 	return phb;
 }
 
@@ -1415,3 +1417,12 @@ long sys_pciconfig_iobase(long which, un
 
 	return -EOPNOTSUPP;
 }
+
+#ifdef CONFIG_NUMA
+int pcibus_to_node(struct pci_bus *bus)
+{
+	struct pci_controller *phb = pci_bus_to_host(bus);
+	return phb->node;
+}
+EXPORT_SYMBOL(pcibus_to_node);
+#endif
Index: build/include/asm-powerpc/pci-bridge.h
===================================================================
--- build.orig/include/asm-powerpc/pci-bridge.h	2006-06-10 11:45:51.000000000 +1000
+++ build/include/asm-powerpc/pci-bridge.h	2006-06-10 11:45:54.000000000 +1000
@@ -6,6 +6,7 @@
 #include <asm-ppc/pci-bridge.h>
 #else
 
+#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/list.h>
 
@@ -22,6 +23,7 @@
 struct pci_controller {
 	struct pci_bus *bus;
 	char is_dynamic;
+	int node;
 	void *arch_data;
 	struct list_head list_node;
 
@@ -165,6 +167,12 @@ static inline unsigned long pci_address_
 #define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
 #define PCI_PROBE_DEVTREE	1	/* Instantiate from device tree */
 
+#ifdef CONFIG_NUMA
+#define PHB_SET_NODE(PHB, NODE)		((PHB)->node = (NODE))
+#else
+#define PHB_SET_NODE(PHB, NODE)		((PHB)->node = -1)
+#endif
+
 #endif /* CONFIG_PPC64 */
 #endif /* __KERNEL__ */
 #endif
Index: build/include/asm-powerpc/topology.h
===================================================================
--- build.orig/include/asm-powerpc/topology.h	2006-06-10 11:45:51.000000000 +1000
+++ build/include/asm-powerpc/topology.h	2006-06-10 11:46:31.000000000 +1000
@@ -32,13 +32,13 @@ static inline int node_to_first_cpu(int 
 
 int of_node_to_nid(struct device_node *device);
 
-#ifdef CONFIG_PPC64
-#define pcibus_to_node(bus)	(of_node_to_nid(bus->sysdata))
-#define pcibus_to_cpumask(bus)	(node_to_cpumask(of_node_to_nid(bus->sysdata)))
-#else
-#define pcibus_to_node(node)    (-1)
-#define pcibus_to_cpumask(bus)	(cpu_online_map)
-#endif
+struct pci_bus;
+extern int pcibus_to_node(struct pci_bus *bus);
+
+#define pcibus_to_cpumask(bus)	(pcibus_to_node(bus) == -1 ? \
+					CPU_MASK_ALL : \
+					node_to_cpumask(pcibus_to_node(bus)) \
+				)
 
 /* sched_domains SD_NODE_INIT for PPC64 machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
