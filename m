Return-Path: <linuxppc-dev+bounces-18090-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC978FED2EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 08:31:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWgnJ1mggz3cJN;
	Thu, 12 Mar 2026 19:31:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773304276;
	cv=none; b=UEL72LA3p9icp+bmQF3oevToHvmyA26FsNlAAISshrvEwfio56u35QvlsIRqaYzzdebw2kNeqhMAHCZFxYlbYi90dt01PEYyzRoq8dBhnlDvD0dXphy6wY+mZOjK08LOrSX4U7+lm4IUIUS7JMdxvpuMdqUgE7XNMCUnAq9Kqt2h8sPgNCpJqVE0/6PB4/QkQNIKrvHD2xy7ZY4qKf0fOAZAySB5dX/avdAr41/0Y7gogg5zy7J1B2FshVulN0GA7N4mFcPgDusGUbeQOVMqDzyv3PAyjDKhLwhnm+3GcYzfBKRIc8CA0Yl+j1zak2HlaZQ/RsP/NvUwGfSmaSpv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773304276; c=relaxed/relaxed;
	bh=72ZM+fqhd/w5mgc5Pu5dcDQ8kJjEjZlqFcDUyy9GIJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lruv0LF/n3TthXxojId78G4WiytyyQGNWB0d1lTNJlO1iE219jNN4odkOfirUYzsztil+mDqL/vPwVyIH0Ie/F07Q1ryHqsQafPw+6rv5KaoQ9M7avIRnmd8kJxUq6dU/6pNkEdl9Z9hmZahnHG5gx1UeuOd5BoRFMRQFHg/R8i9U3mejlHB3HM3yI4YDZ4682IUhT70zjYdTqclszBUiKW25PePVvAYzPHEbo7ulpjkLK99t2PYVGi3O+yi2gaPbCPdbNi0Ll2ASo9GJs7VQCtEq0vvgyn+fxK8WRFyPF1td218OF7zusxKwRPKajTL/V2YOmi3QyEySIuUBHubWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iyIF3YIP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iyIF3YIP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWgnH44CMz3cG5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 19:31:15 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWDBX2303246;
	Thu, 12 Mar 2026 08:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=72ZM+fqhd/w5mgc5P
	u5dcDQ8kJjEjZlqFcDUyy9GIJo=; b=iyIF3YIPi+D3CLFLZAa5tA1/b0edZypI/
	JnmpCwP2JIL63N50f2akUZDwXYfuUh6v8pgby2GQRZGHWsWmmrPo70L6t7oQeFEg
	KDXypdu+Oe+IZOO2fgPXzhDqw1LHu4H4YafsY5CjUKr4aM1q5LVa+z3BXtEXBSSg
	cIHHXEuUMnxy4RUMjc8fNNNNwGjnbV1B5QBPr8CW9G7NQ+xrAd+k1mfYCuI0sy09
	Xmd+lv9kWlm68npYfmIeIuh0sX+XZ0U3aqRJmuU05vkXe+NX/8YBhm7y7Ido6qjP
	DaoVPNmJ6NWf4IXtUxWWSG8cGO1wnCP/ZM0Ie5xinEaJNliBNYAMw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95snar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:31:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C4H7gA014738;
	Thu, 12 Mar 2026 08:31:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha89jtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 08:31:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62C8V2al52101606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 08:31:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 510642004D;
	Thu, 12 Mar 2026 08:31:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE622004B;
	Thu, 12 Mar 2026 08:31:00 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 08:30:59 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>
Subject: [PATCH v3 2/2] powerpc/crash: Update backup region offset in elfcorehdr on memory hotplug
Date: Thu, 12 Mar 2026 14:00:50 +0530
Message-ID: <20260312083051.1935737-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
References: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2MyBTYWx0ZWRfX0RQ5Yg2Ge0WJ
 mV4KqfBI6ofmmDnbwsro3H+GwqgVktuPVM2H84+200ftTCpuhU86k5Y8gMKsHTq2yOGAHQD9o/U
 KBreB/VI4V06tzEArCDm6QL4wg5hYuxI8k3/BxHnrQEXGYGXcbHdXNGnfqALmwyy1TB3CEYBOKs
 0p/5vdoe48P3D2T58caVXXh2QMhxRScxt9ni0HDKLocmbnsAzqHkd+l1JO0NGp229loWlDHBUsO
 RGO52t3Y0r3eggR1uqDR1cF8vU0lcFl6hqltCVbbmEayGWm5MEs8faFSRnoIBE8VT3NqANV7uHc
 JfMWyOmuk1hKFHC+56cb6SdIw5E8lrBFQf5wri5oFbBbG9HgqmrtpNtSsUGUP64FvbCn9j1pvvD
 2ShSfEZCSbey6mo9b7x/El9sImzCwm5pE7ipo/kWCrRdT5H9cKgYNPhtCXSQeI3jyXy9/I2SF5x
 CX+4JSI+o7l0dp2nXcQ==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b279cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=RhITRAMf-4p89KQycyQA:9
