Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 682E01A11BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:34:24 +1000 (AEST)
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DAB2C1402A8
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:34:23 +1000 (AEST)
Received: by pdbnk13 with SMTP id nk13so130696967pdb.0
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:34:22 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [RFC PATCH 2/2] powerpc: Migrate pseries to host_bridge_ops,
 remove pcibios_set_root_bus_speed
Date: Tue, 14 Apr 2015 14:34:01 +1000
Message-Id: <1428986041-25657-3-git-send-email-dja@axtens.net>
In-Reply-To: <1428986041-25657-1-git-send-email-dja@axtens.net>
References: <1428986041-25657-1-git-send-email-dja@axtens.net>
Cc: Yijing Wang <wangyijing@huawei.com>, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the pseries set_root_bus_speed function into a pseries-specific
pci_host_bridge_ops structure.

Only pseries defines set_root_bus_speed. Now that it will be called
through the pci_host_bridge_ops function pointer, both the ppc_md
definition and the function in pci-common.c are unused. Remove them.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/machdep.h     | 2 --
 arch/powerpc/kernel/pci-common.c       | 8 --------
 arch/powerpc/platforms/pseries/setup.c | 7 +++++--
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index f3fea3e..b6912d7 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -125,8 +125,6 @@ struct machdep_calls {
 	/* Called after scanning the bus, before allocating resources */
 	void		(*pcibios_fixup)(void);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
-	void		(*pcibios_set_root_bus_speed)(struct pci_host_bridge
-				*bridge);
 
 	/* To setup PHBs when using automatic OF platform driver for PCI */
 	int		(*pci_setup_phb)(struct pci_controller *host);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 326d848..d629ab2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -761,12 +761,6 @@ int pci_proc_domain(struct pci_bus *bus)
 	return 1;
 }
 
-void pcibios_set_root_bus_speed(struct pci_host_bridge *bridge)
-{
-	if (ppc_md.pcibios_set_root_bus_speed)
-		return ppc_md.pcibios_set_root_bus_speed(bridge);
-}
-
 static int pci_host_scan_bus(struct pci_host_bridge *host)
 {
 	int mode = PCI_PROBE_NORMAL;
@@ -1635,8 +1629,6 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	/* Populate generic ops with defaults */
 	if (!hose->generic_ops.scan_bus)
 		hose->generic_ops.scan_bus = pci_host_scan_bus;
-	if (!hose->generic_ops.set_root_bus_speed)
-		hose->generic_ops.set_root_bus_speed = pcibios_set_root_bus_speed;
 	
 	/* Create an empty bus for the toplevel */
 	host = pci_scan_host_bridge(hose->parent, hose->global_number,
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5ee66a1..79380ba 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -461,6 +461,10 @@ static long pseries_little_endian_exceptions(void)
 }
 #endif
 
+static struct pci_host_bridge_ops pseries_phb_generic_ops = {
+	.set_root_bus_speed = pseries_set_root_bus_speed,
+};
+
 static void __init find_and_init_phbs(void)
 {
 	struct device_node *node;
@@ -475,6 +479,7 @@ static void __init find_and_init_phbs(void)
 		phb = pcibios_alloc_controller(node);
 		if (!phb)
 			continue;
+		phb->generic_ops = pseries_phb_generic_ops;
 		rtas_setup_phb(phb);
 		pci_process_bridge_OF_ranges(phb, node, 0);
 		isa_bridge_find_early(phb);
@@ -544,8 +549,6 @@ static void __init pSeries_setup_arch(void)
 		ppc_md.enable_pmcs = power4_enable_pmcs;
 	}
 
-	ppc_md.pcibios_set_root_bus_speed = pseries_set_root_bus_speed;
-
 	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
 		long rc;
 
-- 
2.1.4
