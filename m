Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 444D967B8D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:14:17 +1000 (EST)
Subject: [PATCH] powerpc: Fix legacy_serial.c error handling on 32 bits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:14:07 +1000
Message-Id: <1151986447.13828.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code in legacy_serial.c wouldn't properly compare OF translation results against
OF_BAD_ADDR as it's using a phys_addr_t which is 32 bits on some 32 bits powerpc
platforms. This fixes it by always using a u64 which is what is returned by the OF
parsing routines. It also makes translation failure harmless for ISA serial ports.
If they can't translate, we can't use the UART early, but we can still let the 8250
driver use it later on by using IO port accessors.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/kernel/legacy_serial.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/legacy_serial.c	2006-07-04 13:01:13.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/legacy_serial.c	2006-07-04 13:06:55.000000000 +1000
@@ -112,7 +112,7 @@
 static int __init add_legacy_soc_port(struct device_node *np,
 				      struct device_node *soc_dev)
 {
-	phys_addr_t addr;
+	u64 addr;
 	u32 *addrp;
 	upf_t flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
 
@@ -143,7 +143,7 @@
 	u32 *reg;
 	char *typep;
 	int index = -1;
-	phys_addr_t taddr;
+	u64 taddr;
 
 	DBG(" -> add_legacy_isa_port(%s)\n", np->full_name);
 
@@ -165,10 +165,13 @@
 	if (typep && *typep == 'S')
 		index = simple_strtol(typep+1, NULL, 0) - 1;
 
-	/* Translate ISA address */
+	/* Translate ISA address. If it fails, we still register the port
+	 * with no translated address so that it can be picked up as an IO
+	 * port later by the serial driver
+	 */
 	taddr = of_translate_address(np, reg);
 	if (taddr == OF_BAD_ADDR)
-		return -1;
+		taddr = 0;
 
 	/* Add port, irq will be dealt with later */
 	return add_legacy_port(np, index, UPIO_PORT, reg[1], taddr,
@@ -180,7 +183,7 @@
 static int __init add_legacy_pci_port(struct device_node *np,
 				      struct device_node *pci_dev)
 {
-	phys_addr_t addr, base;
+	u64 addr, base;
 	u32 *addrp;
 	unsigned int flags;
 	int iotype, index = -1, lindex = 0;