X-Proofpoint-GUID: GpeDNb5HNMzt20-03GyhfERDm_IUtQXK
X-Proofpoint-ORIG-GUID: Z4RpQ5kKR0kZZR9V-HKi_RvqhCEQG4FC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120063

When elfcorehdr is prepared for kdump, the program header representing
the first 64 KB of memory is expected to have its offset point to the
backup region. This is required because purgatory copies the first 64 KB
of the crashed kernel memory to this backup region following a kernel
crash. This allows the capture kernel to use the first 64 KB of memory
to place the exception vectors and other required data.

When elfcorehdr is recreated due to memory hotplug, the offset of
the program header representing the first 64 KB is not updated.
As a result, the capture kernel exports the first 64 KB at offset
0, even though the data actually resides in the backup region.

Fix this by calling sync_backup_region_phdr() to update the program
header offset in the elfcorehdr created during memory hotplug.

sync_backup_region_phdr() works for images loaded via the
kexec_file_load syscall. However, it does not work for kexec_load,
because image->arch.backup_start is not initialized in that case.
So introduce machine_kexec_post_load() to process the elfcorehdr
prepared by kexec-tools and initialize image->arch.backup_start for
kdump images loaded via kexec_load syscall.

Rename update_backup_region_phdr() to sync_backup_region_phdr() and
extend it to synchronize the backup region offset between the kdump
image and the ELF core header. The helper now supports updating either
the kdump image from the ELF program header or updating the ELF program
header from the kdump image, avoiding code duplication.

Define ARCH_HAS_KIMAGE_ARCH and struct kimage_arch when
CONFIG_KEXEC_FILE or CONFIG_CRASH_DUMP is enabled so that
kimage->arch.backup_start is available with the kexec_load system call.

This patch depends on the patch titled
"powerpc/crash: fix backup region offset update to elfcorehdr".

Fixes: 849599b702ef ("powerpc/crash: add crash memory hotplug support")
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h  | 14 +++++--
 arch/powerpc/kexec/crash.c        | 64 +++++++++++++++++++++++++++++++
 arch/powerpc/kexec/file_load_64.c | 29 +-------------
 3 files changed, 76 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index bd4a6c42a5f3..e02710d6a2e1 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -66,11 +66,9 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
 			 unsigned long start_address) __noreturn;
 void kexec_copy_flush(struct kimage *image);
 
-#ifdef CONFIG_KEXEC_FILE
-extern const struct kexec_file_ops kexec_elf64_ops;
 
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
 #define ARCH_HAS_KIMAGE_ARCH
-
 struct kimage_arch {
 	struct crash_mem *exclude_ranges;
 
@@ -78,6 +76,10 @@ struct kimage_arch {
 	void *backup_buf;
 	void *fdt;
 };
+#endif
+
+#ifdef CONFIG_KEXEC_FILE
+extern const struct kexec_file_ops kexec_elf64_ops;
 
 char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 			  unsigned long cmdline_len);
@@ -145,6 +147,10 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
 
 unsigned int arch_crash_get_elfcorehdr_size(void);
 #define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
+
+int machine_kexec_post_load(struct kimage *image);
+#define machine_kexec_post_load machine_kexec_post_load
+
 #endif /* CONFIG_CRASH_HOTPLUG */
 
 extern int crashing_cpu;
@@ -159,6 +165,8 @@ extern void default_machine_crash_shutdown(struct pt_regs *regs);
 extern void crash_kexec_prepare(void);
 extern void crash_kexec_secondary(struct pt_regs *regs);
 
