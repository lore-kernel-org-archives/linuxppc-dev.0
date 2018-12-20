Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF2C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:13:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BEF218FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BEF218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LLyh1XGFzDr85
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:13:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LLgz3bV4zDr3Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43LLgz2nRYz8tRf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:03 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43LLgz1hC7z9sCQ; Fri, 21 Dec 2018 06:01:03 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hbathini@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43LLgy4VtPz9sCV
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2018 06:01:02 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBKIwklk044960
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:01:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pgg5phhjk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:00:59 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 20 Dec 2018 19:00:57 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 19:00:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBKJ0qg459637950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 19:00:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 831C611C06E;
 Thu, 20 Dec 2018 19:00:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFFD511C058;
 Thu, 20 Dec 2018 19:00:50 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.47.3])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Dec 2018 19:00:50 +0000 (GMT)
Subject: [PATCH 5/9] powerpc/fadump: process architected register state data
 provided by firmware
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Fri, 21 Dec 2018 00:30:49 +0530
In-Reply-To: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
References: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18122019-0016-0000-0000-0000023956F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122019-0017-0000-0000-00003291B458
Message-Id: <154533244975.28973.16083421864653823983.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200154
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

Firmware provides architected register state data at the time of crash.
This data contains PIR value. Need to store the logical CPUs PIR values
to match the data provided by f/w with the corresponding logical CPU.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c                    |   40 +---
 arch/powerpc/kernel/fadump_internal.c           |  129 ++++++++++++++
 arch/powerpc/kernel/fadump_internal.h           |   32 +++
 arch/powerpc/platforms/powernv/opal-fadump.c    |  216 +++++++++++++++++++++--
 arch/powerpc/platforms/powernv/opal-fadump.h    |    9 +
 arch/powerpc/platforms/pseries/pseries_fadump.c |    1 
 6 files changed, 384 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 190f7ed..d9cf809 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -276,10 +276,10 @@ static unsigned long get_fadump_area_size(void)
 	size += fw_dump.hpte_region_size;
 	size += fw_dump.boot_memory_size;
 	size += sizeof(struct fadump_crash_info_header);
-	size += sizeof(struct elfhdr); /* ELF core header.*/
-	size += sizeof(struct elf_phdr); /* place holder for cpu notes */
-	/* Program headers for crash memory regions. */
-	size += sizeof(struct elf_phdr) * (memblock_num_regions(memory) + 2);
+	/* To store the start address of backup area */
+	size += sizeof(unsigned long *);
+	size += get_fadump_elfcore_hdr_size();
+	size += fw_dump.backup_area_size;
 
 	size = PAGE_ALIGN(size);
 	return size;
@@ -892,26 +892,6 @@ static int fadump_create_elfcore_headers(char *bufp)
 	return 0;
 }
 
-static unsigned long init_fadump_header(unsigned long addr)
-{
-	struct fadump_crash_info_header *fdh;
-
-	if (!addr)
-		return 0;
-
-	fw_dump.fadumphdr_addr = addr;
-	fdh = __va(addr);
-	addr += sizeof(struct fadump_crash_info_header);
-
-	memset(fdh, 0, sizeof(struct fadump_crash_info_header));
-	fdh->magic_number = FADUMP_CRASH_INFO_MAGIC;
-	fdh->elfcorehdr_addr = addr;
-	/* We will set the crashing cpu id in crash_fadump() during crash. */
-	fdh->crashing_cpu = CPU_UNKNOWN;
-
-	return addr;
-}
-
 static int register_fadump(void)
 {
 	unsigned long addr;
@@ -929,15 +909,15 @@ static int register_fadump(void)
 	if (ret)
 		return ret;
 
-	addr = fw_dump.meta_area_start;
-
 	/* Initialize fadump crash info header. */
-	addr = init_fadump_header(addr);
+	addr = fw_dump.ops->init_fadump_header(&fw_dump);
 	vaddr = __va(addr);
 
 	pr_debug("Creating ELF core headers at %#016lx\n", addr);
 	fadump_create_elfcore_headers(vaddr);
 
+	fadump_populate_backup_area(&fw_dump);
+
 	/* register the future kernel dump with firmware. */
 	pr_debug("Registering for firmware-assisted kernel dump...\n");
 	return fw_dump.ops->register_fadump(&fw_dump);
@@ -1242,8 +1222,12 @@ int __init setup_fadump(void)
 			fadump_invalidate_release_mem();
 	}
 	/* Initialize the kernel dump memory structure for FAD registration. */
