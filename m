Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25B6C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:52:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A632075B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A632075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k2Hm19QwzDq6l
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:52:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1wq50fHzDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:35:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44k1wq2C3Lz8vpV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:35:39 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44k1wp6z7tz9s70; Tue, 16 Apr 2019 20:35:38 +1000 (AEST)
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
 by ozlabs.org (Postfix) with ESMTPS id 44k1wp1mZQz9s55
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 20:35:38 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GAWeB2075309
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:35:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rwbr4vmgm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:35:35 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 16 Apr 2019 11:35:33 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:35:30 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GAZSBO39059560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:35:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A3165204E;
 Tue, 16 Apr 2019 10:35:28 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.184.183.117])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4768A52052;
 Tue, 16 Apr 2019 10:35:27 +0000 (GMT)
Subject: [PATCH v2 10/16] powernv/fadump: add support to preserve crash data
 on FADUMP disabled kernel
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Apr 2019 16:05:26 +0530
In-Reply-To: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
References: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0016-0000-0000-0000026F6026
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0017-0000-0000-000032CBA9FF
Message-Id: <155541091362.812.12892129885564974252.stgit@hbathini.in.ibm.com>
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

Add a new kernel config option, CONFIG_PRESERVE_FA_DUMP that ensures
that crash data, from previously crash'ed kernel, is preserved. This
helps in cases where FADump is not enabled but the subsequent memory
preserving kernel boot is likely to process this crash data. One
typical usecase for this config option is petitboot kernel.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/Kconfig                         |    9 +++++
 arch/powerpc/include/asm/fadump.h            |    9 +++--
 arch/powerpc/kernel/Makefile                 |    6 +++
 arch/powerpc/kernel/fadump-common.h          |    8 ++++
 arch/powerpc/kernel/fadump.c                 |   47 +++++++++++++++++++++++---
 arch/powerpc/kernel/prom.c                   |    4 +-
 arch/powerpc/platforms/powernv/Makefile      |    1 +
 arch/powerpc/platforms/powernv/opal-fadump.c |   37 +++++++++++++++++++-
 8 files changed, 106 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2366a84..ac3259e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -570,6 +570,15 @@ config FA_DUMP
 	  If unsure, say "y". Only special kernels like petitboot may
 	  need to say "N" here.
 
+config PRESERVE_FA_DUMP
+	bool "Preserve Firmware-assisted dump"
+	depends on PPC64 && PPC_POWERNV && !FA_DUMP
+	help
+	  On a kernel with FA_DUMP disabled, this option helps to preserve
+	  crash data from a previously crash'ed kernel. Useful when the next
+	  memory preserving kernel boot would process this crash data.
+	  Petitboot kernel is the typical usecase for this option.
+
 config IRQ_ALL_CPUS
 	bool "Distribute interrupts on all CPUs by default"
 	depends on SMP
diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index d27cde7..d09b77b 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -27,9 +27,6 @@
 extern int crashing_cpu;
 
 extern int is_fadump_memory_area(u64 addr, ulong size);
-extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
-				      int depth, void *data);
-extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
 extern int should_fadump_crash(void);
@@ -41,4 +38,10 @@ static inline int is_fadump_active(void) { return 0; }
 static inline int should_fadump_crash(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
 #endif /* !CONFIG_FA_DUMP */
+
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
+extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
+				      int depth, void *data);
+extern int fadump_reserve_mem(void);
+#endif
 #endif /* __PPC64_FA_DUMP_H__ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index fbecfba..42c24f8 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -65,7 +65,11 @@ obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
-obj-$(CONFIG_FA_DUMP)		+= fadump.o fadump-common.o
+ifeq ($(CONFIG_FA_DUMP),y)
+obj-y				+= fadump.o fadump-common.o
+else
+obj-$(CONFIG_PRESERVE_FA_DUMP)	+= fadump.o
+endif
 ifdef CONFIG_PPC32
 obj-$(CONFIG_E500)		+= idle_e500.o
 endif
diff --git a/arch/powerpc/kernel/fadump-common.h b/arch/powerpc/kernel/fadump-common.h
index 8d47382..1bd3aeb 100644
--- a/arch/powerpc/kernel/fadump-common.h
+++ b/arch/powerpc/kernel/fadump-common.h
@@ -13,6 +13,7 @@
 #ifndef __PPC64_FA_DUMP_INTERNAL_H__
 #define __PPC64_FA_DUMP_INTERNAL_H__
 
