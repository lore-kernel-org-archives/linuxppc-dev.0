Return-Path: <srs0=h6/a=ic=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lQMh3YZdzF2bT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40lQMh1GMwz8sxv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:12 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40lQMg3gRxz9s1w
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 14:59:11 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4F4sFV3008586
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:09 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hyk1mk7v4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:08 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 15 May 2018 05:59:06 +0100
Subject: [RFC PATCH 1/5] powerpc/fadump: move internal fadump code to a new
 file
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Tue, 15 May 2018 10:28:58 +0530
In-Reply-To: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
References: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152636033877.17123.5360738003334252053.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Refactoring fadump code means internal fadump code is referenced from
different places. For ease, move internal code to a new file.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/include/asm/fadump.h     |  114 -------------------
 arch/powerpc/kernel/Makefile          |    2 
 arch/powerpc/kernel/fadump.c          |  190 ++------------------------------
 arch/powerpc/kernel/fadump_internal.c |  194 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/fadump_internal.h |  127 ++++++++++++++++++++++
 5 files changed, 333 insertions(+), 294 deletions(-)
 create mode 100644 arch/powerpc/kernel/fadump_internal.c
 create mode 100644 arch/powerpc/kernel/fadump_internal.h

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 1771134..028a8ef 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -24,34 +24,6 @@
 
 #ifdef CONFIG_FA_DUMP
 
-/*
- * The RMA region will be saved for later dumping when kernel crashes.
- * RMA is Real Mode Area, the first block of logical memory address owned
- * by logical partition, containing the storage that may be accessed with
- * translate off.
- */
-#define RMA_START	0x0
-#define RMA_END		(ppc64_rma_size)
-
-/*
- * On some Power systems where RMO is 128MB, it still requires minimum of
- * 256MB for kernel to boot successfully. When kdump infrastructure is
- * configured to save vmcore over network, we run into OOM issue while
- * loading modules related to network setup. Hence we need aditional 64M
- * of memory to avoid OOM issue.
- */
-#define MIN_BOOT_MEM	(((RMA_END < (0x1UL << 28)) ? (0x1UL << 28) : RMA_END) \
-			+ (0x1UL << 26))
-
-/* The upper limit percentage for user specified boot memory size (25%) */
-#define MAX_BOOT_MEM_RATIO			4
-
-#define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
-
-/* Alignement per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-			max_t(unsigned long, MAX_ORDER - 1, pageblock_order))
-
 /* Firmware provided dump sections */
 #define FADUMP_CPU_STATE_DATA	0x0001
 #define FADUMP_HPTE_REGION	0x0002
@@ -60,18 +32,9 @@
 /* Dump request flag */
 #define FADUMP_REQUEST_FLAG	0x00000001
 
-/* FAD commands */
-#define FADUMP_REGISTER		1
-#define FADUMP_UNREGISTER	2
-#define FADUMP_INVALIDATE	3
-
 /* Dump status flag */
 #define FADUMP_ERROR_FLAG	0x2000
 
