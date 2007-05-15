Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id AC93EDDED4
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 02:50:10 +1000 (EST)
Received: from [10.50.1.88] (rhino.az.mvista.com [10.50.1.88])
	by hermes.mvista.com (Postfix) with ESMTP id BB7A41D3BD
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 09:50:09 -0700 (PDT)
Subject: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev 1.02
	hardware
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
In-Reply-To: <1179245829.8132.100.camel@rhino>
References: <1179245829.8132.100.camel@rhino>
Content-Type: text/plain
Date: Tue, 15 May 2007 09:50:09 -0700
Message-Id: <1179247809.8132.138.camel@rhino>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes PCI support for newer revisions of the MPCN8641 silicon and
the HPCN hardware.

Currently, there is a workaround for a PCI erratum that forces the host
bridge's primary bus to be 0xff.  This workaround is no longer necessary
on newer revisions.

Additionally, the host bridge on the newer rev's behaves like a
transparent bridge, but does not use the correct PCI class, so this adds
a fixup for the class.  This is the only device on bus 0, all other
devices are on subsequent buses.

Furthermore, all of the devices on the southbridge show up on bus 2,
behind an additional PCI bridge.  In order to use the correct IRQ's for
the devices, we need to create additional device nodes for the PCI
bridges, and reproduce the interrupt map on the correct bus.

Since the southbridge devices are now bus 2, we also need to fix the bus
range for PCIe 2 to begin at bus 3.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

---

 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  121 ++++++++++++++++++-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    8 -
 arch/powerpc/platforms/86xx/pci.c          |   27 +++-
 3 files changed, 149 insertions(+), 7 deletions(-)On Tue, 2007-05-15 at
09:17 -0700, Wade Farnsworth wrote:


Index: linux-2.6-8641/arch/powerpc/platforms/86xx/pci.c
===================================================================
--- linux-2.6-8641.orig/arch/powerpc/platforms/86xx/pci.c
+++ linux-2.6-8641/arch/powerpc/platforms/86xx/pci.c
@@ -134,16 +134,24 @@ mpc86xx_setup_pcie(struct pci_controller
 
 	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
 
-	/* PCIE Bus, Fix the MPC8641D host bridge's location to bus 0xFF. */
+	/*
+	 * For Rev 1.0, fix the bus to 0xff.  Otherwise use the default.
+	 */
 	early_read_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, &temps);
