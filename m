Return-Path: <srs0=h6/a=ic=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lQMz5jwyzF2jK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40lQMz1lrSz8wF8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:27 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40lQMy1N9Tz9s1w
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 14:59:25 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4F4xLwb090239
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:24 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hyreh0xpb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:23 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 15 May 2018 05:59:21 +0100
Subject: [RFC PATCH 3/5] powerpc/fadump: enable fadump support on powernv
 platform
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 15 May 2018 10:29:15 +0530
In-Reply-To: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
References: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152636035587.17123.1844308737319409343.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

Firmware-assisted dump support is enabled for POWERNV platform in P9
firmware. Make the corresponding updates in kernel to enable fadump
support on POWERNV platform.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                            |    2 
 arch/powerpc/include/asm/opal-api.h             |    4 
 arch/powerpc/include/asm/opal.h                 |    1 
 arch/powerpc/kernel/fadump.c                    |  397 ++++++++++++++++++++---
 arch/powerpc/kernel/fadump_internal.h           |   27 ++
 arch/powerpc/platforms/powernv/Makefile         |    1 
 arch/powerpc/platforms/powernv/opal-wrappers.S  |    1 
 arch/powerpc/platforms/powernv/powernv_fadump.c |  337 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/powernv_fadump.h |   63 ++++
 arch/powerpc/platforms/pseries/pseries_fadump.c |    8 
 10 files changed, 783 insertions(+), 58 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/powernv_fadump.c
 create mode 100644 arch/powerpc/platforms/powernv/powernv_fadump.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181..d749f1f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -599,7 +599,7 @@ config CRASH_DUMP
 
 config FA_DUMP
 	bool "Firmware-assisted dump"
-	depends on PPC64 && PPC_RTAS
+	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
 	select CRASH_CORE
 	select CRASH_DUMP
 	help
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index d886a5b..75e8925 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -206,7 +206,8 @@
 #define OPAL_NPU_TL_SET				161
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
-#define OPAL_LAST				165
+#define OPAL_CONFIGURE_FADUMP			167
+#define OPAL_LAST				167
 
 /* Device tree flags */
 