+extern void sync_backup_region_phdr(struct kimage *image, Elf64_Ehdr *ehdr,
+				    bool phdr_to_kimage);
 static inline bool kdump_in_progress(void)
 {
 	return crashing_cpu >= 0;
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index a325c1c02f96..e6539f213b3d 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -27,6 +27,7 @@
 #include <asm/debug.h>
 #include <asm/interrupt.h>
 #include <asm/kexec_ranges.h>
+#include <asm/crashdump-ppc64.h>
 
 /*
  * The primary CPU waits a while for all secondary CPUs to enter. This is to
@@ -399,7 +400,68 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 		ppc_md.kexec_cpu_down(1, 0);
 }
 
+#ifdef CONFIG_CRASH_DUMP
+/**
+ * sync_backup_region_phdr - synchronize backup region offset between
+ *			    kexec image and ELF core header.
+ * @image: Kexec image.
+ * @ehdr: ELF core header.
+ * @phdr_to_kimage: If true, read the offset from the ELF program header
+ *		    and update the kimage backup region. If false, update
+ *		    the ELF program header offset from the kimage backup
+ *		    region.
+ *
+ * Note: During kexec_load, this is called with phdr_to_kimage = true. For
+ * kexec_file_load and ELF core header recreation during memory hotplug
+ * events, it is called with phdr_to_kimage = false.
+ *
+ * Returns nothing.
+ */
+void sync_backup_region_phdr(struct kimage *image, Elf64_Ehdr *ehdr, bool phdr_to_kimage)
+{
+	Elf64_Phdr *phdr;
+	unsigned int i;
+
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
+		if (phdr->p_paddr == BACKUP_SRC_START) {
+			if (phdr_to_kimage)
+				image->arch.backup_start = phdr->p_offset;
+			else
+				phdr->p_offset = image->arch.backup_start;
+
+			kexec_dprintk("Backup region offset updated to 0x%lx\n",
+				      image->arch.backup_start);
+			return;
+		}
+	}
+}
+#endif /* CONFIG_CRASH_DUMP */
+
 #ifdef CONFIG_CRASH_HOTPLUG
+
+int machine_kexec_post_load(struct kimage *image)
+{
+	int i;
+	unsigned long mem;
+	unsigned char *ptr;
+
+	if (image->type != KEXEC_TYPE_CRASH)
+		return 0;
+
+	if (image->file_mode)
+		return 0;
+
+	for (i = 0; i < image->nr_segments; i++) {
+		mem = image->segment[i].mem;
+		ptr = (char *)__va(mem);
+
+		if (ptr && memcmp(ptr, ELFMAG, SELFMAG) == 0)
+			sync_backup_region_phdr(image, (Elf64_Ehdr *) ptr, true);
+	}
+	return 0;
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt) "crash hp: " fmt
 
@@ -474,6 +536,8 @@ static void update_crash_elfcorehdr(struct kimage *image, struct memory_notify *
 		goto out;
 	}
 
+	sync_backup_region_phdr(image, (Elf64_Ehdr *) elfbuf, false);
+
 	ptr = __va(mem);
 	if (ptr) {
 		/* Temporarily invalidate the crash image while it is replaced */
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index e631cf2eda2c..502976a1823d 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -374,33 +374,6 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
 	return 0;
 }
 
-/**
- * update_backup_region_phdr - Update backup region's offset for the core to
- *                             export the region appropriately.
- * @image:                     Kexec image.
- * @ehdr:                      ELF core header.
- *
- * Assumes an exclusive program header is setup for the backup region
- * in the ELF headers
- *
- * Returns nothing.
- */
-static void update_backup_region_phdr(struct kimage *image, Elf64_Ehdr *ehdr)
-{
-	Elf64_Phdr *phdr;
-	unsigned int i;
-
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
-		if (phdr->p_paddr == BACKUP_SRC_START) {
-			phdr->p_offset = image->arch.backup_start;
-			kexec_dprintk("Backup region offset updated to 0x%lx\n",
-				      image->arch.backup_start);
-			return;
-		}
-	}
-}
-
 static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
 {
 #if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
@@ -445,7 +418,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	}
 
 	/* Fix the offset for backup region in the ELF header */
-	update_backup_region_phdr(image, headers);
+	sync_backup_region_phdr(image, headers, false);
 
 	kbuf->buffer = headers;
 	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
-- 
2.52.0


