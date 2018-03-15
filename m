Return-Path: <srs0=rxfn=gf=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401ztR29KhzF0kg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 17:57:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 401ztR1TNxz8tCx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 17:57:35 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 401ztQ4nX5z9sSW
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2018 17:57:34 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2F6udDe095233
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2018 02:57:32 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gqe4abmef-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2018 02:57:32 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 15 Mar 2018 06:57:29 -0000
Subject: [RFC PATCH] powerpc/fadump: Reservationless firmware assisted dump
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 kernelfans@gmail.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 12:27:24 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152109702073.29801.12781907311749954095.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

One of the primary issues with Firmware Assisted Dump (fadump) on Power
is that it needs a large amount of memory to be reserved. On large
systems with TeraBytes of memory, this reservation can be quite
significant.

In some cases, fadump fails if the memory reserved is insufficient, or
if the reserved memory was DLPAR hot-removed.

In the normal case, post reboot, the preserved memory is filtered to
extract only relevant areas of interest using the makedumpfile tool.
While the tool provides flexibility to determine what needs to be part
of the dump and what memory to filter out, all supported distributions
default this to "Capture only kernel data and nothing else".

We take advantage of this default and the Linux kernel's Contiguous
Memory Allocator (CMA) to fundamentally change the memory reservation
model for fadump. Fadump can now only capture kernel memory.

Instead of setting aside a significant chunk of memory nobody can use,
this patch uses CMA instead, to reserve a significant chunk of memory
that the kernel is prevented from using (due to MIGRATE_CMA), but
applications are free to use it.

Essentially, on a P9 LPAR with 2 cores, 8GB RAM and current upstream:
[root@zzxx-yy10 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           7557         193        6822          12         541        6725
Swap:          4095           0        4095

With this patch:
[root@zzxx-yy10 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           8133         194        7464          12         475        7338
Swap:          4095           0        4095

Changes made here are completely transparent to how fadump has
traditionally worked.

An additional advantage is that this mechanism is immune to DLPAR memory
remove (since the CMA memory cannot be removed).

Thanks to Aneesh Kumar and Anshuman Khandual for helping us understand
CMA and its usage.

TODO:
- Handle case where CMA reservation spans nodes.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |    3 +
 arch/powerpc/kernel/fadump.c      |  179 ++++++++++++++++++++++++++++++++-----
 2 files changed, 156 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010af600..776cba0baec4 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -119,6 +119,7 @@ struct fadump_mem_struct {
 	struct fadump_section		cpu_state_data;
 	struct fadump_section		hpte_region;
 	struct fadump_section		rmr_region;
+	struct fadump_section		metadata_region;
 };
 
 /* Firmware-assisted dump configuration details. */
@@ -141,6 +142,8 @@ struct fw_dump {
 	unsigned long	fadump_supported:1;
 	unsigned long	dump_active:1;
 	unsigned long	dump_registered:1;
+	/* flag to indicate fadump metadata area is cma allocated */
+	unsigned long	cma_alloc:1;
 };
 
 /*
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 3c2c2688918f..5ca0cb1b6028 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -34,6 +34,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/cma.h>
 
 #include <asm/debugfs.h>
 #include <asm/page.h>
@@ -45,11 +46,59 @@
 static struct fw_dump fw_dump;
 static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
+static struct cma *fadump_cma;
 
 static DEFINE_MUTEX(fadump_mutex);
 struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
 int crash_mem_ranges;
 
+/**
+ * fadump_cma_reserve() - reserve area for fadump memory reservation
+ *
+ * This function reserves memory from early allocator. It should be
+ * called by arch specific code once the memblock allocator
+ * has been activated.
+ */
+int __init fadump_cma_reserve(void)
+{
+	unsigned long long base, size;
+	int rc;
+
+	if (!fw_dump.fadump_enabled)
+		return 0;
+
+	base = fw_dump.reserve_dump_area_start;
+	size = fw_dump.reserve_dump_area_size;
+	pr_debug("Original reserve area base %ld, size %ld\n",
+				(unsigned long)base >> 20,
+				(unsigned long)size >> 20);
+	if (!size)
+		return 0;
+
+	printk("%s: reserving %ld MiB for firmware-assisted dump area\n"
+				, __func__, (unsigned long)size >> 20);
+	rc = cma_declare_contiguous(base, size, 0, 0, 0, false,
+						"fadump_cma", &fadump_cma);
+	if (rc) {
+		printk(KERN_ERR "fadump: Failed to reserve cma area for "
+				"firmware-assisted dump, %d\n", rc);
+		fw_dump.reserve_dump_area_size = 0;
+		return 0;
+	}
+	/*
+	 * So we now have cma area reserved for fadump. base may be different
+	 * from what we requested.
+	 */
+	fw_dump.reserve_dump_area_start = cma_get_base(fadump_cma);
+	fw_dump.reserve_dump_area_size = cma_get_size(fadump_cma);
+	printk("Reserved %ldMB cma area at %ldMB for firmware-assisted dump "
+			"(System RAM: %ldMB)\n",
+			(unsigned long)cma_get_size(fadump_cma) >> 20,
+			(unsigned long)cma_get_base(fadump_cma) >> 20,
+			(unsigned long)(memblock_phys_mem_size() >> 20));
+	return 1;
+}
+
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node,
 			const char *uname, int depth, void *data)
@@ -188,17 +237,42 @@ static void fadump_show_config(void)
 	pr_debug("Boot memory size  : %lx\n", fw_dump.boot_memory_size);
 }
 