@@ -1040,6 +1041,7 @@ enum OpalSysCooling {
 enum {
 	OPAL_REBOOT_NORMAL		= 0,
 	OPAL_REBOOT_PLATFORM_ERROR	= 1,
+	OPAL_REBOOT_MPIPL		= 3,
 };
 
 /* Argument to OPAL_PCI_TCE_KILL */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 03e1a92..4c1f483 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -43,6 +43,7 @@ int64_t opal_npu_spa_clear_cache(uint64_t phb_id, uint32_t bdfn,
 				uint64_t PE_handle);
 int64_t opal_npu_tl_set(uint64_t phb_id, uint32_t bdfn, long cap,
 			uint64_t rate_phys, uint32_t size);
+int64_t opal_configure_fadump(uint64_t command, void *data, uint64_t data_size);
 int64_t opal_console_write(int64_t term_number, __be64 *length,
 			   const uint8_t *buffer);
 int64_t opal_console_read(int64_t term_number, __be64 *length,
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 88fafe1..a27e4af 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -53,8 +53,12 @@ static struct cma *fadump_cma;
 struct fadump_ops_t *fadump_ops;
 
 static DEFINE_MUTEX(fadump_mutex);
-struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
+struct fadump_memory_range crash_memory_ranges[INIT_CRASHMEM_RANGES];
 int crash_mem_ranges;
+struct fadump_memory_range reserved_ranges[INIT_MEMBLOCK_REGIONS];
+int reserved_ranges_cnt;
+struct fadump_memory_range memory_ranges[2 * INIT_MEMBLOCK_REGIONS];
+int memory_ranges_cnt;
 
 #ifdef CONFIG_CMA
 /*
@@ -120,6 +124,9 @@ int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
 	if (strcmp(uname, "rtas") == 0)
 		return pseries_dt_scan_fadump(&fw_dump, node);
 
+	if (strcmp(uname, "ibm,dump") == 0)
+		return powernv_dt_scan_fadump(&fw_dump, node);
+
 	return 0;
 }
 
@@ -156,6 +163,8 @@ int is_fadump_active(void)
 /* Print firmware assisted dump configurations for debugging purpose. */
 static void fadump_show_config(void)
 {
+	int i;
+
 	pr_debug("Support for firmware-assisted dump (fadump): %s\n",
 			(fw_dump.fadump_supported ? "present" : "no support"));
 
@@ -170,6 +179,13 @@ static void fadump_show_config(void)
 	pr_debug("    CPU state data size: %lx\n", fw_dump.cpu_state_data_size);
 	pr_debug("    HPTE region size   : %lx\n", fw_dump.hpte_region_size);
 	pr_debug("Boot memory size  : %lx\n", fw_dump.boot_memory_size);
+	pr_debug("Real memory region hole size  : %lx\n",
+		 fw_dump.boot_memory_hole_size);
+	pr_debug("Real meory regions count : %lx\n", fw_dump.rmr_regions_cnt);
+	for (i = 0; i < fw_dump.rmr_regions_cnt; i++) {
+		pr_debug("%d. RMR base = %lx, size = %lx\n", (i+1),
+			 fw_dump.rmr_src_addr[i], fw_dump.rmr_src_size[i]);
+	}
 }
 
 /**
@@ -243,6 +259,157 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 	return (size > MIN_BOOT_MEM ? size : MIN_BOOT_MEM);
 }
 
+static void __init fadump_get_reserved_ranges(void)
+{
+	unsigned long i, j, dt_root;
+	unsigned long long base, size;
+	struct fadump_memory_range tmp_range;
+	const __be32 *prop;
+	int len, idx;
+
+	early_init_fdt_reserve_self();
+	early_init_fdt_scan_reserved_mem();
+
+	dt_root = of_get_flat_dt_root();
+
+	prop = of_get_flat_dt_prop(dt_root, "reserved-ranges", &len);
+
+	if (!prop)
+		return;
+
+	/*
+	 * Each reserved range is an (address,size) pair, 2 cells each,
+	 * totalling 4 cells per range.
+	 */
+	for (i = 0; i < len / (sizeof(*prop) * 4); i++) {
+		u64 base, size;
+
+		base = of_read_number(prop + (i * 4) + 0, 2);
+		size = of_read_number(prop + (i * 4) + 2, 2);
+		if (!size)
+			continue;
+
+		reserved_ranges[reserved_ranges_cnt].base = base;
+		reserved_ranges[reserved_ranges_cnt].size = size;
+		reserved_ranges_cnt++;
+
+	}
+
+	if (!reserved_ranges_cnt)
+		return;
+
+	/* Sort the reserved ranges */
+	for (i = 0; i < reserved_ranges_cnt; i++) {
+		idx = i;
+		for (j = i + 1; j < reserved_ranges_cnt; j++) {
+			if (reserved_ranges[idx].base > reserved_ranges[j].base)
+				idx = j;
+		}
+		if (idx != i) {
+			tmp_range = reserved_ranges[idx];
+			reserved_ranges[idx] = reserved_ranges[i];
+			reserved_ranges[i] = tmp_range;
+		}
+	}
+
+	/* Merge adjacent reserved ranges */
+	idx = 0;
+	for (i = 1; i < reserved_ranges_cnt; i++) {
+		base = reserved_ranges[i-1].base;
+		size = reserved_ranges[i-1].size;
+		if (reserved_ranges[i].base == (base + size))
+			reserved_ranges[idx].size += reserved_ranges[i].size;
+		else {
+			idx++;
+			if (i == idx)
+				continue;
+
+			reserved_ranges[idx] = reserved_ranges[i];
+		}
+	}
+	reserved_ranges_cnt = idx + 1;
+}
+
+static inline void fadump_add_memory_range(unsigned long long base,
+					   unsigned long long size)
+{
+	if (!size)
+		return;
+
+	pr_debug("memory_range[%d] [%#016llx-%#016llx), %#llx bytes\n",
+		 memory_ranges_cnt, base, base + size, size);
+	memory_ranges[memory_ranges_cnt].base = base;
+	memory_ranges[memory_ranges_cnt].size = size;
+	memory_ranges_cnt++;
+}
+
+static void fadump_setup_memory_ranges(void)
+{
+	unsigned long i, j;
+	unsigned long long base, end, size;
+	struct memblock_region *reg;
+	struct fadump_memory_range tmp_ranges[INIT_MEMBLOCK_REGIONS];
+	int tmp_ranges_cnt;
+
+	/* get memory ranges */
+	tmp_ranges_cnt = 0;
+	for_each_memblock(memory, reg) {
+		tmp_ranges[tmp_ranges_cnt].base = (unsigned long long)reg->base;
+		tmp_ranges[tmp_ranges_cnt].size = (unsigned long long)reg->size;
+		tmp_ranges_cnt++;
+	}
+
+	/* exclude reserved ranges */
+	memory_ranges_cnt = 0;
+	for (i = 0; i < tmp_ranges_cnt; i++) {
+		unsigned long long mem_base, mem_end, rsrv_base, rsrv_end;
+		int add = 1;
+
+		base = mem_base = tmp_ranges[i].base;
+		end = mem_end = base + tmp_ranges[i].size;
+		for (j = 0; j < reserved_ranges_cnt; j++) {
+			rsrv_base = reserved_ranges[j].base;
+			rsrv_end  = rsrv_base + reserved_ranges[j].size;
+
+			if (mem_base > rsrv_end)
+				continue;
+
+			if ((j < (reserved_ranges_cnt - 1)) &&
+			    (reserved_ranges[j + 1].base < mem_end))
+				mem_end = reserved_ranges[j + 1].base;
+
+			if ((rsrv_base < mem_end) && (rsrv_end > mem_base)) {
+				if ((mem_base < rsrv_base) &&
+				    (mem_end > rsrv_end)) {
+					size = rsrv_base - mem_base;
+					fadump_add_memory_range(mem_base, size);
+					size = mem_end - rsrv_end;
+					fadump_add_memory_range(rsrv_end, size);
+				} else if (mem_base < rsrv_base) {
+					size = rsrv_base - mem_base;
+					fadump_add_memory_range(mem_base, size);
+				} else if (mem_end > rsrv_end) {
+					size = mem_end - rsrv_end;
+					fadump_add_memory_range(rsrv_end, size);
+				}
+
+				add = 0;
+			}
+
+			if (mem_end == end)
+				break;
+
+			mem_base = mem_end;
+			mem_end = end;
+			add = 1;
+		}
+
+		if (add)
+			fadump_add_memory_range(mem_base, mem_end - mem_base);
+	}
+}
+
+
 /*
  * Calculate the total memory size required to be reserved for
  * firmware-assisted dump registration.
@@ -264,24 +431,113 @@ static unsigned long get_fadump_area_size(void)
 	return size;
 }
 
-static void __init fadump_reserve_crash_area(unsigned long base,
-					     unsigned long size)
+/* Preserve everything above the base address */
+static void __init fadump_reserve_crash_area(unsigned long base)
 {
-	struct memblock_region *reg;
-	unsigned long mstart, mend, msize;
+	int i;
+	unsigned long mstart, msize;
 
-	for_each_memblock(memory, reg) {
-		mstart = max_t(unsigned long, base, reg->base);
-		mend = reg->base + reg->size;
-		mend = min(base + size, mend);
-
-		if (mstart < mend) {
-			msize = mend - mstart;
-			memblock_reserve(mstart, msize);
-			pr_info("Reserved %ldMB of memory at %#016lx for saving crash dump\n",
-				(msize >> 20), mstart);
+	for (i = 0; i < memory_ranges_cnt; i++) {
+		mstart = memory_ranges[i].base;
+		msize = memory_ranges[i].size;
+		if ((mstart + msize) < base)
+			continue;
+
+		if (mstart < base) {
+			msize -= (base - mstart);
+			mstart = base;
 		}
+		pr_info("Reserving %luMB of memory at %#016lx for saving crash dump",
+			(msize >> 20), mstart);
+		memblock_reserve(mstart, msize);
+	}
+}
+
+static int __init add_rmr_region(unsigned long rmr_start,
+				 unsigned long rmr_size)
+{
+	int i = fw_dump.rmr_regions_cnt++;
+
+	if (fw_dump.rmr_regions_cnt > MAX_REAL_MEM_REGIONS)
+		return 0;
+
+	pr_debug("Added real memory range[%d] [%#016lx-%#016lx)\n",
+		 i, rmr_start, (rmr_start + rmr_size));
+	fw_dump.rmr_src_addr[i] = rmr_start;
+	fw_dump.rmr_src_size[i] = rmr_size;
+	return 1;
+}
+
+/*
+ * Platforms like PowerNV have an upper limit on the size.
+ * If 'rmr_size' is bigger than that limit, split this memory range
+ * into multiple entries.
+ */
+static int __init add_rmr_regions(unsigned long rmr_start,
+				  unsigned long rmr_size)
+{
+	unsigned long rstart, rsize, max_size;
+	int ret = 1;
+
+	rstart = rmr_start;
+	max_size = fw_dump.max_copy_size ? fw_dump.max_copy_size : rmr_size;
+	while (rmr_size) {
+		if (rmr_size > max_size)
+			rsize = max_size;
+		else
+			rsize = rmr_size;
+
+		ret = add_rmr_region(rstart, rsize);
+		if (!ret)
+			break;
+
+		rmr_size -= rsize;
+		rstart += rsize;
 	}
+
+	return ret;
+}
+
+static int __init fadump_get_rmr_regions(void)
+{
+	int i, ret = 1;
+	unsigned long base, size, last_end;
+	unsigned long mem_size = fw_dump.boot_memory_size;
+
+	fw_dump.rmr_regions_cnt = 0;
+	fw_dump.boot_memory_hole_size = 0;
+
+	/*
+	 * TODO: Extent support for multiple real memory regions on
+	 *       pseries platform too.
+	 */
+	if (fw_dump.fadump_platform == FADUMP_PLATFORM_PSERIES) {
+		ret = add_rmr_regions(RMA_START, fw_dump.boot_memory_size);
+		return ret;
+	}
+
+	last_end = memory_ranges[0].base;
+	for (i = 0; i < memory_ranges_cnt; i++) {
+		base = memory_ranges[i].base;
+		size = memory_ranges[i].size;
+
+		if (base > last_end)
+			fw_dump.boot_memory_hole_size += (base - last_end);
+
+		if (size >= mem_size) {
+			ret = add_rmr_regions(base, mem_size);
+			break;
+		}
+
+		mem_size -= size;
+		ret = add_rmr_regions(base, size);
+		if (!ret)
+			break;
+
+		last_end = base + size;
+	}
+
+	return ret;
 }
 
 int __init fadump_reserve_mem(void)
@@ -297,6 +553,10 @@ int __init fadump_reserve_mem(void)
 		fw_dump.fadump_enabled = 0;
 		return 0;
 	}
+
+	fadump_get_reserved_ranges();
+	fadump_setup_memory_ranges();
+
 	/*
 	 * Initialize boot memory size
 	 * If dump is active then we have already calculated the size during
@@ -311,6 +571,11 @@ int __init fadump_reserve_mem(void)
 						 FADUMP_CMA_ALIGNMENT);
 #endif
 		fw_dump.rmr_source_len = fw_dump.boot_memory_size;
+		if (!fadump_get_rmr_regions()) {
+			fw_dump.fadump_enabled = 0;
+			pr_err("Too many holes in boot memory area to enable fadump\n");
+			return 0;
+		}
 	}
 
 	size = get_fadump_area_size();
@@ -335,6 +600,7 @@ int __init fadump_reserve_mem(void)
 	else
 		memory_boundary = memblock_end_of_DRAM();
 
+	base = fw_dump.boot_memory_size + fw_dump.boot_memory_hole_size;
 	if (fw_dump.dump_active) {
 #ifdef CONFIG_HUGETLB_PAGE
 		/*
@@ -348,11 +614,9 @@ int __init fadump_reserve_mem(void)
 		 * If last boot has crashed then reserve all the memory
 		 * above boot_memory_size so that we don't touch it until
 		 * dump is written to disk by userspace tool. This memory
-		 * will be released for general use once the dump is saved.
+		 * can be released for general use by invalidating fadump.
 		 */
-		base = fw_dump.boot_memory_size;
-		size = memory_boundary - base;
-		fadump_reserve_crash_area(base, size);
+		fadump_reserve_crash_area(base);
 
 		fw_dump.fadumphdr_addr =
 			fadump_ops->get_meta_area_start(&fw_dump);
@@ -366,23 +630,22 @@ int __init fadump_reserve_mem(void)
 		 * use memblock_find_in_range() here since it doesn't allocate
 		 * from bottom to top.
 		 */
-		for (base = fw_dump.boot_memory_size;
-		     base <= (memory_boundary - size);
-		     base += size) {
+		while (base <= (memory_boundary - size)) {
 			if (memblock_is_region_memory(base, size) &&
 			    !memblock_is_region_reserved(base, size))
 				break;
+
+			base += size;
 		}
+
 		if ((base > (memory_boundary - size)) ||
 		    memblock_reserve(base, size)) {
 			pr_err("Failed to reserve memory\n");
 			return 0;
 		}
 
-		pr_info("Reserved %ldMB of memory at %ldMB for firmware-"
-			"assisted dump (System RAM: %ldMB)\n",
-			(unsigned long)(size >> 20),
-			(unsigned long)(base >> 20),
+		pr_info("Reserved %ldMB of memory at %#016lx (System RAM: %ldMB)\n",
+			(unsigned long)(size >> 20), base,
 			(unsigned long)(memblock_phys_mem_size() >> 20));
 
 		fw_dump.reserve_dump_area_start = base;
@@ -543,23 +806,28 @@ static int fadump_init_elfcore_header(char *bufp)
  */
 static void fadump_setup_crash_memory_ranges(void)
 {
-	struct memblock_region *reg;
-	unsigned long long start, end;
+	unsigned long long start, end, offset;
+	int i;
 
 	pr_debug("Setup crash memory ranges.\n");
 	crash_mem_ranges = 0;
+	offset = fw_dump.boot_memory_size + fw_dump.boot_memory_hole_size;
+
 	/*
-	 * add the first memory chunk (RMA_START through boot_memory_size) as
-	 * a separate memory chunk. The reason is, at the time crash firmware
-	 * will move the content of this memory chunk to different location
-	 * specified during fadump registration. We need to create a separate
-	 * program header for this chunk with the correct offset.
+	 * Add real memory region(s) whose content is going to be moved to
+	 * a different location, specified during fadump registration, by
+	 * firmware at the time of crash. We need to create separate program
+	 * header(s) for this memory chunk with the correct offset.
 	 */
-	fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
+	for (i = 0; i < fw_dump.rmr_regions_cnt; i++) {
+		start = fw_dump.rmr_src_addr[i];
+		end = start + fw_dump.rmr_src_size[i];
+		fadump_add_crash_memory(start, end);
+	}
 
-	for_each_memblock(memory, reg) {
-		start = (unsigned long long)reg->base;
-		end = start + (unsigned long long)reg->size;
+	for (i = 0; i < memory_ranges_cnt; i++) {
+		start = memory_ranges[i].base;
+		end = start + memory_ranges[i].size;
 
 		/*
 		 * skip the first memory chunk that is already added (RMA_START
@@ -567,9 +835,9 @@ static void fadump_setup_crash_memory_ranges(void)
 		 * when RMA_START changes to a non-zero value.
 		 */
 		BUILD_BUG_ON(RMA_START != 0);
-		if (start < fw_dump.boot_memory_size) {
-			if (end > fw_dump.boot_memory_size)
-				start = fw_dump.boot_memory_size;
+		if (start < offset) {
+			if (end > offset)
+				start = offset;
 			else
 				continue;
 		}
@@ -586,17 +854,32 @@ static void fadump_setup_crash_memory_ranges(void)
  */
 static inline unsigned long fadump_relocate(unsigned long paddr)
 {
-	if (paddr > RMA_START && paddr < fw_dump.boot_memory_size)
-		return fw_dump.rmr_destination_addr + paddr;
-	else
-		return paddr;
+	unsigned long raddr, rstart, rend, offset;
+	int i;
+
+	offset = 0;
+	raddr = paddr;
+	for (i = 0; i < fw_dump.rmr_regions_cnt; i++) {
+		rstart = fw_dump.rmr_src_addr[i];
+		rend = rstart + fw_dump.rmr_src_size[i];
+
+		if (paddr > rstart && paddr < rend) {
+			raddr += fw_dump.rmr_destination_addr + offset;
+			break;
+		}
+
+		offset += fw_dump.rmr_src_size[i];
+	}
+
+	return raddr;
 }
 
 static int fadump_create_elfcore_headers(char *bufp)
 {
 	struct elfhdr *elf;
 	struct elf_phdr *phdr;
-	int i;
+	unsigned long long raddr, offset;
+	int i, j;
 
 	fadump_init_elfcore_header(bufp);
 	elf = (struct elfhdr *)bufp;
@@ -639,9 +922,12 @@ static int fadump_create_elfcore_headers(char *bufp)
 	(elf->e_phnum)++;
 
 	/* setup PT_LOAD sections. */
-
+	j = 0;
+	offset = 0;
+	raddr = fw_dump.rmr_src_addr[0];
 	for (i = 0; i < crash_mem_ranges; i++) {
 		unsigned long long mbase, msize;
+
 		mbase = crash_memory_ranges[i].base;
 		msize = crash_memory_ranges[i].size;
 
@@ -654,13 +940,17 @@ static int fadump_create_elfcore_headers(char *bufp)
 		phdr->p_flags	= PF_R|PF_W|PF_X;
 		phdr->p_offset	= mbase;
 
-		if (mbase == RMA_START) {
+		if (mbase == raddr) {
 			/*
 			 * The entire RMA region will be moved by firmware
 			 * to the specified destination_address. Hence set
 			 * the correct offset.
 			 */
-			phdr->p_offset = fw_dump.rmr_destination_addr;
+			phdr->p_offset = fw_dump.rmr_destination_addr + offset;
+			if (j < (fw_dump.rmr_regions_cnt - 1)) {
+				offset += fw_dump.rmr_src_size[j];
+				raddr = fw_dump.rmr_src_addr[++j];
+			}
 		}
 
 		phdr->p_paddr = mbase;
@@ -707,6 +997,7 @@ static int register_fadump(void)
 	if (!fw_dump.reserve_dump_area_size)
 		return -ENODEV;
 
+	fadump_setup_memory_ranges();
 	fadump_setup_crash_memory_ranges();
 
 	addr = fadump_ops->get_meta_area_start(&fw_dump);
@@ -822,14 +1113,14 @@ static void fadump_invalidate_release_mem(void)
 	 * later for releasing the memory for general use.
 	 */
 	reserved_area_start = fw_dump.reserve_dump_area_start;
-	reserved_area_end = reserved_area_start +
-			fw_dump.reserve_dump_area_size;
+	reserved_area_end =
+		memory_limit ? memory_limit : memblock_end_of_DRAM();
+
 	/*
-	 * Setup reserve_dump_area_start and its size so that we can
-	 * reuse this reserved memory for Re-registration.
+	 * Setup reserve_dump_area_start so that we can reuse this
+	 * reserved memory for Re-registration.
 	 */
 	fw_dump.reserve_dump_area_start = destination_address;
-	fw_dump.reserve_dump_area_size = get_fadump_area_size();
 
 	fadump_release_memory(reserved_area_start, reserved_area_end);
 	if (fw_dump.cpu_notes_buf) {
diff --git a/arch/powerpc/kernel/fadump_internal.h b/arch/powerpc/kernel/fadump_internal.h
index 3791da7..eae4b55 100644
--- a/arch/powerpc/kernel/fadump_internal.h
+++ b/arch/powerpc/kernel/fadump_internal.h
@@ -49,6 +49,7 @@
 
 /* Firmware-Assited Dump platforms */
 #define FADUMP_PLATFORM_PSERIES		1
+#define FADUMP_PLATFORM_POWERNV		2
 
 #define FADUMP_CPU_ID_MASK		((1UL << 32) - 1)
 
@@ -92,11 +93,14 @@ struct fadump_crash_info_header {
 /* Crash memory ranges */
 #define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
 
-struct fad_crash_memory_ranges {
+struct fadump_memory_range {
 	unsigned long long	base;
 	unsigned long long	size;
 };
 
+/* Maximum no. of real memory regions supported by the kernel */
+#define MAX_REAL_MEM_REGIONS		6
+
 /* Firmware-assisted dump configuration details. */
 struct fw_dump {
 	unsigned long	cpu_state_data_size;
@@ -114,6 +118,17 @@ struct fw_dump {
 	unsigned long	rmr_source_len;
 	unsigned long	rmr_destination_addr;
 
+	unsigned long	boot_memory_hole_size;
+	unsigned long	rmr_regions_cnt;
+	unsigned long	rmr_src_addr[MAX_REAL_MEM_REGIONS];
+	unsigned long	rmr_src_size[MAX_REAL_MEM_REGIONS];
+
+	/*
+	 * Maximum size supported by firmware to copy from source to
+	 * destination address per entry.
+	 */
+	unsigned long	max_copy_size;
+
 	int		ibm_configure_kernel_dump;
 
 	unsigned long	fadump_enabled:1;
@@ -157,4 +172,14 @@ pseries_dt_scan_fadump(struct fw_dump *fadump_config, ulong node)
 }
 #endif
 
+#ifdef CONFIG_PPC_POWERNV
+extern int powernv_dt_scan_fadump(struct fw_dump *fadump_config, ulong node);
+#else
+static inline int
+powernv_dt_scan_fadump(struct fw_dump *fadump_config, ulong node)
+{
+	return 1;
+}
+#endif
+
 #endif /* __PPC64_FA_DUMP_INTERNAL_H__ */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 703a350..0d106b5 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,6 +6,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
+obj-$(CONFIG_FA_DUMP)	+= powernv_fadump.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3da30c2..20bbb9c 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -325,3 +325,4 @@ OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
 OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
 OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
+OPAL_CALL(opal_configure_fadump,		OPAL_CONFIGURE_FADUMP);
diff --git a/arch/powerpc/platforms/powernv/powernv_fadump.c b/arch/powerpc/platforms/powernv/powernv_fadump.c
new file mode 100644
index 0000000..6d4b515
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/powernv_fadump.c
@@ -0,0 +1,337 @@
+/*
+ * Firmware-Assisted Dump support on POWERNV platform.
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
+#undef DEBUG
+#define pr_fmt(fmt) "powernv fadump: " fmt
+
+#include <linux/string.h>
+#include <linux/memblock.h>
+#include <linux/bug.h>
+#include <linux/seq_file.h>
+#include <linux/crash_dump.h>
+
+#include <asm/page.h>
+#include <asm/prom.h>
+#include <asm/opal.h>
+#include <asm/fadump.h>
+
+#include "../../kernel/fadump_internal.h"
+#include "powernv_fadump.h"
+
+static struct powernv_fadump_mem_struct fdm;
+static const struct powernv_fadump_mem_struct *fdm_active;
+unsigned long fdm_actual_size;
+
+static void update_fadump_config(struct fw_dump *fadump_conf,
+				 const struct powernv_fadump_mem_struct *fdm)
+{
+	unsigned long base, size, last_end;
+	int section_cnt = be16_to_cpu(fdm->section_count);
+	int unused_sections  = (POWERNV_MAX_SECTIONS - section_cnt);
+	int i, j;
+
+	pr_debug("section_cnt: %d\n", section_cnt);
+	WARN_ON(unused_sections < 0);
+	fdm_actual_size = sizeof(*fdm) -
+		(unused_sections * sizeof(struct powernv_fadump_section));
+
+	/*
+	 * The first real memory region entry is the real memory
+	 * regions destination address.
+	 */
+	fadump_conf->rmr_destination_addr = 0;
+	for (i = 0; i < section_cnt; i++) {
+		if (fdm->section[i].src_type ==
+		    POWERNV_FADUMP_REAL_MODE_REGION) {
+			fadump_conf->rmr_destination_addr =
+				be64_to_cpu(fdm->section[i].dest_addr);
+			break;
+		}
+	}
+	pr_debug("Destination address of real memory regions: %#016lx\n",
+		 fadump_conf->rmr_destination_addr);
+
+	if (fadump_conf->dump_active) {
+		j = 0;
+		last_end = 0;
+		fadump_conf->rmr_source_len = 0;
+		fadump_conf->boot_memory_hole_size = 0;
+		for (i = 0; i < section_cnt; i++) {
+			if (fdm->section[i].src_type ==
+			    POWERNV_FADUMP_REAL_MODE_REGION) {
+				base = be64_to_cpu(fdm->section[i].src_addr);
+				size = be64_to_cpu(fdm->section[i].src_size);
+				pr_debug("%d. RMR base: 0x%lx, size: 0x%lx\n",
+					 (i + 1), base, size);
+
+				fadump_conf->rmr_src_addr[j] = base;
+				fadump_conf->rmr_src_size[j] = size;
+				fadump_conf->rmr_source_len += size;
+
+				if (base > last_end) {
+					fadump_conf->boot_memory_hole_size +=
+						(base - last_end);
+				}
+
+				last_end = base + size;
+				j++;
+			}
+		}
+		fadump_conf->rmr_regions_cnt = j;
+		pr_debug("Real memory regions count: %lu\n",
+			 fadump_conf->rmr_regions_cnt);
+	}
+}
+
+static ulong powernv_init_fadump_mem_struct(struct fw_dump *fadump_conf,
+					    ulong addr)
+{
+	int i, section_cnt = 0;
+
+	fdm.section_size = cpu_to_be16(sizeof(struct powernv_fadump_section));
+
+	/* RMA region sections */
+	for (i = 0; i < fadump_conf->rmr_regions_cnt; i++) {
+		fdm.section[RMR_REGION_INPUT_IDX + i].src_type  =
+			POWERNV_FADUMP_REAL_MODE_REGION;
+		fdm.section[RMR_REGION_INPUT_IDX + i].src_addr  =
+			cpu_to_be64(fadump_conf->rmr_src_addr[i]);
+		fdm.section[RMR_REGION_INPUT_IDX + i].dest_addr =
+			cpu_to_be64(addr);
+		fdm.section[RMR_REGION_INPUT_IDX + i].src_size  =
+			fdm.section[RMR_REGION_INPUT_IDX + i].dest_size =
+			cpu_to_be64(fadump_conf->rmr_src_size[i]);
+
+		section_cnt++;
+		addr += fadump_conf->rmr_src_size[i];
+	}
+
+	fdm.section_count = cpu_to_be16(section_cnt);
+	update_fadump_config(fadump_conf, &fdm);
+
+	return addr;
+}
+
+static int powernv_register_fadump(struct fw_dump *fadump_conf)
+{
+	int rc, err = -EIO;
+
+	rc = opal_configure_fadump(FADUMP_REGISTER, &fdm, fdm_actual_size);
+	switch (rc) {
+	default:
+		pr_err("Failed to register. Unknown Error(%d).\n", rc);
+		break;
+	case OPAL_UNSUPPORTED:
+		pr_err("Support not available.\n");
+		fadump_conf->fadump_supported = 0;
+		fadump_conf->fadump_enabled = 0;
+		break;
+	case OPAL_INTERNAL_ERROR:
+		pr_err("Failed to register. Hardware Error(%d).\n", rc);
+		break;
+	case OPAL_PARAMETER:
+		pr_err("Failed to register. Parameter Error(%d).\n", rc);
+		break;
+	case OPAL_PERMISSION:
+		pr_err("Already registered!\n");
+		fadump_conf->dump_registered = 1;
+		err = -EEXIST;
+		break;
+	case OPAL_SUCCESS:
+		pr_err("Registration is successful!\n");
+		fadump_conf->dump_registered = 1;
+		err = 0;
+		break;
+	}
+
+	return err;
+}
+
+static int powernv_unregister_fadump(struct fw_dump *fadump_conf)
+{
+	int rc;
+
+	rc = opal_configure_fadump(FADUMP_UNREGISTER, &fdm, fdm_actual_size);
+	if (rc) {
+		pr_err("Failed to un-register - unexpected Error(%d).\n", rc);
+		return -EIO;
+	}
+
+	fadump_conf->dump_registered = 0;
+	return 0;
+}
+
+static ulong powernv_get_preserv_area_start(struct fw_dump *fadump_conf)
+{
+	return fadump_conf->rmr_destination_addr;
+}
+
+static ulong powernv_get_meta_area_start(struct fw_dump *fadump_conf)
+{
+	return (fadump_conf->rmr_destination_addr +
+		fadump_conf->rmr_source_len);
+}
+
+static int powernv_invalidate_fadump(struct fw_dump *fadump_conf)
+{
+	int rc;
+
+	rc = opal_configure_fadump(FADUMP_INVALIDATE, (void *)fdm_active,
+				   fdm_actual_size);
+	if (rc) {
+		pr_err("Failed to invalidate - unexpected Error(%d).\n", rc);
+		return -EIO;
+	}
+
+	fadump_conf->dump_active = 0;
+	fdm_active = NULL;
+	return 0;
+}
+
+/*
+ * Read CPU state dump data and convert it into ELF notes.
+ * The CPU dump starts with magic number "REGSAVE". NumCpusOffset should be
+ * used to access the data to allow for additional fields to be added without
+ * affecting compatibility. Each list of registers for a CPU starts with
+ * "CPUSTRT" and ends with "CPUEND". Each register entry is of 16 bytes,
+ * 8 Byte ASCII identifier and 8 Byte register value. The register entry
+ * with identifier "CPUSTRT" and "CPUEND" contains 4 byte cpu id as part
+ * of register value. For more details refer to PAPR document.
+ *
+ * Only for the crashing cpu we ignore the CPU dump data and get exact
+ * state from fadump crash info structure populated by first kernel at the
+ * time of crash.
+ */
+static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
+{
+	u32 num_cpus = 1, *note_buf;
+	struct fadump_crash_info_header *fdh = NULL;
+
+	/* Allocate buffer to hold cpu crash notes. */
+	fadump_conf->cpu_notes_buf_size = num_cpus * sizeof(note_buf_t);
+	fadump_conf->cpu_notes_buf_size =
+		PAGE_ALIGN(fadump_conf->cpu_notes_buf_size);
+	note_buf = fadump_cpu_notes_buf_alloc(fadump_conf->cpu_notes_buf_size);
+	if (!note_buf) {
+		pr_err("Failed to allocate 0x%lx bytes for cpu notes buffer\n",
+		       fadump_conf->cpu_notes_buf_size);
+		return -ENOMEM;
+	}
+	fadump_conf->cpu_notes_buf = __pa(note_buf);
+
+	pr_debug("Allocated buffer for cpu notes of size %ld at %p\n",
+		 (num_cpus * sizeof(note_buf_t)), note_buf);
+
+	if (fadump_conf->fadumphdr_addr)
+		fdh = __va(fadump_conf->fadumphdr_addr);
+
+	if (fdh && (fdh->crashing_cpu != CPU_UNKNOWN)) {
+		note_buf = fadump_regs_to_elf_notes(note_buf, &(fdh->regs));
+		final_note(note_buf);
+
+		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
+			 fdh->elfcorehdr_addr);
+		fadump_update_elfcore_header(fadump_conf,
+					     __va(fdh->elfcorehdr_addr));
+	}
+
+	return 0;
+}
+
+static int __init powernv_process_fadump(struct fw_dump *fadump_conf)
+{
+	struct fadump_crash_info_header *fdh;
+	int rc = 0;
+
+	if (!fdm_active || !fadump_conf->fadumphdr_addr)
+		return -EINVAL;
+
+	/* Validate the fadump crash info header */
+	fdh = __va(fadump_conf->fadumphdr_addr);
+	if (fdh->magic_number != FADUMP_CRASH_INFO_MAGIC) {
+		pr_err("Crash info header is not valid.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * TODO: To build cpu notes, find a way to map PIR to logical id.
+	 *       Also, we may need different method for pseries and powernv.
+	 *       The currently booted kernel could have a different PIR to
+	 *       logical id mapping. So, try saving info of previous kernel's
+	 *       paca to get the right PIR to logical id mapping.
+	 */
+	rc = fadump_build_cpu_notes(fadump_conf);
+	if (rc)
+		return rc;
+
+	/*
+	 * We are done validating dump info and elfcore header is now ready
+	 * to be exported. set elfcorehdr_addr so that vmcore module will
+	 * export the elfcore header through '/proc/vmcore'.
+	 */
+	elfcorehdr_addr = fdh->elfcorehdr_addr;
+
+	return rc;
+}
+
+static void powernv_fadump_region_show(struct fw_dump *fadump_conf,
+				       struct seq_file *m)
+{
+}
+
+static void powernv_crash_fadump(const char *msg)
+{
+	int rc;
+
+	rc = opal_cec_reboot2(OPAL_REBOOT_MPIPL, msg);
+	if (rc == OPAL_UNSUPPORTED)
+		pr_emerg("Reboot type %d not supported\n", OPAL_REBOOT_MPIPL);
+	else if (rc == OPAL_HARDWARE)
+		pr_emerg("No backend support for MPIPL!\n");
+}
+
+static struct fadump_ops_t powernv_fadump_ops = {
+	.init_fadump_mem_struct	= powernv_init_fadump_mem_struct,
+	.register_fadump	= powernv_register_fadump,
+	.unregister_fadump	= powernv_unregister_fadump,
+	.get_preserv_area_start	= powernv_get_preserv_area_start,
+	.get_meta_area_start	= powernv_get_meta_area_start,
+	.invalidate_fadump	= powernv_invalidate_fadump,
+	.process_fadump		= powernv_process_fadump,
+	.fadump_region_show	= powernv_fadump_region_show,
+	.crash_fadump		= powernv_crash_fadump,
+};
+
+int __init powernv_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
+{
+	/*
+	 * Firmware currently supports only 32-bit value for size,
+	 * align it to 1MB size.
+	 */
+	fadump_conf->max_copy_size = _ALIGN_DOWN(0xFFFFFFFF, (1 << 20));
+
+	/*
+	 * Check if dump has been initiated on last reboot.
+	 */
+	fdm_active = of_get_flat_dt_prop(node, "result-table", NULL);
+	if (fdm_active) {
+		pr_info("Firmware-assisted dump is active.\n");
+		fadump_conf->dump_active = 1;
+		update_fadump_config(fadump_conf, (void *)__pa(fdm_active));
+	}
+
+	fadump_ops = &powernv_fadump_ops;
+	fadump_conf->fadump_supported = 1;
+	fadump_conf->fadump_platform = FADUMP_PLATFORM_POWERNV;
+
+	return 1;
+}
diff --git a/arch/powerpc/platforms/powernv/powernv_fadump.h b/arch/powerpc/platforms/powernv/powernv_fadump.h
new file mode 100644
index 0000000..224a142
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/powernv_fadump.h
@@ -0,0 +1,63 @@
+/*
+ * Firmware-Assisted Dump support on POWERNV platform.
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
+#ifndef __PPC64_POWERNV_FA_DUMP_H__
+#define __PPC64_POWERNV_FA_DUMP_H__
+
+#define POWERNV_FADUMP_CPU_STATE_DATA	0x0000
+/* OPAL : 0x01 – 0x39 */
+#define POWERNV_FADUMP_OPAL_REGION	0x0001
+/* Firmware/SMF : 0x40 – 0x79 */
+#define POWERNV_FADUMP_FW_REGION	0x0040
+/* Kernel memory region : 0x80 – 0xb9 */
+#define POWERNV_FADUMP_REAL_MODE_REGION	0x0080
+/* Reserved for future use : 0xc0 – 0xff */
+#define POWERNV_FADUMP_RESERVED_REGION	0x00c0
+
+enum powernv_fadump_section_types {
+	CPU_STATE_TYPE		= 0,
+	OPAL_REGION_TYPE,
+	FW_REGION_TYPE,
+	RMR_REGION_TYPE,
+	POWERNV_SECTIONS
+};
+
+/* Starting index of RMR region in dump sections while registering */
+#define RMR_REGION_INPUT_IDX		0
+
+#define POWERNV_MAX_SECTIONS		(POWERNV_SECTIONS + \
+					 MAX_REAL_MEM_REGIONS - 1)
+
+/* Kernel Dump section info */
+struct powernv_fadump_section {
+	u8	src_type;
+	u8	reserved[7];
+	__be64	src_addr;
+	__be64	src_size;
+	__be64	dest_addr;
+	__be64	dest_size;
+};
+
+/*
+ * Firmware Assisted dump memory structure. This structure is required for
+ * registering future kernel dump with power firmware through opal call.
+ */
+struct powernv_fadump_mem_struct {
+
+	__be16	section_size;		/*sizeof(struct fadump_section) */
+	__be16	section_count;		/* number of sections */
+	__be32	reserved;
+
+	struct powernv_fadump_section	section[POWERNV_MAX_SECTIONS];
+};
+
+#endif /* __PPC64_POWERNV_FA_DUMP_H__ */
diff --git a/arch/powerpc/platforms/pseries/pseries_fadump.c b/arch/powerpc/platforms/pseries/pseries_fadump.c
index ac54501..ef7e59a 100644
--- a/arch/powerpc/platforms/pseries/pseries_fadump.c
+++ b/arch/powerpc/platforms/pseries/pseries_fadump.c
@@ -40,8 +40,12 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 		be64_to_cpu(fdm->rmr_region.destination_address);
 
 	if (fadump_conf->dump_active) {
-		fadump_conf->rmr_source_len =
-			be64_to_cpu(fdm->rmr_region.source_len);
+		fadump_conf->rmr_src_addr[0] =
+			be64_to_cpu(fdm->rmr_region.source_address);
+		fadump_conf->rmr_src_size[0] = be64_to_cpu(fdm->rmr_region.source_len);
+		fadump_conf->rmr_regions_cnt = 1;
+		fadump_conf->rmr_source_len = fadump_conf->rmr_src_size[0];
+		fadump_conf->boot_memory_hole_size = 0;
 	}
 }
 
