Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8879DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:39:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AF920652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AF920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4451tt1dW4zDqRS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 04:39:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4451pB3rNXzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:35:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4451pB1FK9z8tWx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:35:30 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4451pB0WMVz9sCH; Fri, 22 Feb 2019 04:35:30 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 4451p94P9Xz9sBr
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2019 04:35:29 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LHQrfm069040
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:35:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qt00tsrk8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:35:27 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 21 Feb 2019 17:35:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Feb 2019 17:35:22 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1LHZK7D20774928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Feb 2019 17:35:20 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 614BDA405F;
 Thu, 21 Feb 2019 17:35:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96175A4062;
 Thu, 21 Feb 2019 17:35:18 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.32.125])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Feb 2019 17:35:18 +0000 (GMT)
Subject: [PATCH 01/18] powerpc/fadump: move internal fadump code to a new file
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Thu, 21 Feb 2019 23:05:17 +0530
In-Reply-To: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022117-0008-0000-0000-000002C34C6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022117-0009-0000-0000-0000222F889D
Message-Id: <155077051753.21014.6812896556432060987.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-21_10:, , signatures=0
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

Refactoring fadump code means internal fadump code is referenced from
different places. For ease, move internal code to a new file.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/include/asm/fadump.h     |  112 -------------------
 arch/powerpc/kernel/Makefile          |    2 
 arch/powerpc/kernel/fadump.c          |  194 ++-------------------------------
 arch/powerpc/kernel/fadump_internal.c |  184 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/fadump_internal.h |  126 +++++++++++++++++++++
 5 files changed, 324 insertions(+), 294 deletions(-)
 create mode 100644 arch/powerpc/kernel/fadump_internal.c
 create mode 100644 arch/powerpc/kernel/fadump_internal.h

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 188776b..028a8ef 100644
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
@@ -125,59 +88,8 @@ struct fadump_mem_struct {
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
-	unsigned long	nocma:1;
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
@@ -185,29 +97,9 @@ struct fadump_reg_save_area_header {
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
index cb7f0bb..eb50ac3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
-obj-$(CONFIG_FA_DUMP)		+= fadump.o
+obj-$(CONFIG_FA_DUMP)		+= fadump.o fadump_internal.o
 ifdef CONFIG_PPC32
 obj-$(CONFIG_E500)		+= idle_e500.o
 endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 45a8d0b..fcd50bd 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -44,12 +44,11 @@
 #include <asm/fadump.h>
 #include <asm/setup.h>
 
+#include "fadump_internal.h"
+
 static struct fw_dump fw_dump;
 static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
-#ifdef CONFIG_CMA
-static struct cma *fadump_cma;
-#endif
 
 static DEFINE_MUTEX(fadump_mutex);
 struct fad_crash_memory_ranges *crash_memory_ranges;
@@ -58,6 +57,8 @@ int crash_mem_ranges;
 int max_crash_mem_ranges;
 
 #ifdef CONFIG_CMA
+static struct cma *fadump_cma;
+
 /*
  * fadump_cma_init() - Initialize CMA area from a fadump reserved memory
  *
@@ -119,8 +120,8 @@ static int __init fadump_cma_init(void) { return 1; }
 #endif /* CONFIG_CMA */
 
 /* Scan the Firmware Assisted dump configuration details. */
-int __init early_init_dt_scan_fw_dump(unsigned long node,
-			const char *uname, int depth, void *data)
+int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
+				      int depth, void *data)
 {
 	const __be32 *sections;
 	int i, num_sections;
@@ -211,67 +212,6 @@ int is_fadump_active(void)
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
- * Returns true, if there are no holes in reserved memory area,
- * false otherwise.
- */
-static bool is_reserved_memory_area_contiguous(void)
-{
-	struct memblock_region *reg;
-	unsigned long start, end;
-	unsigned long d_start = fw_dump.reserve_dump_area_start;
-	unsigned long d_end = d_start + fw_dump.reserve_dump_area_size;
-
-	for_each_memblock(memory, reg) {
-		start = max(d_start, (unsigned long)reg->base);
-		end = min(d_end, (unsigned long)(reg->base + reg->size));
-		if (d_start < end) {
-			/* Memory hole from d_start to start */
-			if (start > d_start)
-				break;
-
-			if (end == d_end)
-				return true;
-
-			d_start = end + 1;
-		}
-	}
-
-	return false;
-}
-
 /* Print firmware assisted dump configurations for debugging purpose. */
 static void fadump_show_config(void)
 {
@@ -637,9 +577,9 @@ static int register_fw_dump(struct fadump_mem_struct *fdm)
 			" dump. Hardware Error(%d).\n", rc);
 		break;
 	case -3:
-		if (!is_boot_memory_area_contiguous())
+		if (!is_boot_memory_area_contiguous(&fw_dump))
 			pr_err("Can't have holes in boot memory area while registering fadump\n");
-		else if (!is_reserved_memory_area_contiguous())
+		else if (!is_reserved_memory_area_contiguous(&fw_dump))
 			pr_err("Can't have holes in reserved memory area while"
 			       " registering fadump\n");
 
@@ -709,52 +649,6 @@ void crash_fadump(struct pt_regs *regs, const char *str)
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
@@ -769,72 +663,6 @@ fadump_read_registers(struct fadump_reg_entry *reg_entry, struct pt_regs *regs)
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
@@ -924,9 +752,9 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
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
index 0000000..570c357
--- /dev/null
+++ b/arch/powerpc/kernel/fadump_internal.c
@@ -0,0 +1,184 @@
+/*
+ * Firmware-Assisted Dump internal code.
+ *
+ * Copyright 2018-2019, IBM Corp.
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
+ * Returns 1, if there are no holes in memory area between d_start to d_end,
+ * 0 otherwise.
+ */
+static int is_memory_area_contiguous(unsigned long d_start,
+				     unsigned long d_end)
+{
+	struct memblock_region *reg;
+	unsigned long start, end;
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
+
+/*
+ * Returns 1, if there are no holes in boot memory area,
+ * 0 otherwise.
+ */
+int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf)
+{
+	unsigned long d_start = RMA_START;
+	unsigned long d_end   = RMA_START + fadump_conf->boot_memory_size;
+
+	return is_memory_area_contiguous(d_start, d_end);
+}
+
+/*
+ * Returns 1, if there are no holes in reserved memory area,
+ * 0 otherwise.
+ */
+int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf)
+{
+	unsigned long d_start = fadump_conf->reserve_dump_area_start;
+	unsigned long d_end   = d_start + fadump_conf->reserve_dump_area_size;
+
+	return is_memory_area_contiguous(d_start, d_end);
+}
diff --git a/arch/powerpc/kernel/fadump_internal.h b/arch/powerpc/kernel/fadump_internal.h
new file mode 100644
index 0000000..8ccd96d
--- /dev/null
+++ b/arch/powerpc/kernel/fadump_internal.h
@@ -0,0 +1,126 @@
+/*
+ * Firmware-Assisted Dump internal code.
+ *
+ * Copyright 2018-2019, IBM Corp.
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
+/* Register entry. */
+struct fadump_reg_entry {
+	__be64		reg_id;
+	__be64		reg_value;
+};
+
+#define FADUMP_CRASH_INFO_MAGIC		STR_TO_HEX("FADMPINF")
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
+	unsigned long	nocma:1;
+};
+
+/* Helper functions */
+void *fadump_cpu_notes_buf_alloc(unsigned long size);
+void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size);
+void fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val);
+u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs);
+void fadump_update_elfcore_header(struct fw_dump *fadump_config, char *bufp);
+int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf);
+int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf);
+
+#endif /* __PPC64_FA_DUMP_INTERNAL_H__ */

