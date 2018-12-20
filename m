Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B163C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:18:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF4F218FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF4F218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LM3h56Z1zDqdM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:18:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LLhF4bSGzDr3m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43LLhF3Vs0z8tRf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:17 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43LLhF2vzwz9sDB; Fri, 21 Dec 2018 06:01:17 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43LLhD6d0nz9sCh
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2018 06:01:16 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBKIwkVC115453
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:01:15 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pggdx8yrw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:01:13 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 20 Dec 2018 19:01:11 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 19:01:10 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBKJ18Fr2556332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 19:01:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91CB2A4054;
 Thu, 20 Dec 2018 19:01:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9D12A4062;
 Thu, 20 Dec 2018 19:01:06 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.47.3])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Dec 2018 19:01:06 +0000 (GMT)
Subject: [PATCH 7/9] powerpc/fadump: add support to preserve crash data on
 FADUMP disabled kernel
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Fri, 21 Dec 2018 00:31:05 +0530
In-Reply-To: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
References: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122019-0012-0000-0000-000002DBEA6D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122019-0013-0000-0000-000021118D9B
Message-Id: <154533246582.28973.5733341614417266722.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
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

Add a new kernel config option, CONFIG_PRESERVE_FA_DUMP that ensures
that crash data, from previously crash'ed kernel, is preserved. This
helps in cases where FADUMP is not enabled but the subsequent memory
preserving kernel boot is likely to process this crash data. One
typical usecase for this config option is petitboot kernel.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/Kconfig                         |    9 ++++++
 arch/powerpc/include/asm/fadump.h            |   12 ++++----
 arch/powerpc/kernel/Makefile                 |    6 +++-
 arch/powerpc/kernel/fadump.c                 |   41 ++++++++++++++++++++++----
 arch/powerpc/kernel/fadump_internal.h        |    6 ++++
 arch/powerpc/kernel/prom.c                   |    4 +--
 arch/powerpc/platforms/powernv/Makefile      |    6 +++-
 arch/powerpc/platforms/powernv/opal-fadump.c |   35 ++++++++++++++++++++++
 8 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 08add7a..afa4e79 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -579,6 +579,15 @@ config FA_DUMP
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
index db9465f..92a9ddf 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -22,14 +22,16 @@
 #ifndef __PPC64_FA_DUMP_H__
 #define __PPC64_FA_DUMP_H__
 
-#ifdef CONFIG_FA_DUMP
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
+extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
+				      int depth, void *data);
+extern int fadump_reserve_mem(void);
+#endif
 
+#ifdef CONFIG_FA_DUMP
 extern int crashing_cpu;
 
 extern int is_fadump_memory_area(u64 addr, ulong size);
-extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
-				      int depth, void *data);
-extern int fadump_reserve_mem(void);
 extern int setup_fadump(void);
 extern int is_fadump_active(void);
 extern int should_fadump_crash(void);
@@ -41,4 +43,4 @@ static inline int is_fadump_active(void) { return 0; }
 static inline int should_fadump_crash(void) { return 0; }
 static inline void crash_fadump(struct pt_regs *regs, const char *str) { }
 #endif
-#endif
+#endif /* __PPC64_FA_DUMP_H__ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8e4bade..8ed84d2 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -65,7 +65,11 @@ obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
-obj-$(CONFIG_FA_DUMP)		+= fadump.o fadump_internal.o
+ifeq ($(CONFIG_FA_DUMP),y)
+obj-y				+= fadump.o fadump_internal.o
+else
+obj-$(CONFIG_PRESERVE_FA_DUMP)	+= fadump.o
+endif
 ifdef CONFIG_PPC32
 obj-$(CONFIG_E500)		+= idle_e500.o
 endif
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d9cf809..2c9457b 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -47,6 +47,7 @@
 
 static struct fw_dump fw_dump;
 
+#ifdef CONFIG_FA_DUMP
 #ifdef CONFIG_CMA
 static struct cma *fadump_cma;
 #endif
@@ -117,6 +118,7 @@ int __init fadump_cma_init(void)
 #else
 static int __init fadump_cma_init(void) { return 1; }
 #endif /* CONFIG_CMA */
+#endif /* CONFIG_FA_DUMP */
 
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
@@ -125,8 +127,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
 	if (depth != 1)
 		return 0;
 
+#ifdef CONFIG_FA_DUMP
 	if (strcmp(uname, "rtas") == 0)
 		return pseries_dt_scan_fadump(&fw_dump, node);
+#endif
 
 	if (strcmp(uname, "ibm,opal") == 0)
 		return opal_dt_scan_fadump(&fw_dump, node);