+static unsigned long get_fadump_metadata_size(void)
+{
+	unsigned long size = 0;
+
+	size += sizeof(struct fadump_crash_info_header);
+	size += sizeof(struct elfhdr); /* ELF core header.*/
+	size += sizeof(struct elf_phdr); /* place holder for cpu notes */
+	/* Program headers for crash memory regions. */
+	size += sizeof(struct elf_phdr) * (memblock_num_regions(memory) + 2);
+
+	size = PAGE_ALIGN(size);
+	pr_debug("fadump Metadata size is %ld\n", size);
+	return size;
+}
+
 static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 				unsigned long addr)
 {
+	uint16_t num_sections = 0;
+	unsigned long metadata_base = 0;
+	unsigned long metadata_size = 0;
+
 	if (!fdm)
 		return 0;
 
+	if (fw_dump.cma_alloc) {
+		/* Skip the fadump metadata area. */
+		metadata_base = addr;
+		metadata_size = get_fadump_metadata_size();
+		addr += metadata_size;
+	}
+
 	memset(fdm, 0, sizeof(struct fadump_mem_struct));
 	addr = addr & PAGE_MASK;
 
 	fdm->header.dump_format_version = cpu_to_be32(0x00000001);
-	fdm->header.dump_num_sections = cpu_to_be16(3);
 	fdm->header.dump_status_flag = 0;
 	fdm->header.offset_first_dump_section =
 		cpu_to_be32((u32)offsetof(struct fadump_mem_struct, cpu_state_data));
@@ -222,6 +296,7 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	fdm->cpu_state_data.source_address = 0;
 	fdm->cpu_state_data.source_len = cpu_to_be64(fw_dump.cpu_state_data_size);
 	fdm->cpu_state_data.destination_address = cpu_to_be64(addr);
+	num_sections++;
 	addr += fw_dump.cpu_state_data_size;
 
 	/* hpte region section */
@@ -230,6 +305,7 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	fdm->hpte_region.source_address = 0;
 	fdm->hpte_region.source_len = cpu_to_be64(fw_dump.hpte_region_size);
 	fdm->hpte_region.destination_address = cpu_to_be64(addr);
+	num_sections++;
 	addr += fw_dump.hpte_region_size;
 
 	/* RMA region section */
@@ -238,8 +314,29 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	fdm->rmr_region.source_address = cpu_to_be64(RMA_START);
 	fdm->rmr_region.source_len = cpu_to_be64(fw_dump.boot_memory_size);
 	fdm->rmr_region.destination_address = cpu_to_be64(addr);
+	num_sections++;
 	addr += fw_dump.boot_memory_size;
 
+	if (!fw_dump.cma_alloc)
+		goto out;
+
+	/*
+	 * fadump metadata section.
+	 * Add entry with source len a zero. We are only intereseted in
+	 * source address which will help us to detect the location of
+	 * metadata area where faump header and elf core header is placed.
+	 */
+	fdm->metadata_region.request_flag = cpu_to_be32(FADUMP_REQUEST_FLAG);
+	fdm->metadata_region.source_data_type =
+					cpu_to_be16(FADUMP_REAL_MODE_REGION);
+	fdm->metadata_region.source_address = cpu_to_be64(metadata_base);
+	//fdm->metadata_region.source_len = cpu_to_be64(metadata_size);
+	fdm->metadata_region.source_len = 0;
+	fdm->metadata_region.destination_address = cpu_to_be64(addr);
+	num_sections++;
+
+out:
+	fdm->header.dump_num_sections = cpu_to_be16(num_sections);
 	return addr;
 }
 
@@ -325,16 +422,21 @@ static unsigned long get_fadump_area_size(void)
 	size += fw_dump.cpu_state_data_size;
 	size += fw_dump.hpte_region_size;
 	size += fw_dump.boot_memory_size;
-	size += sizeof(struct fadump_crash_info_header);
-	size += sizeof(struct elfhdr); /* ELF core header.*/
-	size += sizeof(struct elf_phdr); /* place holder for cpu notes */
-	/* Program headers for crash memory regions. */
-	size += sizeof(struct elf_phdr) * (memblock_num_regions(memory) + 2);
-
+	size += get_fadump_metadata_size();
 	size = PAGE_ALIGN(size);
 	return size;
 }
 
