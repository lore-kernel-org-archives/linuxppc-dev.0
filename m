Return-Path: <srs0=h6/a=ic=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lQN75gB8zF2nM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:35 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40lQN73N4rz8sxv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:35 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40lQN628JMz9s1w
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 14:59:34 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4F4xOnT044964
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:31 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hyndqpudg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:31 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 15 May 2018 05:59:30 +0100
Subject: [RFC PATCH 4/5] powerpc/fadump: process architected register state
 data provided by firmware
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 15 May 2018 10:29:24 +0530
In-Reply-To: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
References: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152636036417.17123.4475599487836094074.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

Firmware provides architected register state data at the time of crash.
This data contains PIR value. Need to store the logical CPUs PIR values
to match the data provided by f/w with the corresponding logical CPU.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c                    |   38 ++++++
 arch/powerpc/kernel/fadump_internal.h           |   12 ++
 arch/powerpc/platforms/powernv/powernv_fadump.c |  146 +++++++++++++++++++++--
 arch/powerpc/platforms/powernv/powernv_fadump.h |   13 ++
 4 files changed, 195 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index a27e4af..8cafa2b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -421,6 +421,7 @@ static unsigned long get_fadump_area_size(void)
 	size += fw_dump.cpu_state_data_size;
 	size += fw_dump.hpte_region_size;
 	size += fw_dump.boot_memory_size;
+	size += fw_dump.backup_area_size;
 	size += sizeof(struct fadump_crash_info_header);
 	size += sizeof(struct elfhdr); /* ELF core header.*/
 	size += sizeof(struct elf_phdr); /* place holder for cpu notes */
@@ -985,6 +986,37 @@ static unsigned long init_fadump_header(unsigned long addr)
 	return addr;
 }
 
+static inline void read_pir(void *val)
+{
+	*(unsigned long *)val = mfspr(SPRN_PIR);
+}
+
+static unsigned long fadump_populate_backup_area(void)
+{
+	struct fadump_backup_area *backup_info;
+	unsigned int i, size = sizeof(struct fadump_backup_area);
+	unsigned long addr;
+
+	if (fadump_ops->get_backup_area_start)
+		return 0;
+
+	addr = fadump_ops->get_backup_area_start(&fw_dump);
+	backup_info = __va(addr);
+	addr += fw_dump.backup_area_size;
+
+	memset(backup_info, 0, size);
+	backup_info->size = size;
+	backup_info->nr_threads = nr_cpu_ids;
+	for (i = 0; i < nr_cpu_ids; i++) {
+		smp_call_function_single(i, read_pir,
+					 &(backup_info->thread_pir[i]), 1);
+		pr_debug("Logical CPU: %d, PIR: 0x%lx\n",
+			 i, backup_info->thread_pir[i]);
+	}
+
+	return addr;
+}
+
 static int register_fadump(void)
 {
 	unsigned long addr;
@@ -1313,9 +1345,13 @@ int __init setup_fadump(void)
 			fadump_invalidate_release_mem();
 	}
 	/* Initialize the kernel dump memory structure for FAD registration. */
-	else if (fw_dump.reserve_dump_area_size)
+	else if (fw_dump.reserve_dump_area_size) {
 		fadump_ops->init_fadump_mem_struct(&fw_dump,
 				fw_dump.reserve_dump_area_start);
+		/* TODO: Extend this to pseries too */
+		if (fw_dump.fadump_platform == FADUMP_PLATFORM_POWERNV)
+			fadump_populate_backup_area();
+	}
 	fadump_init_files();
 
 	return 1;
