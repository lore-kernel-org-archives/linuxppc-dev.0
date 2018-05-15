Return-Path: <srs0=h6/a=ic=linux.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40lQNK3mfmzF2rn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:45 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40lQNJ6szxz8sxv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 May 2018 14:59:44 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40lQNJ0ytHz9s0q
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 14:59:43 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4F4xN7e186578
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hypw5c15t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2018 00:59:41 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 15 May 2018 05:59:40 +0100
Subject: [RFC PATCH 5/5] powerpc/powernv: export /proc/opaldump for
 analysing opal crashes
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 15 May 2018 10:29:32 +0530
In-Reply-To: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
References: <152636029761.17123.10365462779196202939.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152636037246.17123.11335702239204253371.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hari Bathini <hbathini@linux.vnet.ibm.com>

Export /proc/opaldump file to analyze opal crashes

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile         |    2 
 arch/powerpc/platforms/powernv/opalcore.c       |  282 +++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opalcore.h       |   28 ++
 arch/powerpc/platforms/powernv/powernv_fadump.c |   52 ++++
 4 files changed, 358 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/opalcore.c
 create mode 100644 arch/powerpc/platforms/powernv/opalcore.h

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 0d106b5..31f828f 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,7 +6,7 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
-obj-$(CONFIG_FA_DUMP)	+= powernv_fadump.o
+obj-$(CONFIG_FA_DUMP)	+= powernv_fadump.o opalcore.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opalcore.c b/arch/powerpc/platforms/powernv/opalcore.c
new file mode 100644
index 0000000..d233d9a
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opalcore.c
@@ -0,0 +1,282 @@
+/*
+ * Interface for exporting the OPAL ELF core.
+ * Loosely based on fs/proc/vmcore.c
+ *
+ * Copyright 2018, IBM Corporation
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
+#include <linux/crash_core.h>
+
+#include <asm/page.h>
+
+#include "opalcore.h"
+
+/* Total size of opalcore file. */
+static size_t opalcore_size;
+
+/* This buffer includes all the ELF core headers and the PT_NOTE */
+static char *opalcorebuf;
+static size_t  opalcorebuf_sz;
+
+/* Pointer to the first PT_LOAD in the ELF file */
+Elf64_Phdr *ptload_phdr;
+unsigned int ptload_cnt;
+
+static struct proc_dir_entry *proc_opalcore;
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
+	note->n_namesz = cpu_to_be32(strlen(name) + 1);
+	note->n_descsz = cpu_to_be32(data_len);
+	note->n_type   = cpu_to_be32(type);
+	buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf64_Word));
+	memcpy(buf, name, namesz);
+	buf += DIV_ROUND_UP(note->n_namesz, sizeof(Elf64_Word));
+	memcpy(buf, data, data_len);
+	buf += DIV_ROUND_UP(data_len, sizeof(Elf64_Word));
+
+	return buf;
+}
+
+static void final_elf64_note(Elf64_Word *buf)
+{
+	memset(buf, 0, sizeof(Elf64_Nhdr));
+}
+
+static Elf64_Word *regs_to_elf64_notes(Elf64_Word *buf, struct pt_regs *regs)
+{
+	struct elf_prstatus prstatus;
+
+	memset(&prstatus, 0, sizeof(prstatus));
+	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
+	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
+				&prstatus, sizeof(prstatus));
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
+	Elf64_Phdr *phdr = ptload_phdr;
+	ssize_t tsz, acc = 0;
+	int i;
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
+	if ((phdr == NULL) || (ptload_cnt == 0))
+		return -EFAULT;
+
+	for (i = 0; i < ptload_cnt; i++) {
+		uint64_t end = (be64_to_cpu(phdr->p_offset) +
+				be64_to_cpu(phdr->p_memsz));
+
+		if (*fpos < end) {
+			void *addr;
+
+			tsz = (size_t)min_t(unsigned long long,
+					    (end - *fpos),
+					    buflen);
+			addr = (void *)(be64_to_cpu(phdr->p_vaddr) + *fpos -
+					be64_to_cpu(phdr->p_offset));
+			if (copy_to_user(buffer, addr, tsz))
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
+		phdr++;
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
+	unsigned long hdr_size, order, count, paddr, i;
+	Elf64_Ehdr *elf;
+	Elf64_Phdr *phdr;
+	loff_t opalcore_off;
+	struct page *page;
+	char *bufp;
+
+	if (opalcorebuf || (oc_conf->ptload_cnt == 0) ||
+	    (oc_conf->ptload_cnt > MAX_PT_LOAD_CNT))
+		return -EINVAL;
+
+	hdr_size = (sizeof(Elf64_Ehdr) +
+		    ((oc_conf->ptload_cnt + 1) * sizeof(Elf64_Phdr)));
+	opalcorebuf_sz = (hdr_size + oc_conf->cpu_notes_buf_size);
+	order = get_order(opalcorebuf_sz);
+	opalcorebuf = (char *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, order);
+	if (!opalcorebuf)
+		return -ENOMEM;
+
+	count = 1 << order;
+	page = virt_to_page(opalcorebuf);
+	for (i = 0; i < count; i++)
+		SetPageReserved(page + i);
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
+	phdr->p_filesz	= phdr->p_memsz =
+		cpu_to_be64(oc_conf->cpu_notes_buf_size);
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
+		phdr->p_paddr	= paddr;
+		phdr->p_vaddr	=
+			cpu_to_be64((Elf64_Addr)__va(oc_conf->ptload_addr[i]));
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
+	for (i = 0; i < oc_conf->nr_threads; i++) {
+		bufp = (char *)regs_to_elf64_notes((Elf64_Word *)bufp,
+						   &(oc_conf->regs[i]));
+	}
+	final_elf64_note((Elf64_Word *)bufp);
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
diff --git a/arch/powerpc/platforms/powernv/opalcore.h b/arch/powerpc/platforms/powernv/opalcore.h
new file mode 100644
index 0000000..b791a54
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opalcore.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright 2018, IBM Corporation
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
+struct opalcore_config {
+	unsigned long	cpu_notes_buf_size;
+	unsigned long	ptload_cnt;
+	unsigned long	ptload_addr[MAX_PT_LOAD_CNT];
+	unsigned long	ptload_size[MAX_PT_LOAD_CNT];
+	unsigned int	nr_threads;
+	struct pt_regs	regs[NR_CPUS];
+};
+
+extern int create_opalcore(struct opalcore_config *opalcore_config);
+extern void opalcore_cleanup(void);
+
+#endif /* _OPALCORE_H */
diff --git a/arch/powerpc/platforms/powernv/powernv_fadump.c b/arch/powerpc/platforms/powernv/powernv_fadump.c
index 36f0360..fd95bbb 100644
--- a/arch/powerpc/platforms/powernv/powernv_fadump.c
+++ b/arch/powerpc/platforms/powernv/powernv_fadump.c
@@ -26,8 +26,10 @@
 
 #include "../../kernel/fadump_internal.h"
 #include "powernv_fadump.h"
+#include "opalcore.h"
 
 static struct powernv_fadump_mem_struct fdm;
+static struct opalcore_config oc_config;
 static const struct powernv_fadump_mem_struct *fdm_active;
 unsigned long fdm_actual_size;
 
@@ -200,6 +202,8 @@ static int powernv_invalidate_fadump(struct fw_dump *fadump_conf)
 {
 	int rc;
 
+	opalcore_cleanup();
+
 	rc = opal_configure_fadump(FADUMP_INVALIDATE, (void *)fdm_active,
 				   fdm_actual_size);
 	if (rc) {
@@ -230,15 +234,19 @@ static inline int fadump_get_logical_cpu(struct fadump_backup_area *ba, u32 pir)
 static struct fadump_reg_entry*
 fadump_read_registers(unsigned int regs_per_thread,
 		      struct fadump_reg_entry *reg_entry,
-		      struct pt_regs *regs)
+		      struct pt_regs *regs, bool opal_data)
 {
 	int i;
+	u64 reg_value;
 
 	memset(regs, 0, sizeof(struct pt_regs));
 
 	for (i = 0; i < regs_per_thread; i++) {
+		reg_value = (opal_data ? reg_entry->reg_value :
+			     be64_to_cpu(reg_entry->reg_value));
+
 		fadump_set_regval(regs, be64_to_cpu(reg_entry->reg_id),
-				  be64_to_cpu(reg_entry->reg_value));
+				  reg_value);
 		reg_entry++;
 	}
 	return reg_entry;
@@ -330,16 +338,23 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 				regs = fdh->regs;
 				note_buf = fadump_regs_to_elf_notes(note_buf,
 								    &regs);
+				fadump_read_registers(regs_per_thread,
+						      reg_entry,
+						      &oc_config.regs[cpu],
+						      true);
 				continue;
 			}
 		}
 
 		reg_entry = (struct fadump_reg_entry *)(bufp +
 							CPU_REG_ENTRY_OFFSET);
-		fadump_read_registers(regs_per_thread, reg_entry, &regs);
+		fadump_read_registers(regs_per_thread, reg_entry, &regs, false);
 		note_buf = fadump_regs_to_elf_notes(note_buf, &regs);
+		fadump_read_registers(regs_per_thread, reg_entry,
+				      &oc_config.regs[cpu], true);
 	}
 	final_note(note_buf);
