Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4BD3BDDE26
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 17:57:01 +1100 (EST)
Date: Thu, 3 Apr 2008 01:52:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
Message-ID: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wanted to get any feedback on this initial port of the fixmap support over
from x86.  There are a few TODOs:

* change HIGHMEM support to use fixmap
* fixup up VMALLOC config to respect fixmap

(after initial powerpc patch is in tree/accepted):
* rework a few bits of fixmap.h into an asm-generic/fixmap.h

The reason for introducing fixmap into ppc32 is it provides us with a
clean way of getting fixed compile time virtual addresses for things.

Beyond the HIGHMEM usage.  Ben and I have discussed cleaning up the PCIe
44x config code (and 83xx PCIe cfg) to use it.  Also, Dale's kexec/kdump
support on ppc32 can take advantage of it.  I'm also told this is useful
for hypervisor interactions.

One question for the guys looking at hypervisor.  The x86 code also has a
function called reserve_top_address (see arch/x86/mm/pgtable_32.c).  Is
this functionality something useful on ppc?  If so for what?

- k

---
 arch/powerpc/mm/pgtable_32.c |   18 ++++++
 include/asm-powerpc/fixmap.h |  123 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-powerpc/fixmap.h

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 64c44bc..fa0e48e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -29,6 +29,7 @@

 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
+#include <asm/fixmap.h>
 #include <asm/io.h>

 #include "mmu_decl.h"
@@ -387,3 +388,20 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
 	change_page_attr(page, numpages, enable ? PAGE_KERNEL : __pgprot(0));
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
+
+static int fixmaps;
+unsigned long __FIXADDR_TOP = 0xfffff000;
+EXPORT_SYMBOL(__FIXADDR_TOP);
+
+void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
+{
+	unsigned long address = __fix_to_virt(idx);
+
+	if (idx >= __end_of_fixed_addresses) {
+		BUG();
+		return;
+	}
+
+	map_page(address, phys, flags);
+	fixmaps++;
+}
diff --git a/include/asm-powerpc/fixmap.h b/include/asm-powerpc/fixmap.h
new file mode 100644
index 0000000..7b570e5
--- /dev/null
+++ b/include/asm-powerpc/fixmap.h
@@ -0,0 +1,123 @@
+/*
+ * fixmap.h: compile-time virtual memory allocation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1998 Ingo Molnar
+ *
+ * Support of BIGMEM added by Gerhard Wichert, Siemens AG, July 1999
+ *
+ * Copyright 2008 Freescale Semiconductor Inc.
+ *   Port to powerpc added by Kumar Gala
+ */
+
+#ifndef _ASM_FIXMAP_H
+#define _ASM_FIXMAP_H
+
+
+/* used by vmalloc.c, vsyscall.lds.S.
+ *
+ * Leave one empty page between vmalloc'ed areas and
+ * the start of the fixmap.
+ */
+extern unsigned long __FIXADDR_TOP;
+#define FIXADDR_USER_START     __fix_to_virt(FIX_VDSO)
+#define FIXADDR_USER_END       __fix_to_virt(FIX_VDSO - 1)
+
+#ifndef __ASSEMBLY__
+#include <linux/kernel.h>
+#include <asm/page.h>
+#ifdef CONFIG_HIGHMEM
+#include <linux/threads.h>
+#include <asm/kmap_types.h>
+#endif
+
+/*
+ * Here we define all the compile-time 'special' virtual
+ * addresses. The point is to have a constant address at
+ * compile time, but to set the physical address only
+ * in the boot process. We allocate these special addresses
+ * from the end of virtual memory (0xfffff000) backwards.
+ * Also this lets us do fail-safe vmalloc(), we
+ * can guarantee that these special addresses and
+ * vmalloc()-ed addresses never overlap.
+ *
+ * these 'compile-time allocated' memory buffers are
+ * fixed-size 4k pages. (or larger if used with an increment
+ * highger than 1) use fixmap_set(idx,phys) to associate
+ * physical memory with fixmap indices.
+ *
+ * TLB entries of such buffers will not be flushed across
+ * task switches.
+ */
+enum fixed_addresses {
+	FIX_HOLE,
+	FIX_VDSO,
+#ifdef CONFIG_HIGHMEM
+	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
+	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+#endif
+#ifdef CONFIG_PCI_MMCONFIG
+	FIX_PCIE_MCFG,
+#endif
+	__end_of_fixed_addresses
+};
+
+extern void __set_fixmap (enum fixed_addresses idx,
+					phys_addr_t phys, pgprot_t flags);
+
+#define set_fixmap(idx, phys) \
+		__set_fixmap(idx, phys, PAGE_KERNEL)
+/*
+ * Some hardware wants to get fixmapped without caching.
+ */
+#define set_fixmap_nocache(idx, phys) \
+		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
+
+#define clear_fixmap(idx) \
+		__set_fixmap(idx, 0, __pgprot(0))
+
+#define FIXADDR_TOP	((unsigned long)__FIXADDR_TOP)
+
+#define __FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define __FIXADDR_BOOT_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
+#define FIXADDR_BOOT_START	(FIXADDR_TOP - __FIXADDR_BOOT_SIZE)
+
+#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+
+extern void __this_fixmap_does_not_exist(void);
+
+/*
+ * 'index to address' translation. If anyone tries to use the idx
+ * directly without tranlation, we catch the bug with a NULL-deference
+ * kernel oops. Illegal ranges of incoming indices are caught too.
+ */
+static __always_inline unsigned long fix_to_virt(const unsigned int idx)
+{
+	/*
+	 * this branch gets completely eliminated after inlining,
+	 * except when someone tries to use fixaddr indices in an
+	 * illegal way. (such as mixing up address types or using
+	 * out-of-range indices).
+	 *
+	 * If it doesn't get removed, the linker will complain
+	 * loudly with a reasonably clear error message..
+	 */
+	if (idx >= __end_of_fixed_addresses)
+		__this_fixmap_does_not_exist();
+
+        return __fix_to_virt(idx);
+}
+
+static inline unsigned long virt_to_fix(const unsigned long vaddr)
+{
+	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+	return __virt_to_fix(vaddr);
+}
+
+#endif /* !__ASSEMBLY__ */
+#endif
-- 
1.5.4.1
