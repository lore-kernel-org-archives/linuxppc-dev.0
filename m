Return-Path: <dja@axtens.net>
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com
 [IPv6:2607:f8b0:400e:c03::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 169D21A0736
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:01:30 +1100 (AEDT)
Received: by patj18 with SMTP id j18so8078710pat.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:01:28 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/19] powerpc: pcibios_enable_device_hook: return bool
 rather than int
Date: Tue, 31 Mar 2015 16:00:41 +1100
Message-Id: <1427778057-9505-4-git-send-email-dja@axtens.net>
In-Reply-To: <1427778057-9505-1-git-send-email-dja@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pcibios_enable_device_hook returned an int. Every implementation
returned either -EINVAL or 0. The return value wasn't propagated by
the caller: any non-zero return value caused pcibios_enable_device
to return -EINVAL itself. Therefore, make the hook return a bool.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/machdep.h        | 4 ++--
 arch/powerpc/kernel/pci-common.c          | 2 +-
 arch/powerpc/platforms/powermac/pci.c     | 8 ++++----
 arch/powerpc/platforms/powermac/pmac.h    | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index c8175a3..9d4a067 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -237,9 +237,9 @@ struct machdep_calls {
 	/* Called for each PCI bus in the system when it's probed */
 	void (*pcibios_fixup_bus)(struct pci_bus *);
 
-	/* Called when pci_enable_device() is called. Returns 0 to
+	/* Called when pci_enable_device() is called. Returns true to
 	 * allow assignment/enabling of the device. */
-	int  (*pcibios_enable_device_hook)(struct pci_dev *);
+	bool (*pcibios_enable_device_hook)(struct pci_dev *);
 
 	/* Called after scan and before resource survey */
 	void (*pcibios_fixup_phb)(struct pci_controller *hose);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a525c9..3d07d81 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1451,7 +1451,7 @@ EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	if (ppc_md.pcibios_enable_device_hook)
-		if (ppc_md.pcibios_enable_device_hook(dev))
+		if (!ppc_md.pcibios_enable_device_hook(dev))
 			return -EINVAL;
 
 	return pci_enable_resources(dev, mask);
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index a792f45..9c89fd2 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -942,7 +942,7 @@ void __init pmac_pci_init(void)
 }
 
 #ifdef CONFIG_PPC32
-int pmac_pci_enable_device_hook(struct pci_dev *dev)
+bool pmac_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct device_node* node;
 	int updatecfg = 0;
@@ -958,11 +958,11 @@ int pmac_pci_enable_device_hook(struct pci_dev *dev)
 	    && !node) {
 		printk(KERN_INFO "Apple USB OHCI %s disabled by firmware\n",
 		       pci_name(dev));
-		return -EINVAL;
+		return false;
 	}
 
 	if (!node)
-		return 0;
+		return true;
 
 	uninorth_child = node->parent &&
 		of_device_is_compatible(node->parent, "uni-north");
@@ -1003,7 +1003,7 @@ int pmac_pci_enable_device_hook(struct pci_dev *dev)
 				      L1_CACHE_BYTES >> 2);
 	}
 
-	return 0;
+	return true;
 }
 
 void pmac_pci_fixup_ohci(struct pci_dev *dev)
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 46d2193..b8d5721 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -25,7 +25,7 @@ extern void pmac_pci_init(void);
 extern void pmac_nvram_update(void);
 extern unsigned char pmac_nvram_read_byte(int addr);
 extern void pmac_nvram_write_byte(int addr, unsigned char val);
-extern int pmac_pci_enable_device_hook(struct pci_dev *dev);
+extern bool pmac_pci_enable_device_hook(struct pci_dev *dev);
 extern void pmac_pcibios_after_init(void);
 extern int of_show_percpuinfo(struct seq_file *m, int i);
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6c9ff2b..c18e191 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1910,7 +1910,7 @@ static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
-static int pnv_pci_enable_device_hook(struct pci_dev *dev)
+static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -1922,13 +1922,13 @@ static int pnv_pci_enable_device_hook(struct pci_dev *dev)
 	 * PEs isn't ready.
 	 */
 	if (!phb->initialized)
-		return 0;
+		return true;
 
 	pdn = pci_get_pdn(dev);
 	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
-		return -EINVAL;
+		return false;
 
-	return 0;
+	return true;
 }
 
 static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
-- 
2.1.4