+	oc_config.nr_threads = num_cpus;
 
 	if (fdh) {
 		pr_debug("Updating elfcore header (%llx) with cpu notes\n",
@@ -361,7 +376,7 @@ static int __init fadump_build_cpu_notes(struct fw_dump *fadump_conf)
 static int __init powernv_process_fadump(struct fw_dump *fadump_conf)
 {
 	struct fadump_crash_info_header *fdh;
-	int rc = 0;
+	int i, rc = 0;
 
 	if (!fdm_active || !fadump_conf->fadumphdr_addr)
 		return -EINVAL;
@@ -384,7 +399,34 @@ static int __init powernv_process_fadump(struct fw_dump *fadump_conf)
 	 */
 	elfcorehdr_addr = fdh->elfcorehdr_addr;
 
-	return rc;
+	/*
+	 * pt_regs for opalcore are populated while build cpu notes
+	 * for vmcore. Populate other config info to facilitate
+	 * exporting /proc/opalcore file.
+	 */
+	oc_config.cpu_notes_buf_size	= fadump_conf->cpu_notes_buf_size;
+	oc_config.ptload_cnt		= 0;
+	for(i = 0; i < be16_to_cpu(fdm_active->section_count); i++) {
+		u8 src_type = fdm_active->section[i].src_type;
+
+		if ((src_type < POWERNV_FADUMP_OPAL_REGION) ||
+		    (src_type >= POWERNV_FADUMP_FW_REGION))
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
+	rc = create_opalcore(&oc_config);
+	if (rc)
+		pr_warn("Could not create opalcore ELF file\n");
+
+	return 0;
 }
 
 static void powernv_fadump_region_show(struct fw_dump *fadump_conf,
