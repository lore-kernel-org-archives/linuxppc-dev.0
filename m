Return-Path: <galak@gate.crashing.org>
Date: Tue, 20 Dec 2005 16:16:52 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512201616270.26351-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add the ability to handle SOC ports in
	legacy_serial
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the ability to configure and initialize legacy 8250 serials
ports on an SOC bus.  Also, fixed an issue that we would not
configure any serial ports if "linux,stdout-path" was not found.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit adb69b3e888de037f4e58cc505443e624d498596
tree 7be9bb626b8d2c773dd88a1d3e17a5f56995075f
parent 8bec94b3bb35c0273fbab5a6aa477ec71a4d1fab
author Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 16:20:09 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 16:20:09 -0600

 arch/powerpc/kernel/legacy_serial.c |   62 +++++++++++++++++++++++++++++------
 1 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index d179ec5..59164ba 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -36,7 +36,8 @@ static int legacy_serial_console = -1;
 
 static int __init add_legacy_port(struct device_node *np, int want_index,
 				  int iotype, phys_addr_t base,
-				  phys_addr_t taddr, unsigned long irq)
+				  phys_addr_t taddr, unsigned long irq,
+				  unsigned int flags)
 {
 	u32 *clk, *spd, clock = BASE_BAUD * 16;
 	int index;
@@ -90,7 +91,7 @@ static int __init add_legacy_port(struct
 	legacy_serial_ports[index].iotype = iotype;
 	legacy_serial_ports[index].uartclk = clock;
 	legacy_serial_ports[index].irq = irq;
-	legacy_serial_ports[index].flags = ASYNC_BOOT_AUTOCONF;
+	legacy_serial_ports[index].flags = flags;
 	legacy_serial_infos[index].taddr = taddr;
 	legacy_serial_infos[index].np = of_node_get(np);
 	legacy_serial_infos[index].clock = clock;
@@ -107,6 +108,32 @@ static int __init add_legacy_port(struct
 	return index;
 }
 
+static int __init add_legacy_soc_port(struct device_node *np,
+				      struct device_node *soc_dev)
+{
+	phys_addr_t addr;
+	u32 *addrp;
+	unsigned int flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
+
+	/* We only support ports that have a clock frequency properly
+	 * encoded in the device-tree.
+	 */
+	if (get_property(np, "clock-frequency", NULL) == NULL)
+		return -1;
+
+	/* Get the address */
+	addrp = of_get_address(soc_dev, 0, NULL, NULL);
+	if (addrp == NULL)
+		return -1;
+
+	addr = of_translate_address(soc_dev, addrp);
+
+	/* Add port, irq will be dealt with later. We passed a translated
+	 * IO port value. It will be fixed up later along with the irq
+	 */
+	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ, flags);
+}
+
 static int __init add_legacy_isa_port(struct device_node *np,
 				      struct device_node *isa_bridge)
 {
@@ -137,7 +164,7 @@ static int __init add_legacy_isa_port(st
 	taddr = of_translate_address(np, reg);
 
 	/* Add port, irq will be dealt with later */
-	return add_legacy_port(np, index, UPIO_PORT, reg[1], taddr, NO_IRQ);
+	return add_legacy_port(np, index, UPIO_PORT, reg[1], taddr, NO_IRQ, UPF_BOOT_AUTOCONF);
 
 }
 
@@ -204,7 +231,7 @@ static int __init add_legacy_pci_port(st
 	/* Add port, irq will be dealt with later. We passed a translated
 	 * IO port value. It will be fixed up later along with the irq
 	 */
-	return add_legacy_port(np, index, iotype, base, addr, NO_IRQ);
+	return add_legacy_port(np, index, iotype, base, addr, NO_IRQ, UPF_BOOT_AUTOCONF);
 }
 
 /*
@@ -218,7 +245,7 @@ static int __init add_legacy_pci_port(st
  */
 void __init find_legacy_serial_ports(void)
 {
-	struct device_node *np, *stdout;
+	struct device_node *np, *stdout = NULL;
 	char *path;
 	int index;
 
@@ -226,13 +253,23 @@ void __init find_legacy_serial_ports(voi
 
 	/* Now find out if one of these is out firmware console */
 	path = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
-	if (path == NULL) {
+	if (path != NULL) {
+		stdout = of_find_node_by_path(path);
+		if (stdout)
+			DBG("stdout is %s\n", stdout->full_name);
+	} else {
 		DBG(" no linux,stdout-path !\n");
-		return;
 	}
-	stdout = of_find_node_by_path(path);
-	if (stdout) {
-		DBG("stdout is %s\n", stdout->full_name);
+
+	/* First fill our array with SOC ports */
+	for (np = NULL; (np = of_find_compatible_node(np, "serial", "ns16550")) != NULL;) {
+		struct device_node *soc = of_get_parent(np);
+		if (soc && !strcmp(soc->type, "soc")) {
+			index = add_legacy_soc_port(np, np);
+			if (index >= 0 && np == stdout)
+				legacy_serial_console = index;
+		}
+		of_node_put(soc);
 	}
 
 	/* First fill our array with ISA ports */
@@ -437,6 +474,11 @@ static int __init check_legacy_serial_co
 		DBG(" of_chosen is NULL !\n");
 		return -ENODEV;
 	}
+
+	if (legacy_serial_console < 0) {
+		DBG(" legacy_serial_console not found !\n");
+		return -ENODEV;
+	}
 	/* We are getting a weird phandle from OF ... */
 	/* ... So use the full path instead */
 	name = (char *)get_property(of_chosen, "linux,stdout-path", NULL);
