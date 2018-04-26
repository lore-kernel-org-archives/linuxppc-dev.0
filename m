Return-Path: <srs0=trvj=hp=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WwCg6fTszF25Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40WwCg683gz8tF7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 21:42:23 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40WwCg103Qz9rxs
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 21:42:22 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3QBdBEs004451
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:19 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hkd37jqyc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 07:42:19 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 26 Apr 2018 12:42:17 +0100
Subject: [PATCH v5 2/4] powerpc/fadump: Reservationless firmware assisted dump
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>
Date: Thu, 26 Apr 2018 17:12:11 +0530
In-Reply-To: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
References: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152474293139.5697.15866150160568793982.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

One of the primary issues with Firmware Assisted Dump (fadump) on Power
is that it needs a large amount of memory to be reserved. On large
systems with TeraBytes of memory, this reservation can be quite
significant.

In some cases, fadump fails if the memory reserved is insufficient, or
if the reserved memory was DLPAR hot-removed.

In the normal case, post reboot, the preserved memory is filtered to
extract only relevant areas of interest using the makedumpfile tool.
While the tool provides flexibility to determine what needs to be part
of the dump and what memory to filter out, all supported distributions
default this to "Capture only kernel data and nothing else".

We take advantage of this default and the Linux kernel's Contiguous
Memory Allocator (CMA) to fundamentally change the memory reservation
model for fadump.

Instead of setting aside a significant chunk of memory nobody can use,
this patch uses CMA instead, to reserve a significant chunk of memory
that the kernel is prevented from using (due to MIGRATE_CMA), but
applications are free to use it. With this fadump will still be able
to capture all of the kernel memory and most of the user space memory
except the user pages that were present in CMA region.

Essentially, on a P9 LPAR with 2 cores, 8GB RAM and current upstream:
[root@zzxx-yy10 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           7557         193        6822          12         541        6725
Swap:          4095           0        4095

With this patch:
[root@zzxx-yy10 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:           8133         194        7464          12         475        7338
Swap:          4095           0        4095

Changes made here are completely transparent to how fadump has
traditionally worked.

Thanks to Aneesh Kumar and Anshuman Khandual for helping us understand
CMA and its usage.

TODO:
- Handle case where CMA reservation spans nodes.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   10 ++-
 arch/powerpc/include/asm/fadump.h                |    4 +
 arch/powerpc/kernel/fadump.c                     |   84 +++++++++++++++++++---
 3 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index bdd344aa18d9..f2823a1e3f9d 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -113,7 +113,15 @@ header, is usually reserved at an offset greater than boot memory
 size (see Fig. 1). This area is *not* released: this region will
 be kept permanently reserved, so that it can act as a receptacle
 for a copy of the boot memory content in addition to CPU state
-and HPTE region, in the case a crash does occur.
+and HPTE region, in the case a crash does occur. Since this reserved
+memory area is used only after the system crash, there is no point in
+blocking this significant chunk of memory from production kernel.
+Hence, the implementation uses the Linux kernel's Contiguous Memory
+Allocator (CMA) for memory reservation if CMA is configured for kernel.
+With CMA reservation this memory will be available for applications to
+use it, while kernel is prevented from using it. With this fadump will
+still be able to capture all of the kernel memory and most of the user
+space memory except the user pages that were present in CMA region.
 
   o Memory Reservation during first kernel
 
diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5a23010af600..0bf0d3b37c6e 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -48,6 +48,10 @@
 
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
+/* Alignement per CMA requirement. */
+#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
+			max_t(unsigned long, MAX_ORDER - 1, pageblock_order))
+
 /* Firmware provided dump sections */
 #define FADUMP_CPU_STATE_DATA	0x0001
 #define FADUMP_HPTE_REGION	0x0002
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 07e8396d472b..d44d89c8967f 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -34,6 +34,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/cma.h>
 
 #include <asm/debugfs.h>
 #include <asm/page.h>
@@ -45,11 +46,68 @@
 static struct fw_dump fw_dump;
 static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
+#ifdef CONFIG_CMA
+static struct cma *fadump_cma;
+#endif
 
 static DEFINE_MUTEX(fadump_mutex);
 struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
 int crash_mem_ranges;
 
+#ifdef CONFIG_CMA
+/*
+ * fadump_cma_init() - Initializ CMA area from a fadump reserved memory
+ *
+ * This function initializes CMA area from fadump reserved memory.
+ * The total size of fadump reserved memory covers for boot memory size
+ * + cpu data size + hpte size and metadata.
+ * Initialize only the area equivalent to boot memory size for CMA use.
+ * The reamining portion of fadump reserved memory will be not given
+ * to CMA and pages for thoes will stay reserved. boot memory size is
+ * aligned per CMA requirement to satisy cma_init_reserved_mem() call.
+ * But for some reason even if it fails we still have the memory reservation
+ * with us and we can still continue doing fadump.
+ */
+int __init fadump_cma_init(void)
+{
+	unsigned long long base, size;
+	int rc;
+
+	if (!fw_dump.fadump_enabled)
+		return 0;
+
+	base = fw_dump.reserve_dump_area_start;
+	size = fw_dump.boot_memory_size;
+
+	if (!size)
+		return 0;
+
+	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
+	if (rc) {
+		pr_err("Failed to init cma area for firmware-assisted dump,%d\n", rc);
+		/*
+		 * Though the CMA init has failed we still have memory
+		 * reservation with us. The reserved memory will be
+		 * blocked from production system usage.  Hence return 1,
+		 * so that we can continue with fadump.
+		 */
+		return 1;
+	}
+
+	/*
+	 * So we now have successfully initialized cma area for fadump.
+	 */
+	pr_info("Initialized 0x%lx bytes cma area at %ldMB from 0x%lx "
+		"bytes of memory reserved for firmware-assisted dump\n",
+		cma_get_size(fadump_cma),
+		(unsigned long)cma_get_base(fadump_cma) >> 20,
+		fw_dump.reserve_dump_area_size);
+	return 1;
+}
+#else
+static int __init fadump_cma_init(void) { return 1; }
+#endif /* CONFIG_CMA */
+
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node,
 			const char *uname, int depth, void *data)
