Return-Path: <srs0=h10r=hj=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S3gJ4QPPzF25F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:04:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40S3gJ3rn5z8tKg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:04:28 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40S3gJ095Gz9s5H
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 15:04:27 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3K4xBRr120416
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 01:04:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hf42vurq1-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 01:04:25 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 20 Apr 2018 06:04:23 +0100
Subject: [PATCH v4 1/7] powerpc/fadump: Move the metadata region to start of
 the reserved area.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 20 Apr 2018 10:34:18 +0530
In-Reply-To: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152420065839.31037.9373191008433546810.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Currently the metadata region that holds crash info structure and ELF core
header is placed towards the end of reserved memory area. This patch places
it at the beginning of the reserved memory area. It also introduces
additional dump section called metadata section to communicate location
of metadata region to 2nd kernel. This patch also maintains the
compatibility between production/capture kernels irrespective of their
kernel versions. Both combination older/newer and newer/older works fine.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h |    9 ++
 arch/powerpc/kernel/fadump.c      |  177 ++++++++++++++++++++++++++++++++-----
 2 files changed, 160 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010af600..03d5140a6f0d 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -53,6 +53,11 @@
 #define FADUMP_HPTE_REGION	0x0002
 #define FADUMP_REAL_MODE_REGION	0x0011
 
+/* User define dump sections.
+ * Per PAPR: 0x0100 - 0xFFFF OS defined source types
+ */
+#define FADUMP_METADATA_REGION	0x0100
+
 /* Dump request flag */
 #define FADUMP_REQUEST_FLAG	0x00000001
 
@@ -61,6 +66,9 @@
 #define FADUMP_UNREGISTER	2
 #define FADUMP_INVALIDATE	3
 
+/* Number of dump sections requested by kernel */
+#define FADUMP_NUM_SECTIONS	4
+
 /* Dump status flag */
 #define FADUMP_ERROR_FLAG	0x2000
 
@@ -119,6 +127,7 @@ struct fadump_mem_struct {
 	struct fadump_section		cpu_state_data;
 	struct fadump_section		hpte_region;
 	struct fadump_section		rmr_region;
+	struct fadump_section		metadata_region;
 };
 
 /* Firmware-assisted dump configuration details. */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8ceabef40d3d..43bfa535d0ea 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -188,17 +188,40 @@ static void fadump_show_config(void)
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
 
+	/* Skip the fadump metadata area. */
+	metadata_base = addr;
+	metadata_size = get_fadump_metadata_size();
+	addr += metadata_size;
+
 	memset(fdm, 0, sizeof(struct fadump_mem_struct));
 	addr = addr & PAGE_MASK;
 
 	fdm->header.dump_format_version = cpu_to_be32(0x00000001);
-	fdm->header.dump_num_sections = cpu_to_be16(3);
 	fdm->header.dump_status_flag = 0;
 	fdm->header.offset_first_dump_section =
 		cpu_to_be32((u32)offsetof(struct fadump_mem_struct, cpu_state_data));
@@ -222,6 +245,7 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	fdm->cpu_state_data.source_address = 0;
 	fdm->cpu_state_data.source_len = cpu_to_be64(fw_dump.cpu_state_data_size);
 	fdm->cpu_state_data.destination_address = cpu_to_be64(addr);
+	num_sections++;
 	addr += fw_dump.cpu_state_data_size;
 
 	/* hpte region section */
@@ -230,6 +254,7 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	fdm->hpte_region.source_address = 0;
 	fdm->hpte_region.source_len = cpu_to_be64(fw_dump.hpte_region_size);
 	fdm->hpte_region.destination_address = cpu_to_be64(addr);
+	num_sections++;
 	addr += fw_dump.hpte_region_size;
 
 	/* RMA region section */
@@ -238,8 +263,27 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	fdm->rmr_region.source_address = cpu_to_be64(RMA_START);
 	fdm->rmr_region.source_len = cpu_to_be64(fw_dump.boot_memory_size);
 	fdm->rmr_region.destination_address = cpu_to_be64(addr);
+	num_sections++;
 	addr += fw_dump.boot_memory_size;
 
