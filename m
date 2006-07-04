Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8283167B5A
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:06:39 +1000 (EST)
Subject: [PATCH] powerpc: Workaround Pegasos incorrect ISA "ranges"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:06:29 +1000
Message-Id: <1151985990.13828.29.camel@localhost.localdomain>
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

The Pegasos firmware doesn't create a valid "ranges" property for the
ISA bridge, thus causing translation of ISA addresses and IO ports to
fail. This fixes it, thus re-enabling proper early serial console to
work on Pegasos.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/prom_init.c	2006-07-04 12:57:37.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/prom_init.c	2006-07-04 12:59:33.000000000 +1000
@@ -2030,6 +2030,39 @@
 #define fixup_device_tree_maple()
 #endif
 
+#ifdef CONFIG_PPC_CHRP
+/* Pegasos lacks the "ranges" property in the isa node */
+static void __init fixup_device_tree_chrp(void)
+{
+	phandle isa;
+	u32 isa_ranges[6];
+	char *name;
+	int rc;
+
+	name = "/pci@80000000/isa@c";
+	isa = call_prom("finddevice", 1, 1, ADDR(name));
+	if (!PHANDLE_VALID(isa))
+		return;
+
+	rc = prom_getproplen(isa, "ranges");
+	if (rc != 0 && rc != PROM_ERROR)
+		return;
+
+	prom_printf("Fixing up missing ISA range on Pegasos...\n");
+
+	isa_ranges[0] = 0x1;
+	isa_ranges[1] = 0x0;
+	isa_ranges[2] = 0x01006000;
+	isa_ranges[3] = 0x0;
+	isa_ranges[4] = 0x0;
+	isa_ranges[5] = 0x00010000;
+	prom_setprop(isa, name, "ranges",
+			isa_ranges, sizeof(isa_ranges));
+}
+#else
+#define fixup_device_tree_chrp()
+#endif
+
 #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
 static void __init fixup_device_tree_pmac(void)
 {
@@ -2077,6 +2110,7 @@
 static void __init fixup_device_tree(void)
 {
 	fixup_device_tree_maple();
+	fixup_device_tree_chrp();
 	fixup_device_tree_pmac();
 }
 
