Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9354DEFF5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:38:53 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 32/60] microblaze_v4: page.h, segment.h, unaligned.h
Date: Thu, 26 Jun 2008 14:30:01 +0200
Message-Id: <1214483429-32360-33-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-32-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<1214483429-32360-14-git-send-email-monstr@seznam.cz>
	<1214483429-32360-15-git-send-email-monstr@seznam.cz>
	<1214483429-32360-16-git-send-email-monstr@seznam.cz>
	<1214483429-32360-17-git-send-email-monstr@seznam.cz>
	<1214483429-32360-18-git-send-email-monstr@seznam.cz>
	<1214483429-32360-19-git-send-email-monstr@seznam.cz>
	<1214483429-32360-20-git-send-email-monstr@seznam.cz>
	<1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
	<1214483429-32360-30-git-send-email-monstr@seznam.cz>
	<1214483429-32360-31-git-send-email-monstr@seznam.cz>
	<1214483429-32360-32-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 include/asm-microblaze/page.h      |  117 ++++++++++++++++++++++++++++++++++++
 include/asm-microblaze/segment.h   |   39 ++++++++++++
 include/asm-microblaze/unaligned.h |   19 ++++++
 3 files changed, 175 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/page.h
 create mode 100644 include/asm-microblaze/segment.h
 create mode 100644 include/asm-microblaze/unaligned.h

diff --git a/include/asm-microblaze/page.h b/include/asm-microblaze/page.h
new file mode 100644
index 0000000..f7ed024
--- /dev/null
+++ b/include/asm-microblaze/page.h
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_PAGE_H
+#define _ASM_MICROBLAZE_PAGE_H
+
+#include <linux/autoconf.h>
+#include <linux/pfn.h>
+
+/* PAGE_SHIFT determines the page size */
+
+#define PAGE_SHIFT	(12)
+#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#define PAGE_MASK	(~(PAGE_SIZE-1))
+
+#ifdef __KERNEL__
+
+#include <asm/setup.h>
+
+#ifndef __ASSEMBLY__
+
+#define get_user_page(vaddr)			__get_free_page(GFP_KERNEL)
+#define free_user_page(page, addr)		free_page(addr)
+
+#define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
+#define copy_page(to, from)			memcpy((to), (from), PAGE_SIZE)
+
+#define clear_user_page(pgaddr, vaddr, page)	memset((pgaddr), 0, PAGE_SIZE)
+#define copy_user_page(vto, vfrom, vaddr, topg) \
+			memcpy((vto), (vfrom), PAGE_SIZE)
+
+/*
+ * These are used to make use of C type-checking..
+ */
+typedef struct { unsigned long	pte; }		pte_t;
+typedef struct { unsigned long	ste[64]; }	pmd_t;
+typedef struct { pmd_t		pue[1]; }	pud_t;
+typedef struct { pud_t		pge[1]; }	pgd_t;
+typedef struct { unsigned long	pgprot; }	pgprot_t;
+typedef struct page *pgtable_t;
+
+#define pte_val(x)	((x).pte)
+#define pmd_val(x)	((x).ste[0])
+#define pud_val(x)	((x).pue[0])
+#define pgd_val(x)	((x).pge[0])
+#define pgprot_val(x)	((x).pgprot)
+
+#define __pte(x)	((pte_t) { (x) })
+#define __pmd(x)	((pmd_t) { (x) })
+#define __pgd(x)	((pgd_t) { (x) })
+#define __pgprot(x)	((pgprot_t) { (x) })
+
+/* align addr on a size boundary - adjust address up/down if needed */
+#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
+#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
+
+/* align addr on a size boundary - adjust address up if needed */
+#define _ALIGN(addr, size)	_ALIGN_UP(addr, size)
+
+/* to align the pointer to the (next) page boundary */
+#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)
+
+extern unsigned int __page_offset;
+#define PAGE_OFFSET __page_offset
+
+/**
+ * Conversions for virtual address, physical address, pfn, and struct
+ * page are defined in the following files.
+ *
+ * virt -+
+ *	 | asm-microblaze/page.h
+ * phys -+
+ *	 | linux/pfn.h
+ *  pfn -+
+ *	 | asm-generic/memory_model.h
+ * page -+
+ *
+ */
+
+extern unsigned long max_low_pfn;
+extern unsigned long min_low_pfn;
+extern unsigned long max_pfn;
+
+#define __pa(vaddr)		((unsigned long) (vaddr))
+#define __va(paddr)		((void *) (paddr))
+
+#define phys_to_pfn(phys)	(PFN_DOWN(phys))
+#define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
+
+#define virt_to_pfn(vaddr)	(phys_to_pfn((__pa(vaddr))))
+#define pfn_to_virt(pfn)	__va(pfn_to_phys((pfn)))
+
+#define virt_to_page(vaddr)	(pfn_to_page(virt_to_pfn(vaddr)))
+#define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
+
+#define page_to_phys(page)	(pfn_to_phys(page_to_pfn(page)))
+#define page_to_bus(page)	(page_to_phys(page))
+#define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))
+
+#define pfn_valid(pfn)		((pfn) >= min_low_pfn && (pfn) < max_mapnr)
+#define	virt_addr_valid(vaddr)	(pfn_valid(virt_to_pfn(vaddr)))
+
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#include <asm-generic/memory_model.h>
+#include <asm-generic/page.h>
+
+#endif /* _ASM_MICROBLAZE_PAGE_H */
diff --git a/include/asm-microblaze/segment.h b/include/asm-microblaze/segment.h
new file mode 100644
index 0000000..670a099
--- /dev/null
+++ b/include/asm-microblaze/segment.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_SEGMENT_H
+#define _ASM_MICROBLAZE_SEGMENT_H
+
+#ifndef __ASSEMBLY__
+
+typedef struct {
+	unsigned long seg;
+} mm_segment_t;
+
+/*
+ * The fs value determines whether argument validity checking should be
+ * performed or not. If get_fs() == USER_DS, checking is performed, with
+ * get_fs() == KERNEL_DS, checking is bypassed.
+ *
+ * For historical reasons, these macros are grossly misnamed.
+ *
+ * For non-MMU arch like Microblaze, KERNEL_DS and USER_DS is equal.
+ */
+#define KERNEL_DS	((mm_segment_t){0})
+#define USER_DS		KERNEL_DS
+
+#define get_ds()	(KERNEL_DS)
+#define get_fs()	(current_thread_info()->addr_limit)
+#define set_fs(x) \
+		do { current_thread_info()->addr_limit = (x); } while (0)
+
+#define segment_eq(a, b)		((a).seg == (b).seg)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_MICROBLAZE_SEGMENT_H */
diff --git a/include/asm-microblaze/unaligned.h b/include/asm-microblaze/unaligned.h
new file mode 100644
index 0000000..ad8bd76
--- /dev/null
+++ b/include/asm-microblaze/unaligned.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2008 Michal Simek <monstr@monstr.eu>
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_UNALIGNED_H
+#define _ASM_MICROBLAZE_UNALIGNED_H
+
+#include <linux/unaligned/access_ok.h>
+#include <linux/unaligned/generic.h>
+
+#define get_unaligned	__get_unaligned_be
+#define put_unaligned	__put_unaligned_be
+
+#endif /* _ASM_MICROBLAZE_UNALIGNED_H */
-- 
1.5.4.GIT
