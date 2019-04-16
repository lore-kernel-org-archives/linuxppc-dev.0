Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF69C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:43:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D58206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D58206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k25r39pwzDqJ1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:43:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1vT5jsLzDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:34:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44k1vT1gvpz8vrn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:34:29 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44k1vT19H3z9s55; Tue, 16 Apr 2019 20:34:29 +1000 (AEST)
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
 by ozlabs.org (Postfix) with ESMTPS id 44k1vS3CbGz9s70
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 20:34:28 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GAWHEJ100026
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:34:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwb22eb1n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:34:26 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 16 Apr 2019 11:34:23 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:34:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GAYJvn49348706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:34:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB85E42045;
 Tue, 16 Apr 2019 10:34:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E0A742047;
 Tue, 16 Apr 2019 10:34:17 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.184.183.117])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:34:17 +0000 (GMT)
Subject: [PATCH v2 05/16] powerpc/fadump: enable fadump support on OPAL
 based POWER platform
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Apr 2019 16:04:16 +0530
In-Reply-To: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
References: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0020-0000-0000-000003305E6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0021-0000-0000-00002182A203
Message-Id: <155541083708.812.9990556226002312899.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160072
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Stewart Smith <stewart@linux.ibm.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

Firmware-assisted dump support is enabled for OPAL based POWER platforms
in P9 firmware. Make the corresponding updates in kernel to enable fadump
support for such platforms.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---

Changes in v2:
* Updated API number for FADump according to recent OPAL changes


 arch/powerpc/Kconfig                         |    5 
 arch/powerpc/include/asm/opal-api.h          |   35 ++
 arch/powerpc/include/asm/opal.h              |    1 
 arch/powerpc/kernel/fadump-common.c          |   27 ++
 arch/powerpc/kernel/fadump-common.h          |   44 ++-
 arch/powerpc/kernel/fadump.c                 |  259 ++++++++++++++----
 arch/powerpc/platforms/powernv/Makefile      |    1 
 arch/powerpc/platforms/powernv/opal-call.c   |    1 
 arch/powerpc/platforms/powernv/opal-fadump.c |  375 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-fadump.h |   40 +++
 arch/powerpc/platforms/pseries/rtas-fadump.c |   18 -
 11 files changed, 716 insertions(+), 90 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82..2366a84 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -556,7 +556,7 @@ config CRASH_DUMP
 
 config FA_DUMP
 	bool "Firmware-assisted dump"
-	depends on PPC64 && PPC_RTAS
+	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
 	select CRASH_CORE
 	select CRASH_DUMP
 	help
@@ -567,7 +567,8 @@ config FA_DUMP
 	  is meant to be a kdump replacement offering robustness and
 	  speed not possible without system firmware assistance.
 
-	  If unsure, say "N"
+	  If unsure, say "y". Only special kernels like petitboot may
+	  need to say "N" here.
 
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b..75471c2 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -210,7 +210,8 @@
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
 #define	OPAL_NX_COPROC_INIT			167
-#define OPAL_LAST				167
+#define OPAL_CONFIGURE_FADUMP			173
+#define OPAL_LAST				173
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
@@ -972,6 +973,37 @@ struct opal_sg_list {
 };
 
 /*
+ * Firmware-Assisted Dump (FADump)
+ */
+
+/* The maximum number of dump sections supported by OPAL */
+#define OPAL_FADUMP_NR_SECTIONS			64
+
+/* Kernel Dump section info */
+struct opal_fadump_section {
+	u8	src_type;
+	u8	reserved[7];
+	__be64	src_addr;
+	__be64	src_size;
+	__be64	dest_addr;
+	__be64	dest_size;
+};
+
+/*
+ * FADump memory structure for registering dump support with
+ * POWER f/w through opal call.
+ */
+struct opal_fadump_mem_struct {
+
+	__be16	section_size;		/*sizeof(struct fadump_section) */
+	__be16	section_count;		/* number of sections */
+	__be32	crashing_cpu;		/* Thread on which OPAL crashed */
+	__be64	reserved;
+
+	struct opal_fadump_section	section[OPAL_FADUMP_NR_SECTIONS];
+};
+
+/*
  * Dump region ID range usable by the OS
  */
 #define OPAL_DUMP_REGION_HOST_START		0x80
