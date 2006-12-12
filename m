Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B795967C3D
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 15:39:33 +1100 (EST)
Date: Tue, 12 Dec 2006 13:39:23 +0900 (JST)
Message-Id: <200612120439.kBC4dOUJ002218@toshiba.co.jp>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 14/15] powerpc: avoid claiming some PCI bus
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Celleb has multiple PCI buses. Devices on some of those PCI buses
require to assign resources by Linux.  This patch is for such buses
not to claim resources, because claimed resource does not become a
target for resource assign.

Signed-off-by: Kou Ishizaki <kou.ishizaki.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/kernel/pci_64.c
diff -u linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.1.1.1 linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.2
--- linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/kernel/pci_64.c	Wed Dec  6 08:43:14 2006
@@ -249,8 +249,16 @@
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		return;
 
+#ifdef CONFIG_PPC_MULTIPLATFORM
+	list_for_each_entry(b, &pci_root_buses, node) {
+		if (!machine_is(celleb) ||
+		    ppc_md.pci_probe_mode(b) == PCI_PROBE_DEVTREE)
+			pcibios_claim_one_bus(b);
+	}
+#else
 	list_for_each_entry(b, &pci_root_buses, node)
 		pcibios_claim_one_bus(b);
+#endif
 }
 
 static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
