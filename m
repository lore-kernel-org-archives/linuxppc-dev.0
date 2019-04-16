Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD7DC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:50:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9972075B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9972075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k2Fn2y5lzDqLK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:50:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1wQ6RcdzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:35:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44k1wQ3Wmcz8vxw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:35:18 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44k1wQ29J6z9s55; Tue, 16 Apr 2019 20:35:18 +1000 (AEST)
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
 by ozlabs.org (Postfix) with ESMTPS id 44k1wP4s1Rz9s5c
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 20:35:17 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GAWIp3100090
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:35:15 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwb22ecap-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:35:15 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 16 Apr 2019 11:35:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:35:10 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GAZ8Gj60031072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:35:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63F7AAE051;
 Tue, 16 Apr 2019 10:35:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DCEAAE053;
 Tue, 16 Apr 2019 10:35:07 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.184.183.117])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:35:06 +0000 (GMT)
Subject: [PATCH v2 09/16] powernv/fadump: process architected register state
 data provided by firmware
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Apr 2019 16:05:06 +0530
In-Reply-To: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
References: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-4275-0000-0000-000003286468
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-4276-0000-0000-0000383794BF
Message-Id: <155541089317.812.14447001298006010972.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
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

Firmware provides architected register state data at the time of crash.
Process this data and build CPU notes to append to ELF core.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---

