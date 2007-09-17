Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B2ACFDDD0A
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 14:08:13 +1000 (EST)
Date: Mon, 17 Sep 2007 14:08:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix section mismatch in pci code
Message-Id: <20070917140806.b12ae5e9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Create a helper function (alloc_maybe_bootmem) that is marked __init_refok
to limit the chances of mistakenly refferring to other __init routines.

WARNING: vmlinux.o(.text+0x2a9c4): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.update_dn_pci_info' and '.pci_dn_reconfig_notifier')
WARNING: vmlinux.o(.text+0x36430): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.mpic_msi_init_allocator' and '.find_ht_magic_addr')
WARNING: vmlinux.o(.text+0x5e804): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5e8e8): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5e968): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_dn.c        |    7 +------
 arch/powerpc/lib/Makefile           |    2 +-
 arch/powerpc/lib/alloc.c            |   14 ++++++++++++++
 arch/powerpc/platforms/celleb/pci.c |   19 +++++--------------
 arch/powerpc/sysdev/mpic_msi.c      |    6 +-----
 include/asm-powerpc/system.h        |    2 ++
 6 files changed, 24 insertions(+), 26 deletions(-)
 create mode 100644 arch/powerpc/lib/alloc.c

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index d7d36df..b483903 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -23,8 +23,6 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -45,10 +43,7 @@ static void * __devinit update_dn_pci_info(struct device_node *dn, void *data)
 	const u32 *regs;
 	struct pci_dn *pdn;
 
-	if (mem_init_done)
-		pdn = kmalloc(sizeof(*pdn), GFP_KERNEL);
-	else
-		pdn = alloc_bootmem(sizeof(*pdn));
+	pdn = alloc_maybe_bootmem(sizeof(*pdn), GFP_KERNEL);
 	if (pdn == NULL)
 		return NULL;
 	memset(pdn, 0, sizeof(*pdn));
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 0a486d4..23bbb1e 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -7,7 +7,7 @@ EXTRA_CFLAGS		+= -mno-minimal-toc
 endif
 
 ifeq ($(CONFIG_PPC_MERGE),y)
-obj-y			:= string.o
+obj-y			:= string.o alloc.o
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o checksum_32.o
 endif
 
diff --git a/arch/powerpc/lib/alloc.c b/arch/powerpc/lib/alloc.c
new file mode 100644
index 0000000..e58c805
--- /dev/null
+++ b/arch/powerpc/lib/alloc.c
@@ -0,0 +1,14 @@
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/bootmem.h>
+
+#include <asm/system.h>
+
+void * __init_refok alloc_maybe_bootmem(size_t size, gfp_t mask)
+{
+	if (mem_init_done)
+		return kmalloc(size, mask);
+	else
+		return alloc_bootmem(size);
+}
diff --git a/arch/powerpc/platforms/celleb/pci.c b/arch/powerpc/platforms/celleb/pci.c
index 11336b4..1348b23 100644
--- a/arch/powerpc/platforms/celleb/pci.c
+++ b/arch/powerpc/platforms/celleb/pci.c
@@ -327,10 +327,7 @@ static int __init celleb_setup_fake_pci_device(struct device_node *node,
 
 	size = 256;
 	config = &private->fake_config[devno][fn];
-	if (mem_init_done)
-		*config = kzalloc(size, GFP_KERNEL);
-	else
-		*config = alloc_bootmem(size);
+	*config = alloc_maybe_bootmem(size, GFP_KERNEL);
 	if (*config == NULL) {
 		printk(KERN_ERR "PCI: "
 		       "not enough memory for fake configuration space\n");
@@ -341,10 +338,7 @@ static int __init celleb_setup_fake_pci_device(struct device_node *node,
 
 	size = sizeof(struct celleb_pci_resource);
 	res = &private->res[devno][fn];
-	if (mem_init_done)
-		*res = kzalloc(size, GFP_KERNEL);
-	else
-		*res = alloc_bootmem(size);
+	*res = alloc_maybe_bootmem(size, GFP_KERNEL);
 	if (*res == NULL) {
 		printk(KERN_ERR
 		       "PCI: not enough memory for resource data space\n");
@@ -436,12 +430,9 @@ static int __init phb_set_bus_ranges(struct device_node *dev,
 
 static void __init celleb_alloc_private_mem(struct pci_controller *hose)
 {
-	if (mem_init_done)
-		hose->private_data =
-			kzalloc(sizeof(struct celleb_pci_private), GFP_KERNEL);
-	else
-		hose->private_data =
-			alloc_bootmem(sizeof(struct celleb_pci_private));
+	hose->private_data =
+		alloc_maybe_bootmem(sizeof(struct celleb_pci_private),
+			GFP_KERNEL);
 }
 
 int __init celleb_setup_phb(struct pci_controller *phb)
diff --git a/arch/powerpc/sysdev/mpic_msi.c b/arch/powerpc/sysdev/mpic_msi.c
index 9ca4d8f..d272a52 100644
--- a/arch/powerpc/sysdev/mpic_msi.c
+++ b/arch/powerpc/sysdev/mpic_msi.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/bootmem.h>
 #include <linux/bitmap.h>
 #include <linux/msi.h>
 #include <asm/mpic.h>
@@ -152,10 +151,7 @@ int mpic_msi_init_allocator(struct mpic *mpic)
 	size = BITS_TO_LONGS(mpic->irq_count) * sizeof(long);
 	pr_debug("mpic: allocator bitmap size is 0x%x bytes\n", size);
 
-	if (mem_init_done)
-		mpic->hwirq_bitmap = kmalloc(size, GFP_KERNEL);
-	else
-		mpic->hwirq_bitmap = alloc_bootmem(size);
+	mpic->hwirq_bitmap = alloc_maybe_bootmem(size, GFP_KERNEL);
 
 	if (!mpic->hwirq_bitmap) {
 		pr_debug("mpic: ENOMEM allocating allocator bitmap!\n");
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index 41520b7..f7879fc 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -189,6 +189,8 @@ extern int mem_init_done;	/* set on boot once kmalloc can be called */
 extern unsigned long memory_limit;
 extern unsigned long klimit;
 
+extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
+
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 /*
-- 
1.5.3.1