-	else if (fw_dump.reserve_dump_area_size)
+	else if (fw_dump.reserve_dump_area_size) {
 		fw_dump.ops->init_fadump_mem_struct(&fw_dump);
+		fw_dump.ops->init_fadump_header(&fw_dump);
+		init_fadump_backup_area(&fw_dump);
+		fadump_populate_backup_area(&fw_dump);
+	}
 
 	fadump_init_files();
 
diff --git a/arch/powerpc/kernel/fadump_internal.c b/arch/powerpc/kernel/fadump_internal.c
index b46c7da..ea6f8ba 100644
--- a/arch/powerpc/kernel/fadump_internal.c
+++ b/arch/powerpc/kernel/fadump_internal.c
@@ -20,6 +20,34 @@
 
 #include "fadump_internal.h"
 
+/*
+ * Initializes the legacy fadump header format.
+ * Platform specific code can reuse/overwrite this format.
+ * OPAL platform overrides this data to add backup area support.
+ *
+ * TODO: Extend backup area support to pseries to make it robust?
+ */
+unsigned long generic_init_fadump_header(struct fw_dump *fadump_conf)
+{
+	unsigned long addr = fadump_conf->meta_area_start;
+	struct fadump_crash_info_header *fdh;
+
+	if (!addr)
+		return 0;
+
+	fadump_conf->fadumphdr_addr = addr;
+	fdh = __va(addr);
+	addr += sizeof(struct fadump_crash_info_header);
+
+	memset(fdh, 0, sizeof(struct fadump_crash_info_header));
+	fdh->magic_number = FADUMP_CRASH_INFO_MAGIC;
+	fdh->elfcorehdr_addr = addr;
+	/* We will set the crashing cpu id in crash_fadump() during crash. */
+	fdh->crashing_cpu = CPU_UNKNOWN;
+
+	return addr;
+}
+
 void *fadump_cpu_notes_buf_alloc(unsigned long size)
 {
 	void *vaddr;
@@ -106,6 +134,43 @@ void fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val)
 		regs->dsisr = (unsigned long)reg_val;
 }
 
+void fadump_set_regval_regnum(struct pt_regs *regs, u64 reg_id,
+			      u64 reg_val, int reg_cnt)
+{
+	if (reg_cnt >= 63) {
+		if (reg_id < 32) {
+			regs->gpr[reg_id] = reg_val;
+			return;
+		}
+	}
+	switch (reg_id) {
+	case 2000:
+		regs->nip = reg_val;
+		break;
+	case 2001:
+		regs->msr = reg_val;
+		break;
+	case 9:
+		regs->ctr = reg_val;
+		break;
+	case 8:
+		regs->link = reg_val;
+		break;
+	case 1:
+		regs->xer = reg_val;
+		break;
+	case 2002:
+		regs->ccr = reg_val;
+		break;
+	case 19:
+		regs->dar = reg_val;
+		break;
+	case 18:
+		regs->dsisr = reg_val;
+		break;
+	}
+}
+
 u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 {
 	struct elf_prstatus prstatus;
@@ -121,6 +186,19 @@ u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
 	return buf;
 }
 
