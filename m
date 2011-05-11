Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 77F981007F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:42 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <f17e21da1cfa059181f1cbca49876f9d3a620e11.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:29:24 -0500
Subject: [PATCH 15/37] powerpc: remove alloc_maybe_bootmem for zalloc version
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace all remaining callers of alloc_maybe_bootmem with
zalloc_maybe_bootmem.   The callsite in pci_dn is followed with a
memset to clear the memory, and not zeroing at the other callsites
in the celleb fake pci code could lead to following uninitialized
memory as pointers or even freeing said pointers on error paths.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/include/asm/system.h        |    2 --
 arch/powerpc/kernel/pci_dn.c             |    3 +--
 arch/powerpc/lib/alloc.c                 |    8 --------
 arch/powerpc/platforms/cell/celleb_pci.c |    6 +++---
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index 5e474dd..2dc595d 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -219,8 +219,6 @@ extern int mem_init_done;	/* set on boot once kmalloc can be called */
 extern int init_bootmem_done;	/* set once bootmem is available */
 extern phys_addr_t memory_limit;
 extern unsigned long klimit;
-
-extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index d225d99..6baabc1 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -43,10 +43,9 @@ void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 	const u32 *regs;
 	struct pci_dn *pdn;
 
-	pdn = alloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
+	pdn = zalloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
 	if (pdn == NULL)
 		return NULL;
-	memset(pdn, 0, sizeof(*pdn));
 	dn->data = pdn;
 	pdn->node = dn;
 	pdn->phb = phb;
diff --git a/arch/powerpc/lib/alloc.c b/arch/powerpc/lib/alloc.c
index f53e09c..13b676c 100644
--- a/arch/powerpc/lib/alloc.c
+++ b/arch/powerpc/lib/alloc.c
@@ -6,14 +6,6 @@
 
 #include <asm/system.h>
 
-void * __init_refok alloc_maybe_bootmem(size_t size, gfp_t mask)
-{
-	if (mem_init_done)
-		return kmalloc(size, mask);
-	else
-		return alloc_bootmem(size);
-}
-
 void * __init_refok zalloc_maybe_bootmem(size_t size, gfp_t mask)
 {
 	void *p;
diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index 2904b0a..5822141 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -319,7 +319,7 @@ static int __init celleb_setup_fake_pci_device(struct device_node *node,
 
 	size = 256;
 	config = &private->fake_config[devno][fn];
-	*config = alloc_maybe_bootmem(size, GFP_KERNEL);
+	*config = zalloc_maybe_bootmem(size, GFP_KERNEL);
 	if (*config == NULL) {
 		printk(KERN_ERR "PCI: "
 		       "not enough memory for fake configuration space\n");
@@ -330,7 +330,7 @@ static int __init celleb_setup_fake_pci_device(struct device_node *node,
 
 	size = sizeof(struct celleb_pci_resource);
 	res = &private->res[devno][fn];
-	*res = alloc_maybe_bootmem(size, GFP_KERNEL);
+	*res = zalloc_maybe_bootmem(size, GFP_KERNEL);
 	if (*res == NULL) {
 		printk(KERN_ERR
 		       "PCI: not enough memory for resource data space\n");
@@ -431,7 +431,7 @@ static int __init phb_set_bus_ranges(struct device_node *dev,
 static void __init celleb_alloc_private_mem(struct pci_controller *hose)
 {
 	hose->private_data =
-		alloc_maybe_bootmem(sizeof(struct celleb_pci_private),
+		zalloc_maybe_bootmem(sizeof(struct celleb_pci_private),
 			GFP_KERNEL);
 }
 
-- 
1.7.0.4
