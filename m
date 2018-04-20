Return-Path: <srs0=h10r=hj=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S3hG01YRzF25y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:05:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40S3hF6Wbsz8vqS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 15:05:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40S3hF1ZqWz9s5H
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 15:05:17 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3K54i3r113865
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 01:05:15 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hf8g2abwc-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2018 01:05:15 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 20 Apr 2018 06:05:13 +0100
Subject: [PATCH v4 7/7] powerpc/fadump: Do not allow hot-remove memory from
 fadump reserved area.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 20 Apr 2018 10:35:08 +0530
In-Reply-To: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152420070863.31037.11093621382553645534.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

For fadump to work successfully there should not be any holes in reserved
memory ranges where kernel has asked firmware to move the content of old
kernel memory in event of crash. But this memory area is currently not
protected from hot-remove operations. Hence, fadump service can fail to
re-register after the hot-remove operation, if hot-removed memory belongs
to fadump reserved region. To avoid this make sure that memory from fadump
reserved area is not hot-removable if fadump is registered.

However, if user still wants to remove that memory, he can do so by
manually stopping fadump service before hot-remove operation.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h               |    2 +-
 arch/powerpc/kernel/fadump.c                    |   10 ++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 03d5140a6f0d..5c0a88821ae9 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -212,7 +212,7 @@ struct fad_crash_memory_ranges {
 	unsigned long long	size;
 };
 
-extern int is_fadump_boot_memory_area(u64 addr, ulong size);
+extern int is_fadump_memory_area(u64 addr, ulong size);
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4884ab796f4a..2fda1e4a6318 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -162,13 +162,19 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 
 /*
  * If fadump is registered, check if the memory provided
- * falls within boot memory area.
+ * falls within boot memory area and reserved memory area.
  */
-int is_fadump_boot_memory_area(u64 addr, ulong size)
+int is_fadump_memory_area(u64 addr, ulong size)
 {
+	u64 d_start = fw_dump.reserve_dump_area_start;
+	u64 d_end = d_start + fw_dump.reserve_dump_area_size;
+
 	if (!fw_dump.dump_registered)
 		return 0;
 
+	if (((addr + size) > d_start) && (addr <= d_end))
+		return 1;
+
 	return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
 }
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index c1578f54c626..e4c658cda3a7 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -389,8 +389,11 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
 	phys_addr = lmb->base_addr;
 
 #ifdef CONFIG_FA_DUMP
-	/* Don't hot-remove memory that falls in fadump boot memory area */
-	if (is_fadump_boot_memory_area(phys_addr, block_sz))
+	/*
+	 * Don't hot-remove memory that falls in fadump boot memory area
+	 * and memory that is reserved for capturing old kernel memory.
+	 */
+	if (is_fadump_memory_area(phys_addr, block_sz))
 		return false;
 #endif
 