+unsigned long get_fadump_elfcore_hdr_size(void)
+{
+	unsigned long size = 0;
+
+	size = sizeof(struct elfhdr); /* ELF core header.*/
+	size += sizeof(struct elf_phdr); /* place holder for cpu notes */
+	size += sizeof(struct elf_phdr); /* vmcoreinfo notes program header */
+	/* Program headers for crash memory regions. */
+	size += sizeof(struct elf_phdr) * (memblock_num_regions(memory) + 1);
+
+	return size;
+}
+
 void fadump_update_elfcore_header(struct fw_dump *fadump_conf, char *bufp)
 {
 	struct elfhdr *elf;
@@ -203,3 +281,54 @@ int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf)
 
 	return is_memory_area_contiguous(d_start, d_end);
 }
+
+void init_fadump_backup_area(struct fw_dump *fadump_conf)
+{
+	unsigned long addr = fadump_conf->backup_area_start;
+	struct fadump_backup_area *backup_info;
+
+	if (!addr)
+		return;
+
+	backup_info = __va(addr);
+	memset(backup_info, 0xFF, fadump_conf->backup_area_size);
+	backup_info->version = BACKUP_AREA_VERSION_V1;
+	backup_info->size = fadump_conf->backup_area_size;
+	backup_info->nr_threads = 0;
+}
+
+static inline void read_pir(void *val)
+{
+	*(unsigned long *)val = mfspr(SPRN_PIR);
+}
+
+unsigned long fadump_populate_backup_area(struct fw_dump *fadump_conf)
+{
+	unsigned long pir, addr;
+	struct fadump_backup_area *backup_info;
+	unsigned int i;
+
+	if (!fadump_conf->backup_area_start)
+		return 0;
+
+	addr = fadump_conf->backup_area_start;
+	backup_info = __va(addr);
+	addr += fadump_conf->backup_area_size;
+
+	backup_info->present_mask = *cpu_present_mask;
+	for_each_present_cpu(i) {
+		/*
+		 * Skip if PIR is already read to avoid complex scenarios
+		 * where the CPUs are offline'd after initial read.
+		 */
+		if (backup_info->thread_pir[i] != 0xFFFFFFFFU)
+			continue;
+
+		smp_call_function_single(i, read_pir, &pir, 1);
+		pr_debug("Logical CPU: %d, PIR: 0x%lx\n", i, pir);
+		backup_info->thread_pir[i] = pir;
+		backup_info->nr_threads++;
+	}
+
+	return addr;
+}
diff --git a/arch/powerpc/kernel/fadump_internal.h b/arch/powerpc/kernel/fadump_internal.h
index 61c6335..a117f60 100644
--- a/arch/powerpc/kernel/fadump_internal.h
+++ b/arch/powerpc/kernel/fadump_internal.h
@@ -71,6 +71,9 @@ static inline u64 str_to_u64(const char *str)
 
 #define FADUMP_CRASH_INFO_MAGIC		STR_TO_HEX("FADMPINF")
 
