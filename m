Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E721C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:15:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2E3218FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2E3218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LM144bN4zDrG3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:15:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LLh60YydzDr4t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43LLh56Nxfz8tRf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:09 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43LLh55nbcz9sCQ; Fri, 21 Dec 2018 06:01:09 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43LLh52fNpz9sCV
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2018 06:01:09 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBKIwlbs028012
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:01:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pgffrke89-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:01:07 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 20 Dec 2018 19:01:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 19:01:02 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBKJ10Kw41156716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 19:01:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96F1DA405F;
 Thu, 20 Dec 2018 19:01:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D37E6A4060;
 Thu, 20 Dec 2018 19:00:58 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.47.3])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Dec 2018 19:00:58 +0000 (GMT)
Subject: [PATCH 6/9] powerpc/powernv: export /proc/opalcore for analysing
 opal crashes
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Fri, 21 Dec 2018 00:30:57 +0530
In-Reply-To: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
References: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122019-0020-0000-0000-000002FA7168
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122019-0021-0000-0000-0000214A84F6
Message-Id: <154533245772.28973.16648357509786201016.stgit@hbathini.in.ibm.com>
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

Export /proc/opalcore file to analyze opal crashes

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile      |    2 
 arch/powerpc/platforms/powernv/opal-core.c   |  385 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-core.h   |   35 ++
 arch/powerpc/platforms/powernv/opal-fadump.c |   73 +++++
 4 files changed, 488 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-core.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-core.h

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index adc0de6..9420631 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,7 +6,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
-obj-$(CONFIG_FA_DUMP)	+= opal-fadump.o
+obj-$(CONFIG_FA_DUMP)	+= opal-fadump.o opal-core.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
new file mode 100644
index 0000000..1d75526
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -0,0 +1,385 @@
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
+
+#include "opal-core.h"
+
+struct opalcore {
+	struct list_head list;
+	unsigned long long paddr;
+	unsigned long long size;
+	loff_t offset;
+};
+
+static LIST_HEAD(opalcore_list);
+
+/* Total size of opalcore file. */
+static size_t opalcore_size;
+
+/* This buffer includes all the ELF core headers and the PT_NOTE */
+static char *opalcorebuf;
+static size_t  opalcorebuf_sz;
+
+/* NT_AUXV buffer */
+static char auxv_buf[AUXV_DESC_SZ];
+
+/* Pointer to the first PT_LOAD in the ELF file */
+Elf64_Phdr *ptload_phdr;
+unsigned int ptload_cnt;
+
+static struct proc_dir_entry *proc_opalcore;
+
+static struct opalcore * __init get_new_element(void)
+{
+	return kzalloc(sizeof(struct opalcore), GFP_KERNEL);
+}
+
+static inline int is_opalcore_usable(void)
+{
+	return (opalcorebuf != NULL) ? 1 : 0;
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
+static void fill_prstatus(struct elf_prstatus *prstatus, int cpu,
+			  struct opalcore_config *oc_conf)
+{
+	memset(prstatus, 0, sizeof(struct elf_prstatus));
+	elf_core_copy_kernel_regs(&(prstatus->pr_reg), &(oc_conf->regs[cpu]));
+
+	/*
+	 * Overload PID with PIR value.
+	 * As a PIR value could also be '0', add an offset of '100'
+	 * to every PIR to avoid misinterpretations in GDB.
+	 */
+	prstatus->pr_pid  = cpu_to_be32(100 + oc_conf->thread_pir[cpu]);
+	prstatus->pr_ppid = cpu_to_be32(1);
+
+	/*
+	 * Indicate SIGTERM for crash initiated from OPAL.
+	 * SIGUSR1 otherwise.
+	 */
+	if (cpu == oc_conf->crashing_cpu) {
+		short sig;
+
+		sig = oc_conf->is_opal_initiated ? SIGTERM : SIGUSR1;
+		prstatus->pr_cursig = cpu_to_be16(sig);
+	}
+}
+
+static Elf64_Word *regs_to_elf64_notes(Elf64_Word *buf,
+				       struct opalcore_config *oc_conf)
+{
+	int i;
+	struct elf_prstatus prstatus;
+
+	/*
+	 * First NT_PRSTATUS note should be crashing cpu info
+	 * for GDB to interpret it appropriately.
+	 */
+	fill_prstatus(&prstatus, oc_conf->crashing_cpu, oc_conf);
+	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+				&prstatus, sizeof(prstatus));
+
+	for_each_cpu(i, &(oc_conf->online_mask)) {
+		/*
+		 * Skip crashing CPU as it's already added as the first
+		 * NT_PRSTATUS note.
+		 */
+		if (i == oc_conf->crashing_cpu)
+			continue;
+
+		fill_prstatus(&prstatus, i, oc_conf);
+		buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+					&prstatus, sizeof(prstatus));
+	}
+
+	return buf;
+}
+
+static Elf64_Word *auxv_to_elf64_notes(Elf64_Word *buf,
+				       uint64_t opal_boot_entry)
+{
+	int idx = 0;
+	Elf64_Off *bufp = (Elf64_Off *)auxv_buf;
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
+				auxv_buf, AUXV_DESC_SZ);
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
+	if (buflen == 0 || *fpos >= opalcore_size)
+		return 0;
+
+	/* Read ELF core header and/or PT_NOTE segment */
+	if (*fpos < opalcorebuf_sz) {
+		tsz = min(opalcorebuf_sz - (size_t)*fpos, buflen);
+		if (copy_to_user(buffer, opalcorebuf + *fpos, tsz))
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
+int __init create_opalcore(struct opalcore_config *oc_conf)
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
+	if (opalcorebuf || (oc_conf->ptload_cnt == 0) ||
+	    (oc_conf->ptload_cnt > MAX_PT_LOAD_CNT))
+		return -EINVAL;
+
+	numcpus = cpumask_weight(&(oc_conf->online_mask));
+	hdr_size = (sizeof(Elf64_Ehdr) +
+		    ((oc_conf->ptload_cnt + 1) * sizeof(Elf64_Phdr)));
+	cpu_notes_size = ((numcpus * (CRASH_CORE_NOTE_HEAD_BYTES +
+			  CRASH_CORE_NOTE_NAME_BYTES +
+			  CRASH_CORE_NOTE_DESC_BYTES)) +
+			  (CRASH_CORE_NOTE_HEAD_BYTES +
+			  CRASH_CORE_NOTE_NAME_BYTES + AUXV_DESC_SZ));
+	opalcorebuf_sz = (hdr_size + cpu_notes_size);
+	order = get_order(opalcorebuf_sz);
+	opalcorebuf = (char *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
+	if (!opalcorebuf) {
+		pr_err("Not enough memory to setup opalcore\n");
+		return -ENOMEM;
+	}
+
+	pr_debug("opalcorebuf = 0x%lx\n", (unsigned long)opalcorebuf);
+
+	count = 1 << order;
+	page = virt_to_page(opalcorebuf);
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
+	bufp = opalcorebuf;
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
+	opalcore_off = opalcorebuf_sz;
+	ptload_phdr  = (Elf64_Phdr *)bufp;
+	ptload_cnt   = oc_conf->ptload_cnt;
+	paddr = 0;
+	for (i = 0; i < ptload_cnt; i++) {
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
+	bufp = (char *)regs_to_elf64_notes((Elf64_Word *)bufp, oc_conf);
+	bufp = (char *)auxv_to_elf64_notes((Elf64_Word *)bufp, opal_boot_entry);
+
+	opalcore_size = opalcore_off;
+	return 0;
+}
+
+/* Init function for opalcore module. */
+static int __init opalcore_init(void)
+{
+	int rc = 0;
+
+	/*
+	 * If opalcorebuf= is set in the 2nd kernel,
+	 * then capture the dump.
+	 */
+	if (!(is_opalcore_usable()))
+		return rc;
+
+	proc_opalcore = proc_create("opalcore", 0400, NULL,
+				    &proc_opalcore_operations);
+	if (proc_opalcore)
+		proc_set_size(proc_opalcore, opalcore_size);
+	return 0;
+}
+fs_initcall(opalcore_init);
+
+/* Cleanup function for opalcore module. */
+void opalcore_cleanup(void)
+{
+	unsigned long order, count, i;
+	struct page *page;
+
+	if (proc_opalcore) {
+		proc_remove(proc_opalcore);
+		proc_opalcore = NULL;
+	}
+
+	ptload_phdr = NULL;
+	ptload_cnt = 0;
+
+	/* free core buffer */
+	order = get_order(opalcorebuf_sz);
+	count = 1 << order;
+	page = virt_to_page(opalcorebuf);
+	for (i = 0; i < count; i++)
+		ClearPageReserved(page + i);
+	__free_pages(page, order);
+}
diff --git a/arch/powerpc/platforms/powernv/opal-core.h b/arch/powerpc/platforms/powernv/opal-core.h
new file mode 100644
index 0000000..bb7a89a
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-core.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright 2018-2019, IBM Corp.
+ * Author: Hari Bathini <hbathini@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _OPALCORE_H
+#define _OPALCORE_H
+
+#define MAX_PT_LOAD_CNT		16
+
+/* NT_AUXV note related info */
+#define AUXV_CNT		1
+#define AUXV_DESC_SZ		(((2 * AUXV_CNT) + 1) * sizeof(Elf64_Off))
+
+struct opalcore_config {
+	unsigned int	crashing_cpu;
+	unsigned int	is_opal_initiated:1;
+	unsigned int	ptload_cnt:15;
+	unsigned int	reserved:16;
+	unsigned long	ptload_addr[MAX_PT_LOAD_CNT];
+	unsigned long	ptload_size[MAX_PT_LOAD_CNT];
+	struct pt_regs	regs[NR_CPUS];
+	uint32_t	thread_pir[NR_CPUS];
+	struct cpumask	online_mask;
+};
+
+extern int create_opalcore(struct opalcore_config *opalcore_config);
+extern void opalcore_cleanup(void);
+
+#endif /* _OPALCORE_H */
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index 9e677de..5bd0a0f 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -27,8 +27,10 @@
 
 #include "../../kernel/fadump_internal.h"
 #include "opal-fadump.h"
+#include "opal-core.h"
 
 static struct opal_fadump_mem_struct fdm;
+static struct opalcore_config oc_config;
 static const struct opal_fadump_mem_struct *fdm_active;
 unsigned long fdm_actual_size;
 
@@ -262,6 +264,8 @@ static int opal_invalidate_fadump(struct fw_dump *fadump_conf)
 {
 	int rc;
 
+	opalcore_cleanup();
+
 	rc = opal_configure_fadump(FADUMP_INVALIDATE, (void *)fdm_active,
 				   fdm_actual_size);
 	if (rc) {
@@ -291,17 +295,19 @@ static inline int fadump_get_logical_cpu(struct fadump_backup_area *ba, u32 pir)
 static struct fadump_reg_entry*
 fadump_read_registers(unsigned int regs_per_thread,
 		      struct fadump_reg_entry *reg_entry,
-		      struct pt_regs *regs)
+		      struct pt_regs *regs, bool opal_data)
 {
 	int i;
+	u64 reg_value;
 	int reg_cnt = 0;
 
 	memset(regs, 0, sizeof(struct pt_regs));
 
 	for (i = 0; i < regs_per_thread; i++) {
+		reg_value = (opal_data ? reg_entry->reg_value :
+			     be64_to_cpu(reg_entry->reg_value));
 		fadump_set_regval_regnum(regs, be64_to_cpu(reg_entry->reg_id),
-					 be64_to_cpu(reg_entry->reg_value),
-					 reg_cnt++);
+					 reg_value, reg_cnt++);
 		reg_entry++;
 	}
 	return reg_entry;
@@ -382,12 +388,26 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf,
 				regs = fdh->regs;
 				note_buf = fadump_regs_to_elf_notes(note_buf,
 								    &regs);
+				fadump_read_registers(regs_per_thread,
+						      reg_entry,
+						      &oc_config.regs[cpu],
+						      true);
+
+				pr_debug("crashing cpu%d - R1 : 0x%lx, NIP : 0x%lx\n",
+					 cpu, regs.gpr[1], regs.nip);
+				pr_debug("cpu%d - R1 : 0x%lx, NIP : 0x%lx\n",
+					 cpu, oc_config.regs[cpu].gpr[1],
+					 oc_config.regs[cpu].nip);
 				continue;
 			}
 		}
 
-		fadump_read_registers(regs_per_thread, reg_entry, &regs);
+		fadump_read_registers(regs_per_thread, reg_entry, &regs, false);
 		note_buf = fadump_regs_to_elf_notes(note_buf, &regs);
+		fadump_read_registers(regs_per_thread, reg_entry,
+				      &oc_config.regs[cpu], true);
+		pr_debug("cpu%d - R1 : 0x%lx, NIP : 0x%lx\n", cpu,
+			 oc_config.regs[cpu].gpr[1], oc_config.regs[cpu].nip);
 	}
 	final_note(note_buf);
 
