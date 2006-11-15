Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EE4B67C86
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 20:58:38 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id kAF9wYWY016859
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:58:34 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id kAF9wZrZ008568
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 18:58:35 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id kAF9wYjl016718
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:58:34 +0900 (JST)
Date: Wed, 15 Nov 2006 18:58:33 +0900 (JST)
Message-Id: <200611150958.kAF9wXTQ011153@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/16] Resource assignments for PCI devices on Celleb
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

Celleb has multiple PCI buses. Devices on some of those PCI buses require to
assign resources by Linux. 
This patch is for such buses not to claim resources, because claimed resource
does not become a target for resource assign.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/kernel/pci_64.c
diff -u linux-2.6.19/arch/powerpc/kernel/pci_64.c:1.1.1.2 linux-2.6.19/arch/powerpc/kernel/pci_64.c:1.3
--- linux-2.6.19/arch/powerpc/kernel/pci_64.c:1.1.1.2	Tue Oct 24 13:35:53 2006
+++ linux-2.6.19/arch/powerpc/kernel/pci_64.c	Mon Nov  6 22:04:23 2006
@@ -247,8 +247,16 @@
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
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