+#ifndef CONFIG_PRESERVE_FA_DUMP
 /*
  * The RMA region will be saved for later dumping when kernel crashes.
  * RMA is Real Mode Area, the first block of logical memory address owned
@@ -88,6 +89,7 @@ struct fadump_crash_info_header {
 
 /* Platform specific callback functions */
 struct fadump_ops;
+#endif /* !CONFIG_PRESERVE_FA_DUMP */
 
 /* Firmware-Assited Dump platforms */
 enum fadump_platform_type {
@@ -157,9 +159,12 @@ struct fw_dump {
 	unsigned long	nocma:1;
 
 	enum fadump_platform_type	fadump_platform;
+#ifndef CONFIG_PRESERVE_FA_DUMP
 	struct fadump_ops		*ops;
+#endif
 };
 
+#ifndef CONFIG_PRESERVE_FA_DUMP
 struct fadump_ops {
 	ulong	(*init_fadump_mem_struct)(struct fw_dump *fadump_config);
 	int	(*register_fadump)(struct fw_dump *fadump_config);
@@ -181,8 +186,9 @@ u32 *fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs);
 void fadump_update_elfcore_header(struct fw_dump *fadump_config, char *bufp);
 int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf);
 int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf);
+#endif /* !CONFIG_PRESERVE_FA_DUMP */
 
-#ifdef CONFIG_PPC_PSERIES
+#if !defined(CONFIG_PRESERVE_FA_DUMP) && defined(CONFIG_PPC_PSERIES)
 extern int pseries_dt_scan_fadump(struct fw_dump *fadump_config, ulong node);
 #else
 static inline int
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index fd06571..ba26169 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -47,6 +47,7 @@
 
 static struct fw_dump fw_dump;
 
+#ifndef CONFIG_PRESERVE_FA_DUMP
 static DEFINE_MUTEX(fadump_mutex);
 struct fadump_memory_range *crash_memory_ranges;
 int crash_memory_ranges_size;
@@ -217,6 +218,9 @@ static void __init early_init_dt_scan_reserved_ranges(unsigned long node)
 		}
 	}
 }
+#else /* !CONFIG_PRESERVE_FA_DUMP */
+static inline void early_init_dt_scan_reserved_ranges(unsigned long node) { }
+#endif /* CONFIG_PRESERVE_FA_DUMP */
 
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
@@ -238,6 +242,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
 	return 0;
 }
 
+#ifndef CONFIG_PRESERVE_FA_DUMP
 /*
  * If fadump is registered, check if the memory provided
  * falls within boot memory area and reserved memory area.
@@ -488,6 +493,7 @@ static bool overlaps_with_reserved_ranges(ulong base, ulong end)
 
 	return ret;
 }
+#endif /* !CONFIG_PRESERVE_FA_DUMP */
 
 /* Preserve everything above the base address */
 static void __init fadump_reserve_crash_area(unsigned long base)
@@ -506,12 +512,45 @@ static void __init fadump_reserve_crash_area(unsigned long base)
 			msize -= (base - mstart);
 			mstart = base;
 		}
-		pr_info("Reserving %luMB of memory at %#016lx for saving crash dump",
+		pr_info("Reserving %luMB of memory at %#016lx for preserving crash data",
 			(msize >> 20), mstart);
 		memblock_reserve(mstart, msize);
 	}
 }
 
+unsigned long __init arch_reserved_kernel_pages(void)
+{
+	return memblock_reserved_size() / PAGE_SIZE;
+}
+
+#ifdef CONFIG_PRESERVE_FA_DUMP
+/*
+ * When dump is active but PRESERVE_FA_DUMP is enabled on the kernel,
+ * preserve crash data. The subsequent memory preserving kernel boot
+ * is likely to process this crash data.
+ */
+int __init fadump_reserve_mem(void)
+{
+	if (fw_dump.dump_active) {
+		unsigned long base;
+
+		pr_info("Preserving crash data for processing in next boot.\n");
+		fw_dump.boot_memory_size = fw_dump.rmr_source_len;
+		base = fw_dump.boot_memory_size + fw_dump.boot_memory_hole_size;
+		base = PAGE_ALIGN(base);
+
+		/*
+		 * If last boot has crashed then reserve all the memory
+		 * above boot memory size to preserve crash data.
+		 */
+		fadump_reserve_crash_area(base);
+	} else
+		pr_debug("FADump-aware kernel..\n");
+
+	return 1;
+}
+#else /* CONFIG_PRESERVE_FA_DUMP */
+
 int __init fadump_reserve_mem(void)
 {
 	int ret = 1;
@@ -630,11 +669,6 @@ int __init fadump_reserve_mem(void)
 	return 0;
 }
 
