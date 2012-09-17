Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CDBD52C0086
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2012 00:34:41 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 17 Sep 2012 10:34:37 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8HEYXYq041804
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2012 10:34:33 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8HEYVo2032037
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2012 08:34:31 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] ppc/eeh: fix crash on converting OF node to edev
Date: Mon, 17 Sep 2012 22:34:28 +0800
Message-Id: <1347892468-25818-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347892468-25818-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347892468-25818-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel crash was reported by Alexy. He was testing some feature
with private kernel, in which Alexy added some code in pci_pm_reset()
to read the CSR after writting it. The bug could be reproduced on
Fiber Channel card (Fibre Channel: Emulex Corporation Saturn-X:
LightPulse Fibre Channel Host Adapter (rev 03)) by the following
commands.

	# echo 1 > /sys/devices/pci0004:01/0004:01:00.0/reset
	# rmmod lpfc
	# modprobe lpfc

The history behind the test case is that those additional config
space reading operations in pci_pm_reset() would cause EEH error,
but we didn't detect EEH error until "modprobe lpfc". For the case,
all the PCI devices on PCI bus (0004:01) were removed and added after
PE reset. Then the EEH devices would be figured out again based on
the OF nodes. Unfortunately, there were some child OF nodes under
PCI device (0004:01:00.0), but they didn't have attached PCI_DN since
they're invisible from PCI domain. However, we were still trying to
convert OF node to EEH device without checking on the attached PCI_DN.
Eventually, it caused the kernel crash as follows:

Unable to handle kernel paging request for data at address 0x00000030
Faulting instruction address: 0xc00000000004d888
cpu 0x0: Vector: 300 (Data Access) at [c000000fc797b950]
    pc: c00000000004d888: .eeh_add_device_tree_early+0x78/0x140
    lr: c00000000004d880: .eeh_add_device_tree_early+0x70/0x140
    sp: c000000fc797bbd0
   msr: 8000000000009032
   dar: 30
 dsisr: 40000000
  current = 0xc000000fc78d9f70
  paca    = 0xc00000000edb0000   softe: 0        irq_happened: 0x00
    pid   = 2951, comm = eehd
enter ? for help
[c000000fc797bc50] c00000000004d848 .eeh_add_device_tree_early+0x38/0x140
[c000000fc797bcd0] c00000000004d848 .eeh_add_device_tree_early+0x38/0x140
[c000000fc797bd50] c000000000051b54 .pcibios_add_pci_devices+0x34/0x190
[c000000fc797bde0] c00000000004fb10 .eeh_reset_device+0x100/0x160
[c000000fc797be70] c0000000000502dc .eeh_handle_event+0x19c/0x300
[c000000fc797bf00] c000000000050570 .eeh_event_handler+0x130/0x1a0
[c000000fc797bf90] c000000000020138 .kernel_thread+0x54/0x70

The patch changes of_node_to_eeh_dev() and just returns NULL if the
passed OF node doesn't have attached PCI_DN.

Cc: stable@vger.kernel.org
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h |    8 ++++++++
 arch/powerpc/platforms/pseries/eeh.c  |    2 +-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index a059cb9..025a130 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -182,6 +182,14 @@ static inline int pci_device_from_OF_node(struct device_node *np,
 #if defined(CONFIG_EEH)
 static inline struct eeh_dev *of_node_to_eeh_dev(struct device_node *dn)
 {
+	/*
+	 * For those OF nodes whose parent isn't PCI bridge, they
+	 * don't have PCI_DN actually. So we have to skip them for
+	 * any EEH operations.
+	 */
+	if (!dn || !PCI_DN(dn))
+		return NULL;
+
 	return PCI_DN(dn)->edev;
 }
 #else
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 43f6ed4..9a04322 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -728,7 +728,7 @@ static void eeh_add_device_early(struct device_node *dn)
 {
 	struct pci_controller *phb;
 
-	if (!dn || !of_node_to_eeh_dev(dn))
+	if (!of_node_to_eeh_dev(dn))
 		return;
 	phb = of_node_to_eeh_dev(dn)->phb;
 
-- 
1.7.5.4
