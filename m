Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9811C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 18:05:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F00820836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 18:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F00820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4452Sj3CZMzDqRk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 05:05:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4451rc3VK6zDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:37:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4451rc2Fs9z8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:37:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4451rc1qM7z9sCH; Fri, 22 Feb 2019 04:37:36 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hbathini@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4451rb5vyfz9sBr
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2019 04:37:35 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LHaCev009107
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:37:34 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qt07rh13u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:37:33 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 21 Feb 2019 17:37:29 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Feb 2019 17:37:27 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1LHbQrR29753380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Feb 2019 17:37:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57001A4054;
 Thu, 21 Feb 2019 17:37:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA36A405C;
 Thu, 21 Feb 2019 17:37:24 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.32.125])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Feb 2019 17:37:24 +0000 (GMT)
Subject: [PATCH 17/18] powernv/fadump: use backup area to map PIR to logical
 CPUs
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Thu, 21 Feb 2019 23:07:23 +0530
In-Reply-To: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022117-0016-0000-0000-000002594824
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022117-0017-0000-0000-000032B399D8
Message-Id: <155077064359.21014.5626320039944439935.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-21_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210125
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

Firmware provides architected register state data but it doesn't have
corresponding logical CPU number used in the kernel. So, populate a
backup area storing logical CPU number and PIR values while registering
FADump and use it to correlate the register state data to corresponding
logical CPU while processing this crash data.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c                    |   40 ++------
 arch/powerpc/kernel/fadump_internal.c           |   92 ++++++++++++++++++
 arch/powerpc/kernel/fadump_internal.h           |   28 ++++++
 arch/powerpc/platforms/powernv/opal-fadump.c    |  116 ++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/pseries_fadump.c |    1 
 5 files changed, 245 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index c8eb166..30c555d 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -385,10 +385,10 @@ static unsigned long get_fadump_area_size(void)
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
@@ -1065,26 +1065,6 @@ static int fadump_create_elfcore_headers(char *bufp)
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
@@ -1102,15 +1082,15 @@ static int register_fadump(void)
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
@@ -1429,8 +1409,12 @@ int __init setup_fadump(void)
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
index b46c7da..8dac166 100644
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
@@ -121,6 +149,19 @@ u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
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
@@ -203,3 +244,54 @@ int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf)
 
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
index f59fdc7..5f2b3f2 100644
--- a/arch/powerpc/kernel/fadump_internal.h
+++ b/arch/powerpc/kernel/fadump_internal.h
@@ -89,6 +89,9 @@ struct fadump_reg_entry {
 
 #define FADUMP_CRASH_INFO_MAGIC		STR_TO_HEX("FADMPINF")
 
+/* Backup area support in this version */
+#define FADUMP_CRASH_INFO_MAGIC_V2	STR_TO_HEX("FADINFV2")
+
 /* fadump crash info structure */
 struct fadump_crash_info_header {
 	u64		magic_number;
@@ -100,6 +103,22 @@ struct fadump_crash_info_header {
 
 /* Platform specific callback functions */
 struct fadump_ops;
+
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
 #endif /* !CONFIG_PRESERVE_FA_DUMP */
 
 /* Firmware-Assited Dump platforms */
@@ -140,6 +159,8 @@ struct fw_dump {
 	unsigned long	reserve_dump_area_size;
 	unsigned long	meta_area_start;
 	unsigned long	preserv_area_start;
+	unsigned long	backup_area_start;
+	unsigned long	backup_area_size;
 	/* cmd line option during boot */
 	unsigned long	reserve_bootvar;
 
@@ -178,6 +199,7 @@ struct fw_dump {
 #ifndef CONFIG_PRESERVE_FA_DUMP
 struct fadump_ops {
 	ulong	(*init_fadump_mem_struct)(struct fw_dump *fadump_config);
+	ulong	(*init_fadump_header)(struct fw_dump *fadump_config);
 	int	(*register_fadump)(struct fw_dump *fadump_config);
 	int	(*unregister_fadump)(struct fw_dump *fadump_config);
 	int	(*invalidate_fadump)(struct fw_dump *fadump_config);
@@ -188,15 +210,21 @@ struct fadump_ops {
 				const char *msg);
 };
 
+/* Generic version of fadump operations */
+unsigned long generic_init_fadump_header(struct fw_dump *fadump_conf);
+
 /* Helper functions */
 void *fadump_cpu_notes_buf_alloc(unsigned long size);
 void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size);
 void fadump_set_meta_area_start(struct fw_dump *fadump_conf);
 void fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val);
 u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs);
+unsigned long get_fadump_elfcore_hdr_size(void);
 void fadump_update_elfcore_header(struct fw_dump *fadump_config, char *bufp);
 int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf);
 int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf);