+static inline unsigned long get_fadump_metadata_base(
+			const struct fadump_mem_struct *fdm_active)
+{
+	if (be16_to_cpu(fdm_active->header.dump_num_sections) == 4)
+		return be64_to_cpu(fdm_active->metadata_region.source_address);
+
+	return (be64_to_cpu(fdm_active->rmr_region.destination_address) +
+			be64_to_cpu(fdm_active->rmr_region.source_len));
+}
+
 int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
@@ -395,11 +497,13 @@ int __init fadump_reserve_mem(void)
 				(unsigned long)(size >> 20),
 				(unsigned long)(base >> 20));
 
-		fw_dump.fadumphdr_addr =
-				be64_to_cpu(fdm_active->rmr_region.destination_address) +
-				be64_to_cpu(fdm_active->rmr_region.source_len);
+		pr_info("Number of kernel Dump sections: %d\n",
+			be16_to_cpu(fdm_active->header.dump_num_sections));
+		fw_dump.fadumphdr_addr = get_fadump_metadata_base(fdm_active);
 		pr_debug("fadumphdr_addr = %p\n",
 				(void *) fw_dump.fadumphdr_addr);
+		fw_dump.reserve_dump_area_start = base;
+		fw_dump.reserve_dump_area_size = size;
 	} else {
 		size = get_fadump_area_size();
 
@@ -416,21 +520,10 @@ int __init fadump_reserve_mem(void)
 			    !memblock_is_region_reserved(base, size))
 				break;
 		}
-		if ((base > (memory_boundary - size)) ||
-		    memblock_reserve(base, size)) {
-			pr_err("Failed to reserve memory\n");
-			return 0;
-		}
-
-		pr_info("Reserved %ldMB of memory at %ldMB for firmware-"
-			"assisted dump (System RAM: %ldMB)\n",
-			(unsigned long)(size >> 20),
-			(unsigned long)(base >> 20),
-			(unsigned long)(memblock_phys_mem_size() >> 20));
+		fw_dump.reserve_dump_area_start = base;
+		fw_dump.reserve_dump_area_size = size;
+		return fadump_cma_reserve();
 	}
-
-	fw_dump.reserve_dump_area_start = base;
-	fw_dump.reserve_dump_area_size = size;
 	return 1;
 }
 
@@ -1068,6 +1161,30 @@ static unsigned long init_fadump_header(unsigned long addr)
 	return addr;
 }
 
+static unsigned long allocate_metadata_area(void)
+{
+	int nr_pages;
+	unsigned long size;
+	struct page *page = NULL;
+
+	/* If fadump_cma->count == 0 means cma activation has failed. */
+	if (!cma_get_size(fadump_cma))
+		return 0;
+
+	size = get_fadump_metadata_size();
+	nr_pages = ALIGN(size, PAGE_SIZE) >> PAGE_SHIFT;
+	printk("Fadump metadata size = %ld (nr_pages = %d)\n", size, nr_pages);
+
+	page = cma_alloc(fadump_cma, nr_pages, 0, GFP_KERNEL);
+	if (page) {
+		pr_debug("Allocated fadump metadata area at %ldMB (cma)\n",
+				(unsigned long)page_to_phys(page) >> 20);
+		fw_dump.cma_alloc = 1;
+		return page_to_phys(page);
+	}
+	return 0;
+}
+
 static int register_fadump(void)
 {
 	unsigned long addr;
@@ -1082,7 +1199,12 @@ static int register_fadump(void)
 
 	fadump_setup_crash_memory_ranges();
 
-	addr = be64_to_cpu(fdm.rmr_region.destination_address) + be64_to_cpu(fdm.rmr_region.source_len);
+	if (fw_dump.cma_alloc)
+		addr = fw_dump.reserve_dump_area_start;
+	else
+		addr = be64_to_cpu(fdm.rmr_region.destination_address)
+				+ be64_to_cpu(fdm.rmr_region.source_len);
+
 	/* Initialize fadump crash info header. */
 	addr = init_fadump_header(addr);
 	vaddr = __va(addr);
@@ -1490,8 +1612,13 @@ int __init setup_fadump(void)
 			fadump_invalidate_release_mem();
 	}
 	/* Initialize the kernel dump memory structure for FAD registration. */
-	else if (fw_dump.reserve_dump_area_size)
+	else if (fw_dump.reserve_dump_area_size) {
+		/* By this time cma area has been activated. Allocate memory
+		 * for metadata from cma region.
+		 */
+		allocate_metadata_area();
 		init_fadump_mem_struct(&fdm, fw_dump.reserve_dump_area_start);
+	}
 	fadump_init_files();
 
 	return 1;
