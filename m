Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPS2g2DwPzDrfP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 00:10:19 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org
CC: olof@lixom.net,
	chzigotzky@xenosoft.de
Date: Wed, 31 Aug 2016 13:24:40 +0100 (BST)
Message-ID: <48ba9b707d0.721225f3@auth.smtp.1and1.co.uk>
Subject: [ RFC PATCH 2/3] powerpc/pasemi: Fix Nemo SB600 i8259 interrupts.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6dab4a807c6aaf60.95"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6dab4a807c6aaf60.95
Content-Type: text/plain

    The device tree on the Nemo passes all of the i8259 interruts with
    numbers between 212 and 222, and points their interrupt-parent property
    to the pasemi-opic, requiring custom patches to the kernel.
    Fix the values so that they can be controlled by the generic ppc i8259
    code.

    Signed-off-by: Darren Stevens <darren@stevens-zone.net>

---


----=_BOUNDARY.6dab4a807c6aaf60.95
Content-Type: text/plain;
	name="nemo_1.patch"
Content-Disposition: attachment;
	filename="nemo_1.patch";
	size=2593

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 4e74fc5..8269093 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2639,6 +2639,69 @@ static void __init fixup_device_tree_efika(void)
 #else
 #define fixup_device_tree_efika()
 #endif
+#ifdef CONFIG_PPC_PASEMI
+static void __init fixup_device_tree_pasemi(void)
+{
+#ifdef CONFIG_PPC_PASEMI_NEMO
+/*
+ * CFE supplied on Nemo is broken in several ways, biggest
+ * problem is that it reassigns ISA interrupts to unused mpic ints.
+ * Add an interrupt-controller property for the io-bridge to use
+ * and correct the ints so we can attach them to an irq_domain
+ */
+ 	phandle iob, node;
+	u32 interrupts[2];
+	u32 parent;
+	u32 val = 0, rval;
+	char * name, * pci_name;
+
+	/* Find the root pci node */
+	name = "/pxp@0,e0000000";
+	iob = call_prom("finddevice", 1, 1, ADDR(name));
+	if (!PHANDLE_VALID(iob))
+		return;
+
+	/* check if interrupt-controller node set yet */
+	if (prom_getproplen(iob, "interrupt-controller") !=PROM_ERROR)
+		return;
+
+	prom_printf("adding interrupt-controller property for SB600...\n");
+
+	prom_setprop(iob, name, "interrupt-controller", &val, 0);
+
+	pci_name = "/pxp@0,e0000000/pci@11";
+	node = call_prom("finddevice", 1, 1, ADDR(pci_name));
+	parent = ADDR(iob);
+	for( ; prom_next_node(&node); ) {
+		/* scan each node for one with an interrupt */
+		if (PHANDLE_VALID(node)) {
+			rval = prom_getproplen(node, "interrupts");
+			if (rval != 0 && rval != PROM_ERROR) {
+				prom_getprop(node, "interrupts", &interrupts, sizeof(interrupts));
+				if ((interrupts[0] > 211) && (interrupts[0] < 223)) {
+					/* found a node, update both interrupts and interrupt-parent */
+					if ((interrupts[0] > 211) && (interrupts[0] < 216))
+						interrupts[0] -= 203;
+					if ((interrupts[0] > 215) && (interrupts[0] < 221))
+						interrupts[0] -= 213;
+					if (interrupts[0] == 221)
+						interrupts[0] = 14;
+					if (interrupts[0] == 222)
+						interrupts[0] = 8;
+
+					prom_setprop(node, pci_name, "interrupts", interrupts,
+								sizeof(interrupts));
+					prom_setprop(node, pci_name, "interrupt-parent", &parent,
+								sizeof(parent));
+				}
+			}
+		}
+	}
+#endif //CONFIG_PPC_PASEMI_NEMO
+}
+#else
+#define fixup_device_tree_pasemi()
+#endif
 
 static void __init fixup_device_tree(void)
 {
@@ -2647,6 +2710,7 @@ static void __init fixup_device_tree(void)
 	fixup_device_tree_chrp();
 	fixup_device_tree_pmac();
 	fixup_device_tree_efika();
+	fixup_device_tree_pasemi();
 }
 
 static void __init prom_find_boot_cpu(void)

----=_BOUNDARY.6dab4a807c6aaf60.95--
