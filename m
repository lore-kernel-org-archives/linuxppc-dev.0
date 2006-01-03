Return-Path: <galak@gate.crashing.org>
Date: Tue, 3 Jan 2006 16:15:21 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0601031614480.9938-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: fixing compile issue with !CONFIG_PCI in
	legacy_serial.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Only build in support for ISA and PCI cases if we have enabled CONFIG_ISA
and CONFIG_PCI.  Additionally, isa_bridge is a global so we shouldn't use
it a parameter name since it gets redefined to NULL when !CONFIG_PCI.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 010d770e4b04e159ce9841b4572224579b26ae22
tree a04b75607365053bf289edc0b76923bb86b06b5c
parent 8e80181ef9bf122ea5053e90cf9d9d0277c6e7ab
author Kumar Gala <galak@kernel.crashing.org> Tue, 03 Jan 2006 16:19:45 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 03 Jan 2006 16:19:45 -0600

 arch/powerpc/kernel/legacy_serial.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 59164ba..f970ace 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -134,8 +134,9 @@ static int __init add_legacy_soc_port(st
 	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ, flags);
 }
 
+#ifdef CONFIG_ISA
 static int __init add_legacy_isa_port(struct device_node *np,
-				      struct device_node *isa_bridge)
+				      struct device_node *isa_brg)
 {
 	u32 *reg;
 	char *typep;
@@ -167,7 +168,9 @@ static int __init add_legacy_isa_port(st
 	return add_legacy_port(np, index, UPIO_PORT, reg[1], taddr, NO_IRQ, UPF_BOOT_AUTOCONF);
 
 }
+#endif
 
+#ifdef CONFIG_PCI
 static int __init add_legacy_pci_port(struct device_node *np,
 				      struct device_node *pci_dev)
 {
@@ -233,6 +236,7 @@ static int __init add_legacy_pci_port(st
 	 */
 	return add_legacy_port(np, index, iotype, base, addr, NO_IRQ, UPF_BOOT_AUTOCONF);
 }
+#endif
 
 /*
  * This is called very early, as part of setup_system() or eventually
@@ -272,6 +276,7 @@ void __init find_legacy_serial_ports(voi
 		of_node_put(soc);
 	}
 
+#ifdef CONFIG_ISA
 	/* First fill our array with ISA ports */
 	for (np = NULL; (np = of_find_node_by_type(np, "serial"));) {
 		struct device_node *isa = of_get_parent(np);
@@ -282,7 +287,9 @@ void __init find_legacy_serial_ports(voi
 		}
 		of_node_put(isa);
 	}
+#endif
 
+#ifdef CONFIG_PCI
 	/* Next, try to locate PCI ports */
 	for (np = NULL; (np = of_find_all_nodes(np));) {
 		struct device_node *pci, *parent = of_get_parent(np);
@@ -312,6 +319,7 @@ void __init find_legacy_serial_ports(voi
 			legacy_serial_console = index;
 		of_node_put(parent);
 	}
+#endif
 
 	DBG("legacy_serial_console = %d\n", legacy_serial_console);
 
@@ -375,6 +383,7 @@ static void __init fixup_port_pio(int in
 				  struct device_node *np,
 				  struct plat_serial8250_port *port)
 {
+#ifdef CONFIG_PCI
 	struct pci_controller *hose;
 
 	DBG("fixup_port_pio(%d)\n", index);
@@ -391,6 +400,7 @@ static void __init fixup_port_pio(int in
 		    index, port->iobase, port->iobase + offset);
 		port->iobase += offset;
 	}
+#endif
 }
 
 static void __init fixup_port_mmio(int index,
