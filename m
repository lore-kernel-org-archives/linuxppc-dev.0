Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DD8BDEE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 23:41:12 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/60] microblaze_v4: cache support
Date: Thu, 26 Jun 2008 14:29:40 +0200
Message-Id: <1214483429-32360-12-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-11-git-send-email-monstr@seznam.cz>
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
 arch/microblaze/kernel/cpu/cache.c  |  255 +++++++++++++++++++++++++++++++++++
 include/asm-microblaze/cache.h      |   44 ++++++
 include/asm-microblaze/cacheflush.h |   75 ++++++++++
 3 files changed, 374 insertions(+), 0 deletions(-)
 create mode 100644 arch/microblaze/kernel/cpu/cache.c
 create mode 100644 include/asm-microblaze/cache.h
 create mode 100644 include/asm-microblaze/cacheflush.h

diff --git a/arch/microblaze/kernel/cpu/cache.c b/arch/microblaze/kernel/cpu/cache.c
new file mode 100644
index 0000000..9dcf3e9
--- /dev/null
+++ b/arch/microblaze/kernel/cpu/cache.c
@@ -0,0 +1,255 @@
+/*
+ * Cache control for MicroBlaze cache memories
+ *
+ * Copyright (C) 2007 Michal Simek <monstr@monstr.eu>
+ * Copyright (C) 2007 PetaLogix
+ * Copyright (C) 2007 John Williams <john.williams@petalogix.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ */
+
+#include <asm/cacheflush.h>
+#include <asm/cache.h>
+#include <asm/cpuinfo.h>
+
+/* Exported functions */
+
+void _enable_icache(void)
+{
+	if (cpuinfo.use_icache) {
+#if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
+		__asm__ __volatile__ ("					\
+				msrset	r0, %0;				\
+				nop; "					\
+				:					\
+				: "i" (MSR_ICE)				\
+				: "memory");
+#else
+		__asm__ __volatile__ ("					\
+				mfs	r12, rmsr;			\
+				ori	r12, r12, %0;			\
+				mts	rmsr, r12;			\
+				nop; "					\
+				:					\
+				: "i" (MSR_ICE)				\
+				: "memory", "r12");
+#endif
+	}
+}
+
+void _disable_icache(void)
+{
+	if (cpuinfo.use_icache) {
+#if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
+		__asm__ __volatile__ ("					\
+				msrclr r0, %0;				\
+				nop; "					\
+				:					\
+				: "i" (MSR_ICE)				\
+				: "memory");
+#else
+		__asm__ __volatile__ ("					\
+				mfs	r12, rmsr;			\
+				andi	r12, r12, ~%0;			\
+				mts	rmsr, r12;			\
+				nop; "					\
+				:					\
+				: "i" (MSR_ICE)				\
+				: "memory", "r12");
+#endif
+	}
+}
+
+void _invalidate_icache(unsigned int addr)
+{
+	if (cpuinfo.use_icache) {
+		__asm__ __volatile__ ("					\
+				wic	%0, r0"				\
+				:					\
+				: "r" (addr));
+	}
+}
+
+void _enable_dcache(void)
+{
+	if (cpuinfo.use_dcache) {
+#if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
+		__asm__ __volatile__ ("					\
+				msrset	r0, %0;				\
+				nop; "					\
+				:					\
+				: "i" (MSR_DCE)				\
+				: "memory");
+#else
+		__asm__ __volatile__ ("					\
+				mfs	r12, rmsr;			\
+				ori	r12, r12, %0;			\
+				mts	rmsr, r12;			\
+				nop; "					\
+				:					\
+				: "i" (MSR_DCE)			\
+				: "memory", "r12");
+#endif
+	}
+}
+
+void _disable_dcache(void)
+{
+	if (cpuinfo.use_dcache) {
+#if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
+		__asm__ __volatile__ ("					\
+				msrclr	r0, %0;				\
+				nop; "					\
+				:					\
+				: "i" (MSR_DCE)			\
+				: "memory");
+#else
+		__asm__ __volatile__ ("					\
+				mfs	r12, rmsr;			\
+				andi	r12, r12, ~%0;			\
+				mts	rmsr, r12;			\
+				nop; "					\
+				:					\
+				: "i" (MSR_DCE)			\
+				: "memory", "r12");
+#endif
+	}
+}
+
+void _invalidate_dcache(unsigned int addr)
+{
+	if (cpuinfo.use_dcache)
+		__asm__ __volatile__ ("					\
+				wdc	%0, r0"				\
+				:					\
+				: "r" (addr));
+}
+
+void __invalidate_icache_all(void)
+{
+	unsigned int i;
+	unsigned flags;
+
+	if (cpuinfo.use_icache) {
+		local_irq_save(flags);
+		__disable_icache();
+
+		/* Just loop through cache size and invalidate, no need to add
+			CACHE_BASE address */
+		for (i = 0; i < cpuinfo.icache_size;
+			i += cpuinfo.icache_line)
+				__invalidate_icache(i);
+
+		__enable_icache();
+		local_irq_restore(flags);
+	}
+}
+
+void __invalidate_icache_range(unsigned long start, unsigned long end)
+{
+	unsigned int i;
+	unsigned flags;
+	unsigned int align;
+
+	if (cpuinfo.use_icache) {
+		/*
+		 * No need to cover entire cache range,
+		 * just cover cache footprint
+		 */
+		end = min(start + cpuinfo.icache_size, end);
+		align = ~(cpuinfo.icache_line - 1);
+		start &= align; /* Make sure we are aligned */
+		/* Push end up to the next cache line */
+		end = ((end & align) + cpuinfo.icache_line);
+
+		local_irq_save(flags);
+		__disable_icache();
+
+		for (i = start; i < end; i += cpuinfo.icache_line)
+			__invalidate_icache(i);
+
+		__enable_icache();
+		local_irq_restore(flags);
+	}
+}
+
+void __invalidate_icache_page(struct vm_area_struct *vma, struct page *page)
+{
+	__invalidate_icache_all();
+}
+
+void __invalidate_icache_user_range(struct vm_area_struct *vma,
+				struct page *page, unsigned long adr,
+				int len)
+{
+	__invalidate_icache_all();
+}
+
+void __invalidate_cache_sigtramp(unsigned long addr)
+{
+	__invalidate_icache_range(addr, addr + 8);
+}
+
+void __invalidate_dcache_all(void)
+{
+	unsigned int i;
+	unsigned flags;
+
+	if (cpuinfo.use_dcache) {
+		local_irq_save(flags);
+		__disable_dcache();
+
+		/*
+		 * Just loop through cache size and invalidate,
+		 * no need to add CACHE_BASE address
+		 */
+		for (i = 0; i < cpuinfo.dcache_size;
+			i += cpuinfo.dcache_line)
+				__invalidate_dcache(i);
+
+		__enable_dcache();
+		local_irq_restore(flags);
+	}
+}
+
+void __invalidate_dcache_range(unsigned long start, unsigned long end)
+{
+	unsigned int i;
+	unsigned flags;
+	unsigned int align;
+
+	if (cpuinfo.use_dcache) {
+		/*
+		 * No need to cover entire cache range,
+		 * just cover cache footprint
+		 */
+		end = min(start + cpuinfo.dcache_size, end);
+		align = ~(cpuinfo.dcache_line - 1);
+		start &= align; /* Make sure we are aligned */
+		/* Push end up to the next cache line */
+		end = ((end & align) + cpuinfo.dcache_line);
+		local_irq_save(flags);
+		__disable_dcache();
+
+		for (i = start; i < end; i += cpuinfo.dcache_line)
+			__invalidate_dcache(i);
+
+		__enable_dcache();
+		local_irq_restore(flags);
+	}
+}
+
+void __invalidate_dcache_page(struct vm_area_struct *vma, struct page *page)
+{
+	__invalidate_dcache_all();
+}
+
+void __invalidate_dcache_user_range(struct vm_area_struct *vma,
+				struct page *page, unsigned long adr,
+				int len)
+{
+	__invalidate_dcache_all();
+}
diff --git a/include/asm-microblaze/cache.h b/include/asm-microblaze/cache.h
new file mode 100644
index 0000000..08828ec
--- /dev/null
+++ b/include/asm-microblaze/cache.h
@@ -0,0 +1,44 @@
+/*
+ * Cache operations
+ *
+ * Copyright (C) 2007 Michal Simek <monstr@monstr.eu>
+ * Copyright (C) 2003 John Williams <jwilliams@itee.uq.edu.au>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file COPYING in the main directory of this
+ * archive for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_CACHE_H
+#define _ASM_MICROBLAZE_CACHE_H
+
+#include <asm/registers.h>
+#include <linux/autoconf.h>
+
+#ifndef L1_CACHE_BYTES
+/* word-granular cache in microblaze */
+#define L1_CACHE_BYTES		4
+#endif
+
+void _enable_icache(void);
+void _disable_icache(void);
+void _invalidate_icache(unsigned int addr);
+
+#define __enable_icache()		_enable_icache()
+#define __disable_icache()		_disable_icache()
+#define __invalidate_icache(addr)	_invalidate_icache(addr)
+
+void _enable_dcache(void);
+void _disable_dcache(void);
+void _invalidate_dcache(unsigned int addr);
+
+#define __enable_dcache()		_enable_dcache()
+#define __disable_dcache()		_disable_dcache()
+#define __invalidate_dcache(addr)	_invalidate_dcache(addr)
+
+/* FIXME - I don't think this is right */
+#ifdef CONFIG_XILINX_UNCACHED_SHADOW
+#define UNCACHED_SHADOW_MASK (CONFIG_XILINX_ERAM_SIZE)
+#endif
+
+#endif /* _ASM_MICROBLAZE_CACHE_H */
diff --git a/include/asm-microblaze/cacheflush.h b/include/asm-microblaze/cacheflush.h
new file mode 100644
index 0000000..6afe017
--- /dev/null
+++ b/include/asm-microblaze/cacheflush.h
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2007 PetaLogix
+ * Copyright (C) 2007 John Williams <john.williams@petalogix.com>
+ * based on v850 version which was
+ * Copyright (C) 2001,02,03 NEC Electronics Corporation
+ * Copyright (C) 2001,02,03 Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ */
+
+#ifndef _ASM_MICROBLAZE_CACHEFLUSH_H
+#define _ASM_MICROBLAZE_CACHEFLUSH_H
+
+/* Somebody depends on this; sigh... */
+#include <linux/mm.h>
+
+/*
+ * Cache handling functions.
+ * Microblaze has a write-through data cache, and no icache snooping of dcache
+ */
+
+#define flush_cache_all()			__invalidate_cache_all()
+#define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_range(vma, start, end)	__invalidate_cache_all()
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
+
+#define flush_dcache_range(start, end)	__invalidate_dcache_range(start, end)
+#define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+
+#define flush_icache_range(start, len)	__invalidate_icache_range(start, len)
+#define flush_icache_page(vma, pg)		do { } while (0)
+
+#define flush_cache_vmap(start, end)		do { } while (0)
+#define flush_cache_vunmap(start, end)		do { } while (0)
+
+struct page;
+struct mm_struct;
+struct vm_area_struct;
+
+/* see arch/microblaze/kernel/cache.c */
+extern void __invalidate_icache_all(void);
+extern void __invalidate_icache_range(unsigned long start, unsigned long end);
+extern void __invalidate_icache_page(struct vm_area_struct *vma, struct page *page);
+extern void __invalidate_icache_user_range(struct vm_area_struct *vma,
+				struct page *page,
+				unsigned long adr, int len);
+extern void __invalidate_cache_sigtramp(unsigned long addr);
+
+extern void __invalidate_dcache_all(void);
+extern void __invalidate_dcache_range(unsigned long start, unsigned long end);
+extern void __invalidate_dcache_page(struct vm_area_struct *vma, struct page *page);
+extern void __invalidate_dcache_user_range(struct vm_area_struct *vma,
+				struct page *page,
+				unsigned long adr, int len);
+
+extern inline void __invalidate_cache_all(void)
+{
+	__invalidate_icache_all();
+	__invalidate_dcache_all();
+}
+
+#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
+do { memcpy((dst), (src), (len)); \
+	flush_icache_range((unsigned) (dst), (unsigned) (dst) + (len)); \
+} while (0)
+
+#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
+	memcpy((dst), (src), (len))
+
+#endif /* _ASM_MICROBLAZE_CACHEFLUSH_H */
-- 
1.5.4.GIT