diff --git a/arch/powerpc/kernel/fadump_internal.h b/arch/powerpc/kernel/fadump_internal.h
index eae4b55..f391405 100644
--- a/arch/powerpc/kernel/fadump_internal.h
+++ b/arch/powerpc/kernel/fadump_internal.h
@@ -101,9 +101,20 @@ struct fadump_memory_range {
 /* Maximum no. of real memory regions supported by the kernel */
 #define MAX_REAL_MEM_REGIONS		6
 
+/* Backup area populated with data for processing in capture kernel */
+struct fadump_backup_area {
+	unsigned int	size;
+	unsigned int	nr_threads;
+	unsigned long	thread_pir[NR_CPUS];
+};
+
 /* Firmware-assisted dump configuration details. */
 struct fw_dump {
+	unsigned long	cpu_state_destination_addr;
+	unsigned long	cpu_state_data_version;
+	unsigned long	cpu_state_entry_size;
 	unsigned long	cpu_state_data_size;
+	unsigned long	backup_area_size;
 	unsigned long	hpte_region_size;
 	unsigned long	boot_memory_size;
 	unsigned long	reserve_dump_area_start;
@@ -145,6 +156,7 @@ struct fadump_ops_t {
 	int	(*unregister_fadump)(struct fw_dump *fadump_config);
 	ulong	(*get_preserv_area_start)(struct fw_dump *fadump_conf);
 	ulong	(*get_meta_area_start)(struct fw_dump *fadump_conf);
+	ulong	(*get_backup_area_start)(struct fw_dump *fadump_conf);
 	int	(*invalidate_fadump)(struct fw_dump *fadump_config);
 	int	(*process_fadump)(struct fw_dump *fadump_config);
 	void	(*fadump_region_show)(struct fw_dump *fadump_config,
diff --git a/arch/powerpc/platforms/powernv/powernv_fadump.c b/arch/powerpc/platforms/powernv/powernv_fadump.c
index 6d4b515..36f0360 100644
--- a/arch/powerpc/platforms/powernv/powernv_fadump.c
+++ b/arch/powerpc/platforms/powernv/powernv_fadump.c
@@ -39,6 +39,8 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 	int unused_sections  = (POWERNV_MAX_SECTIONS - section_cnt);
 	int i, j;
 
+	fadump_conf->backup_area_size = sizeof(struct fadump_backup_area);
+
 	pr_debug("section_cnt: %d\n", section_cnt);
 	WARN_ON(unused_sections < 0);
 	fdm_actual_size = sizeof(*fdm) -
@@ -84,6 +86,12 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 
 				last_end = base + size;
 				j++;
+			} else if (fdm->section[i].src_type ==
+				   POWERNV_FADUMP_CPU_STATE_DATA) {
+				fadump_conf->cpu_state_destination_addr =
+					be64_to_cpu(fdm->section[i].dest_addr);
+				fadump_conf->cpu_state_data_size =
+					be64_to_cpu(fdm->section[i].dest_size);
 			}
 		}
 		fadump_conf->rmr_regions_cnt = j;
@@ -178,6 +186,13 @@ static ulong powernv_get_preserv_area_start(struct fw_dump *fadump_conf)
 static ulong powernv_get_meta_area_start(struct fw_dump *fadump_conf)
 {
 	return (fadump_conf->rmr_destination_addr +
+		fadump_conf->rmr_source_len +
+		fadump_conf->backup_area_size);
+}
+
+static ulong powernv_get_backup_area_start(struct fw_dump *fadump_conf)
+{
+	return (fadump_conf->rmr_destination_addr +
 		fadump_conf->rmr_source_len);
 }
 
@@ -197,6 +212,38 @@ static int powernv_invalidate_fadump(struct fw_dump *fadump_conf)
 	return 0;
 }
 
+static inline int fadump_get_logical_cpu(struct fadump_backup_area *ba, u32 pir)
+{
+	int i = 0, cpu = CPU_UNKNOWN;
+
+	while (i < ba->nr_threads) {
+		if (ba->thread_pir[i] == pir) {
+			cpu = i;
+			break;
+		}
+		i++;
+	}
+
+	return cpu;
+}
+
+static struct fadump_reg_entry*
+fadump_read_registers(unsigned int regs_per_thread,
+		      struct fadump_reg_entry *reg_entry,
+		      struct pt_regs *regs)
+{
+	int i;
+
+	memset(regs, 0, sizeof(struct pt_regs));
+
+	for (i = 0; i < regs_per_thread; i++) {
+		fadump_set_regval(regs, be64_to_cpu(reg_entry->reg_id),
+				  be64_to_cpu(reg_entry->reg_value));
+		reg_entry++;
+	}
+	return reg_entry;
+}
+
 /*
  * Read CPU state dump data and convert it into ELF notes.
  * The CPU dump starts with magic number "REGSAVE". NumCpusOffset should be
@@ -213,8 +260,34 @@ static int powernv_invalidate_fadump(struct fw_dump *fadump_conf)
  */
 static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 {
-	u32 num_cpus = 1, *note_buf;
+	struct powernv_thread_hdr *thdr;
+	struct fadump_reg_entry *reg_entry;
 	struct fadump_crash_info_header *fdh = NULL;
+	struct fadump_backup_area *backup_info = NULL;
+	char *bufp, *note_bufp;
+	u32 thread_pir;
+	unsigned long addr;
+	u32 num_cpus, *note_buf;
+	struct pt_regs regs;
+	int i, rc = 0, cpu = 0;
+	unsigned int size_of_each_thread, regs_per_thread;
+
+	addr = powernv_get_backup_area_start(fadump_conf);
+	if (!addr) {
+		pr_err("Unable to read CPU state data\n");
+		return -ENOENT;
+	}
+
+	backup_info = __va(addr);
+	num_cpus = backup_info->nr_threads;
+
+	size_of_each_thread = fadump_conf->cpu_state_entry_size;
+	regs_per_thread =
+		((size_of_each_thread - CPU_REG_ENTRY_OFFSET) /
+		 sizeof(struct fadump_reg_entry));
+
+	addr = fadump_conf->cpu_state_destination_addr;
+	bufp = __va(addr);
 
 	/* Allocate buffer to hold cpu crash notes. */
 	fadump_conf->cpu_notes_buf_size = num_cpus * sizeof(note_buf_t);
@@ -234,10 +307,41 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 	if (fadump_conf->fadumphdr_addr)
 		fdh = __va(fadump_conf->fadumphdr_addr);
 
-	if (fdh && (fdh->crashing_cpu != CPU_UNKNOWN)) {
-		note_buf = fadump_regs_to_elf_notes(note_buf, &(fdh->regs));
-		final_note(note_buf);
+	pr_debug("--------CPU State Data------------\n");
+	num_cpus = fadump_conf->cpu_state_data_size / size_of_each_thread;
+	pr_debug("NumCpus     : %u\n", num_cpus);
+
+	note_bufp = (char *)note_buf;
+	for (i = 0; i < num_cpus; i++, bufp += size_of_each_thread) {
+		thdr = (struct powernv_thread_hdr *)bufp;
+		thread_pir = be32_to_cpu(thdr->pir);
+		cpu = fadump_get_logical_cpu(backup_info, thread_pir);
+		if (cpu == CPU_UNKNOWN) {
+			pr_err("Unable to read CPU state data");
+			rc = -ENOENT;
+			goto error_out;
+		}
+
+		if (fdh) {
+			if (!cpumask_test_cpu(cpu, &fdh->online_mask))
+				continue;
+
+			if (fdh->crashing_cpu == cpu) {
+				regs = fdh->regs;
+				note_buf = fadump_regs_to_elf_notes(note_buf,
+								    &regs);
+				continue;
+			}
+		}
+
+		reg_entry = (struct fadump_reg_entry *)(bufp +
+							CPU_REG_ENTRY_OFFSET);
+		fadump_read_registers(regs_per_thread, reg_entry, &regs);
+		note_buf = fadump_regs_to_elf_notes(note_buf, &regs);
+	}
+	final_note(note_buf);
 
+	if (fdh) {
 		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
 			 fdh->elfcorehdr_addr);
 		fadump_update_elfcore_header(fadump_conf,
@@ -245,6 +349,13 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 	}
 
 	return 0;
+
+error_out:
+	fadump_cpu_notes_buf_free((ulong)__va(fadump_conf->cpu_notes_buf),
+				  fadump_conf->cpu_notes_buf_size);
+	fadump_conf->cpu_notes_buf = 0;
+	fadump_conf->cpu_notes_buf_size = 0;
+	return rc;
 }
 
 static int __init powernv_process_fadump(struct fw_dump *fadump_conf)
@@ -262,13 +373,6 @@ static int __init powernv_process_fadump(struct fw_dump *fadump_conf)
 		return -EINVAL;
 	}
 
-	/*
-	 * TODO: To build cpu notes, find a way to map PIR to logical id.
-	 *       Also, we may need different method for pseries and powernv.
-	 *       The currently booted kernel could have a different PIR to
-	 *       logical id mapping. So, try saving info of previous kernel's
-	 *       paca to get the right PIR to logical id mapping.
-	 */
 	rc = fadump_build_cpu_notes(fadump_conf);
 	if (rc)
 		return rc;
@@ -305,6 +409,7 @@ static struct fadump_ops_t powernv_fadump_ops = {
 	.unregister_fadump	= powernv_unregister_fadump,
 	.get_preserv_area_start	= powernv_get_preserv_area_start,
 	.get_meta_area_start	= powernv_get_meta_area_start,
+	.get_backup_area_start	= powernv_get_backup_area_start,
 	.invalidate_fadump	= powernv_invalidate_fadump,
 	.process_fadump		= powernv_process_fadump,
 	.fadump_region_show	= powernv_fadump_region_show,
@@ -313,6 +418,15 @@ static struct fadump_ops_t powernv_fadump_ops = {
 
 int __init powernv_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 {
+	const __be32 *prop;
+
+	prop = of_get_flat_dt_prop(node, "cpu-data-version", NULL);
+	if (prop)
+		fadump_conf->cpu_state_data_version = of_read_number(prop, 1);
+
+	if (fadump_conf->cpu_state_data_version != CPU_STATE_DATA_VERSION)
+		return 1;
+
 	/*
 	 * Firmware currently supports only 32-bit value for size,
 	 * align it to 1MB size.
@@ -327,6 +441,16 @@ int __init powernv_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 		pr_info("Firmware-assisted dump is active.\n");
 		fadump_conf->dump_active = 1;
 		update_fadump_config(fadump_conf, (void *)__pa(fdm_active));
+
+		/*
+		 * Doesn't need to populate these fields while registering dump
+		 * as destination address and size are provided by F/W.
+		 */
+		prop = of_get_flat_dt_prop(node, "cpu-data-size", NULL);
+		if (prop) {
+			fadump_conf->cpu_state_entry_size =
+						of_read_number(prop, 1);
+		}
 	}
 
 	fadump_ops = &powernv_fadump_ops;
diff --git a/arch/powerpc/platforms/powernv/powernv_fadump.h b/arch/powerpc/platforms/powernv/powernv_fadump.h
index 224a142..33be534 100644
--- a/arch/powerpc/platforms/powernv/powernv_fadump.h
+++ b/arch/powerpc/platforms/powernv/powernv_fadump.h
@@ -13,6 +13,9 @@
 #ifndef __PPC64_POWERNV_FA_DUMP_H__
 #define __PPC64_POWERNV_FA_DUMP_H__
 
+#define CPU_STATE_DATA_VERSION		16
+#define CPU_REG_ENTRY_OFFSET		16
+
 #define POWERNV_FADUMP_CPU_STATE_DATA	0x0000
 /* OPAL : 0x01 – 0x39 */
 #define POWERNV_FADUMP_OPAL_REGION	0x0001
@@ -37,6 +40,12 @@ enum powernv_fadump_section_types {
 #define POWERNV_MAX_SECTIONS		(POWERNV_SECTIONS + \
 					 MAX_REAL_MEM_REGIONS - 1)
 
+struct powernv_thread_hdr {
+	__be32  pir;
+	u8      core_state;
+	u8      reserved[11];
+} __attribute__ ((packed));
+
 /* Kernel Dump section info */
 struct powernv_fadump_section {
 	u8	src_type;
@@ -45,7 +54,7 @@ struct powernv_fadump_section {
 	__be64	src_size;
 	__be64	dest_addr;
 	__be64	dest_size;
-};
+} __attribute__ ((packed));
 
 /*
  * Firmware Assisted dump memory structure. This structure is required for
@@ -58,6 +67,6 @@ struct powernv_fadump_mem_struct {
 	__be32	reserved;
 
 	struct powernv_fadump_section	section[POWERNV_MAX_SECTIONS];
-};
+} __attribute__ ((packed));
 
 #endif /* __PPC64_POWERNV_FA_DUMP_H__ */
