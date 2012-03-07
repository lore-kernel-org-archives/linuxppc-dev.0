Return-Path: <bhelgaas@google.com>
Received: from mail-gy0-f201.google.com (mail-gy0-f201.google.com
 [209.85.160.201])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3A5BB6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 09:33:03 +1100 (EST)
Received: by ghbg15 with SMTP id g15so836616ghb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2012 14:33:00 -0800 (PST)
Subject: [PATCH v3 11/34] powerpc/PCI: replace pci_probe_only with pci_flags
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 07 Mar 2012 15:33:00 -0700
Message-ID: <20120307223300.25669.54100.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already use pci_flags, so this just sets pci_flags directly and removes
the intermediate step of figuring out pci_probe_only, then using it to set
pci_flags.

The PCI core provides a pci_flags definition (currently __weak), so drop
the powerpc definitions in favor of that.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/include/asm/ppc-pci.h        |    2 --
 arch/powerpc/kernel/pci-common.c          |    3 ---
 arch/powerpc/kernel/pci_64.c              |    5 -----
 arch/powerpc/kernel/rtas_pci.c            |   10 +++++++---
 arch/powerpc/platforms/iseries/pci.c      |    2 +-
 arch/powerpc/platforms/maple/pci.c        |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |    5 ++---
 arch/powerpc/platforms/powernv/pci.c      |    2 +-
 arch/powerpc/platforms/pseries/setup.c    |    4 ++--
 9 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 43268f1..f4f7ad8 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -45,8 +45,6 @@ extern void init_pci_config_tokens (void);
 extern unsigned long get_phb_buid (struct device_node *);
 extern int rtas_setup_phb(struct pci_controller *phb);
 
-extern unsigned long pci_probe_only;
-
 /* ---- EEH internal-use-only related routines ---- */
 #ifdef CONFIG_EEH
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index cce98d7..6d03da4 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -50,9 +50,6 @@ static int global_phb_number;		/* Global phb counter */
 /* ISA Memory physical address */
 resource_size_t isa_mem_base;
 
-/* Default PCI flags is 0 on ppc32, modified at boot on ppc64 */
-unsigned int pci_flags = 0;
-
 
 static struct dma_map_ops *pci_dma_ops = &dma_direct_ops;
 
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index f627eb7..75417fd 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -33,8 +33,6 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 
-unsigned long pci_probe_only = 0;
-
 /* pci_io_base -- the base address from which io bars are offsets.
  * This is the lowest I/O base address (so bar values are always positive),
  * and it *must* be the start of ISA space if an ISA bus exists because
@@ -55,9 +53,6 @@ static int __init pcibios_init(void)
 	 */
 	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
 
-	if (pci_probe_only)
-		pci_add_flags(PCI_PROBE_ONLY);
-
 	/* On ppc64, we always enable PCI domains and we keep domain 0
 	 * backward compatible in /proc for video cards
 	 */
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 6cd8f01..140735c 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -276,7 +276,7 @@ void __init find_and_init_phbs(void)
 	pci_devs_phb_init();
 
 	/*
-	 * pci_probe_only and pci_assign_all_buses can be set via properties
+	 * PCI_PROBE_ONLY and PCI_REASSIGN_ALL_BUS can be set via properties
 	 * in chosen.
 	 */
 	if (of_chosen) {
@@ -284,8 +284,12 @@ void __init find_and_init_phbs(void)
 
 		prop = of_get_property(of_chosen,
 				"linux,pci-probe-only", NULL);
-		if (prop)
-			pci_probe_only = *prop;
+		if (prop) {
+			if (*prop)
+				pci_add_flags(PCI_PROBE_ONLY);
+			else
+				pci_clear_flags(PCI_PROBE_ONLY);
+		}
 
 #ifdef CONFIG_PPC32 /* Will be made generic soon */
 		prop = of_get_property(of_chosen,
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index c754128..171b2f3 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -868,7 +868,7 @@ void __init iSeries_pcibios_init(void)
 	/* Install IO hooks */
 	ppc_pci_io = iseries_pci_io;
 
-	pci_probe_only = 1;
+	pci_add_flags(PCI_PROBE_ONLY);
 
 	/* iSeries has no IO space in the common sense, it needs to set
 	 * the IO base to 0
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 401e3f3..465ee8f 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -620,7 +620,7 @@ void __init maple_pci_init(void)
 	}
 
 	/* Tell pci.c to not change any resource allocations.  */
-	pci_probe_only = 1;
+	pci_add_flags(PCI_PROBE_ONLY);
 }
 
 int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5e155df..fbdd74d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1299,15 +1299,14 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	/* Setup MSI support */
 	pnv_pci_init_ioda_msis(phb);
 
-	/* We set both probe_only and PCI_REASSIGN_ALL_RSRC. This is an
+	/* We set both PCI_PROBE_ONLY and PCI_REASSIGN_ALL_RSRC. This is an
 	 * odd combination which essentially means that we skip all resource
 	 * fixups and assignments in the generic code, and do it all
 	 * ourselves here
 	 */
-	pci_probe_only = 1;
 	ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
-	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
+	pci_add_flags(PCI_PROBE_ONLY | PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
 	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a053f4f..69dca5a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -555,7 +555,7 @@ void __init pnv_pci_init(void)
 {
 	struct device_node *np;
 
-	pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
+	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
 	/* OPAL absent, try POPAL first then RTAS detection of PHBs */
 	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 386e265..fc2a6f6 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -380,8 +380,8 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
-	/* By default, only probe PCI (can be overriden by rtas_pci */
-	pci_probe_only = 1;
+	/* By default, only probe PCI (can be overriden by rtas_pci) */
+	pci_add_flags(PCI_PROBE_ONLY);
 
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