-#define FADUMP_CPU_ID_MASK	((1UL << 32) - 1)
-
-#define CPU_UNKNOWN		(~((u32)0))
-
 /* Utility macros */
 #define SKIP_TO_NEXT_CPU(reg_entry)					\
 ({									\
@@ -125,58 +88,8 @@ struct fadump_mem_struct {
 	struct fadump_section		rmr_region;
 };
 
-/* Firmware-assisted dump configuration details. */
-struct fw_dump {
-	unsigned long	cpu_state_data_size;
-	unsigned long	hpte_region_size;
-	unsigned long	boot_memory_size;
-	unsigned long	reserve_dump_area_start;
-	unsigned long	reserve_dump_area_size;
-	/* cmd line option during boot */
-	unsigned long	reserve_bootvar;
-
-	unsigned long	fadumphdr_addr;
-	unsigned long	cpu_notes_buf;
-	unsigned long	cpu_notes_buf_size;
-
-	int		ibm_configure_kernel_dump;
-
-	unsigned long	fadump_enabled:1;
-	unsigned long	fadump_supported:1;
-	unsigned long	dump_active:1;
-	unsigned long	dump_registered:1;
-};
-
-/*
- * Copy the ascii values for first 8 characters from a string into u64
- * variable at their respective indexes.
- * e.g.
- *  The string "FADMPINF" will be converted into 0x4641444d50494e46
- */
-static inline u64 str_to_u64(const char *str)
-{
-	u64 val = 0;
-	int i;
-
-	for (i = 0; i < sizeof(val); i++)
-		val = (*str) ? (val << 8) | *str++ : val << 8;
-	return val;
-}
-#define STR_TO_HEX(x)	str_to_u64(x)
-#define REG_ID(x)	str_to_u64(x)
-
-#define FADUMP_CRASH_INFO_MAGIC		STR_TO_HEX("FADMPINF")
 #define REGSAVE_AREA_MAGIC		STR_TO_HEX("REGSAVE")
 
-/* The firmware-assisted dump format.
- *
- * The register save area is an area in the partition's memory used to preserve
- * the register contents (CPU state data) for the active CPUs during a firmware
- * assisted dump. The dump format contains register save area header followed
- * by register entries. Each list of registers for a CPU starts with
- * "CPUSTRT" and ends with "CPUEND".
- */
-
 /* Register save area header. */
 struct fadump_reg_save_area_header {
 	__be64		magic_number;
@@ -184,32 +97,9 @@ struct fadump_reg_save_area_header {
 	__be32		num_cpu_offset;
 };
 
-/* Register entry. */
-struct fadump_reg_entry {
-	__be64		reg_id;
-	__be64		reg_value;
-};
-
-/* fadump crash info structure */
-struct fadump_crash_info_header {
-	u64		magic_number;
-	u64		elfcorehdr_addr;
-	u32		crashing_cpu;
-	struct pt_regs	regs;
-	struct cpumask	online_mask;
-};
-
-/* Crash memory ranges */
-#define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
-
-struct fad_crash_memory_ranges {
-	unsigned long long	base;
-	unsigned long long	size;
-};
-
 extern int is_fadump_memory_area(u64 addr, ulong size);
-extern int early_init_dt_scan_fw_dump(unsigned long node,
-		const char *uname, int depth, void *data);
+extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
+				      int depth, void *data);
 extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b2..c653ecd 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -61,7 +61,7 @@ obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
-obj-$(CONFIG_FA_DUMP)		+= fadump.o
+obj-$(CONFIG_FA_DUMP)		+= fadump.o fadump_internal.o
 ifeq ($(CONFIG_PPC32),y)
 obj-$(CONFIG_E500)		+= idle_e500.o
 endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 91e10cb..75cad00 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -43,6 +43,8 @@
 #include <asm/fadump.h>
 #include <asm/setup.h>
 
+#include "fadump_internal.h"
+
 static struct fw_dump fw_dump;
 static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
@@ -109,8 +111,8 @@ static int __init fadump_cma_init(void) { return 1; }
 #endif /* CONFIG_CMA */
 
 /* Scan the Firmware Assisted dump configuration details. */
-int __init early_init_dt_scan_fw_dump(unsigned long node,
-			const char *uname, int depth, void *data)
+int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
+				      int depth, void *data)
 {
 	const __be32 *sections;
 	int i, num_sections;
@@ -201,68 +203,6 @@ int is_fadump_active(void)
 	return fw_dump.dump_active;
 }
 
-/*
- * Returns 1, if there are no holes in boot memory area,
- * 0 otherwise.
- */
-static int is_boot_memory_area_contiguous(void)
-{
-	struct memblock_region *reg;
-	unsigned long tstart, tend;
-	unsigned long start_pfn = PHYS_PFN(RMA_START);
-	unsigned long end_pfn = PHYS_PFN(RMA_START + fw_dump.boot_memory_size);
-	unsigned int ret = 0;
-
-	for_each_memblock(memory, reg) {
-		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
-		tend = min(end_pfn, memblock_region_memory_end_pfn(reg));
-		if (tstart < tend) {
-			/* Memory hole from start_pfn to tstart */
-			if (tstart > start_pfn)
-				break;
-
-			if (tend == end_pfn) {
-				ret = 1;
-				break;
-			}
-
-			start_pfn = tend + 1;
-		}
-	}
-
-	return ret;
-}
-
-/*
- * Returns 1, if there are no holes in reserved memory area,
- * 0 otherwise.
- */
-static int is_reserved_memory_area_contiguous(void)
-{
-	struct memblock_region *reg;
-	unsigned long start, end;
-	unsigned long d_start = fw_dump.reserve_dump_area_start;
-	unsigned long d_end = d_start + fw_dump.reserve_dump_area_size;
-	int ret = 0;
-
-	for_each_memblock(memory, reg) {
-		start = max(d_start, (unsigned long)reg->base);
-		end = min(d_end, (unsigned long)(reg->base + reg->size));
-		if (d_start < end) {
-			/* Memory hole from d_start to start */
-			if (start > d_start)
-				break;
-
-			if (end == d_end) {
-				ret = 1;
-				break;
-			}
-			d_start = end + 1;
-		}
-	}
-	return ret;
-}
-
 /* Print firmware assisted dump configurations for debugging purpose. */
 static void fadump_show_config(void)
 {
@@ -622,10 +562,10 @@ static int register_fw_dump(struct fadump_mem_struct *fdm)
 			" dump. Hardware Error(%d).\n", rc);
 		break;
 	case -3:
-		if (!is_boot_memory_area_contiguous())
+		if (!is_boot_memory_area_contiguous(&fw_dump))
 			pr_err("Can't have holes in boot memory area while "
 			       "registering fadump\n");
-		else if (!is_reserved_memory_area_contiguous())
+		else if (!is_reserved_memory_area_contiguous(&fw_dump))
 			pr_err("Can't have holes in reserved memory area while"
 			       " registering fadump\n");
 
@@ -695,52 +635,6 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 	rtas_os_term((char *)str);
 }
 