@@ -134,6 +138,7 @@ int __init early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
 	return 0;
 }
 
+#ifdef CONFIG_FA_DUMP
 /*
  * If fadump is registered, check if the memory provided
  * falls within boot memory area and reserved memory area.
@@ -366,6 +371,7 @@ static int __init fadump_get_rmr_regions(void)
 
 	return ret;
 }
+#endif /* CONFIG_FA_DUMP */
 
 /* Preserve everything above the base address */
 static void __init fadump_reserve_crash_area(unsigned long base)
@@ -384,7 +390,7 @@ static void __init fadump_reserve_crash_area(unsigned long base)
 			msize -= (base - mstart);
 			mstart = base;
 		}
-		pr_info("Reserving %luMB of memory at %#016lx for saving crash dump",
+		pr_info("Reserving %luMB of memory at %#016lx for preserving crash data",
 			(msize >> 20), mstart);
 		memblock_reserve(mstart, msize);
 	}
@@ -392,26 +398,46 @@ static void __init fadump_reserve_crash_area(unsigned long base)
 
 int __init fadump_reserve_mem(void)
 {
-	unsigned long base, size, memory_boundary;
+	unsigned long base;
+#ifndef CONFIG_PRESERVE_FA_DUMP
+	unsigned long size, memory_boundary;
 
 	if (!fw_dump.fadump_enabled)
 		return 0;
 
 	if (!fw_dump.fadump_supported) {
-		printk(KERN_INFO "Firmware-assisted dump is not supported on"
-				" this hardware\n");
+		pr_info("Firmware-assisted dump is not supported on this hardware\n");
 		fw_dump.fadump_enabled = 0;
 		return 0;
 	}
+#endif
 
 	/*
 	 * Initialize boot memory size
 	 * If dump is active then we have already calculated the size during
 	 * first kernel.
 	 */
-	if (fw_dump.dump_active)
+	if (fw_dump.dump_active) {
 		fw_dump.boot_memory_size = fw_dump.rmr_source_len;
-	else {
+
+		/*
+		 * When dump is active but PRESERVE_FA_DUMP is enabled on the
+		 * kernel, preserve crash data. The subsequent memory preserving
+		 * kernel boot is likely to process this crash data.
+		 */
+#ifdef CONFIG_PRESERVE_FA_DUMP
+		pr_info("Preserving crash data for processing in next boot.\n");
+		base = fw_dump.boot_memory_size + fw_dump.boot_memory_hole_size;
+		base = PAGE_ALIGN(base);
+
+		/*
+		 * If last boot has crashed then reserve all the memory
+		 * above boot memory size to preserve crash data.
+		 */
+		fadump_reserve_crash_area(base);
+	}
+#else /* CONFIG_PRESERVE_FA_DUMP */
+	} else {
 		fw_dump.boot_memory_size = fadump_calculate_reserve_size();
 #ifdef CONFIG_CMA
 		if (!fw_dump.nocma)
@@ -499,6 +525,7 @@ int __init fadump_reserve_mem(void)
 		fw_dump.reserve_dump_area_start = base;
 		return fadump_cma_init();
 	}
+#endif /* !CONFIG_PRESERVE_FA_DUMP */
 	return 1;
 }
 
@@ -507,6 +534,7 @@ unsigned long __init arch_reserved_kernel_pages(void)
 	return memblock_reserved_size() / PAGE_SIZE;
 }
 
+#ifdef CONFIG_FA_DUMP
 /* Look for fadump= cmdline option. */
 static int __init early_fadump_param(char *p)
 {
@@ -1234,3 +1262,4 @@ int __init setup_fadump(void)
 	return 1;
 }
 subsys_initcall(setup_fadump);
+#endif /* CONFIG_FA_DUMP */
diff --git a/arch/powerpc/kernel/fadump_internal.h b/arch/powerpc/kernel/fadump_internal.h
index a117f60..ce4c0f9 100644
--- a/arch/powerpc/kernel/fadump_internal.h
+++ b/arch/powerpc/kernel/fadump_internal.h
@@ -13,6 +13,7 @@
 #ifndef __PPC64_FA_DUMP_INTERNAL_H__
 #define __PPC64_FA_DUMP_INTERNAL_H__
 
+#ifdef CONFIG_FA_DUMP
 /*
  * The RMA region will be saved for later dumping when kernel crashes.
  * RMA is Real Mode Area, the first block of logical memory address owned
@@ -106,6 +107,7 @@ struct fadump_backup_area {
 	 * the version field.
 	 */
 };