Changes in v2:
* Updated reg type values according to recent OPAL changes


 arch/powerpc/include/asm/opal-api.h          |   23 +++
 arch/powerpc/kernel/fadump-common.h          |    3 
 arch/powerpc/platforms/powernv/opal-fadump.c |  187 ++++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/opal-fadump.h |    4 +
 4 files changed, 206 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 75471c2..91f2735 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -976,6 +976,29 @@ struct opal_sg_list {
  * Firmware-Assisted Dump (FADump)
  */
 
+/* FADump thread header for register entries */
+struct opal_fadump_thread_hdr {
+	__be32  pir;
+	/* 0x00 - 0x0F - The corresponding stop state of the core */
+	u8      core_state;
+	u8      reserved[3];
+
+	__be32	offset;	/* Offset to Register Entries array */
+	__be32	ecnt;	/* Number of entries */
+	__be32	esize;	/* Alloc size of each array entry in bytes */
+	__be32	eactsz;	/* Actual size of each array entry in bytes */
+} __packed;
+
+#define OPAL_REG_TYPE_GPR		0x01
+#define OPAL_REG_TYPE_SPR		0x02
+
+/* FADump register entry. */
+struct opal_fadump_reg_entry {
+	__be32		reg_type;
+	__be32		reg_num;
+	__be64		reg_val;
+};
+
 /* The maximum number of dump sections supported by OPAL */
 #define OPAL_FADUMP_NR_SECTIONS			64
 
diff --git a/arch/powerpc/kernel/fadump-common.h b/arch/powerpc/kernel/fadump-common.h
index ff764d4..8d47382 100644
--- a/arch/powerpc/kernel/fadump-common.h
+++ b/arch/powerpc/kernel/fadump-common.h
@@ -117,6 +117,9 @@ struct fadump_memory_range {
 
 /* Firmware-assisted dump configuration details. */
 struct fw_dump {
+	unsigned long	cpu_state_destination_addr;
+	unsigned long	cpu_state_data_version;
+	unsigned long	cpu_state_entry_size;
 	unsigned long	cpu_state_data_size;
 	unsigned long	hpte_region_size;
 	unsigned long	boot_memory_size;
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index da8480d..853f663 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -94,6 +94,12 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 
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
@@ -199,6 +205,75 @@ static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
 	return 0;
 }
 
+static inline void fadump_set_regval_regnum(struct pt_regs *regs, u32 reg_type,
+					    u32 reg_num, u64 reg_val)
+{
+	if (reg_type == OPAL_REG_TYPE_GPR) {
+		if (reg_num < 32)
+			regs->gpr[reg_num] = reg_val;
+		return;
+	}
+
+	switch (reg_num) {
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
+static inline void fadump_read_registers(char *bufp, unsigned int regs_cnt,
+					 unsigned int reg_entry_size,
+					 struct pt_regs *regs)
+{
+	int i;
+	struct opal_fadump_reg_entry *reg_entry;
+
+	memset(regs, 0, sizeof(struct pt_regs));
+
+	for (i = 0; i < regs_cnt; i++, bufp += reg_entry_size) {
+		reg_entry = (struct opal_fadump_reg_entry *)bufp;
+		fadump_set_regval_regnum(regs,
+					 be32_to_cpu(reg_entry->reg_type),
+					 be32_to_cpu(reg_entry->reg_num),
+					 be64_to_cpu(reg_entry->reg_val));
+	}
+}
+
+static inline bool __init is_thread_core_inactive(u8 core_state)
+{
+	bool is_inactive = false;
+
+	/*
+	 * TODO: Check what each state value means and implement accordingly.
+	 *       Also, make sure F/W is updating this field appropriately.
+	 */
+	if (core_state == CORE_STATE_INACTIVE)
+		is_inactive = true;
+
+	return is_inactive;
+}
+
 /*
  * Read CPU state dump data and convert it into ELF notes.
  *
@@ -210,8 +285,32 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 {
 	u32 num_cpus, *note_buf;
 	struct fadump_crash_info_header *fdh = NULL;
+	struct opal_fadump_thread_hdr *thdr;
+	unsigned long addr;
+	u32 thread_pir;
+	char *bufp;
+	struct pt_regs regs;
+	unsigned int size_of_each_thread;
+	unsigned int regs_offset, regs_cnt, reg_esize;
+	int i;
+
+	size_of_each_thread = fadump_conf->cpu_state_entry_size;
+	num_cpus = (fadump_conf->cpu_state_data_size / size_of_each_thread);
+
+	addr = fadump_conf->cpu_state_destination_addr;
+	bufp = __va(addr);
+
+	/*
+	 * Offset for register entries, entry size and registers count is
+	 * duplicated in every thread header in keeping with HDAT format.
+	 * Use these values from the first thread header.
+	 */
+	thdr = (struct opal_fadump_thread_hdr *)bufp;
+	regs_offset = (offsetof(struct opal_fadump_thread_hdr, offset) +
+		       be32_to_cpu(thdr->offset));
+	reg_esize = be32_to_cpu(thdr->esize);
+	regs_cnt  = be32_to_cpu(thdr->ecnt);
 
-	num_cpus = 1;
 	/* Allocate buffer to hold cpu crash notes. */
 	fadump_conf->cpu_notes_buf_size = num_cpus * sizeof(note_buf_t);
 	fadump_conf->cpu_notes_buf_size =
@@ -230,10 +329,53 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 	if (fadump_conf->fadumphdr_addr)
 		fdh = __va(fadump_conf->fadumphdr_addr);
 
-	if (fdh && (fdh->crashing_cpu != CPU_UNKNOWN)) {
-		note_buf = fadump_regs_to_elf_notes(note_buf, &(fdh->regs));
-		final_note(note_buf);
+	pr_debug("--------CPU State Data------------\n");
+	pr_debug("NumCpus     : %u\n", num_cpus);
+	pr_debug("\tOffset: %u, Entry size: %u, Cnt: %u\n",
+		 regs_offset, reg_esize, regs_cnt);
+
+	for (i = 0; i < num_cpus; i++, bufp += size_of_each_thread) {
+		thdr = (struct opal_fadump_thread_hdr *)bufp;
+
+		thread_pir = be32_to_cpu(thdr->pir);
+		pr_debug("%04d) PIR: 0x%x, core state: 0x%02x\n",
+			 (i + 1), thread_pir, thdr->core_state);
+
+		/*
+		 * Register state data of MAX cores is provided by firmware,
+		 * but some of this cores may not be active. So, while
+		 * processing register state data, check core state and
+		 * skip threads that belong to inactive cores.
+		 */
+		if (is_thread_core_inactive(thdr->core_state))
+			continue;
+
+		/*
+		 * If this is kernel initiated crash, crashing_cpu would be set
+		 * appropriately and register data of the crashing CPU saved by
+		 * crashing kernel. Add this saved register data of crashing CPU
+		 * to elf notes and populate the pt_regs for the remaining CPUs
+		 * from register state data provided by firmware.
+		 */
+		if (fdh && (fdh->crashing_cpu == thread_pir)) {
+			note_buf = fadump_regs_to_elf_notes(note_buf,
+							    &fdh->regs);
+			pr_debug("Crashing CPU PIR: 0x%x - R1 : 0x%lx, NIP : 0x%lx\n",
+				 fdh->crashing_cpu, fdh->regs.gpr[1],
+				 fdh->regs.nip);
+			continue;
+		}
+
+		fadump_read_registers((bufp + regs_offset), regs_cnt,
+				      reg_esize, &regs);
+
+		note_buf = fadump_regs_to_elf_notes(note_buf, &regs);
+		pr_debug("CPU PIR: 0x%x - R1 : 0x%lx, NIP : 0x%lx\n",
+			 thread_pir, regs.gpr[1], regs.nip);
+	}
+	final_note(note_buf);
 
+	if (fdh) {
 		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
 			 fdh->elfcorehdr_addr);
 		fadump_update_elfcore_header(fadump_conf,
@@ -258,13 +400,6 @@ static int __init opal_process_fadump(struct fw_dump *fadump_conf)
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
@@ -319,6 +454,14 @@ static void opal_crash_fadump(struct fadump_crash_info_header *fdh,
 {
 	int rc;
 
+	/*
+	 * Unlike on pseries platform, logical CPU number is not provided
+	 * with architected register state data. So, store the crashing
+	 * CPU's PIR instead to plug the appropriate register data for
+	 * crashing CPU in the vmcore file.
+	 */
+	fdh->crashing_cpu = (u32)mfspr(SPRN_PIR);
+
 	rc = opal_cec_reboot2(OPAL_REBOOT_OS_ERROR, msg);
 	if (rc == OPAL_UNSUPPORTED) {
 		pr_emerg("Reboot type %d not supported.\n",
@@ -340,6 +483,7 @@ static struct fadump_ops opal_fadump_ops = {
 int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 {
 	unsigned long dn;
+	const __be32 *prop;
 
 	/*
 	 * Check if Firmware-Assisted Dump is supported. if yes, check
@@ -351,6 +495,17 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 		return 1;
 	}
 
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
@@ -365,6 +520,16 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
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
index a5eeb2c..80aee2d 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.h
+++ b/arch/powerpc/platforms/powernv/opal-fadump.h
@@ -13,6 +13,8 @@
 #ifndef __PPC64_OPAL_FA_DUMP_H__
 #define __PPC64_OPAL_FA_DUMP_H__
 
+#define CPU_STATE_DATA_VERSION		1
+
 #define OPAL_FADUMP_CPU_STATE_DATA	0x0000
 /* OPAL : 0x01 – 0x39 */
 #define OPAL_FADUMP_OPAL_REGION	0x0001
@@ -37,4 +39,6 @@ enum opal_fadump_section_types {
 #define OPAL_MAX_SECTIONS		(OPAL_SECTIONS + \
 					 MAX_REAL_MEM_REGIONS - 1)
 
+#define CORE_STATE_INACTIVE		(0x0F)
+
 #endif /* __PPC64_OPAL_FA_DUMP_H__ */