-unsigned long __init arch_reserved_kernel_pages(void)
-{
-	return memblock_reserved_size() / PAGE_SIZE;
-}
-
 /* Look for fadump= cmdline option. */
 static int __init early_fadump_param(char *p)
 {
@@ -1395,3 +1429,4 @@ int __init setup_fadump(void)
 	return 1;
 }
 subsys_initcall(setup_fadump);
+#endif /* !CONFIG_PRESERVE_FA_DUMP */
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4221527..b71be60 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -708,7 +708,7 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_opal, NULL);
 #endif
 
-#ifdef CONFIG_FA_DUMP
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
 	/* scan tree to see if dump is active during last boot */
 	of_scan_flat_dt(early_init_dt_scan_fw_dump, NULL);
 #endif
@@ -735,7 +735,7 @@ void __init early_init_devtree(void *params)
 	if (PHYSICAL_START > MEMORY_START)
 		memblock_reserve(MEMORY_START, 0x8000);
 	reserve_kdump_trampoline();
-#ifdef CONFIG_FA_DUMP
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
 	/*
 	 * If we fail to reserve memory for firmware-assisted dump then
 	 * fallback to kexec based kdump.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 43a6e1c..b4a8022 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -7,6 +7,7 @@ obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_FA_DUMP)	+= opal-fadump.o
+obj-$(CONFIG_PRESERVE_FA_DUMP)	+= opal-fadump.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index 853f663..11a7c5f 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -28,9 +28,10 @@
 #include "../../kernel/fadump-common.h"
 #include "opal-fadump.h"
 
-static struct opal_fadump_mem_struct fdm;
-static const struct opal_fadump_mem_struct *fdm_active;
 unsigned long fdm_actual_size;
+static const struct opal_fadump_mem_struct *fdm_active;
+#ifndef CONFIG_PRESERVE_FA_DUMP
+static struct opal_fadump_mem_struct fdm;
 
 static void opal_set_preserv_area_start(struct fw_dump *fadump_conf)
 {
@@ -39,6 +40,7 @@ static void opal_set_preserv_area_start(struct fw_dump *fadump_conf)
 	pr_debug("Preserve area start address: 0x%lx\n",
 		 fadump_conf->preserv_area_start);
 }
+#endif /* !CONFIG_PRESERVE_FA_DUMP */
 
 static void update_fadump_config(struct fw_dump *fadump_conf,
 				 const struct opal_fadump_mem_struct *fdm)
@@ -107,10 +109,40 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 			 fadump_conf->rmr_regions_cnt);
 	}
 
+#ifndef CONFIG_PRESERVE_FA_DUMP
 	fadump_set_meta_area_start(fadump_conf);
 	opal_set_preserv_area_start(fadump_conf);
+#endif
+}
+
+/*
+ * When dump is active but PRESERVE_FA_DUMP is enabled on the kernel,
+ * ensure crash data is preserved in hope that the subsequent memory
+ * preserving kernel boot is going to process this crash data.
+ */
+#ifdef CONFIG_PRESERVE_FA_DUMP
+int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
+{
+	unsigned long dn;
+
+	dn = of_get_flat_dt_subnode_by_name(node, "dump");
+	if (dn == -FDT_ERR_NOTFOUND)
+		return 1;
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
+	return 1;
 }
 
+#else /* CONFIG_PRESERVE_FA_DUMP */
 static ulong opal_init_fadump_mem_struct(struct fw_dump *fadump_conf)
 {
 	ulong addr = fadump_conf->reserve_dump_area_start;
@@ -538,3 +570,4 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 
 	return 1;
 }
+#endif /* !CONFIG_PRESERVE_FA_DUMP */

