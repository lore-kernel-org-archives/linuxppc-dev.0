Return-Path: <srs0=hqze=5g=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdvL169Z0zDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 03:22:33 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wdvL15X80z8t85
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 03:22:33 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wdvL12C12z9s78
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2017 03:22:33 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51HIscv010022
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2017 13:22:28 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atnkbcphs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Jun 2017 13:22:27 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 2 Jun 2017 03:22:25 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51HMFgr2163064
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2017 03:22:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51HLgsv002941
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2017 03:21:43 +1000
Subject: [PATCH v3 2/3] powerpc/fadump: avoid holes in boot memory area when
 fadump is registered
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Pingfan Liu <piliu@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 01 Jun 2017 22:51:26 +0530
In-Reply-To: <149633761543.6229.12888040793158845755.stgit@hbathini.in.ibm.com>
References: <149633761543.6229.12888040793158845755.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149633766253.6229.9801508816798942650.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To register fadump, boot memory area - the size of low memory chunk that
is required for a kernel to boot successfully when booted with restricted
memory, is assumed to have no holes. But this memory area is currently
not protected from hot-remove operations. So, fadump could fail to
re-register after a memory hot-remove operation, if memory is removed
from boot memory area. To avoid this, ensure that memory from boot
memory area is not hot-removed when fadump is registered.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
---

* No changes since v2.


 arch/powerpc/include/asm/fadump.h               |    1 +
 arch/powerpc/kernel/fadump.c                    |   12 ++++++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 60b9108..d3e1e18 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -200,6 +200,7 @@ struct fad_crash_memory_ranges {
 	unsigned long long	size;
 };
 
+extern int is_fadump_boot_memory_area(u64 addr, ulong size);
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index f7ba0dc..0e78135 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -113,6 +113,18 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 	return 1;
 }
 
+/*
+ * If fadump is registered, check if the memory provided
+ * falls within boot memory area.
+ */
+int is_fadump_boot_memory_area(u64 addr, ulong size)
+{
+	if (!fw_dump.dump_registered)
+		return 0;
+
+	return (addr + size) > RMA_START && addr <= fw_dump.boot_memory_size;
+}
+
 int is_fadump_active(void)
 {
 	return fw_dump.dump_active;
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index e104c71..a186b8e 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -22,6 +22,7 @@
 #include <asm/machdep.h>
 #include <asm/prom.h>
 #include <asm/sparsemem.h>
+#include <asm/fadump.h>
 #include "pseries.h"
 
 static bool rtas_hp_event;
@@ -406,6 +407,12 @@ static bool lmb_is_removable(struct of_drconf_cell *lmb)
 	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
 	phys_addr = lmb->base_addr;
 
+#ifdef CONFIG_FA_DUMP
+	/* Don't hot-remove memory that falls in fadump boot memory area */
+	if (is_fadump_boot_memory_area(phys_addr, block_sz))
+		return false;
+#endif
+
 	for (i = 0; i < scns_per_block; i++) {
 		pfn = PFN_DOWN(phys_addr);
 		if (!pfn_present(pfn))