+/* Backup area support in this version */
+#define FADUMP_CRASH_INFO_MAGIC_V2	STR_TO_HEX("FADINFV2")
+
 /* Register entry. */
 struct fadump_reg_entry {
 	__be64		reg_id;
@@ -89,6 +92,21 @@ struct fadump_crash_info_header {
 /* Platform specific callback functions */
 struct fadump_ops;
 
+#define BACKUP_AREA_VERSION_V1			1
+
+/* Backup area populated with data for processing in capture kernel */
+struct fadump_backup_area {
+	u32		size;
+	u32		version:4;
+	u32		nr_threads:28;
+	u32		thread_pir[NR_CPUS];
+	struct cpumask	present_mask;
+	/*
+	 * New backup data entries can be added here by bumping up
+	 * the version field.
+	 */
+};
+
 /* Firmware-Assited Dump platforms */
 enum fadump_platform_type {
 	FADUMP_PLATFORM_UNKNOWN = 0,
@@ -106,6 +124,9 @@ struct fadump_memory_range {
 
 /* Firmware-assisted dump configuration details. */
 struct fw_dump {
+	unsigned long	cpu_state_destination_addr;
+	unsigned long	cpu_state_data_version;
+	unsigned long	cpu_state_entry_size;
 	unsigned long	cpu_state_data_size;
 	unsigned long	hpte_region_size;
 	unsigned long	boot_memory_size;
@@ -113,6 +134,8 @@ struct fw_dump {
 	unsigned long	reserve_dump_area_size;
 	unsigned long	meta_area_start;
 	unsigned long	preserv_area_start;
+	unsigned long	backup_area_start;
+	unsigned long	backup_area_size;
 	/* cmd line option during boot */
 	unsigned long	reserve_bootvar;
 
@@ -148,6 +171,7 @@ struct fw_dump {
 
 struct fadump_ops {
 	ulong	(*init_fadump_mem_struct)(struct fw_dump *fadump_config);
+	ulong	(*init_fadump_header)(struct fw_dump *fadump_config);
 	int	(*register_fadump)(struct fw_dump *fadump_config);
 	int	(*unregister_fadump)(struct fw_dump *fadump_config);
 	int	(*invalidate_fadump)(struct fw_dump *fadump_config);
@@ -157,15 +181,23 @@ struct fadump_ops {
 	void	(*crash_fadump)(const char *msg);
 };
 
+/* Generic version of fadump operations */
+unsigned long generic_init_fadump_header(struct fw_dump *fadump_conf);
+
 /* Helper functions */
 void *fadump_cpu_notes_buf_alloc(unsigned long size);
 void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size);
 void fadump_set_meta_area_start(struct fw_dump *fadump_conf);
 void fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val);
+void fadump_set_regval_regnum(struct pt_regs *regs, u64 reg_id,
+			      u64 reg_val, int reg_cnt);
 u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs);
+unsigned long get_fadump_elfcore_hdr_size(void);
 void fadump_update_elfcore_header(struct fw_dump *fadump_config, char *bufp);
 int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf);
 int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf);
+void init_fadump_backup_area(struct fw_dump *fadump_conf);
+unsigned long fadump_populate_backup_area(struct fw_dump *fadump_conf);
 
 #ifdef CONFIG_PPC_PSERIES
 extern int pseries_dt_scan_fadump(struct fw_dump *fadump_config, ulong node);
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index 0679d98..9e677de 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -32,6 +32,39 @@ static struct opal_fadump_mem_struct fdm;
 static const struct opal_fadump_mem_struct *fdm_active;
 unsigned long fdm_actual_size;
 
+/*
+ * Backup area is not available in older format. In the newer fadump
+ * header format (v2), backup info is stored at the end of elfcorehdrs
+ * and pointer to this address is stored at the tail end of FADump
+ * crash info header.
+ */
+static void opal_set_backup_area_start(struct fw_dump *fadump_conf)
+{
+	unsigned long addr = fadump_conf->meta_area_start;
+
+	/*
+	 * The start of meta area holds fadump_crash_info_header followed
+	 * by a pointer to backup area start address, elfcore headers &
+	 * backup info.
+	 */
+	addr += sizeof(struct fadump_crash_info_header);
+
+	if (fadump_conf->dump_active) {
+		/* Pointer to backup area start address */
+		unsigned long *ptr = __va(addr);
+
+		addr = *ptr;
+	} else {
+		addr += sizeof(unsigned long *);
+		addr += get_fadump_elfcore_hdr_size();
+	}
+
+	fadump_conf->backup_area_start = addr;
+
+	pr_debug("Backup area start address: 0x%lx\n",
+		 fadump_conf->backup_area_start);
+}
+
 static void opal_set_preserv_area_start(struct fw_dump *fadump_conf)
 {
 	fadump_conf->preserv_area_start = fadump_conf->rmr_destination_addr;
@@ -94,6 +127,12 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 
 				last_end = base + size;
 				j++;
+			} else if (fdm->section[i].src_type ==
+				   OPAL_FADUMP_CPU_STATE_DATA) {
+				fadump_conf->cpu_state_destination_addr =
+					be64_to_cpu(fdm->section[i].dest_addr);
+				fadump_conf->cpu_state_data_size =
+					be64_to_cpu(fdm->section[i].dest_size);
 			}
 		}
 		fadump_conf->rmr_regions_cnt = j;
@@ -103,6 +142,7 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 
 	fadump_set_meta_area_start(fadump_conf);
 	opal_set_preserv_area_start(fadump_conf);
+	opal_set_backup_area_start(fadump_conf);
 }
 
 static ulong opal_init_fadump_mem_struct(struct fw_dump *fadump_conf)
@@ -134,6 +174,41 @@ static ulong opal_init_fadump_mem_struct(struct fw_dump *fadump_conf)
 	return addr;
 }
 