@@ -406,7 +426,7 @@ static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 	struct fadump_crash_info_header *fdh;
 	struct fadump_backup_area *backup_info = NULL;
 	unsigned long addr;
-	int rc = 0;
+	int i, rc = 0;
 
 	if (!fdm_active || !fadump_conf->fadumphdr_addr)
 		return -EINVAL;
@@ -436,7 +456,48 @@ static int __init opal_process_fadump(struct fw_dump *fadump_conf)
 	 */
 	elfcorehdr_addr = fdh->elfcorehdr_addr;
 
-	return rc;
+	/*
+	 * pt_regs  & PIR info for opalcore are populated while building
+	 * cpu notes for vmcore. Populate remaining info to facilitate
+	 * exporting /proc/opalcore file.
+	 */
+	oc_config.ptload_cnt		= 0;
+	for (i = 0; i < be16_to_cpu(fdm_active->section_count); i++) {
+		u8 src_type = fdm_active->section[i].src_type;
+
+		if ((src_type < OPAL_FADUMP_OPAL_REGION) ||
+		    (src_type >= OPAL_FADUMP_FW_REGION))
+			continue;
+
+		if (oc_config.ptload_cnt >= MAX_PT_LOAD_CNT)
+			break;
+
+		oc_config.ptload_addr[oc_config.ptload_cnt]   =
+			be64_to_cpu(fdm_active->section[i].dest_addr);
+		oc_config.ptload_size[oc_config.ptload_cnt++] =
+			be64_to_cpu(fdm_active->section[i].dest_size);
+	}
+
+	if (fdh->crashing_cpu == CPU_UNKNOWN) {
+		u32 pir = be32_to_cpu(fdm_active->crashing_cpu);
+
+		oc_config.is_opal_initiated = 1;
+		oc_config.crashing_cpu = fadump_get_logical_cpu(backup_info,
+								pir);
+	} else {
+		oc_config.is_opal_initiated = 0;
+		oc_config.crashing_cpu = fdh->crashing_cpu;
+	}
+
+	oc_config.online_mask = fdh->online_mask;
+	memcpy(&(oc_config.thread_pir), &(backup_info->thread_pir),
+	       sizeof(backup_info->thread_pir));
+
+	rc = create_opalcore(&oc_config);
+	if (rc)
+		pr_warn("Could not create opalcore ELF file\n");
+
+	return 0;
 }
 
 static void opal_fadump_region_show(struct fw_dump *fadump_conf,