+	/*
+	 * fadump metadata section.
+	 * This section will help 2nd kernel to locate the metadata base
+	 * looking at source_address. This entry will also copy the metadata
+	 * content after the RMR region dump data, so that old kernels that
+	 * does not support this section can still find the metadata to
+	 * process fadump.
+	 */
+	fdm->metadata_region.request_flag = cpu_to_be32(FADUMP_REQUEST_FLAG);
+	fdm->metadata_region.source_data_type =
+					cpu_to_be16(FADUMP_METADATA_REGION);
+	fdm->metadata_region.source_address = cpu_to_be64(metadata_base);
+	fdm->metadata_region.source_len = cpu_to_be64(metadata_size);
+	fdm->metadata_region.destination_address = cpu_to_be64(addr);
+	num_sections++;
+
+	fdm->header.dump_num_sections = cpu_to_be16(num_sections);
+	BUILD_BUG_ON(num_sections != FADUMP_NUM_SECTIONS);
 	return addr;
 }
 
@@ -325,12 +369,12 @@ static unsigned long get_fadump_area_size(void)
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
+	/* Add it twice. We will ask platform to move metadata contents
+	 * at rmr_region.destination_address + source_len, so that old
+	 * kernels also can get metadata to process fadump successfully.
+	 */
+	size += get_fadump_metadata_size();
 	size = PAGE_ALIGN(size);
 	return size;
 }
@@ -355,6 +399,35 @@ static void __init fadump_reserve_crash_area(unsigned long base,
 	}
 }
 
+static inline unsigned long get_fadump_metadata_base(
+			const struct fadump_mem_struct *fdm)
+{
+	const struct fadump_section *dump_section;
+	uint16_t num_sections;
+
+	/* Scan through all dump sections to find out metadata section. */
+	dump_section = &fdm->cpu_state_data;
+	num_sections = be16_to_cpu(fdm->header.dump_num_sections);
+
+	while (num_sections--) {
+		uint16_t type = be16_to_cpu(dump_section->source_data_type);
+		if (type == FADUMP_METADATA_REGION)
+			return be64_to_cpu(dump_section->source_address);
+
+		dump_section++;
+	}
+
+	/*
+	 * Support the older kernel which does not contain metadata
+	 * dump section. We end up here only when fadump is active and
+	 * the previously crashed kernel is old kernel which had metadata
+	 * section at the top of the reserved memory.
+	 */
+	BUG_ON(fw_dump.dump_active == 0);
+	return be64_to_cpu(fdm->rmr_region.destination_address) +
+				be64_to_cpu(fdm->rmr_region.source_len);
+}
+
 int __init fadump_reserve_mem(void)
 {
 	unsigned long base, size, memory_boundary;
@@ -420,9 +493,9 @@ int __init fadump_reserve_mem(void)
 		size = memory_boundary - base;
 		fadump_reserve_crash_area(base, size);
 
-		fw_dump.fadumphdr_addr =
-				be64_to_cpu(fdm_active->rmr_region.destination_address) +
-				be64_to_cpu(fdm_active->rmr_region.source_len);
+		pr_info("Number of kernel Dump sections: %d\n",
+			be16_to_cpu(fdm_active->header.dump_num_sections));
+		fw_dump.fadumphdr_addr = get_fadump_metadata_base(fdm_active);
 		pr_debug("fadumphdr_addr = %p\n",
 				(void *) fw_dump.fadumphdr_addr);
 	} else {
@@ -821,6 +894,38 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 
 }
 
+static int validate_dump(const struct fadump_mem_struct *fdm_active)
+{
+	const struct fadump_section *dump_section;
+	uint16_t num_sections = 0;
+	int rc = 0;
+
+	num_sections = be16_to_cpu(fdm_active->header.dump_num_sections);
+	dump_section = &fdm_active->cpu_state_data;
+
+	if ((be16_to_cpu(fdm_active->header.dump_status_flag)
+						== FADUMP_ERROR_FLAG)) {
+		pr_err("Error occured while taking a dump by platform\n");
+		rc = -EINVAL;
+	}
+
+	/* Print Section type and error flags for failed dump section. */
+	while (num_sections--) {
+		if (dump_section->error_flags != 0 ||
+		(dump_section->source_len != dump_section->bytes_dumped)) {
+			pr_err("Section: %04x, Error flag: %04x, "
+				"Bytes Req: %llx, Bytes Dumped: %llx\n",
+				be16_to_cpu(dump_section->source_data_type),
+				be16_to_cpu(dump_section->error_flags),
+				be64_to_cpu(dump_section->source_len),
+				be64_to_cpu(dump_section->bytes_dumped));
+			rc = -EINVAL;
+		}
+		dump_section++;
+	}
+	return rc;
+}
+
 /*
  * Validate and process the dump data stored by firmware before exporting
  * it through '/proc/vmcore'.
@@ -834,17 +939,10 @@ static int __init process_fadump(const struct fadump_mem_struct *fdm_active)
 		return -EINVAL;
 
 	/* Check if the dump data is valid. */
