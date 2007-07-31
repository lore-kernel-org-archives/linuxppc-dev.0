Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AEA24DDDE4
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 17:14:10 +1000 (EST)
Date: Tue, 31 Jul 2007 17:14:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix section mismatch references to alloc_bootmem
Message-Id: <20070731171407.c1028de4.sfr@canb.auug.org.au>
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

WARNING: vmlinux.o(.text+0x2a9c4): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.update_dn_pci_info' and '.pci_dn_reconfig_notifier')
WARNING: vmlinux.o(.text+0x36430): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.mpic_msi_init_allocator' and '.find_ht_magic_addr')
WARNING: vmlinux.o(.text+0x5e804): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5e8e8): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5e968): Section mismatch: reference to .init.text:.__alloc_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5ec50): Section mismatch: reference to .init.text:.free_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5ec70): Section mismatch: reference to .init.text:.free_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5eb88): Section mismatch: reference to .init.text:.free_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')
WARNING: vmlinux.o(.text+0x5eba8): Section mismatch: reference to .init.text:.free_bootmem (between '.celleb_setup_phb' and '.celleb_fake_pci_write_config')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_dn.c        |    7 +-----
 arch/powerpc/lib/Makefile           |    2 +-
 arch/powerpc/lib/alloc.c            |   22 ++++++++++++++++++
 arch/powerpc/platforms/celleb/pci.c |   41 +++++++---------------------------
 arch/powerpc/sysdev/mpic_msi.c      |    6 +----
 include/asm-powerpc/system.h        |    3 ++
 6 files changed, 37 insertions(+), 44 deletions(-)
 create mode 100644 arch/powerpc/lib/alloc.c

Built for ppc64_defconfig and allmodconfig.  ppc64_defconfig build booted
on iSeries 270.

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
index 0000000..4a6bc23
--- /dev/null
+++ b/arch/powerpc/lib/alloc.c
@@ -0,0 +1,22 @@
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
+
+void __init_refok free_maybe_bootmem(void *ptr, size_t size)
+{
+	if (mem_init_done)
+		kfree(ptr);
+	else
+		free_bootmem((unsigned long)ptr, size);
+}
diff --git a/arch/powerpc/platforms/celleb/pci.c b/arch/powerpc/platforms/celleb/pci.c
index e9ac19c..72ce335 100644
--- a/arch/powerpc/platforms/celleb/pci.c
+++ b/arch/powerpc/platforms/celleb/pci.c
@@ -29,7 +29,6 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/bootmem.h>
 #include <linux/pci_regs.h>
 
 #include <asm/io.h>
@@ -327,10 +326,7 @@ static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
 
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
@@ -341,10 +337,7 @@ static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
 
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
@@ -398,23 +391,10 @@ static int __devinit celleb_setup_fake_pci_device(struct device_node *node,
 	return 0;
 
 error:
-	if (mem_init_done) {
-		if (config && *config)
-			kfree(*config);
-		if (res && *res)
-			kfree(*res);
-
-	} else {
-		if (config && *config) {
-			size = 256;
-			free_bootmem((unsigned long)(*config), size);
-		}
-		if (res && *res) {
-			size = sizeof(struct celleb_pci_resource);
-			free_bootmem((unsigned long)(*res), size);
-		}
-	}
-
+	if (config && *config)
+		free_maybe_bootmem(*config, 256);
+	if (res && *res)
+		free_maybe_bootmem(*res, sizeof(struct celleb_pci_resource));
 	return 1;
 }
 
@@ -436,12 +416,9 @@ static int __devinit phb_set_bus_ranges(struct device_node *dev,
 
 static void __devinit celleb_alloc_private_mem(struct pci_controller *hose)
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
 
 int __devinit celleb_setup_phb(struct pci_controller *phb)
diff --git a/arch/powerpc/sysdev/mpic_msi.c b/arch/powerpc/sysdev/mpic_msi.c
index b076793..53fa9f5 100644
--- a/arch/powerpc/sysdev/mpic_msi.c
+++ b/arch/powerpc/sysdev/mpic_msi.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/bootmem.h>
 #include <linux/bitmap.h>
 #include <linux/msi.h>
 #include <asm/mpic.h>
@@ -151,10 +150,7 @@ int mpic_msi_init_allocator(struct mpic *mpic)
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
index 41520b7..047b740 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -189,6 +189,9 @@ extern int mem_init_done;	/* set on boot once kmalloc can be called */
 extern unsigned long memory_limit;
 extern unsigned long klimit;
 
+extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
+extern void free_maybe_bootmem(void *ptr, size_t size);
+
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 /*
-- 
1.5.2.4