@@ -375,8 +433,13 @@ int __init fadump_reserve_mem(void)
 	 */
 	if (fdm_active)
 		fw_dump.boot_memory_size = be64_to_cpu(fdm_active->rmr_region.source_len);
-	else
+	else {
 		fw_dump.boot_memory_size = fadump_calculate_reserve_size();
+#ifdef CONFIG_CMA
+		fw_dump.boot_memory_size = ALIGN(fw_dump.boot_memory_size,
+							FADUMP_CMA_ALIGNMENT);
+#endif
+	}
 
 	/*
 	 * Calculate the memory boundary.
@@ -423,8 +486,9 @@ int __init fadump_reserve_mem(void)
 		fw_dump.fadumphdr_addr =
 				be64_to_cpu(fdm_active->rmr_region.destination_address) +
 				be64_to_cpu(fdm_active->rmr_region.source_len);
-		pr_debug("fadumphdr_addr = %p\n",
-				(void *) fw_dump.fadumphdr_addr);
+		pr_debug("fadumphdr_addr = %pa\n", &fw_dump.fadumphdr_addr);
+		fw_dump.reserve_dump_area_start = base;
+		fw_dump.reserve_dump_area_size = size;
 	} else {
 		size = get_fadump_area_size();
 
@@ -452,10 +516,11 @@ int __init fadump_reserve_mem(void)
 			(unsigned long)(size >> 20),
 			(unsigned long)(base >> 20),
 			(unsigned long)(memblock_phys_mem_size() >> 20));
-	}
 
-	fw_dump.reserve_dump_area_start = base;
-	fw_dump.reserve_dump_area_size = size;
+		fw_dump.reserve_dump_area_start = base;
+		fw_dump.reserve_dump_area_size = size;
+		return fadump_cma_init();
+	}
 	return 1;
 }
 
@@ -1146,7 +1211,7 @@ static int fadump_unregister_dump(struct fadump_mem_struct *fdm)
 	return 0;
 }
 
-static int fadump_invalidate_dump(struct fadump_mem_struct *fdm)
+static int fadump_invalidate_dump(const struct fadump_mem_struct *fdm)
 {
 	int rc = 0;
 	unsigned int wait_time;
@@ -1177,9 +1242,8 @@ void fadump_cleanup(void)
 {
 	/* Invalidate the registration only if dump is active. */
 	if (fw_dump.dump_active) {
-		init_fadump_mem_struct(&fdm,
-			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
-		fadump_invalidate_dump(&fdm);
+		/* pass the same memory dump structure provided by platform */
+		fadump_invalidate_dump(fdm_active);
 	} else if (fw_dump.dump_registered) {
 		/* Un-register Firmware-assisted dump if it was registered. */
 		fadump_unregister_dump(&fdm);