-	if ((be16_to_cpu(fdm_active->header.dump_status_flag) == FADUMP_ERROR_FLAG) ||
-			(fdm_active->cpu_state_data.error_flags != 0) ||
-			(fdm_active->rmr_region.error_flags != 0)) {
+	rc = validate_dump(fdm_active);
+	if (rc) {
 		printk(KERN_ERR "Dump taken by platform is not valid\n");
-		return -EINVAL;
-	}
-	if ((fdm_active->rmr_region.bytes_dumped !=
-			fdm_active->rmr_region.source_len) ||
-			!fdm_active->cpu_state_data.bytes_dumped) {
-		printk(KERN_ERR "Dump taken by platform is incomplete\n");
-		return -EINVAL;
+		return rc;
 	}
 
 	/* Validate the fadump crash info header */
@@ -1107,7 +1205,7 @@ static int register_fadump(void)
 
 	fadump_setup_crash_memory_ranges();
 
-	addr = be64_to_cpu(fdm.rmr_region.destination_address) + be64_to_cpu(fdm.rmr_region.source_len);
+	addr = be64_to_cpu(fdm.metadata_region.source_address);
 	/* Initialize fadump crash info header. */
 	addr = init_fadump_header(addr);
 	vaddr = __va(addr);
@@ -1146,7 +1244,7 @@ static int fadump_unregister_dump(struct fadump_mem_struct *fdm)
 	return 0;
 }
 
-static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
+static int fadump_invalidate_dump(const struct fadump_mem_struct *fdm)
 {
 	int rc = 0;
 	unsigned int wait_time;
@@ -1177,9 +1275,7 @@ void fadump_cleanup(void)
 {
 	/* Invalidate the registration only if dump is active. */
 	if (fw_dump.dump_active) {
-		init_fadump_mem_struct(&fdm,
-			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
-		fadump_invalidate_dump(&fdm);
+		fadump_invalidate_dump(fdm_active);
 	}
 }
 
@@ -1250,6 +1346,35 @@ static void fadump_release_memory(unsigned long begin, unsigned long end)
 		fadump_release_reserved_area(begin, end);
 }
 
+static inline unsigned long get_fadump_prev_mstart(
+			const struct fadump_mem_struct *fdm)
+{
+	const struct fadump_section *dump_section;
+	uint16_t num_sections;
+
+	/* This function is called only when fadump is active. */
+	BUG_ON(fw_dump.dump_active == 0);
+
+	/* Scan through all dump sections to find out metadata section. */
+	dump_section = &fdm->cpu_state_data;
+	num_sections = be16_to_cpu(fdm->header.dump_num_sections);
+
+	while (num_sections--) {
+		uint16_t type = be16_to_cpu(dump_section->source_data_type);
+		if (type == FADUMP_METADATA_REGION)
+			return be64_to_cpu(dump_section->source_address);
+
+		dump_section++;
+	}
+
+	/*
+	 * Support the older kernel which does not contain metadata
+	 * dump section. For older kernel reserved memory start is
+	 * at cpu_state_data.destination_address.
+	 */
+	return be64_to_cpu(fdm->cpu_state_data.destination_address);
+}
+
 static void fadump_invalidate_release_mem(void)
 {
 	unsigned long reserved_area_start, reserved_area_end;
@@ -1261,7 +1386,7 @@ static void fadump_invalidate_release_mem(void)
 		return;
 	}
 
-	destination_address = be64_to_cpu(fdm_active->cpu_state_data.destination_address);
+	destination_address = get_fadump_prev_mstart(fdm_active);
 	fadump_cleanup();
 	mutex_unlock(&fadump_mutex);
 
