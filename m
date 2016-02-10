Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D10B1A03FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:04:40 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 16:04:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7132C2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:04:26 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1A64I1F1900990
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:04:26 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1A63r6a012928
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 17:03:54 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru, ruscur@russell.cc, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v14 3/9] powerpc/pci: Remove VFs prior to PF
Date: Wed, 10 Feb 2016 17:02:51 +1100
Message-Id: <1455084177-15525-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455084177-15525-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

As commit ac205b7bb72f ("PCI: make sriov work with hotplug remove")
indicates, VFs which is on the same PCI bus as their PF, should be
removed before the PF. Otherwise, we might run into kernel crash
at PCI unplugging time.

This applies the above pattern to powerpc PCI hotplug path.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 7f9ed0c..59c4361 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -55,7 +55,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
 
 	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
 		 pci_domain_nr(bus),  bus->number);
-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
 		pr_debug("   Removing %s...\n", pci_name(dev));
 		pci_stop_and_remove_bus_device(dev);
 	}
-- 
2.1.0