@@ -1051,6 +1083,7 @@ enum {
 	OPAL_REBOOT_NORMAL		= 0,
 	OPAL_REBOOT_PLATFORM_ERROR	= 1,
 	OPAL_REBOOT_FULL_IPL		= 2,
+	OPAL_REBOOT_OS_ERROR		= 3,
 };
 
 /* Argument to OPAL_PCI_TCE_KILL */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index a55b01c..2123b3f 100644
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
diff --git a/arch/powerpc/kernel/fadump-common.c b/arch/powerpc/kernel/fadump-common.c
index 0182886..514bbb5 100644
--- a/arch/powerpc/kernel/fadump-common.c
+++ b/arch/powerpc/kernel/fadump-common.c
@@ -10,6 +10,9 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#undef DEBUG
+#define pr_fmt(fmt) "fadump: " fmt
+
 #include <linux/memblock.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
@@ -48,6 +51,15 @@ void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size)
 	__free_pages(page, order);
 }
 
+void fadump_set_meta_area_start(struct fw_dump *fadump_conf)
+{
+	fadump_conf->meta_area_start = (fadump_conf->rmr_destination_addr +
+					fadump_conf->rmr_source_len);
+
+	pr_debug("Meta area start address: 0x%lx\n",
+		 fadump_conf->meta_area_start);
+}
+
 #define GPR_MASK	0xffffff0000000000
 static inline int fadump_gpr_index(u64 id)
 {
@@ -165,10 +177,19 @@ static int is_memory_area_contiguous(unsigned long d_start,
  */
 int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf)
 {
-	unsigned long d_start = RMA_START;
-	unsigned long d_end   = RMA_START + fadump_conf->boot_memory_size;
+	int i, ret = 0;
+	unsigned long d_start, d_end;
 
-	return is_memory_area_contiguous(d_start, d_end);
+	for (i = 0; i < fadump_conf->rmr_regions_cnt; i++) {
+		d_start = fadump_conf->rmr_src_addr[i];
+		d_end   = d_start + fadump_conf->rmr_src_size[i];
+
+		ret = is_memory_area_contiguous(d_start, d_end);
+		if (!ret)
+			break;
+	}
+
+	return ret;
 }
 
 /*
diff --git a/arch/powerpc/kernel/fadump-common.h b/arch/powerpc/kernel/fadump-common.h
index f926145..8ad98db 100644
--- a/arch/powerpc/kernel/fadump-common.h
+++ b/arch/powerpc/kernel/fadump-common.h
@@ -47,12 +47,6 @@
 #define FADUMP_UNREGISTER		2
 #define FADUMP_INVALIDATE		3
 
-/* Firmware-Assited Dump platforms */
-enum fadump_platform_type {
-	FADUMP_PLATFORM_UNKNOWN = 0,
-	FADUMP_PLATFORM_PSERIES,
-};
-
 #define FADUMP_CPU_ID_MASK		((1UL << 32) - 1)
 
 #define CPU_UNKNOWN			(~((u32)0))
@@ -92,13 +86,23 @@ struct fadump_crash_info_header {
 	struct cpumask	online_mask;
 };
 
-struct fad_crash_memory_ranges {
+/* Platform specific callback functions */
+struct fadump_ops;
+
+/* Firmware-Assited Dump platforms */
+enum fadump_platform_type {
+	FADUMP_PLATFORM_UNKNOWN = 0,
+	FADUMP_PLATFORM_PSERIES,
+	FADUMP_PLATFORM_POWERNV,
+};
+
+struct fadump_memory_range {
 	unsigned long long	base;
 	unsigned long long	size;
 };
 
-/* Platform specific callback functions */
-struct fadump_ops;
+/* Maximum no. of real memory regions supported by the kernel */
+#define MAX_REAL_MEM_REGIONS		8
 
 /* Firmware-assisted dump configuration details. */
 struct fw_dump {
@@ -119,6 +123,17 @@ struct fw_dump {
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
@@ -146,6 +161,7 @@ struct fadump_ops {
 /* Helper functions */
 void *fadump_cpu_notes_buf_alloc(unsigned long size);
 void fadump_cpu_notes_buf_free(unsigned long vaddr, unsigned long size);
+void fadump_set_meta_area_start(struct fw_dump *fadump_conf);
 void fadump_set_regval(struct pt_regs *regs, u64 reg_id, u64 reg_val);
 u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs);
 void fadump_update_elfcore_header(struct fw_dump *fadump_config, char *bufp);
@@ -162,4 +178,14 @@ pseries_dt_scan_fadump(struct fw_dump *fadump_config, ulong node)
 }
 #endif
 
+#ifdef CONFIG_PPC_POWERNV
+extern int opal_dt_scan_fadump(struct fw_dump *fadump_config, ulong node);
+#else
+static inline int
+opal_dt_scan_fadump(struct fw_dump *fadump_config, ulong node)
+{
+	return 1;
+}
+#endif
+
 #endif /* __PPC64_FA_DUMP_INTERNAL_H__ */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index b5c265e..913ab6e 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -48,7 +48,7 @@
 static struct fw_dump fw_dump;
 
 static DEFINE_MUTEX(fadump_mutex);
-struct fad_crash_memory_ranges *crash_memory_ranges;
+struct fadump_memory_range *crash_memory_ranges;
 int crash_memory_ranges_size;
 int crash_mem_ranges;
 int max_crash_mem_ranges;
@@ -126,6 +126,9 @@ int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
 	if (strcmp(uname, "rtas") == 0)
 		return pseries_dt_scan_fadump(&fw_dump, node);
 
+	if (strcmp(uname, "ibm,opal") == 0)
+		return opal_dt_scan_fadump(&fw_dump, node);
+
 	return 0;
 }
 
@@ -137,6 +140,7 @@ int is_fadump_memory_area(u64 addr, ulong size)
 {
 	u64 d_start = fw_dump.reserve_dump_area_start;
 	u64 d_end = d_start + fw_dump.reserve_dump_area_size;
+	u64 b_end = fw_dump.boot_memory_size + fw_dump.boot_memory_hole_size;
 
 	if (!fw_dump.dump_registered)
 		return 0;
@@ -144,7 +148,7 @@ int is_fadump_memory_area(u64 addr, ulong size)
 	if (((addr + size) > d_start) && (addr <= d_end))
 		return 1;
 
-	return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
+	return (((addr + size) > RMA_START) && (addr <= b_end));
 }
 
 int should_fadump_crash(void)
@@ -162,6 +166,8 @@ int is_fadump_active(void)
 /* Print firmware assisted dump configurations for debugging purpose. */
 static void fadump_show_config(void)
 {
+	int i;
+
 	pr_debug("Support for firmware-assisted dump (fadump): %s\n",
 			(fw_dump.fadump_supported ? "present" : "no support"));
 
@@ -176,6 +182,13 @@ static void fadump_show_config(void)
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
@@ -270,39 +283,122 @@ static unsigned long get_fadump_area_size(void)
 	return size;
 }
 
-static void __init fadump_reserve_crash_area(unsigned long base,
-					     unsigned long size)
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
+	}
+
+	return ret;
+}
+
+static int __init fadump_get_rmr_regions(void)
+{
+	int ret = 1;
+	struct memblock_region *reg;
+	unsigned long base, size, cur_size, last_end;
+	unsigned long mem_size = fw_dump.boot_memory_size;
+
+	fw_dump.rmr_regions_cnt = 0;
+	fw_dump.boot_memory_hole_size = 0;
+
+	last_end = 0;
+	cur_size = 0;
+	for_each_memblock(memory, reg) {
+		base = reg->base;
+		size = reg->size;
+		fw_dump.boot_memory_hole_size += (base - last_end);
+
+		if ((cur_size + size) >= mem_size) {
+			size = (mem_size - cur_size);
+			ret = add_rmr_regions(base, size);
+			break;
+		}
+
+		mem_size -= size;
+		cur_size += size;
+		ret = add_rmr_regions(base, size);
+		if (!ret)
+			break;
+
+		last_end = base + size;
+	}
+
+	return ret;
+}
+
+/* Preserve everything above the base address */
+static void __init fadump_reserve_crash_area(unsigned long base)
 {
 	struct memblock_region *reg;
-	unsigned long mstart, mend, msize;
+	unsigned long mstart, msize;
 
 	for_each_memblock(memory, reg) {
-		mstart = max_t(unsigned long, base, reg->base);
-		mend = reg->base + reg->size;
-		mend = min(base + size, mend);
-
-		if (mstart < mend) {
-			msize = mend - mstart;
-			memblock_reserve(mstart, msize);
-			pr_info("Reserved %ldMB of memory at %#016lx for saving crash dump\n",
-				(msize >> 20), mstart);
+		mstart = reg->base;
+		msize  = reg->size;
+
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
 	}
 }
 
 int __init fadump_reserve_mem(void)
 {
+	int ret = 1;
 	unsigned long base, size, memory_boundary;
 
 	if (!fw_dump.fadump_enabled)
 		return 0;
 
 	if (!fw_dump.fadump_supported) {
-		printk(KERN_INFO "Firmware-assisted dump is not supported on"
-				" this hardware\n");
-		fw_dump.fadump_enabled = 0;
-		return 0;
+		pr_info("Firmware-Assisted Dump is not supported on this hardware\n");
+		goto error_out;
 	}
+
 	/*
 	 * Initialize boot memory size
 	 * If dump is active then we have already calculated the size during
@@ -319,9 +415,14 @@ int __init fadump_reserve_mem(void)
 							FADUMP_CMA_ALIGNMENT);
 #endif
 		fw_dump.rmr_source_len = fw_dump.boot_memory_size;
+		if (!fadump_get_rmr_regions()) {
+			pr_err("Too many holes in boot memory area to enable fadump\n");
+			goto error_out;
+		}
 	}
 
 	size = get_fadump_area_size();
+	fw_dump.reserve_dump_area_size = size;
 
 	/*
 	 * Calculate the memory boundary.
@@ -342,6 +443,8 @@ int __init fadump_reserve_mem(void)
 	else
 		memory_boundary = memblock_end_of_DRAM();
 
+	base = fw_dump.boot_memory_size + fw_dump.boot_memory_hole_size;
+	base = PAGE_ALIGN(base);
 	if (fw_dump.dump_active) {
 #ifdef CONFIG_HUGETLB_PAGE
 		/*
@@ -353,18 +456,15 @@ int __init fadump_reserve_mem(void)
 #endif
 		/*
 		 * If last boot has crashed then reserve all the memory
-		 * above boot_memory_size so that we don't touch it until
+		 * above boot memory size so that we don't touch it until
 		 * dump is written to disk by userspace tool. This memory
-		 * will be released for general use once the dump is saved.
+		 * can be released for general use by invalidating fadump.
 		 */
-		base = fw_dump.boot_memory_size;
-		size = memory_boundary - base;
-		fadump_reserve_crash_area(base, size);
+		fadump_reserve_crash_area(base);
 
 		fw_dump.fadumphdr_addr = fw_dump.meta_area_start;
 		pr_debug("fadumphdr_addr = %#016lx\n", fw_dump.fadumphdr_addr);
 		fw_dump.reserve_dump_area_start = base;
-		fw_dump.reserve_dump_area_size = size;
 	} else {
 		/*
 		 * Reserve memory at an offset closer to bottom of the RAM to
@@ -372,30 +472,32 @@ int __init fadump_reserve_mem(void)
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
-			return 0;
+			goto error_out;
 		}
 
-		pr_info("Reserved %ldMB of memory at %ldMB for firmware-"
-			"assisted dump (System RAM: %ldMB)\n",
-			(unsigned long)(size >> 20),
-			(unsigned long)(base >> 20),
+		pr_info("Reserved %ldMB of memory at %#016lx (System RAM: %ldMB)\n",
+			(unsigned long)(size >> 20), base,
 			(unsigned long)(memblock_phys_mem_size() >> 20));
 
 		fw_dump.reserve_dump_area_start = base;
-		fw_dump.reserve_dump_area_size = size;
-		return fadump_cma_init();
+		ret = fadump_cma_init();
 	}
-	return 1;
+
+	return ret;
+error_out:
+	fw_dump.fadump_enabled = 0;
+	return 0;
 }
 
 unsigned long __init arch_reserved_kernel_pages(void)
@@ -494,7 +596,7 @@ static void free_crash_memory_ranges(void)
  */
 static int allocate_crash_memory_ranges(void)
 {
-	struct fad_crash_memory_ranges *new_array;
+	struct fadump_memory_range *new_array;
 	u64 new_size;
 
 	new_size = crash_memory_ranges_size + PAGE_SIZE;
@@ -511,7 +613,7 @@ static int allocate_crash_memory_ranges(void)
 	crash_memory_ranges = new_array;
 	crash_memory_ranges_size = new_size;
 	max_crash_mem_ranges = (new_size /
-				sizeof(struct fad_crash_memory_ranges));
+				sizeof(struct fadump_memory_range));
 	return 0;
 }
 
@@ -623,36 +725,40 @@ static int fadump_init_elfcore_header(char *bufp)
 static int fadump_setup_crash_memory_ranges(void)
 {
 	struct memblock_region *reg;
-	unsigned long long start, end;
-	int ret;
+	unsigned long long start, end, offset;
+	int i, ret;
 
 	pr_debug("Setup crash memory ranges.\n");
 	crash_mem_ranges = 0;
+	offset = fw_dump.boot_memory_size + fw_dump.boot_memory_hole_size;
 
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
-	ret = fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
-	if (ret)
-		return ret;
+	for (i = 0; i < fw_dump.rmr_regions_cnt; i++) {
+		start = fw_dump.rmr_src_addr[i];
+		end = start + fw_dump.rmr_src_size[i];
+		ret = fadump_add_crash_memory(start, end);
+		if (ret)
+			return ret;
+	}
 
 	for_each_memblock(memory, reg) {
 		start = (unsigned long long)reg->base;
 		end = start + (unsigned long long)reg->size;
 
 		/*
-		 * skip the first memory chunk that is already added (RMA_START
+		 * Skip the first memory chunk that is already added (RMA_START
 		 * through boot_memory_size). This logic needs a relook if and
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
@@ -673,17 +779,35 @@ static int fadump_setup_crash_memory_ranges(void)
  */
 static inline unsigned long fadump_relocate(unsigned long paddr)
 {
-	if (paddr > RMA_START && paddr < fw_dump.boot_memory_size)
-		return fw_dump.rmr_destination_addr + paddr;
-	else
-		return paddr;
+	unsigned long raddr, rstart, rend, rlast, hole_size;
+	int i;
+
+	hole_size = 0;
+	rlast = 0;
+	raddr = paddr;
+	for (i = 0; i < fw_dump.rmr_regions_cnt; i++) {
+		rstart = fw_dump.rmr_src_addr[i];
+		rend = rstart + fw_dump.rmr_src_size[i];
+		hole_size += (rstart - rlast);
+
+		if (paddr >= rstart && paddr < rend) {
+			raddr += fw_dump.rmr_destination_addr - hole_size;
+			break;
+		}
+
+		rlast = rend;
+	}
+
+	pr_debug("vmcoreinfo: paddr = 0x%lx, raddr = 0x%lx\n", paddr, raddr);
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
@@ -726,9 +850,12 @@ static int fadump_create_elfcore_headers(char *bufp)
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
 
@@ -741,13 +868,17 @@ static int fadump_create_elfcore_headers(char *bufp)
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
@@ -913,14 +1044,14 @@ static void fadump_invalidate_release_mem(void)
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
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index da2e99e..43a6e1c 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,6 +6,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
+obj-$(CONFIG_FA_DUMP)	+= opal-fadump.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index daad8c4..ead4ffc 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -282,3 +282,4 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
 OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
 OPAL_CALL(opal_nx_coproc_init,			OPAL_NX_COPROC_INIT);
+OPAL_CALL(opal_configure_fadump,		OPAL_CONFIGURE_FADUMP);
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
new file mode 100644
index 0000000..da8480d
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -0,0 +1,375 @@
+/*
+ * Firmware-Assisted Dump support on POWER platform (OPAL).
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
+#undef DEBUG
+#define pr_fmt(fmt) "opal fadump: " fmt
+
+#include <linux/string.h>
+#include <linux/memblock.h>
+#include <linux/bug.h>
+#include <linux/seq_file.h>
+#include <linux/crash_dump.h>
+#include <linux/libfdt.h>
+
+#include <asm/page.h>
+#include <asm/prom.h>
+#include <asm/opal.h>
+#include <asm/fadump.h>
+
+#include "../../kernel/fadump-common.h"
+#include "opal-fadump.h"
+
+static struct opal_fadump_mem_struct fdm;
+static const struct opal_fadump_mem_struct *fdm_active;
+unsigned long fdm_actual_size;
+
+static void opal_set_preserv_area_start(struct fw_dump *fadump_conf)
+{
+	fadump_conf->preserv_area_start = fadump_conf->rmr_destination_addr;
+
+	pr_debug("Preserve area start address: 0x%lx\n",
+		 fadump_conf->preserv_area_start);
+}
+
+static void update_fadump_config(struct fw_dump *fadump_conf,
+				 const struct opal_fadump_mem_struct *fdm)
+{
+	unsigned long base, size, last_end;
+	int section_cnt = be16_to_cpu(fdm->section_count);
+	int unused_sections  = (OPAL_MAX_SECTIONS - section_cnt);
+	int i, j;
+
+	pr_debug("section_cnt: %d\n", section_cnt);
+	BUILD_BUG_ON(OPAL_MAX_SECTIONS > OPAL_FADUMP_NR_SECTIONS);
+	WARN_ON(unused_sections < 0);
+	fdm_actual_size = sizeof(*fdm) -
+		(unused_sections * sizeof(struct opal_fadump_section));
+
+	/*
+	 * The first real memory region entry is the real memory
+	 * regions destination address.
+	 */
+	fadump_conf->rmr_destination_addr = 0;
+	for (i = 0; i < section_cnt; i++) {
+		if (fdm->section[i].src_type ==
+		    OPAL_FADUMP_REAL_MODE_REGION) {
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
+			    OPAL_FADUMP_REAL_MODE_REGION) {
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
+
+	fadump_set_meta_area_start(fadump_conf);
+	opal_set_preserv_area_start(fadump_conf);
+}
+
+static ulong opal_init_fadump_mem_struct(struct fw_dump *fadump_conf)
+{
+	ulong addr = fadump_conf->reserve_dump_area_start;
+	int i, section_cnt = 0;
+
+	fdm.section_size = cpu_to_be16(sizeof(struct opal_fadump_section));
+
+	/* RMA region sections */
+	for (i = 0; i < fadump_conf->rmr_regions_cnt; i++) {
+		fdm.section[RMR_REGION_INPUT_IDX + i].src_type  =
+			OPAL_FADUMP_REAL_MODE_REGION;
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
+static int opal_register_fadump(struct fw_dump *fadump_conf)
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
+static int opal_unregister_fadump(struct fw_dump *fadump_conf)
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
+static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
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
+ *
+ * Each register entry is of 16 bytes, A numerical identifier along with
+ * a GPR/SPR flag in the first 8 bytes and the register value in the next
+ * 8 bytes. For more details refer to F/W documentation.
+ */
+static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
+{
+	u32 num_cpus, *note_buf;
+	struct fadump_crash_info_header *fdh = NULL;
+
+	num_cpus = 1;
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
+static int __init opal_process_fadump(struct fw_dump *fadump_conf)
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
+static void opal_fadump_region_show(struct fw_dump *fadump_conf,
+				    struct seq_file *m)
+{
+	int i;
+	const struct opal_fadump_mem_struct *fdm_ptr;
+
+	if (fdm_active)
+		fdm_ptr = fdm_active;
+	else
+		fdm_ptr = &fdm;
+
+	seq_puts(m, "-------------------------------------------------------");
+	seq_puts(m, "-----------------------------\n");
+	seq_puts(m, "|      |               Source                |         ");
+	seq_puts(m, "    Destination             |\n");
+	seq_puts(m, "-      ------------------------------------------------");
+	seq_puts(m, "-----------------------------\n");
+	seq_puts(m, "| Type |     Address      |       Size       |      ");
+	seq_puts(m, "Address     |       Size       |\n");
+	seq_puts(m, "-------------------------------------------------------");
+	seq_puts(m, "-----------------------------\n");
+
+	for (i = 0; i < be16_to_cpu(fdm_ptr->section_count); i++) {
+		seq_printf(m, "|%5u | %016llx | %016llx | %016llx | %016llx |\n",
+			      fdm_ptr->section[i].src_type,
+			      be64_to_cpu(fdm_ptr->section[i].src_addr),
+			      be64_to_cpu(fdm_ptr->section[i].src_size),
+			      be64_to_cpu(fdm_ptr->section[i].dest_addr),
+			      be64_to_cpu(fdm_ptr->section[i].dest_size));
+		seq_puts(m, "-----------------------------------------------");
+		seq_puts(m, "-------------------------------------\n");
+	}
+
+}
+
+static void opal_crash_fadump(struct fadump_crash_info_header *fdh,
+			      const char *msg)
+{
+	int rc;
+
+	rc = opal_cec_reboot2(OPAL_REBOOT_OS_ERROR, msg);
+	if (rc == OPAL_UNSUPPORTED) {
+		pr_emerg("Reboot type %d not supported.\n",
+			 OPAL_REBOOT_OS_ERROR);
+	} else if (rc == OPAL_HARDWARE)
+		pr_emerg("No backend support for MPIPL!\n");
+}
+
+static struct fadump_ops opal_fadump_ops = {
+	.init_fadump_mem_struct	= opal_init_fadump_mem_struct,
+	.register_fadump	= opal_register_fadump,
+	.unregister_fadump	= opal_unregister_fadump,
+	.invalidate_fadump	= opal_invalidate_fadump,
+	.process_fadump		= opal_process_fadump,
+	.fadump_region_show	= opal_fadump_region_show,
+	.crash_fadump		= opal_crash_fadump,
+};
+
+int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
+{
+	unsigned long dn;
+
+	/*
+	 * Check if Firmware-Assisted Dump is supported. if yes, check
+	 * if dump has been initiated on last reboot.
+	 */
+	dn = of_get_flat_dt_subnode_by_name(node, "dump");
+	if (dn == -FDT_ERR_NOTFOUND) {
+		pr_debug("FADump support is missing!\n");
+		return 1;
+	}
+
+	/*
+	 * Firmware currently supports only 32-bit value for size,
+	 * align it to 1MB size.
+	 */
+	fadump_conf->max_copy_size = _ALIGN_DOWN(0xFFFFFFFF, (1 << 20));
+
+	/*
+	 * Check if dump has been initiated on last reboot.
+	 */
+	fdm_active = of_get_flat_dt_prop(dn, "result-table", NULL);
+	if (fdm_active) {
+		pr_info("Firmware-assisted dump is active.\n");
+		fadump_conf->dump_active = 1;
+		update_fadump_config(fadump_conf, (void *)__pa(fdm_active));
+	}
+
+	fadump_conf->ops		= &opal_fadump_ops;
+	fadump_conf->fadump_platform	= FADUMP_PLATFORM_POWERNV;
+	fadump_conf->fadump_supported	= 1;
+
+	return 1;
+}
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.h b/arch/powerpc/platforms/powernv/opal-fadump.h
new file mode 100644
index 0000000..a5eeb2c
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-fadump.h
@@ -0,0 +1,40 @@
+/*
+ * Firmware-Assisted Dump support on POWER platform (OPAL).
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
+#ifndef __PPC64_OPAL_FA_DUMP_H__
+#define __PPC64_OPAL_FA_DUMP_H__
+
+#define OPAL_FADUMP_CPU_STATE_DATA	0x0000
+/* OPAL : 0x01 – 0x39 */
+#define OPAL_FADUMP_OPAL_REGION	0x0001
+/* Firmware/SMF : 0x40 – 0x79 */
+#define OPAL_FADUMP_FW_REGION	0x0040
+/* Kernel memory region : 0x80 – 0xb9 */
+#define OPAL_FADUMP_REAL_MODE_REGION	0x0080
+/* Reserved for future use : 0xc0 – 0xff */
+#define OPAL_FADUMP_RESERVED_REGION	0x00c0
+
+enum opal_fadump_section_types {
+	CPU_STATE_TYPE		= 0,
+	OPAL_REGION_TYPE,
+	FW_REGION_TYPE,
+	RMR_REGION_TYPE,
+	OPAL_SECTIONS
+};
+
+/* Starting index of RMR region in dump sections while registering */
+#define RMR_REGION_INPUT_IDX		0
+
+#define OPAL_MAX_SECTIONS		(OPAL_SECTIONS + \
+					 MAX_REAL_MEM_REGIONS - 1)
+
+#endif /* __PPC64_OPAL_FA_DUMP_H__ */
diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
index 2e6678c..9c4c45c 100644
--- a/arch/powerpc/platforms/pseries/rtas-fadump.c
+++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
@@ -49,15 +49,6 @@ static void pseries_set_preserv_area_start(struct fw_dump *fadump_conf)
 		 fadump_conf->preserv_area_start);
 }
 
-static void pseries_set_meta_area_start(struct fw_dump *fadump_conf)
-{
-	fadump_conf->meta_area_start = (fadump_conf->rmr_destination_addr +
-					fadump_conf->rmr_source_len);
-
-	pr_debug("Meta area start address: 0x%lx\n",
-		 fadump_conf->meta_area_start);
-}
-
 static void update_fadump_config(struct fw_dump *fadump_conf,
 				 const struct pseries_fadump_mem_struct *fdm)
 {
@@ -65,11 +56,16 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 		be64_to_cpu(fdm->rmr_region.destination_address);
 
 	if (fadump_conf->dump_active) {
-		fadump_conf->rmr_source_len =
+		fadump_conf->rmr_src_addr[0] =
+			be64_to_cpu(fdm->rmr_region.source_address);
+		fadump_conf->rmr_src_size[0] =
 			be64_to_cpu(fdm->rmr_region.source_len);
+		fadump_conf->rmr_regions_cnt = 1;
+		fadump_conf->rmr_source_len = fadump_conf->rmr_src_size[0];
+		fadump_conf->boot_memory_hole_size = 0;
 	}
 
-	pseries_set_meta_area_start(fadump_conf);
+	fadump_set_meta_area_start(fadump_conf);
 	pseries_set_preserv_area_start(fadump_conf);
 }
 

