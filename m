Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E58611A0A70
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 14:30:33 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 09:00:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 39F32125805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 09:00:28 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA43UNtU2490390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:00:24 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA43UM6l000914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 09:00:23 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
 aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V12 3/9] powerpc/pci: Remove VFs prior to PF
Date: Wed,  4 Nov 2015 11:28:46 +0800
Message-Id: <1446607732-4166-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As commit ac205b7bb72f ("PCI: make sriov work with hotplug remove")
indicates, VFs which is on the same PCI bus as their PF, should be removed
before the PF. Otherwise, the PCI hot unplugging of PCI devices on the PCI
bus would cause kernel crash.

The patch applies the above pattern to PowerPC PCI hotplug path.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
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
2.5.0
