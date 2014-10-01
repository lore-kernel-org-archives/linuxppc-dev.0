Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0803F1A040E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:02:38 +1000 (EST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D12EC140174
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2014 17:02:37 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:02:37 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8CC132CE8047
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2014 17:02:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9174R6g34209872
 for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2014 17:04:27 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9172Y4l024222
 for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2014 17:02:35 +1000
Subject: [PATCH v2] fadump: fix endianess issues in firmware assisted dump
 handling
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 01 Oct 2014 12:32:30 +0530
Message-ID: <20141001070230.17401.59316.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Firmware-assisted dump (fadump) kernel code is not LE compliant. The
below patch tries to fix this issue. Tested this patch with upstream
kernel. Did some sanity testing for the  LE fadump vmcore generated.
Below output shows crash tool successfully opening LE fadump vmcore.

	# crash vmlinux vmcore

	crash 7.0.5
	Copyright (C) 2002-2014  Red Hat, Inc.
	Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
	Copyright (C) 1999-2006  Hewlett-Packard Co
	Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
	Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
	Copyright (C) 2005, 2011  NEC Corporation
	Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
	Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
	This program is free software, covered by the GNU General Public License,
	and you are welcome to change it and/or distribute copies of it under
	certain conditions.  Enter "help copying" to see the conditions.
	This program has absolutely no warranty.  Enter "help warranty" for details.

	crash: vmlinux: no .gnu_debuglink section
	GNU gdb (GDB) 7.6
	Copyright (C) 2013 Free Software Foundation, Inc.
	License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
	This is free software: you are free to change and redistribute it.
	There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
	and "show warranty" for details.
	This GDB was configured as "powerpc64le-unknown-linux-gnu"...

	      KERNEL: vmlinux
	    DUMPFILE: vmcore
		CPUS: 16
		DATE: Wed Dec 31 19:00:00 1969
	      UPTIME: 00:03:28
	LOAD AVERAGE: 0.46, 0.86, 0.41
	       TASKS: 268
	    NODENAME: linux-dhr2
	     RELEASE: 3.17.0-rc5-7-default
	     VERSION: #6 SMP Tue Sep 30 01:06:34 EDT 2014
	     MACHINE: ppc64le  (4116 Mhz)
	      MEMORY: 40 GB
	       PANIC: "Oops: Kernel access of bad area, sig: 11 [#1]" (check log for details)
		 PID: 6223
	     COMMAND: "bash"
		TASK: c0000009661b2500  [THREAD_INFO: c000000967ac0000]
		 CPU: 2
	       STATE: TASK_RUNNING (PANIC)

	crash>

Changes in v2:
1. Addressed casting related warnings.
2. Elaborated on why exceptions should not be changed to big endian during fadump boot.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h     |   52 ++++++++-------
 arch/powerpc/kernel/fadump.c          |  114 +++++++++++++++++----------------
 arch/powerpc/platforms/pseries/lpar.c |   15 ++++
 3 files changed, 96 insertions(+), 85 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index a677456..493e72f 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -70,39 +70,39 @@
 #define CPU_UNKNOWN		(~((u32)0))
 
 /* Utility macros */
-#define SKIP_TO_NEXT_CPU(reg_entry)			\
-({							\
-	while (reg_entry->reg_id != REG_ID("CPUEND"))	\
-		reg_entry++;				\
-	reg_entry++;					\
+#define SKIP_TO_NEXT_CPU(reg_entry)					\
+({									\
+	while (be64_to_cpu(reg_entry->reg_id) != REG_ID("CPUEND"))	\
+		reg_entry++;						\
+	reg_entry++;							\
 })
 
 /* Kernel Dump section info */
 struct fadump_section {
-	u32	request_flag;
-	u16	source_data_type;
-	u16	error_flags;
-	u64	source_address;
-	u64	source_len;
-	u64	bytes_dumped;
-	u64	destination_address;
+	__be32	request_flag;
+	__be16	source_data_type;
+	__be16	error_flags;
+	__be64	source_address;
+	__be64	source_len;
+	__be64	bytes_dumped;
+	__be64	destination_address;
 };
 
 /* ibm,configure-kernel-dump header. */
 struct fadump_section_header {
-	u32	dump_format_version;
-	u16	dump_num_sections;
-	u16	dump_status_flag;
-	u32	offset_first_dump_section;
+	__be32	dump_format_version;
+	__be16	dump_num_sections;
+	__be16	dump_status_flag;
+	__be32	offset_first_dump_section;
 
 	/* Fields for disk dump option. */
-	u32	dd_block_size;
-	u64	dd_block_offset;
-	u64	dd_num_blocks;
-	u32	dd_offset_disk_path;
+	__be32	dd_block_size;
+	__be64	dd_block_offset;
+	__be64	dd_num_blocks;
+	__be32	dd_offset_disk_path;
 
 	/* Maximum time allowed to prevent an automatic dump-reboot. */
-	u32	max_time_auto;
+	__be32	max_time_auto;
 };
 
 /*
@@ -174,15 +174,15 @@ static inline u64 str_to_u64(const char *str)
 
 /* Register save area header. */
 struct fadump_reg_save_area_header {
-	u64		magic_number;
-	u32		version;
-	u32		num_cpu_offset;
+	__be64		magic_number;
+	__be32		version;
+	__be32		num_cpu_offset;
 };
 
 /* Register entry. */
 struct fadump_reg_entry {
-	u64		reg_id;
-	u64		reg_value;
+	__be64		reg_id;
+	__be64		reg_value;
 };
 
 /* fadump crash info structure */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 742694c..26d091a 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -58,7 +58,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 	const __be32 *sections;
 	int i, num_sections;
 	int size;
-	const int *token;
+	const __be32 *token;
 
 	if (depth != 1 || strcmp(uname, "rtas") != 0)
 		return 0;
@@ -72,7 +72,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 		return 1;
 
 	fw_dump.fadump_supported = 1;
-	fw_dump.ibm_configure_kernel_dump = *token;
+	fw_dump.ibm_configure_kernel_dump = be32_to_cpu(*token);
 
 	/*
 	 * The 'ibm,kernel-dump' rtas node is present only if there is
@@ -147,11 +147,11 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 	memset(fdm, 0, sizeof(struct fadump_mem_struct));
 	addr = addr & PAGE_MASK;
 
-	fdm->header.dump_format_version = 0x00000001;
-	fdm->header.dump_num_sections = 3;
+	fdm->header.dump_format_version = cpu_to_be32(0x00000001);
+	fdm->header.dump_num_sections = cpu_to_be16(3);
 	fdm->header.dump_status_flag = 0;
 	fdm->header.offset_first_dump_section =
-		(u32)offsetof(struct fadump_mem_struct, cpu_state_data);
+		cpu_to_be32((u32)offsetof(struct fadump_mem_struct, cpu_state_data));
 
 	/*
 	 * Fields for disk dump option.
@@ -167,27 +167,27 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
 
 	/* Kernel dump sections */
 	/* cpu state data section. */
-	fdm->cpu_state_data.request_flag = FADUMP_REQUEST_FLAG;
-	fdm->cpu_state_data.source_data_type = FADUMP_CPU_STATE_DATA;
+	fdm->cpu_state_data.request_flag = cpu_to_be32(FADUMP_REQUEST_FLAG);
+	fdm->cpu_state_data.source_data_type = cpu_to_be16(FADUMP_CPU_STATE_DATA);
 	fdm->cpu_state_data.source_address = 0;
-	fdm->cpu_state_data.source_len = fw_dump.cpu_state_data_size;
-	fdm->cpu_state_data.destination_address = addr;
+	fdm->cpu_state_data.source_len = cpu_to_be64(fw_dump.cpu_state_data_size);
+	fdm->cpu_state_data.destination_address = cpu_to_be64(addr);
 	addr += fw_dump.cpu_state_data_size;
 
 	/* hpte region section */
-	fdm->hpte_region.request_flag = FADUMP_REQUEST_FLAG;
-	fdm->hpte_region.source_data_type = FADUMP_HPTE_REGION;
+	fdm->hpte_region.request_flag = cpu_to_be32(FADUMP_REQUEST_FLAG);
+	fdm->hpte_region.source_data_type = cpu_to_be16(FADUMP_HPTE_REGION);
 	fdm->hpte_region.source_address = 0;
-	fdm->hpte_region.source_len = fw_dump.hpte_region_size;
-	fdm->hpte_region.destination_address = addr;
+	fdm->hpte_region.source_len = cpu_to_be64(fw_dump.hpte_region_size);
+	fdm->hpte_region.destination_address = cpu_to_be64(addr);
 	addr += fw_dump.hpte_region_size;
 
 	/* RMA region section */
-	fdm->rmr_region.request_flag = FADUMP_REQUEST_FLAG;
-	fdm->rmr_region.source_data_type = FADUMP_REAL_MODE_REGION;
-	fdm->rmr_region.source_address = RMA_START;
-	fdm->rmr_region.source_len = fw_dump.boot_memory_size;
-	fdm->rmr_region.destination_address = addr;
+	fdm->rmr_region.request_flag = cpu_to_be32(FADUMP_REQUEST_FLAG);
+	fdm->rmr_region.source_data_type = cpu_to_be16(FADUMP_REAL_MODE_REGION);
+	fdm->rmr_region.source_address = cpu_to_be64(RMA_START);
+	fdm->rmr_region.source_len = cpu_to_be64(fw_dump.boot_memory_size);
+	fdm->rmr_region.destination_address = cpu_to_be64(addr);
 	addr += fw_dump.boot_memory_size;
 
 	return addr;
@@ -272,7 +272,7 @@ int __init fadump_reserve_mem(void)
 	 * first kernel.
 	 */
 	if (fdm_active)
-		fw_dump.boot_memory_size = fdm_active->rmr_region.source_len;
+		fw_dump.boot_memory_size = be64_to_cpu(fdm_active->rmr_region.source_len);
 	else
 		fw_dump.boot_memory_size = fadump_calculate_reserve_size();
 
@@ -314,8 +314,8 @@ int __init fadump_reserve_mem(void)
 				(unsigned long)(base >> 20));
 
 		fw_dump.fadumphdr_addr =
-				fdm_active->rmr_region.destination_address +
-				fdm_active->rmr_region.source_len;
+				be64_to_cpu(fdm_active->rmr_region.destination_address) +
+				be64_to_cpu(fdm_active->rmr_region.source_len);
 		pr_debug("fadumphdr_addr = %p\n",
 				(void *) fw_dump.fadumphdr_addr);
 	} else {
@@ -472,9 +472,9 @@ fadump_read_registers(struct fadump_reg_entry *reg_entry, struct pt_regs *regs)
 {
 	memset(regs, 0, sizeof(struct pt_regs));
 
-	while (reg_entry->reg_id != REG_ID("CPUEND")) {
-		fadump_set_regval(regs, reg_entry->reg_id,
-					reg_entry->reg_value);
+	while (be64_to_cpu(reg_entry->reg_id) != REG_ID("CPUEND")) {
+		fadump_set_regval(regs, be64_to_cpu(reg_entry->reg_id),
+					be64_to_cpu(reg_entry->reg_value));
 		reg_entry++;
 	}
 	reg_entry++;
@@ -603,20 +603,20 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 	if (!fdm->cpu_state_data.bytes_dumped)
 		return -EINVAL;
 
-	addr = fdm->cpu_state_data.destination_address;
+	addr = be64_to_cpu(fdm->cpu_state_data.destination_address);
 	vaddr = __va(addr);
 
 	reg_header = vaddr;
-	if (reg_header->magic_number != REGSAVE_AREA_MAGIC) {
+	if (be64_to_cpu(reg_header->magic_number) != REGSAVE_AREA_MAGIC) {
 		printk(KERN_ERR "Unable to read register save area.\n");
 		return -ENOENT;
 	}
 	pr_debug("--------CPU State Data------------\n");
-	pr_debug("Magic Number: %llx\n", reg_header->magic_number);
-	pr_debug("NumCpuOffset: %x\n", reg_header->num_cpu_offset);
+	pr_debug("Magic Number: %llx\n", be64_to_cpu(reg_header->magic_number));
+	pr_debug("NumCpuOffset: %x\n", be32_to_cpu(reg_header->num_cpu_offset));
 
-	vaddr += reg_header->num_cpu_offset;
-	num_cpus = *((u32 *)(vaddr));
+	vaddr += be32_to_cpu(reg_header->num_cpu_offset);
+	num_cpus = be32_to_cpu(*((__be32 *)(vaddr)));
 	pr_debug("NumCpus     : %u\n", num_cpus);
 	vaddr += sizeof(u32);
 	reg_entry = (struct fadump_reg_entry *)vaddr;
@@ -639,13 +639,13 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 		fdh = __va(fw_dump.fadumphdr_addr);
 
 	for (i = 0; i < num_cpus; i++) {
-		if (reg_entry->reg_id != REG_ID("CPUSTRT")) {
+		if (be64_to_cpu(reg_entry->reg_id) != REG_ID("CPUSTRT")) {
 			printk(KERN_ERR "Unable to read CPU state data\n");
 			rc = -ENOENT;
 			goto error_out;
 		}
 		/* Lower 4 bytes of reg_value contains logical cpu id */
-		cpu = reg_entry->reg_value & FADUMP_CPU_ID_MASK;
+		cpu = be64_to_cpu(reg_entry->reg_value) & FADUMP_CPU_ID_MASK;
 		if (fdh && !cpumask_test_cpu(cpu, &fdh->cpu_online_mask)) {
 			SKIP_TO_NEXT_CPU(reg_entry);
 			continue;
@@ -692,7 +692,7 @@ static int __init process_fadump(const struct fadump_mem_struct *fdm_active)
 		return -EINVAL;
 
 	/* Check if the dump data is valid. */
-	if ((fdm_active->header.dump_status_flag == FADUMP_ERROR_FLAG) ||
+	if ((be16_to_cpu(fdm_active->header.dump_status_flag) == FADUMP_ERROR_FLAG) ||
 			(fdm_active->cpu_state_data.error_flags != 0) ||
 			(fdm_active->rmr_region.error_flags != 0)) {
 		printk(KERN_ERR "Dump taken by platform is not valid\n");
@@ -828,7 +828,7 @@ static void fadump_setup_crash_memory_ranges(void)
 static inline unsigned long fadump_relocate(unsigned long paddr)
 {
 	if (paddr > RMA_START && paddr < fw_dump.boot_memory_size)
-		return fdm.rmr_region.destination_address + paddr;
+		return be64_to_cpu(fdm.rmr_region.destination_address) + paddr;
 	else
 		return paddr;
 }
@@ -902,7 +902,7 @@ static int fadump_create_elfcore_headers(char *bufp)
 			 * to the specified destination_address. Hence set
 			 * the correct offset.
 			 */
-			phdr->p_offset = fdm.rmr_region.destination_address;
+			phdr->p_offset = be64_to_cpu(fdm.rmr_region.destination_address);
 		}
 
 		phdr->p_paddr = mbase;
@@ -951,7 +951,7 @@ static void register_fadump(void)
 
 	fadump_setup_crash_memory_ranges();
 
-	addr = fdm.rmr_region.destination_address + fdm.rmr_region.source_len;
+	addr = be64_to_cpu(fdm.rmr_region.destination_address) + be64_to_cpu(fdm.rmr_region.source_len);
 	/* Initialize fadump crash info header. */
 	addr = init_fadump_header(addr);
 	vaddr = __va(addr);
@@ -1023,7 +1023,7 @@ void fadump_cleanup(void)
 	/* Invalidate the registration only if dump is active. */
 	if (fw_dump.dump_active) {
 		init_fadump_mem_struct(&fdm,
-			fdm_active->cpu_state_data.destination_address);
+			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
 		fadump_invalidate_dump(&fdm);
 	}
 }
@@ -1063,7 +1063,7 @@ static void fadump_invalidate_release_mem(void)
 		return;
 	}
 
-	destination_address = fdm_active->cpu_state_data.destination_address;
+	destination_address = be64_to_cpu(fdm_active->cpu_state_data.destination_address);
 	fadump_cleanup();
 	mutex_unlock(&fadump_mutex);
 
@@ -1183,31 +1183,31 @@ static int fadump_region_show(struct seq_file *m, void *private)
 	seq_printf(m,
 			"CPU : [%#016llx-%#016llx] %#llx bytes, "
 			"Dumped: %#llx\n",
-			fdm_ptr->cpu_state_data.destination_address,
-			fdm_ptr->cpu_state_data.destination_address +
-			fdm_ptr->cpu_state_data.source_len - 1,
-			fdm_ptr->cpu_state_data.source_len,
-			fdm_ptr->cpu_state_data.bytes_dumped);
+			be64_to_cpu(fdm_ptr->cpu_state_data.destination_address),
+			be64_to_cpu(fdm_ptr->cpu_state_data.destination_address) +
+			be64_to_cpu(fdm_ptr->cpu_state_data.source_len) - 1,
+			be64_to_cpu(fdm_ptr->cpu_state_data.source_len),
+			be64_to_cpu(fdm_ptr->cpu_state_data.bytes_dumped));
 	seq_printf(m,
 			"HPTE: [%#016llx-%#016llx] %#llx bytes, "
 			"Dumped: %#llx\n",
-			fdm_ptr->hpte_region.destination_address,
-			fdm_ptr->hpte_region.destination_address +
-			fdm_ptr->hpte_region.source_len - 1,
-			fdm_ptr->hpte_region.source_len,
-			fdm_ptr->hpte_region.bytes_dumped);
+			be64_to_cpu(fdm_ptr->hpte_region.destination_address),
+			be64_to_cpu(fdm_ptr->hpte_region.destination_address) +
+			be64_to_cpu(fdm_ptr->hpte_region.source_len) - 1,
+			be64_to_cpu(fdm_ptr->hpte_region.source_len),
+			be64_to_cpu(fdm_ptr->hpte_region.bytes_dumped));
 	seq_printf(m,
 			"DUMP: [%#016llx-%#016llx] %#llx bytes, "
 			"Dumped: %#llx\n",
-			fdm_ptr->rmr_region.destination_address,
-			fdm_ptr->rmr_region.destination_address +
-			fdm_ptr->rmr_region.source_len - 1,
-			fdm_ptr->rmr_region.source_len,
-			fdm_ptr->rmr_region.bytes_dumped);
+			be64_to_cpu(fdm_ptr->rmr_region.destination_address),
+			be64_to_cpu(fdm_ptr->rmr_region.destination_address) +
+			be64_to_cpu(fdm_ptr->rmr_region.source_len) - 1,
+			be64_to_cpu(fdm_ptr->rmr_region.source_len),
+			be64_to_cpu(fdm_ptr->rmr_region.bytes_dumped));
 
 	if (!fdm_active ||
 		(fw_dump.reserve_dump_area_start ==
-		fdm_ptr->cpu_state_data.destination_address))
+		be64_to_cpu(fdm_ptr->cpu_state_data.destination_address)))
 		goto out;
 
 	/* Dump is active. Show reserved memory region. */
@@ -1215,10 +1215,10 @@ static int fadump_region_show(struct seq_file *m, void *private)
 			"    : [%#016llx-%#016llx] %#llx bytes, "
 			"Dumped: %#llx\n",
 			(unsigned long long)fw_dump.reserve_dump_area_start,
-			fdm_ptr->cpu_state_data.destination_address - 1,
-			fdm_ptr->cpu_state_data.destination_address -
+			be64_to_cpu(fdm_ptr->cpu_state_data.destination_address) - 1,
+			be64_to_cpu(fdm_ptr->cpu_state_data.destination_address) -
 			fw_dump.reserve_dump_area_start,
-			fdm_ptr->cpu_state_data.destination_address -
+			be64_to_cpu(fdm_ptr->cpu_state_data.destination_address) -
 			fw_dump.reserve_dump_area_start);
 out:
 	if (fdm_active)
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 34e6423..495d164 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -43,6 +43,7 @@
 #include <asm/trace.h>
 #include <asm/firmware.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/fadump.h>
 
 #include "pseries.h"
 
@@ -249,8 +250,18 @@ static void pSeries_lpar_hptab_clear(void)
 	}
 
 #ifdef __LITTLE_ENDIAN__
-	/* Reset exceptions to big endian */
-	if (firmware_has_feature(FW_FEATURE_SET_MODE)) {
+	/*
+	 * Reset exceptions to big endian
+	 * In fadump case, after system crash phyp preserves the memory contents
+	 * and hashtable. Hence in the second kernel it is necessary to clear
+	 * the hastable during htab_initialize() to remove old mappings.
+	 * When we do that in second kernel we already booted in LE mode
+	 * and ready to take up exception in LE mode. If we enable big endian
+	 * exception in fadump case we see system crash because it tries to run
+	 * LE interrupt code in BE mode. Hence if we are coming here as part of
+	 * fadump crash we must not enable big endian exception.
+	 */
+	if (firmware_has_feature(FW_FEATURE_SET_MODE) && !is_fadump_active()) {
 		long rc;
 
 		rc = pseries_big_endian_exceptions();
