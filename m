Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A33C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:56:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A8920818
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A8920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4452Gt2Fp5zDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 04:56:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4451qs1bcszDqM6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:36:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4451qr5QWsz8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:36:56 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4451qr3Vlsz9sCH; Fri, 22 Feb 2019 04:36:56 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 4451qq5hX8z9sD4
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2019 04:36:55 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LHa5Fq007268
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:36:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qsy6p4ehm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:36:53 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 21 Feb 2019 17:36:51 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Feb 2019 17:36:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1LHalIS16580710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Feb 2019 17:36:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07B4CA404D;
 Thu, 21 Feb 2019 17:36:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D5CAA4051;
 Thu, 21 Feb 2019 17:36:45 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.32.125])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Feb 2019 17:36:45 +0000 (GMT)
Subject: [PATCH 12/18] powerpc/powernv: export /proc/opalcore for analysing
 opal crashes
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Thu, 21 Feb 2019 23:06:44 +0530
In-Reply-To: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022117-0008-0000-0000-000002C34C91
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022117-0009-0000-0000-0000222F88C3
Message-Id: <155077060437.21014.1614597045889633641.stgit@hbathini.in.ibm.com>
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

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

Export /proc/opalcore file to analyze opal crashes. Since opalcore can
be generated independent of CONFIG_FA_DUMP support in kernel, add this
support under a new kernel config option CONFIG_OPAL_CORE. Also, avoid
code duplication by moving common code used for processing the register
state data to export /proc/vmcore and/or /proc/opalcore file(s).

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig                         |    9 
 arch/powerpc/platforms/powernv/Makefile      |    1 
 arch/powerpc/platforms/powernv/opal-core.c   |  563 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-fadump.c |   94 +---
 arch/powerpc/platforms/powernv/opal-fadump.h |   72 +++
 5 files changed, 669 insertions(+), 70 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-core.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 964a3ba..2c08c3b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -591,6 +591,15 @@ config PRESERVE_FA_DUMP
 	  memory preserving kernel boot would process this crash data.
 	  Petitboot kernel is the typical usecase for this option.
 
+config OPAL_CORE
+	bool "Export OPAL memory as /proc/opalcore"
+	depends on PPC64 && PPC_POWERNV
+	help
+	  This option uses the MPIPL support in firmware to provide
+	  an ELF core of OPAL memory after a crash. The ELF core is
+	  exported as /proc/opalcore file which is helpful in debugging
+	  opal crashes using GDB.
+
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
 	depends on SMP
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index f05a262..05ba0c9 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -8,6 +8,7 @@ obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_FA_DUMP)	+= opal-fadump.o
 obj-$(CONFIG_PRESERVE_FA_DUMP)	+= opal-fadump.o