-#define GPR_MASK	0xffffff0000000000
-static inline int fadump_gpr_index(u64 id)
-{
-	int i = -1;
-	char str[3];
-
-	if ((id & GPR_MASK) == REG_ID("GPR")) {
-		/* get the digits at the end */
-		id &= ~GPR_MASK;
-		id >>= 24;
-		str[2] = '\0';
-		str[1] = id & 0xff;
-		str[0] = (id >> 8) & 0xff;
-		sscanf(str, "%d", &i);
-		if (i > 31)
-			i = -1;
-	}
-	return i;
-}
-
-static inline void fadump_set_regval(struct pt_regs *regs, u64 reg_id,
-								u64 reg_val)
-{
-	int i;
-
-	i = fadump_gpr_index(reg_id);
-	if (i >= 0)
-		regs->gpr[i] = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("NIA"))
-		regs->nip = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("MSR"))
-		regs->msr = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("CTR"))
-		regs->ctr = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("LR"))
-		regs->link = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("XER"))
-		regs->xer = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("CR"))
-		regs->ccr = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("DAR"))
-		regs->dar = (unsigned long)reg_val;
-	else if (reg_id == REG_ID("DSISR"))
-		regs->dsisr = (unsigned long)reg_val;
-}
-
 static struct fadump_reg_entry*
 fadump_read_registers(struct fadump_reg_entry *reg_entry, struct pt_regs *regs)
 {
@@ -755,72 +649,6 @@ fadump_read_registers(struct fadump_reg_entry *reg_entry, struct pt_regs *regs)
 	return reg_entry;
 }
 