-	temps = (temps & 0xff000000) | (0xff) | (0x0 << 8) | (0xfe << 16);
+	if ((mfspr(SPRN_SVR) & 0xf0) == 0x10)
+		temps = (temps & 0xff000000) | 0xff | (0xfe << 16);
+	else
+		temps = (temps & 0xff000000) | hose->first_busno |
+			((hose->first_busno + 1) << 8) |
+			(hose->last_busno << 16);
 	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, temps);
 }
 
 int mpc86xx_exclude_device(u_char bus, u_char devfn)
 {
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	if ((mfspr(SPRN_SVR) & 0xf0) == 0x10)
+		if (bus == 0 && PCI_SLOT(devfn) == 0)
+			return PCIBIOS_DEVICE_NOT_FOUND;
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -162,6 +170,11 @@ int __init add_bridge(struct device_node
 	/* Fetch host bridge registers address */
 	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
 
+	/* For Rev 1 silicon, only the first PCI host is supported. */
+	if (((mfspr(SPRN_SVR) & 0xf0) == 0x10) &&
+	    ((rsrc.start & 0xfffff) == 0x9000))
+		return 0;
+
 	/* Get bus range if any */
 	bus_range = of_get_property(dev, "bus-range", &len);
 	if (bus_range == NULL || len < 2 * sizeof(int))
@@ -203,3 +216,9 @@ int __init add_bridge(struct device_node
 
 	return 0;
 }
+
+static void __devinit early_mpc86xx_pcie(struct pci_dev *dev)
+{
+	   dev->class = PCI_CLASS_BRIDGE_PCI << 8 | 0x1;
+}
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, early_mpc86xx_pcie);
Index: linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
===================================================================
--- linux-2.6-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -286,6 +286,125 @@
 				f800 0 0 4 &i8259 0 0
 				>;
 
+			pci@00 {
+				device_type = "pci";
+				#interrupt-cells = <1>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				reg = <0000 0 0 0 0>;
+				bus-range = <0 fe>;
+				ranges = <02000000 0 80000000 80000000 0
+					  20000000
+					  01000000 0 00000000 00000000 0
+					  00100000>;
+
+				pci@00 {
+					device_type = "pci";
+					#interrupt-cells = <1>;
+					#size-cells = <2>;
+					#address-cells = <3>;
+					reg = <0000 0 0 0 0>;
+					bus-range = <1 fe>;
+					ranges = <02000000 0 80000000 80000000
+						  0 20000000
+						  01000000 0 00000000 00000000
+						  0 00100000>;
+					interrupt-map-mask = <3f800 0 0 7>;
+					interrupt-map = <
+						/* IDSEL 0x11 */
+						28800 0 0 1 &i8259 3 2
+						28800 0 0 2 &i8259 4 2
+						28800 0 0 3 &i8259 5 2
+						28800 0 0 4 &i8259 6 2
+
+						/* IDSEL 0x12 */
+						29000 0 0 1 &i8259 4 2
+						29000 0 0 2 &i8259 5 2
+						29000 0 0 3 &i8259 6 2
+						29000 0 0 4 &i8259 3 2
+
+						/* IDSEL 0x13 */
+						29800 0 0 1 &i8259 0 0
+						29800 0 0 2 &i8259 0 0
+						29800 0 0 3 &i8259 0 0
+						29800 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x14 */
+						2a000 0 0 1 &i8259 0 0
+						2a000 0 0 2 &i8259 0 0
+						2a000 0 0 3 &i8259 0 0
+						2a000 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x15 */
+						2a800 0 0 1 &i8259 0 0
+						2a800 0 0 2 &i8259 0 0
+						2a800 0 0 3 &i8259 0 0
+						2a800 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x16 */
+						2b000 0 0 1 &i8259 0 0
+						2b000 0 0 2 &i8259 0 0
+						2b000 0 0 3 &i8259 0 0
+						2b000 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x17 */
+						2b800 0 0 1 &i8259 0 0
+						2b800 0 0 2 &i8259 0 0
+						2b800 0 0 3 &i8259 0 0
+						2b800 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x18 */
+						2c000 0 0 1 &i8259 0 0
+						2c000 0 0 2 &i8259 0 0
+						2c000 0 0 3 &i8259 0 0
+						2c000 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x19 */
+						2c800 0 0 1 &i8259 0 0
+						2c800 0 0 2 &i8259 0 0
+						2c800 0 0 3 &i8259 0 0
+						2c800 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x1a */
+						2d000 0 0 1 &i8259 6 2
+						2d000 0 0 2 &i8259 3 2
+						2d000 0 0 3 &i8259 4 2
+						2d000 0 0 4 &i8259 5 2
+
+						/* IDSEL 0x1b */
+						2d800 0 0 1 &i8259 5 2
+						2d800 0 0 2 &i8259 0 0
+						2d800 0 0 3 &i8259 0 0
+						2d800 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x1c */
+						2e000 0 0 1 &i8259 9 2
+						2e000 0 0 2 &i8259 a 2
+						2e000 0 0 3 &i8259 b 2
+						2e000 0 0 4 &i8259 7 2
+
+						/* IDSEL 0x1d */
+						2e800 0 0 1 &i8259 9 2
+						2e800 0 0 2 &i8259 a 2
+						2e800 0 0 3 &i8259 b 2
+						2e800 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x1e */
+						2f000 0 0 1 &i8259 b 2
+						2f000 0 0 2 &i8259 0 0
+						2f000 0 0 3 &i8259 0 0
+						2f000 0 0 4 &i8259 0 0
+
+						/* IDSEL 0x1f */
+						2f800 0 0 1 &i8259 6 2
+						2f800 0 0 2 &i8259 0 0
+						2f800 0 0 3 &i8259 0 0
+						2f800 0 0 4 &i8259 0 0
+						>;
+					};
+				};
+
+
 			isa@f0 {
 				device_type = "isa";
 				#interrupt-cells = <2>;
@@ -335,7 +454,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <9000 1000>;
-			bus-range = <0 ff>;
+			bus-range = <3 ff>;
 			ranges = <02000000 0 a0000000 a0000000 0 20000000
 				  01000000 0 00000000 e3000000 0 00100000>;
 			clock-frequency = <1fca055>;
Index: linux-2.6-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-2.6-8641.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ linux-2.6-8641/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -419,8 +419,12 @@ mpc86xx_hpcn_setup_arch(void)
 	}
 
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		add_bridge(np);
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct device_node *parent = of_get_parent(np);
+		if (strcmp(parent->type, "pci"))
+			add_bridge(np);
+		of_node_put(parent);
+	}
 
 	ppc_md.pci_exclude_device = mpc86xx_exclude_device;
 #endif