+void init_fadump_backup_area(struct fw_dump *fadump_conf);
+unsigned long fadump_populate_backup_area(struct fw_dump *fadump_conf);
 #endif /* !CONFIG_PRESERVE_FA_DUMP */
 
 #if !defined(CONFIG_PRESERVE_FA_DUMP) && defined(CONFIG_PPC_PSERIES)
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index 06053fd..9ae1835 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -37,6 +37,39 @@ static struct opal_fadump_mem_struct fdm;
 extern bool kernel_initiated;
 #endif
 
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
@@ -128,6 +161,7 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 #ifndef CONFIG_PRESERVE_FA_DUMP
 	fadump_set_meta_area_start(fadump_conf);
 	opal_set_preserv_area_start(fadump_conf);
+	opal_set_backup_area_start(fadump_conf);
 #endif
 }
 
@@ -188,6 +222,41 @@ static ulong opal_init_fadump_mem_struct(struct fw_dump *fadump_conf)
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
@@ -253,6 +322,20 @@ static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
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
 /*
  * Read CPU state dump data and convert it into ELF notes.
  *
@@ -260,7 +343,8 @@ static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
  * a GPR/SPR flag in the first 8 bytes and the register value in the next
  * 8 bytes. For more details refer to F/W documentation.
  */
-static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
+static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf,
+					 struct fadump_backup_area *backup_info)
 {
 	u32 num_cpus, *note_buf;
 	struct fadump_crash_info_header *fdh = NULL;
@@ -271,7 +355,7 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 	struct pt_regs regs;
 	unsigned int size_of_each_thread;
 	unsigned int regs_offset, regs_cnt, reg_esize;
-	int i;
+	int i, cpu;
 
 	size_of_each_thread = fadump_conf->cpu_state_entry_size;
 	num_cpus = (fadump_conf->cpu_state_data_size / size_of_each_thread);
@@ -308,6 +392,11 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 	if (fadump_conf->fadumphdr_addr)
 		fdh = __va(fadump_conf->fadumphdr_addr);
 
+	if (backup_info->nr_threads != num_cpus) {
+		pr_warn("Calculated numcpus (%d) not same as populated value (%d)!\n",
+			num_cpus, backup_info->nr_threads);
+	}
+
 	pr_debug("--------CPU State Data------------\n");
 	pr_debug("NumCpus     : %u\n", num_cpus);
 	pr_debug("\tOffset: %u, Entry size: %u, Cnt: %u\n",
@@ -345,6 +434,13 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 			continue;
 		}
 
+		cpu = fadump_get_logical_cpu(backup_info, thread_pir);
+		if (cpu == CPU_UNKNOWN) {
+			pr_warn("Unable to get the logical CPU of PIR %d\n",
+				thread_pir);
+			continue;
+		}
+
 		fadump_read_registers((bufp + regs_offset), regs_cnt,
 				      reg_esize, true, &regs);
 
@@ -367,6 +463,8 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 {
 	struct fadump_crash_info_header *fdh;
+	struct fadump_backup_area *backup_info = NULL;
+	unsigned long addr;
 	int rc = 0;
 
 	if (!fdm_active || !fadump_conf->fadumphdr_addr)
@@ -374,7 +472,7 @@ static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 
 	/* Validate the fadump crash info header */
 	fdh = __va(fadump_conf->fadumphdr_addr);
-	if (fdh->magic_number != FADUMP_CRASH_INFO_MAGIC) {
+	if (fdh->magic_number != FADUMP_CRASH_INFO_MAGIC_V2) {
 		pr_err("Crash info header is not valid.\n");
 		return -EINVAL;
 	}
@@ -398,7 +496,14 @@ static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 	}
 #endif
 
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
 
@@ -470,6 +575,7 @@ static void opal_crash_fadump(struct fadump_crash_info_header *fdh,
 
 static struct fadump_ops opal_fadump_ops = {
 	.init_fadump_mem_struct	= opal_init_fadump_mem_struct,
+	.init_fadump_header	= opal_init_fadump_header,
 	.register_fadump	= opal_register_fadump,
 	.unregister_fadump	= opal_unregister_fadump,
 	.invalidate_fadump	= opal_invalidate_fadump,
@@ -553,6 +659,8 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 		}
 	}
 
+	fadump_conf->backup_area_size	= sizeof(struct fadump_backup_area);
+
 	fadump_conf->ops		= &opal_fadump_ops;
 	fadump_conf->fadump_platform	= FADUMP_PLATFORM_POWERNV;
 	fadump_conf->fadump_supported	= 1;
diff --git a/arch/powerpc/platforms/pseries/pseries_fadump.c b/arch/powerpc/platforms/pseries/pseries_fadump.c
index 2e2bd1e..b52bd20 100644
--- a/arch/powerpc/platforms/pseries/pseries_fadump.c
+++ b/arch/powerpc/platforms/pseries/pseries_fadump.c
@@ -461,6 +461,7 @@ static void pseries_crash_fadump(struct fadump_crash_info_header *fdh,
 
 static struct fadump_ops pseries_fadump_ops = {
 	.init_fadump_mem_struct	= pseries_init_fadump_mem_struct,
+	.init_fadump_header	= generic_init_fadump_header,
 	.register_fadump	= pseries_register_fadump,
 	.unregister_fadump	= pseries_unregister_fadump,
 	.invalidate_fadump	= pseries_invalidate_fadump,