+/*
+ * Newer fadump header version (v2) is used for process'ing OPAL FADump.
+ * In this version, PIR to Logical CPU map is backed up by crashing kernel
+ * for the capture kernel to make sense of the register state data provided
+ * by F/W. The start address of the area where this info is backed up is
+ * stored at the tail end of fadump crash info header.
+ */
+static ulong opal_init_fadump_header(struct fw_dump *fadump_conf)
+{
+	unsigned long addr = fadump_conf->meta_area_start;
+	struct fadump_crash_info_header *fdh;
+	unsigned long *backup_area_ptr;
+
+	if (!addr)
+		return 0;
+
+	fdh = __va(addr);
+	addr = generic_init_fadump_header(fadump_conf);
+	fdh->magic_number = FADUMP_CRASH_INFO_MAGIC_V2;
+
+	/*
+	 * This function returns the start address of elfcore headers.
+	 * Earlier, elfcore headers sit right below crash info header but
+	 * with V2, pointer to backup area start address (8 bytes) sits
+	 * in-between. So, update the return value and elfcorehdr_addr
+	 * in fadump crash info structure accordingly.
+	 */
+	backup_area_ptr = __va(addr);
+	addr += sizeof(unsigned long *);
+	fdh->elfcorehdr_addr = addr;
+	*backup_area_ptr = fadump_conf->backup_area_start;
+
+	return addr;
+}
+
 static int opal_register_fadump(struct fw_dump *fadump_conf)
 {
 	int rc, err = -EIO;
@@ -199,6 +274,39 @@ static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
 	return 0;
 }
 
