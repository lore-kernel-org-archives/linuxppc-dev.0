Return-Path: <arnd@arndb.de>
Message-Id: <20061127182432.342279000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:19:00 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 9/9] fix building without PCI
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At least the ide driver calls pcibus_to_node, which is not
defined when CONFIG_PCI is disabled. This adds a nop function
for the !PCI case.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

diff --git a/include/asm-powerpc/topology.h b/include/asm-powerpc/topology.h
index 9fe7894..50c0140 100644
--- a/include/asm-powerpc/topology.h
+++ b/include/asm-powerpc/topology.h
@@ -32,7 +32,14 @@ static inline int node_to_first_cpu(int 
 int of_node_to_nid(struct device_node *device);
 
 struct pci_bus;
+#ifdef CONFIG_PCI
 extern int pcibus_to_node(struct pci_bus *bus);
+#else
+static inline int pcibus_to_node(struct pci_bus *bus)
+{
+	return -1;
+}
+#endif
 
 #define pcibus_to_cpumask(bus)	(pcibus_to_node(bus) == -1 ? \
 					CPU_MASK_ALL : \

--