+#endif /* CONFIG_FA_DUMP */
 
 /* Firmware-Assited Dump platforms */
 enum fadump_platform_type {
@@ -166,9 +168,12 @@ struct fw_dump {
 	unsigned long	nocma:1;
 
 	enum fadump_platform_type	fadump_platform;
+#ifdef CONFIG_FA_DUMP
 	struct fadump_ops		*ops;
+#endif
 };
 
+#ifdef CONFIG_FA_DUMP
 struct fadump_ops {
 	ulong	(*init_fadump_mem_struct)(struct fw_dump *fadump_config);
 	ulong	(*init_fadump_header)(struct fw_dump *fadump_config);
@@ -198,6 +203,7 @@ int is_boot_memory_area_contiguous(struct fw_dump *fadump_conf);
 int is_reserved_memory_area_contiguous(struct fw_dump *fadump_conf);
 void init_fadump_backup_area(struct fw_dump *fadump_conf);
 unsigned long fadump_populate_backup_area(struct fw_dump *fadump_conf);
+#endif /* CONFIG_FA_DUMP */
 
 #ifdef CONFIG_PPC_PSERIES
 extern int pseries_dt_scan_fadump(struct fw_dump *fadump_config, ulong node);
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fe758ce..aa425ad 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -705,7 +705,7 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(early_init_dt_scan_opal, NULL);
 #endif
 
-#ifdef CONFIG_FA_DUMP
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
 	/* scan tree to see if dump is active during last boot */
 	of_scan_flat_dt(early_init_dt_scan_fw_dump, NULL);
 #endif
@@ -732,7 +732,7 @@ void __init early_init_devtree(void *params)
 	if (PHYSICAL_START > MEMORY_START)
 		memblock_reserve(MEMORY_START, 0x8000);
 	reserve_kdump_trampoline();
-#ifdef CONFIG_FA_DUMP
+#if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
 	/*
 	 * If we fail to reserve memory for firmware-assisted dump then
 	 * fallback to kexec based kdump.
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 9420631..750675e 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,7 +6,11 @@ obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
 obj-y			+= opal-kmsg.o opal-powercap.o opal-psr.o opal-sensor-groups.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
-obj-$(CONFIG_FA_DUMP)	+= opal-fadump.o opal-core.o
+ifeq ($(CONFIG_FA_DUMP),y)
+obj-y			+= opal-fadump.o opal-core.o
+else
+obj-$(CONFIG_PRESERVE_FA_DUMP)	+= opal-fadump.o
+endif
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o pci-ioda-tce.o
 obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opal-fadump.c b/arch/powerpc/platforms/powernv/opal-fadump.c
index 5bd0a0f..b3f3903 100644
--- a/arch/powerpc/platforms/powernv/opal-fadump.c
+++ b/arch/powerpc/platforms/powernv/opal-fadump.c
@@ -27,13 +27,16 @@
 
 #include "../../kernel/fadump_internal.h"
 #include "opal-fadump.h"
+#ifdef CONFIG_FA_DUMP
 #include "opal-core.h"
 
 static struct opal_fadump_mem_struct fdm;
 static struct opalcore_config oc_config;
+#endif
 static const struct opal_fadump_mem_struct *fdm_active;
 unsigned long fdm_actual_size;
 
+#ifndef CONFIG_PRESERVE_FA_DUMP
 /*
  * Backup area is not available in older format. In the newer fadump
  * header format (v2), backup info is stored at the end of elfcorehdrs
@@ -74,6 +77,7 @@ static void opal_set_preserv_area_start(struct fw_dump *fadump_conf)
 	pr_debug("Preserve area start address: 0x%lx\n",
 		 fadump_conf->preserv_area_start);
 }
+#endif /* !CONFIG_PRESERVE_FA_DUMP */
 
 static void update_fadump_config(struct fw_dump *fadump_conf,
 				 const struct opal_fadump_mem_struct *fdm)
@@ -142,11 +146,41 @@ static void update_fadump_config(struct fw_dump *fadump_conf,
 			 fadump_conf->rmr_regions_cnt);
 	}
 
+#ifndef CONFIG_PRESERVE_FA_DUMP
 	fadump_set_meta_area_start(fadump_conf);
 	opal_set_preserv_area_start(fadump_conf);
 	opal_set_backup_area_start(fadump_conf);
+#endif
 }
 
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
+}
+
+#else /* CONFIG_PRESERVE_FA_DUMP */
 static ulong opal_init_fadump_mem_struct(struct fw_dump *fadump_conf)
 {
 	ulong addr = fadump_conf->reserve_dump_area_start;
@@ -618,3 +652,4 @@ int __init opal_dt_scan_fadump(struct fw_dump *fadump_conf, ulong node)
 
 	return 1;
 }
+#endif /* !CONFIG_PRESERVE_FA_DUMP */

