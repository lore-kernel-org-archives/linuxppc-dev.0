Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A64DFDDF69
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:01 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 7EB4E368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:08:01 +1100 (EST)
Date: Fri, 7 Dec 2007 02:00:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 15/19] [POWERPC] iSeries: call iSeries_pcibios_init from
	setup_arch
Message-Id: <20071207020045.429b86ed.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c           |    3 ---
 arch/powerpc/platforms/iseries/pci.h   |    4 +++-
 arch/powerpc/platforms/iseries/setup.c |    2 ++
 include/asm-powerpc/ppc-pci.h          |    3 ---
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 13a3615..b58f091 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -519,9 +519,6 @@ static int __init pcibios_init(void)
 	 */
 	ppc_md.phys_mem_access_prot = pci_phys_mem_access_prot;
 
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		iSeries_pcibios_init();
-
 	printk(KERN_DEBUG "PCI: Probing PCI hardware\n");
 
 	/* Scan all of the recorded PCI controllers.  */
diff --git a/arch/powerpc/platforms/iseries/pci.h b/arch/powerpc/platforms/iseries/pci.h
index 3af9cf1..b142873 100644
--- a/arch/powerpc/platforms/iseries/pci.h
+++ b/arch/powerpc/platforms/iseries/pci.h
@@ -50,9 +50,11 @@ struct pci_dev;				/* For Forward Reference */
 extern void	iSeries_Device_Information(struct pci_dev *PciDev, int count,
 			u16 bus, HvSubBusNumber subbus);
 #ifdef CONFIG_PCI
+extern void	iSeries_pcibios_init(void);
 extern void	iSeries_pci_final_fixup(void);
 #else
-static void	iSeries_pci_final_fixup(void) { }
+static inline void	iSeries_pcibios_init(void) { }
+static inline void	iSeries_pci_final_fixup(void) { }
 #endif
 
 #endif /* _PLATFORMS_ISERIES_PCI_H */
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 2175a71..5616219 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -495,6 +495,8 @@ static void __init iSeries_setup_arch(void)
 			itVpdAreas.xSlicMaxLogicalProcs);
 	printk("Max physical processors = %d\n",
 			itVpdAreas.xSlicMaxPhysicalProcs);
+
+	iSeries_pcibios_init();
 }
 
 static void iSeries_show_cpuinfo(struct seq_file *m)
diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
index fda5e3d..854ab71 100644
--- a/include/asm-powerpc/ppc-pci.h
+++ b/include/asm-powerpc/ppc-pci.h
@@ -46,9 +46,6 @@ extern void init_pci_config_tokens (void);
 extern unsigned long get_phb_buid (struct device_node *);
 extern int rtas_setup_phb(struct pci_controller *phb);
 
-/* From iSeries PCI */
-extern void iSeries_pcibios_init(void);
-
 extern unsigned long pci_probe_only;
 
 /* ---- EEH internal-use-only related routines ---- */
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