+static inline int fadump_get_logical_cpu(struct fadump_backup_area *ba, u32 pir)
+{
+	int i = 0, cpu = CPU_UNKNOWN;
+
+	for_each_cpu(i, &(ba->present_mask)) {
+		if (ba->thread_pir[i] == pir) {
+			cpu = i;
+			break;
+		}
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
+	int reg_cnt = 0;
+
+	memset(regs, 0, sizeof(struct pt_regs));
+
+	for (i = 0; i < regs_per_thread; i++) {
+		fadump_set_regval_regnum(regs, be64_to_cpu(reg_entry->reg_id),
+					 be64_to_cpu(reg_entry->reg_value),
+					 reg_cnt++);
+		reg_entry++;
+	}
+	return reg_entry;
+}
+
 /*
  * Read CPU state dump data and convert it into ELF notes.
  *
@@ -206,10 +314,27 @@ static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
  * a GPR/SPR flag in the first 8 bytes and the register value in the next
  * 8 bytes. For more details refer to F/W documentation.
  */
-static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
+static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf,
+					 struct fadump_backup_area *backup_info)
 {
-	u32 num_cpus = 1, *note_buf;
+	struct opal_thread_hdr *thdr;
+	struct fadump_reg_entry *reg_entry;
 	struct fadump_crash_info_header *fdh = NULL;
+	unsigned long addr;
+	u32 num_cpus, *note_buf;
+	u32 thread_pir;
+	char *bufp;
+	struct pt_regs regs;
+	int i, rc = 0, cpu = 0;
+	unsigned int size_of_each_thread, regs_per_thread;
+
+	size_of_each_thread = fadump_conf->cpu_state_entry_size;
+	num_cpus = (fadump_conf->cpu_state_data_size / size_of_each_thread);
+	regs_per_thread = ((size_of_each_thread - CPU_REG_ENTRY_OFFSET) /
+			   sizeof(struct fadump_reg_entry));
+
+	addr = fadump_conf->cpu_state_destination_addr;
+	bufp = __va(addr);
 
 	/* Allocate buffer to hold cpu crash notes. */
 	fadump_conf->cpu_notes_buf_size = num_cpus * sizeof(note_buf_t);
@@ -229,22 +354,58 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 	if (fadump_conf->fadumphdr_addr)
 		fdh = __va(fadump_conf->fadumphdr_addr);
 
-	if (fdh && (fdh->crashing_cpu != CPU_UNKNOWN)) {
-		note_buf = fadump_regs_to_elf_notes(note_buf, &(fdh->regs));
-		final_note(note_buf);
+	if (backup_info->nr_threads != num_cpus) {
+		pr_warn("Calculated numcpus (%d) not same as populated value (%d)!\n",
+			num_cpus, backup_info->nr_threads);
+	}
+	pr_debug("--------CPU State Data------------\n");
+	pr_debug("NumCpus     : %u\n", num_cpus);
+
+	for (i = 0; i < num_cpus; i++, bufp += size_of_each_thread) {
+		thdr = (struct opal_thread_hdr *)bufp;
+		thread_pir = be32_to_cpu(thdr->pir);
+		cpu = fadump_get_logical_cpu(backup_info, thread_pir);
+		if (cpu == CPU_UNKNOWN) {
+			pr_warn("Unable to get the logical CPU of PIR %d\n",
+				thread_pir);
+			continue;
+		}
+
+		reg_entry = (struct fadump_reg_entry *)(bufp +
+							CPU_REG_ENTRY_OFFSET);
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
+		fadump_read_registers(regs_per_thread, reg_entry, &regs);
+		note_buf = fadump_regs_to_elf_notes(note_buf, &regs);
+	}
+	final_note(note_buf);
 
+	if (fdh) {
 		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
 			 fdh->elfcorehdr_addr);
 		fadump_update_elfcore_header(fadump_conf,
 					     __va(fdh->elfcorehdr_addr));
 	}
 
-	return 0;
+	return rc;
 }
 
 static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 {
 	struct fadump_crash_info_header *fdh;
+	struct fadump_backup_area *backup_info = NULL;
+	unsigned long addr;
 	int rc = 0;
 
 	if (!fdm_active || !fadump_conf->fadumphdr_addr)
@@ -252,19 +413,19 @@ static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 
 	/* Validate the fadump crash info header */
 	fdh = __va(fadump_conf->fadumphdr_addr);
-	if (fdh->magic_number != FADUMP_CRASH_INFO_MAGIC) {
+	if (fdh->magic_number != FADUMP_CRASH_INFO_MAGIC_V2) {
 		pr_err("Crash info header is not valid.\n");
 		return -EINVAL;
 	}
 
-	/*
-	 * TODO: To build cpu notes, find a way to map PIR to logical id.
-	 *       Also, we may need different method for pseries and powernv.
-	 *       The currently booted kernel could have a different PIR to
-	 *       logical id mapping. So, try saving info of previous kernel's
-	 *       paca to get the right PIR to logical id mapping.
-	 */
-	rc = fadump_build_cpu_notes(fadump_conf);
+	addr = fadump_conf->backup_area_start;
+	backup_info = __va(addr);
+	if (!addr || (backup_info->version != BACKUP_AREA_VERSION_V1)) {
+		pr_err("Backup data missing or unsupported!\n");
+		return -EINVAL;
+	}
+
+	rc = fadump_build_cpu_notes(fadump_conf, backup_info);
 	if (rc)
 		return rc;
 
@@ -327,6 +488,7 @@ static void opal_crash_fadump(const char *msg)
 
 static struct fadump_ops opal_fadump_ops = {
 	.init_fadump_mem_struct	= opal_init_fadump_mem_struct,
+	.init_fadump_header	= opal_init_fadump_header,
 	.register_fadump	= opal_register_fadump,
 	.unregister_fadump	= opal_unregister_fadump,
 	.invalidate_fadump	= opal_invalidate_fadump,
@@ -338,6 +500,7 @@ static struct fadump_ops opal_fadump_ops = {
 int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 {
 	unsigned long dn;
+	const __be32 *prop;
 
 	/*
 	 * Check if Firmware Assisted dump is supported. if yes, check
@@ -349,6 +512,19 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 		return 1;
 	}
 
+	fadump_conf->backup_area_size = sizeof(struct fadump_backup_area);
+
+	prop = of_get_flat_dt_prop(dn, "cpu-data-version", NULL);
+	if (prop)
+		fadump_conf->cpu_state_data_version = of_read_number(prop, 1);
+
+	if (fadump_conf->cpu_state_data_version != CPU_STATE_DATA_VERSION) {
+		pr_err("CPU state data format version mismatch!\n");
+		pr_err("Kernel: %u, OPAL: %lu\n", CPU_STATE_DATA_VERSION,
+		       fadump_conf->cpu_state_data_version);
+		return 1;
+	}
+
 	/*
 	 * Firmware currently supports only 32-bit value for size,
 	 * align it to 1MB size.
@@ -363,6 +539,16 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 		pr_info("Firmware-assisted dump is active.\n");
 		fadump_conf->dump_active = 1;
 		update_fadump_config(fadump_conf, (void *)__pa(fdm_active));
+
+		/*
+		 * Doesn't need to populate these fields while registering dump
+		 * as destination address and size are provided by F/W.
+		 */
+		prop = of_get_flat_dt_prop(dn, "cpu-data-size", NULL);
+		if (prop) {
+			fadump_conf->cpu_state_entry_size =
+						of_read_number(prop, 1);
+		}
 	}
 
 	fadump_conf->ops		= &opal_fadump_ops;
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.h b/arch/powerpc/platforms/powernv/opal-fadump.h
index a5eeb2c..392e4ce 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.h
+++ b/arch/powerpc/platforms/powernv/opal-fadump.h
@@ -13,6 +13,9 @@
 #ifndef __PPC64_OPAL_FA_DUMP_H__
 #define __PPC64_OPAL_FA_DUMP_H__
 
+#define CPU_STATE_DATA_VERSION		1
+#define CPU_REG_ENTRY_OFFSET		16
+
 #define OPAL_FADUMP_CPU_STATE_DATA	0x0000
 /* OPAL : 0x01 – 0x39 */
 #define OPAL_FADUMP_OPAL_REGION	0x0001
@@ -37,4 +40,10 @@ enum opal_fadump_section_types {
 #define OPAL_MAX_SECTIONS		(OPAL_SECTIONS + \
 					 MAX_REAL_MEM_REGIONS - 1)
 
+struct opal_thread_hdr {
+	__be32  pir;
+	u8      core_state;
+	u8      reserved[11];
+} __packed;
+
 #endif /* __PPC64_OPAL_FA_DUMP_H__ */
diff --git a/arch/powerpc/platforms/pseries/pseries_fadump.c b/arch/powerpc/platforms/pseries/pseries_fadump.c
index f380f3f..f1d7b66 100644
--- a/arch/powerpc/platforms/pseries/pseries_fadump.c
+++ b/arch/powerpc/platforms/pseries/pseries_fadump.c
@@ -460,6 +460,7 @@ static void pseries_crash_fadump(const char *msg)
 
 static struct fadump_ops pseries_fadump_ops = {
 	.init_fadump_mem_struct	= pseries_init_fadump_mem_struct,
+	.init_fadump_header	= generic_init_fadump_header,
 	.register_fadump	= pseries_register_fadump,
 	.unregister_fadump	= pseries_unregister_fadump,
 	.invalidate_fadump	= pseries_invalidate_fadump,

