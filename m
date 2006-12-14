Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F55767D00
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 13:29:02 +1100 (EST)
Date: Thu, 14 Dec 2006 11:28:54 +0900 (JST)
Message-Id: <200612140228.kBE2SvUQ013034@toshiba.co.jp>
Subject: [PATCH 6/19] powerpc: avoid claiming some PCI bus
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
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

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/kernel/pci_64.c
diff -u linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.1.1.1 linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.3
--- linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.1.1.1	Wed Dec  6 08:25:43 2006
+++ linux-powerpc-git/arch/powerpc/kernel/pci_64.c	Tue Dec 12 15:37:56 2006
@@ -249,8 +249,13 @@
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		return;
 
-	list_for_each_entry(b, &pci_root_buses, node)
-		pcibios_claim_one_bus(b);
+	list_for_each_entry(b, &pci_root_buses, node) {
+		if (machine_is(celleb) &&
+		    ppc_md.pci_probe_mode(b) != PCI_PROBE_DEVTREE)
+			;
+		else
+			pcibios_claim_one_bus(b);
+	}
 }
 
 static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