+obj-$(CONFIG_OPAL_CORE)	+= opal-core.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
new file mode 100644
index 0000000..5355d95
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -0,0 +1,563 @@
+/*
+ * Interface for exporting the OPAL ELF core.
+ * Heavily inspired from fs/proc/vmcore.c
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
+#define pr_fmt(fmt) "opalcore: " fmt
+
+#include <linux/memblock.h>
+#include <linux/uaccess.h>
+#include <linux/proc_fs.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+#include <linux/slab.h>
+#include <linux/crash_core.h>
+#include <linux/of.h>
+
+#include <asm/page.h>
+#include <asm/opal.h>
+
+#include "../../kernel/fadump_internal.h"
+#include "opal-fadump.h"
+
+#define MAX_PT_LOAD_CNT		8
+
+/* NT_AUXV note related info */
+#define AUXV_CNT		1
+#define AUXV_DESC_SZ		(((2 * AUXV_CNT) + 1) * sizeof(Elf64_Off))
+
+struct opalcore_config {
+	unsigned int		num_cpus;
+	/* PIR value of crashing CPU */
+	unsigned int		crashing_cpu;
+
+	/* CPU state data info from F/W */
+	unsigned long		cpu_state_destination_addr;
+	unsigned long		cpu_state_data_size;
+	unsigned long		cpu_state_entry_size;
+
+	/* OPAL memory to be exported as PT_LOAD segments */
+	unsigned long		ptload_addr[MAX_PT_LOAD_CNT];
+	unsigned long		ptload_size[MAX_PT_LOAD_CNT];
+	unsigned long		ptload_cnt;
+
+	/* Pointer to the first PT_LOAD in the ELF core file */
+	Elf64_Phdr		*ptload_phdr;
+
+	/* Total size of opalcore file. */
+	size_t			opalcore_size;
+
+	struct proc_dir_entry	*proc_opalcore;
+
+	/* Buffer for all the ELF core headers and the PT_NOTE */
+	size_t			opalcorebuf_sz;
+	char			*opalcorebuf;
+
+	/* NT_AUXV buffer */
+	char			auxv_buf[AUXV_DESC_SZ];
+};
+
+struct opalcore {
+	struct list_head list;
+	unsigned long long paddr;
+	unsigned long long size;
+	loff_t offset;
+};
+
+static LIST_HEAD(opalcore_list);
+static struct opalcore_config *oc_conf;
+static const struct opal_fadump_mem_struct *fdm_active;
+
+/*
+ * Set crashing CPU's signal to SIGUSR1. if the kernel is triggered
+ * by kernel, SIGTERM otherwise.
+ */
+bool kernel_initiated;
+
+static struct opalcore * __init get_new_element(void)
+{
+	return kzalloc(sizeof(struct opalcore), GFP_KERNEL);
+}
+
+static inline int is_opalcore_usable(void)
+{
+	return (oc_conf && oc_conf->opalcorebuf != NULL) ? 1 : 0;
+}
+
+static Elf64_Word *append_elf64_note(Elf64_Word *buf, char *name,
+				     unsigned int type, void *data,
+				     size_t data_len)
+{
+	Elf64_Nhdr *note = (Elf64_Nhdr *)buf;
+	Elf64_Word namesz = strlen(name) + 1;
+
+	note->n_namesz = cpu_to_be32(namesz);
+	note->n_descsz = cpu_to_be32(data_len);
+	note->n_type   = cpu_to_be32(type);
+	buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf64_Word));
+	memcpy(buf, name, namesz);
+	buf += DIV_ROUND_UP(namesz, sizeof(Elf64_Word));
+	memcpy(buf, data, data_len);
+	buf += DIV_ROUND_UP(data_len, sizeof(Elf64_Word));
+
+	return buf;
+}
+
+static void fill_prstatus(struct elf_prstatus *prstatus, int pir,
+			  struct pt_regs *regs)
+{
+	memset(prstatus, 0, sizeof(struct elf_prstatus));
+	elf_core_copy_kernel_regs(&(prstatus->pr_reg), regs);
+
+	/*
+	 * Overload PID with PIR value.
+	 * As a PIR value could also be '0', add an offset of '100'
+	 * to every PIR to avoid misinterpretations in GDB.
+	 */
+	prstatus->pr_pid  = cpu_to_be32(100 + pir);
+	prstatus->pr_ppid = cpu_to_be32(1);
+
+	/*
+	 * Indicate SIGUSR1 for crash initiated from kernel.
+	 * SIGTERM otherwise.
+	 */
+	if (pir == oc_conf->crashing_cpu) {
+		short sig;
+
+		sig = kernel_initiated ? SIGUSR1 : SIGTERM;
+		prstatus->pr_cursig = cpu_to_be16(sig);
+	}
+}
+
+static Elf64_Word *auxv_to_elf64_notes(Elf64_Word *buf,
+				       uint64_t opal_boot_entry)
+{
+	int idx = 0;
+	Elf64_Off *bufp = (Elf64_Off *)oc_conf->auxv_buf;
+
+	memset(bufp, 0, AUXV_DESC_SZ);
+
+	/* Entry point of OPAL */
+	bufp[idx++] = cpu_to_be64(AT_ENTRY);
+	bufp[idx++] = cpu_to_be64(opal_boot_entry);
+
+	/* end of vector */
+	bufp[idx++] = cpu_to_be64(AT_NULL);
+
+	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_AUXV,
+				oc_conf->auxv_buf, AUXV_DESC_SZ);
+	return buf;
+}
+
+/*
+ * Read from the ELF header and then the crash dump.
+ * Returns number of bytes read on success, -errno on failure.
+ */
+static ssize_t read_opalcore(struct file *file, char __user *buffer,
+			     size_t buflen, loff_t *fpos)
+{
+	struct opalcore *m;
+	ssize_t tsz, acc = 0;
+
+	if (buflen == 0 || *fpos >= oc_conf->opalcore_size)
+		return 0;
+
+	/* Read ELF core header and/or PT_NOTE segment */
+	if (*fpos < oc_conf->opalcorebuf_sz) {
+		tsz = min(oc_conf->opalcorebuf_sz - (size_t)*fpos, buflen);
+		if (copy_to_user(buffer, oc_conf->opalcorebuf + *fpos, tsz))
+			return -EFAULT;
+		buflen -= tsz;
+		*fpos += tsz;
+		buffer += tsz;
+		acc += tsz;
+
+		/* leave now if filled buffer already */
+		if (buflen == 0)
+			return acc;
+	}
+
+	list_for_each_entry(m, &opalcore_list, list) {
+		if (*fpos < m->offset + m->size) {
+			void *addr;
+
+			tsz = (size_t)min_t(unsigned long long,
+					    m->offset + m->size - *fpos,
+					    buflen);
+			addr = (void *)(m->paddr + *fpos - m->offset);
+			if (copy_to_user(buffer, __va(addr), tsz))
+				return -EFAULT;
+			buflen -= tsz;
+			*fpos += tsz;
+			buffer += tsz;
+			acc += tsz;
+
+			/* leave now if filled buffer already */
+			if (buflen == 0)
+				return acc;
+		}
+	}
+
+	return acc;
+}
+
+static const struct file_operations proc_opalcore_operations = {
+	.read		= read_opalcore,
+};
+
+/*
+ * Read CPU state dump data and convert it into ELF notes.
+ *
+ * Each register entry is of 16 bytes, A numerical identifier along with
+ * a GPR/SPR flag in the first 8 bytes and the register value in the next
+ * 8 bytes. For more details refer to F/W documentation.
+ */
+static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
+{
+	struct opal_fadump_thread_hdr *thdr;
+	unsigned long addr;
+	u32 thread_pir;
+	char *bufp;
+	Elf64_Word *first_cpu_note;
+	struct pt_regs regs;
+	struct elf_prstatus prstatus;
+	unsigned int size_of_each_thread;
+	unsigned int regs_offset, regs_cnt, reg_esize;
+	int i;
+
+	size_of_each_thread = oc_conf->cpu_state_entry_size;
+
+	addr = oc_conf->cpu_state_destination_addr;
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
+
+	pr_debug("--------CPU State Data------------\n");
+	pr_debug("NumCpus     : %u\n", oc_conf->num_cpus);
+	pr_debug("\tOffset: %u, Entry size: %u, Cnt: %u\n",
+		 regs_offset, reg_esize, regs_cnt);
+
+	/*
+	 * Skip past the first CPU note. Fill this note with the
+	 * crashing CPU's prstatus.
+	 */
+	first_cpu_note = buf;
+	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+				&prstatus, sizeof(prstatus));
+
+	for (i = 0; i < oc_conf->num_cpus; i++, bufp += size_of_each_thread) {
+		thdr = (struct opal_fadump_thread_hdr *)bufp;
+		thread_pir = be32_to_cpu(thdr->pir);
+
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
+		fadump_read_registers((bufp + regs_offset), regs_cnt,
+				      reg_esize, false, &regs);
+
+		pr_debug("PIR 0x%x - R1 : 0x%llx, NIP : 0x%llx\n", thread_pir,
+			 be64_to_cpu(regs.gpr[1]), be64_to_cpu(regs.nip));
+		fill_prstatus(&prstatus, thread_pir, &regs);
+
+		if (thread_pir != oc_conf->crashing_cpu) {
+			buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME,
+						NT_PRSTATUS, &prstatus,
+						sizeof(prstatus));
+		} else {
+			/*
+			 * Add crashing CPU as the first NT_PRSTATUS note for
+			 * GDB to process the core file appropriately.
+			 */
+			append_elf64_note(first_cpu_note, CRASH_CORE_NOTE_NAME,
+					  NT_PRSTATUS, &prstatus,
+					  sizeof(prstatus));
+		}
+	}
+
+	return buf;
+}
+
+static int __init create_opalcore(void)
+{
+	int hdr_size, cpu_notes_size, order, count;
+	int i, ret;
+	unsigned int numcpus;
+	unsigned long paddr;
+	Elf64_Ehdr *elf;
+	Elf64_Phdr *phdr;
+	loff_t opalcore_off;
+	struct opalcore *new;
+	struct page *page;
+	char *bufp;
+	struct device_node *dn;
+	uint64_t opal_base_addr;
+	uint64_t opal_boot_entry;
+
+
+	if ((oc_conf->ptload_cnt == 0) ||
+	    (oc_conf->ptload_cnt > MAX_PT_LOAD_CNT))
+		return -EINVAL;
+
+	numcpus = oc_conf->num_cpus;
+	hdr_size = (sizeof(Elf64_Ehdr) +
+		    ((oc_conf->ptload_cnt + 1) * sizeof(Elf64_Phdr)));
+	cpu_notes_size = ((numcpus * (CRASH_CORE_NOTE_HEAD_BYTES +
+			  CRASH_CORE_NOTE_NAME_BYTES +
+			  CRASH_CORE_NOTE_DESC_BYTES)) +
+			  (CRASH_CORE_NOTE_HEAD_BYTES +
+			  CRASH_CORE_NOTE_NAME_BYTES + AUXV_DESC_SZ));
+	oc_conf->opalcorebuf_sz = (hdr_size + cpu_notes_size);
+	order = get_order(oc_conf->opalcorebuf_sz);
+	oc_conf->opalcorebuf =
+		(char *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
+	if (!oc_conf->opalcorebuf) {
+		pr_err("Not enough memory to setup opalcore (size: %lu)\n",
+		       oc_conf->opalcorebuf_sz);
+		oc_conf->opalcorebuf_sz = 0;
+		return -ENOMEM;
+	}
+
+	pr_debug("opalcorebuf = 0x%lx\n", (unsigned long)oc_conf->opalcorebuf);
+
+	count = 1 << order;
+	page = virt_to_page(oc_conf->opalcorebuf);
+	for (i = 0; i < count; i++)
+		SetPageReserved(page + i);
+
+	/* Read OPAL related device-tree entries */
+	dn = of_find_node_by_name(NULL, "ibm,opal");
+	if (dn) {
+		ret = of_property_read_u64(dn, "opal-base-address",
+					   &opal_base_addr);
+		ret |= of_property_read_u64(dn, "opal-boot-address",
+					    &opal_boot_entry);
+	}
+	if (!dn || ret)
+		pr_warn("WARNING: Failed to read OPAL base & entry values\n");
+
+	/* Use count to keep track of the program headers */
+	count = 0;
+
+	bufp = oc_conf->opalcorebuf;
+	elf = (Elf64_Ehdr *)bufp;
+	bufp += sizeof(Elf64_Ehdr);
+	memcpy(elf->e_ident, ELFMAG, SELFMAG);
+	elf->e_ident[EI_CLASS] = ELF_CLASS;
+	elf->e_ident[EI_DATA] = ELFDATA2MSB;
+	elf->e_ident[EI_VERSION] = EV_CURRENT;
+	elf->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(elf->e_ident+EI_PAD, 0, EI_NIDENT-EI_PAD);
+	elf->e_type = cpu_to_be16(ET_CORE);
+	elf->e_machine = cpu_to_be16(ELF_ARCH);
+	elf->e_version = cpu_to_be32(EV_CURRENT);
+	elf->e_entry = 0;
+	elf->e_phoff = cpu_to_be64(sizeof(Elf64_Ehdr));
+	elf->e_shoff = 0;
+	elf->e_flags = 0;
+
+	elf->e_ehsize = cpu_to_be16(sizeof(Elf64_Ehdr));
+	elf->e_phentsize = cpu_to_be16(sizeof(Elf64_Phdr));
+	elf->e_phnum = 0;
+	elf->e_shentsize = 0;
+	elf->e_shnum = 0;
+	elf->e_shstrndx = 0;
+
+	phdr = (Elf64_Phdr *)bufp;
+	bufp += sizeof(Elf64_Phdr);
+	phdr->p_type	= cpu_to_be32(PT_NOTE);
+	phdr->p_flags	= 0;
+	phdr->p_align	= 0;
+	phdr->p_paddr	= phdr->p_vaddr = 0;
+	phdr->p_offset	= cpu_to_be64(hdr_size);
+	phdr->p_filesz	= phdr->p_memsz = cpu_to_be64(cpu_notes_size);
+	count++;
+
+	opalcore_off = oc_conf->opalcorebuf_sz;
+	oc_conf->ptload_phdr  = (Elf64_Phdr *)bufp;
+	paddr = 0;
+	for (i = 0; i < oc_conf->ptload_cnt; i++) {
+		phdr = (Elf64_Phdr *)bufp;
+		bufp += sizeof(Elf64_Phdr);
+		phdr->p_type	= cpu_to_be32(PT_LOAD);
+		phdr->p_flags	= cpu_to_be32(PF_R|PF_W|PF_X);
+		phdr->p_align	= 0;
+
+		new = get_new_element();
+		if (!new)
+			return -ENOMEM;
+		new->paddr  = oc_conf->ptload_addr[i];
+		new->size   = oc_conf->ptload_size[i];
+		new->offset = opalcore_off;
+		list_add_tail(&new->list, &opalcore_list);
+
+		phdr->p_paddr	= cpu_to_be64(paddr);
+		phdr->p_vaddr	= cpu_to_be64(opal_base_addr + paddr);
+		phdr->p_filesz	= phdr->p_memsz  =
+			cpu_to_be64(oc_conf->ptload_size[i]);
+		phdr->p_offset	= cpu_to_be64(opalcore_off);
+
+		count++;
+		opalcore_off += oc_conf->ptload_size[i];
+		paddr += oc_conf->ptload_size[i];
+	}
+
+	elf->e_phnum = cpu_to_be16(count);
+
+	bufp = (char *)opalcore_append_cpu_notes((Elf64_Word *)bufp);
+	bufp = (char *)auxv_to_elf64_notes((Elf64_Word *)bufp, opal_boot_entry);
+
+	oc_conf->opalcore_size = opalcore_off;
+	return 0;
+}
+
+static void __init opalcore_config_init(void)
+{
+	struct device_node *np;
+	const __be32 *prop;
+	int i;
+
+	np = of_find_node_by_path("/ibm,opal/dump");
+	if (np == NULL)
+		return;
+
+	fdm_active = of_get_property(np, "result-table", NULL);
+	if (fdm_active == NULL)
+		goto out;
+
+	oc_conf = kzalloc(sizeof(struct opalcore_config), GFP_KERNEL);
+	if (oc_conf == NULL)
+		goto out;
+
+	prop = of_get_property(np, "cpu-data-size", NULL);
+	if (prop == NULL) {
+		pr_err("Failed to get CPU state entry size!");
+		kfree(oc_conf);
+		oc_conf = NULL;
+		goto out;
+	}
+	oc_conf->cpu_state_entry_size = of_read_number(prop, 1);
+
+	oc_conf->ptload_cnt = 0;
+	for (i = 0; i < be16_to_cpu(fdm_active->section_count); i++) {
+		u8 src_type = fdm_active->section[i].src_type;
+
+		if (src_type == OPAL_FADUMP_CPU_STATE_DATA) {
+			oc_conf->cpu_state_destination_addr =
+				be64_to_cpu(fdm_active->section[i].dest_addr);
+			oc_conf->cpu_state_data_size =
+				be64_to_cpu(fdm_active->section[i].dest_size);
+			continue;
+		}
+
+		if ((src_type < OPAL_FADUMP_OPAL_REGION) ||
+		    (src_type >= OPAL_FADUMP_FW_REGION))
+			continue;
+
+		if (oc_conf->ptload_cnt >= MAX_PT_LOAD_CNT)
+			break;
+
+		oc_conf->ptload_addr[oc_conf->ptload_cnt]   =
+				be64_to_cpu(fdm_active->section[i].dest_addr);
+		oc_conf->ptload_size[oc_conf->ptload_cnt++] =
+				be64_to_cpu(fdm_active->section[i].dest_size);
+	}
+
+	oc_conf->num_cpus = (oc_conf->cpu_state_data_size /
+			     oc_conf->cpu_state_entry_size);
+	oc_conf->crashing_cpu = be32_to_cpu(fdm_active->crashing_cpu);
+
+out:
+	of_node_put(np);
+}
+
+/* Cleanup function for opalcore module. */
+static void opalcore_cleanup(void)
+{
+	unsigned long order, count, i;
+	struct page *page;
+
+	if (oc_conf == NULL)
+		return;
+
+	if (oc_conf->proc_opalcore) {
+		proc_remove(oc_conf->proc_opalcore);
+		oc_conf->proc_opalcore = NULL;
+	}
+
+	oc_conf->ptload_phdr = NULL;
+	oc_conf->ptload_cnt = 0;
+
+	/* free core buffer */
+	if ((oc_conf->opalcorebuf != NULL) && (oc_conf->opalcorebuf_sz != 0)) {
+		order = get_order(oc_conf->opalcorebuf_sz);
+		count = 1 << order;
+		page = virt_to_page(oc_conf->opalcorebuf);
+		for (i = 0; i < count; i++)
+			ClearPageReserved(page + i);
+		__free_pages(page, order);
+
+		oc_conf->opalcorebuf = NULL;
+		oc_conf->opalcorebuf_sz = 0;
+	}
+
+	kfree(oc_conf);
+	oc_conf = NULL;
+}
+__exitcall(opalcore_cleanup);
+
+/* Init function for opalcore module. */
+static int __init opalcore_init(void)
+{
+	int rc = -1;
+
+	opalcore_config_init();
+
+	if (oc_conf == NULL)
+		return rc;
+
+	create_opalcore();
+
+	/*
+	 * If oc_conf->opalcorebuf= is set in the 2nd kernel,
+	 * then capture the dump.
+	 */
+	if (!(is_opalcore_usable())) {
+		pr_err("Failed to export /proc/opalcore\n");
+		opalcore_cleanup();
+		return rc;
+	}
+
+	oc_conf->proc_opalcore = proc_create("opalcore", 0400, NULL,
+					     &proc_opalcore_operations);
+	if (oc_conf->proc_opalcore)
+		proc_set_size(oc_conf->proc_opalcore, oc_conf->opalcore_size);
+	return 0;
+}
+fs_initcall(opalcore_init);
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index f16f1aa..2b36b5f 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -33,6 +33,10 @@ static const struct opal_fadump_mem_struct *fdm_active;
 #ifndef CONFIG_PRESERVE_FA_DUMP
 static struct opal_fadump_mem_struct fdm;
 
+#ifdef CONFIG_OPAL_CORE
+extern bool kernel_initiated;
+#endif
+
 static void opal_set_preserv_area_start(struct fw_dump *fadump_conf)
 {
 	fadump_conf->preserv_area_start = fadump_conf->rmr_destination_addr;
@@ -237,75 +241,6 @@ static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
 	return 0;
 }
 
-static inline void fadump_set_regval_regnum(struct pt_regs *regs, u32 reg_type,
-					    u32 reg_num, u64 reg_val)
-{
-	if (reg_type == OPAL_REG_TYPE_GPR) {
-		if (reg_num < 32)
-			regs->gpr[reg_num] = reg_val;
-		return;
-	}
-
-	switch (reg_num) {
-	case 2000:
-		regs->nip = reg_val;
-		break;
-	case 2001:
-		regs->msr = reg_val;
-		break;
-	case 9:
-		regs->ctr = reg_val;
-		break;
-	case 8:
-		regs->link = reg_val;
-		break;
-	case 1:
-		regs->xer = reg_val;
-		break;
-	case 2002:
-		regs->ccr = reg_val;
-		break;
-	case 19:
-		regs->dar = reg_val;
-		break;
-	case 18:
-		regs->dsisr = reg_val;
-		break;
-	}
-}
-
-static inline void fadump_read_registers(char *bufp, unsigned int regs_cnt,
-					 unsigned int reg_entry_size,
-					 struct pt_regs *regs)
-{
-	int i;
-	struct opal_fadump_reg_entry *reg_entry;
-
-	memset(regs, 0, sizeof(struct pt_regs));
-
-	for (i = 0; i < regs_cnt; i++, bufp += reg_entry_size) {
-		reg_entry = (struct opal_fadump_reg_entry *)bufp;
-		fadump_set_regval_regnum(regs,
-					 be32_to_cpu(reg_entry->reg_type),
-					 be32_to_cpu(reg_entry->reg_num),
-					 be64_to_cpu(reg_entry->reg_val));
-	}
-}
-
-static inline bool __init is_thread_core_inactive(u8 core_state)
-{
-	bool is_inactive = false;
-
-	/*
-	 * TODO: Check what each state value means and implement accordingly.
-	 *       Also, make sure F/W is updating this field appropriately.
-	 */
-	if (core_state == CORE_STATE_INACTIVE)
-		is_inactive = true;
-
-	return is_inactive;
-}
-
 /*
  * Read CPU state dump data and convert it into ELF notes.
  *
@@ -399,7 +334,7 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 		}
 
 		fadump_read_registers((bufp + regs_offset), regs_cnt,
-				      reg_esize, &regs);
+				      reg_esize, true, &regs);
 
 		note_buf = fadump_regs_to_elf_notes(note_buf, &regs);
 		pr_debug("CPU PIR: 0x%x - R1 : 0x%lx, NIP : 0x%lx\n",
@@ -432,6 +367,25 @@ static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_OPAL_CORE
+	/*
+	 * If this is a kernel initiated crash, crashing_cpu would be set
+	 * appropriately and register data of the crashing CPU saved by
+	 * crashing kernel. Add this saved register data of crashing CPU
+	 * to elf notes and populate the pt_regs for the remaining CPUs
+	 * from register state data provided by firmware.
+	 */
+	if (fdh->crashing_cpu != CPU_UNKNOWN) {
+		kernel_initiated = true;
+		if (fdh->crashing_cpu !=
+		    be32_to_cpu(fdm_active->crashing_cpu)) {
+			pr_warn("Crashing CPU PIR logged by kernel (%u) and firmware (%u) don't match!\n",
+				fdh->crashing_cpu,
+				be32_to_cpu(fdm_active->crashing_cpu));
+		}
+	}
+#endif
+
 	rc = fadump_build_cpu_notes(fadump_conf);
 	if (rc)
 		return rc;
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.h b/arch/powerpc/platforms/powernv/opal-fadump.h
index 80aee2d..ccddfec 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.h
+++ b/arch/powerpc/platforms/powernv/opal-fadump.h
@@ -41,4 +41,76 @@ enum opal_fadump_section_types {
 
 #define CORE_STATE_INACTIVE		(0x0F)
 
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
+					 bool cpu_endian,
+					 struct pt_regs *regs)
+{
+	int i;
+	u64 val;
+	struct opal_fadump_reg_entry *reg_entry;
+
+	memset(regs, 0, sizeof(struct pt_regs));
+
+	for (i = 0; i < regs_cnt; i++, bufp += reg_entry_size) {
+		reg_entry = (struct opal_fadump_reg_entry *)bufp;
+		val = (cpu_endian ? be64_to_cpu(reg_entry->reg_val) :
+		       reg_entry->reg_val);
+		fadump_set_regval_regnum(regs,
+					 be32_to_cpu(reg_entry->reg_type),
+					 be32_to_cpu(reg_entry->reg_num), val);
+	}
+}
+
 #endif /* __PPC64_OPAL_FA_DUMP_H__ */