-static u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
-{
-	struct elf_prstatus prstatus;
-
-	memset(&prstatus, 0, sizeof(prstatus));
-	/*
-	 * FIXME: How do i get PID? Do I really need it?
-	 * prstatus.pr_pid = ????
-	 */
-	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
-	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
-			      &prstatus, sizeof(prstatus));
-	return buf;
-}
-
-static void fadump_update_elfcore_header(char *bufp)
-{
-	struct elfhdr *elf;
-	struct elf_phdr *phdr;
-
-	elf = (struct elfhdr *)bufp;
-	bufp += sizeof(struct elfhdr);
-
-	/* First note is a place holder for cpu notes info. */
-	phdr = (struct elf_phdr *)bufp;
-
-	if (phdr->p_type == PT_NOTE) {
-		phdr->p_paddr = fw_dump.cpu_notes_buf;
-		phdr->p_offset	= phdr->p_paddr;
-		phdr->p_filesz	= fw_dump.cpu_notes_buf_size;
-		phdr->p_memsz = fw_dump.cpu_notes_buf_size;
-	}
-	return;
-}
-
-static void *fadump_cpu_notes_buf_alloc(unsigned long size)
-{
-	void *vaddr;
-	struct page *page;
-	unsigned long order, count, i;
-
-	order = get_order(size);
-	vaddr = (void *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
-	if (!vaddr)
-		return NULL;
-
-	count = 1 << order;
-	page = virt_to_page(vaddr);
-	for (i = 0; i < count; i++)
-		SetPageReserved(page + i);
-	return vaddr;
-}
-
-static void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size)
-{
-	struct page *page;
-	unsigned long order, count, i;
-
-	order = get_order(size);
-	count = 1 << order;
-	page = virt_to_page(vaddr);
-	for (i = 0; i < count; i++)
-		ClearPageReserved(page + i);
-	__free_pages(page, order);
-}
-
 /*
  * Read CPU state dump data and convert it into ELF notes.
  * The CPU dump starts with magic number "REGSAVE". NumCpusOffset should be
@@ -910,9 +738,9 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 	final_note(note_buf);
 
 	if (fdh) {
-		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
-							fdh->elfcorehdr_addr);
-		fadump_update_elfcore_header((char *)__va(fdh->elfcorehdr_addr));
+		addr = fdh->elfcorehdr_addr;
+		pr_debug("Updating elfcore header(%lx) with cpu notes\n", addr);
+		fadump_update_elfcore_header(&fw_dump, (char *)__va(addr));
 	}
 	return 0;
 
diff --git a/arch/powerpc/kernel/fadump_internal.c b/arch/powerpc/kernel/fadump_internal.c
new file mode 100644
index 0000000..8259f22
--- /dev/null
+++ b/arch/powerpc/kernel/fadump_internal.c
@@ -0,0 +1,194 @@
+/*
+ * Firmware-Assisted Dump internal code.
+ *
+ * Copyright 2018, IBM Corporation
+ * Author: Hari Bathini <hbathini@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/memblock.h>
+#include <linux/elf.h>
+#include <linux/mm.h>
+#include <linux/crash_core.h>
+
+#include "fadump_internal.h"
+
+void *fadump_cpu_notes_buf_alloc(unsigned long size)
+{
+	void *vaddr;
+	struct page *page;
+	unsigned long order, count, i;
+
+	order = get_order(size);
+	vaddr = (void *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
+	if (!vaddr)
+		return NULL;
+
+	count = 1 << order;
+	page = virt_to_page(vaddr);
+	for (i = 0; i < count; i++)
+		SetPageReserved(page + i);
+	return vaddr;
+}
+
+void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size)
+{
+	struct page *page;
+	unsigned long order, count, i;
+
+	order = get_order(size);
+	count = 1 << order;
+	page = virt_to_page(vaddr);
+	for (i = 0; i < count; i++)
+		ClearPageReserved(page + i);
+	__free_pages(page, order);
+}
+
+#define GPR_MASK	0xffffff0000000000
+static inline int fadump_gpr_index(u64 id)
+{
+	int i = -1;
+	char str[3];
+
+	if ((id & GPR_MASK) == REG_ID("GPR")) {
+		/* get the digits at the end */
+		id &= ~GPR_MASK;
+		id >>= 24;
+		str[2] = '\0';
+		str[1] = id & 0xff;
+		str[0] = (id >> 8) & 0xff;
+		if (kstrtoint(str, 10, &i))
+			i = -EINVAL;
+		if (i > 31)
+			i = -1;
+	}
+	return i;
+}
+
+void fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val)
+{
+	int i;
+
+	i = fadump_gpr_index(reg_id);
+	if (i >= 0)
+		regs->gpr[i] = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("NIA"))
+		regs->nip = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("MSR"))
+		regs->msr = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("CTR"))
+		regs->ctr = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("LR"))
+		regs->link = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("XER"))
+		regs->xer = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("CR"))
+		regs->ccr = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("DAR"))
+		regs->dar = (unsigned long)reg_val;
+	else if (reg_id == REG_ID("DSISR"))
+		regs->dsisr = (unsigned long)reg_val;
+}
+
+u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
+{
+	struct elf_prstatus prstatus;
+
+	memset(&prstatus, 0, sizeof(prstatus));
+	/*
+	 * FIXME: How do i get PID? Do I really need it?
+	 * prstatus.pr_pid = ????
+	 */
+	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
+	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+			      &prstatus, sizeof(prstatus));
+	return buf;
+}
+
+void fadump_update_elfcore_header(struct fw_dump *fadump_conf, char *bufp)
+{
+	struct elfhdr *elf;
+	struct elf_phdr *phdr;
+
+	elf = (struct elfhdr *)bufp;
+	bufp += sizeof(struct elfhdr);
+
+	/* First note is a place holder for cpu notes info. */
+	phdr = (struct elf_phdr *)bufp;
+
+	if (phdr->p_type == PT_NOTE) {
+		phdr->p_paddr  = fadump_conf->cpu_notes_buf;
+		phdr->p_offset = phdr->p_paddr;
+		phdr->p_memsz  = fadump_conf->cpu_notes_buf_size;
+		phdr->p_filesz = phdr->p_memsz;
+	}
+}
+
+/*
+ * Returns 1, if there are no holes in boot memory area,
+ * 0 otherwise.
+ */
+int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf)
+{
+	struct memblock_region *reg;
+	unsigned long tstart, tend;
+	unsigned long start_pfn = PHYS_PFN(RMA_START);
+	unsigned long end_pfn = PHYS_PFN(RMA_START +
+					 fadump_conf->boot_memory_size);
+	unsigned int ret = 0;
+
+	for_each_memblock(memory, reg) {
+		tstart = max(start_pfn, memblock_region_memory_base_pfn(reg));
+		tend = min(end_pfn, memblock_region_memory_end_pfn(reg));
+		if (tstart < tend) {
+			/* Memory hole from start_pfn to tstart */
+			if (tstart > start_pfn)
+				break;
+
+			if (tend == end_pfn) {
+				ret = 1;
+				break;
+			}
+
+			start_pfn = tend + 1;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Returns 1, if there are no holes in reserved memory area,
+ * 0 otherwise.
+ */
+int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf)
+{
+	struct memblock_region *reg;
+	unsigned long start, end;
+	unsigned long d_start = fadump_conf->reserve_dump_area_start;
+	unsigned long d_end = d_start + fadump_conf->reserve_dump_area_size;
+	int ret = 0;
+
+	for_each_memblock(memory, reg) {
+		start = max_t(unsigned long, d_start, reg->base);
+		end = min_t(unsigned long, d_end, (reg->base + reg->size));
+		if (d_start < end) {
+			/* Memory hole from d_start to start */
+			if (start > d_start)
+				break;
+
+			if (end == d_end) {
+				ret = 1;
+				break;
+			}
+
+			d_start = end + 1;
+		}
+	}
+
+	return ret;
+}
diff --git a/arch/powerpc/kernel/fadump_internal.h b/arch/powerpc/kernel/fadump_internal.h
new file mode 100644
index 0000000..4c26eda
--- /dev/null
+++ b/arch/powerpc/kernel/fadump_internal.h
@@ -0,0 +1,127 @@
+/*
+ * Firmware-Assisted Dump internal code.
+ *
+ * Copyright 2018, IBM Corporation
+ * Author: Hari Bathini <hbathini@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __PPC64_FA_DUMP_INTERNAL_H__
+#define __PPC64_FA_DUMP_INTERNAL_H__
+
+/*
+ * The RMA region will be saved for later dumping when kernel crashes.
+ * RMA is Real Mode Area, the first block of logical memory address owned
+ * by logical partition, containing the storage that may be accessed with
+ * translate off.
+ */
+#define RMA_START	0x0
+#define RMA_END		(ppc64_rma_size)
+
+/*
+ * On some Power systems where RMO is 128MB, it still requires minimum of
+ * 256MB for kernel to boot successfully. When kdump infrastructure is
+ * configured to save vmcore over network, we run into OOM issue while
+ * loading modules related to network setup. Hence we need additional 64M
+ * of memory to avoid OOM issue.
+ */
+#define MIN_BOOT_MEM	(((RMA_END < (0x1UL << 28)) ? (0x1UL << 28) : RMA_END) \
+			+ (0x1UL << 26))
+
+/* The upper limit percentage for user specified boot memory size (25%) */
+#define MAX_BOOT_MEM_RATIO			4
+
+#define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
+
+/* Alignment per CMA requirement. */
+#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
+				 max_t(unsigned long, MAX_ORDER - 1,	\
+				 pageblock_order))
+
+/* FAD commands */
+#define FADUMP_REGISTER			1
+#define FADUMP_UNREGISTER		2
+#define FADUMP_INVALIDATE		3
+
+#define FADUMP_CPU_ID_MASK		((1UL << 32) - 1)
+
+#define CPU_UNKNOWN			(~((u32)0))
+
+/*
+ * Copy the ascii values for first 8 characters from a string into u64
+ * variable at their respective indexes.
+ * e.g.
+ *  The string "FADMPINF" will be converted into 0x4641444d50494e46
+ */
+static inline u64 str_to_u64(const char *str)
+{
+	u64 val = 0;
+	int i;
+
+	for (i = 0; i < sizeof(val); i++)
+		val = (*str) ? (val << 8) | *str++ : val << 8;
+	return val;
+}
+#define STR_TO_HEX(x)	str_to_u64(x)
+#define REG_ID(x)	str_to_u64(x)
+
+#define FADUMP_CRASH_INFO_MAGIC		STR_TO_HEX("FADMPINF")
+
+/* Register entry. */
+struct fadump_reg_entry {
+	__be64		reg_id;
+	__be64		reg_value;
+};
+
+/* fadump crash info structure */
+struct fadump_crash_info_header {
+	u64		magic_number;
+	u64		elfcorehdr_addr;
+	u32		crashing_cpu;
+	struct pt_regs	regs;
+	struct cpumask	online_mask;
+};
+
+/* Crash memory ranges */
+#define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
+
+struct fad_crash_memory_ranges {
+	unsigned long long	base;
+	unsigned long long	size;
+};
+
+/* Firmware-assisted dump configuration details. */
+struct fw_dump {
+	unsigned long	cpu_state_data_size;
+	unsigned long	hpte_region_size;
+	unsigned long	boot_memory_size;
+	unsigned long	reserve_dump_area_start;
+	unsigned long	reserve_dump_area_size;
+	/* cmd line option during boot */
+	unsigned long	reserve_bootvar;
+
+	unsigned long	fadumphdr_addr;
+	unsigned long	cpu_notes_buf;
+	unsigned long	cpu_notes_buf_size;
+
+	int		ibm_configure_kernel_dump;
+
+	unsigned long	fadump_enabled:1;
+	unsigned long	fadump_supported:1;
+	unsigned long	dump_active:1;
+	unsigned long	dump_registered:1;
+};
+
+int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf);
+int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf);
+void *fadump_cpu_notes_buf_alloc(unsigned long size);
+void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size);
+void fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val);
+u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs);
+void fadump_update_elfcore_header(struct fw_dump *fadump_config, char *bufp);
+
+#endif /* __PPC64_FA_DUMP_INTERNAL_H__ */
