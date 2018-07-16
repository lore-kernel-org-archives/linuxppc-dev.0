Return-Path: <srs0=gorp=ka=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TXsv1JM4zF373
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 16:04:03 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41TXst6pg3z8tFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 16:04:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41TXst27zLz9s29
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 16:04:02 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6G5wcG5116428
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 02:04:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k8h6t8b0r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2018 02:04:00 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Jul 2018 07:03:57 +0100
Subject: [RFC PATCH v6 4/4] powerpc/fadump: Do not allow hot-remove memory
 from fadump reserved area.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Michal Hocko <mhocko@suse.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Date: Mon, 16 Jul 2018 11:33:49 +0530
In-Reply-To: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
References: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153172102841.29252.14752362099821314856.stgit@jupiter.in.ibm.com>
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
kernel memory in event of crash. Now that fadump reserved memory is marked
as movable zone, this memory area is now not protected from hot-remove
operations. Hence, fadump service can fail to re-register after the
hot-remove operation, if hot-removed memory belongs to fadump reserved
region. To avoid this make sure that memory from fadump reserved area is
not hot-removable if fadump is registered.

However, if user still wants to remove that memory, he can do so by
manually stopping fadump service before hot-remove operation.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/fadump.h               |    2 +-
 arch/powerpc/kernel/fadump.c                    |   10 ++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 5c0de4508aab..cd28e9b59057 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -208,7 +208,7 @@ struct fad_crash_memory_ranges {
 	unsigned long long	size;
 };
 
-extern int is_fadump_boot_memory_area(u64 addr, ulong size);
+extern int is_fadump_memory_area(u64 addr, ulong size);
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d1375f3f48c3..18a35f12ffb5 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -116,13 +116,19 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 
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
 
