Return-Path: <srs0=ldm+=4k=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJjNc0MyXzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 03:55:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wJjNb4QXGz8vy7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 03:55:11 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wJjNZ50jrz9s7C
 for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2017 03:55:10 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44HrpJv028338
 for <linuxppc-dev@ozlabs.org>; Thu, 4 May 2017 13:55:01 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7vsr2rpa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 May 2017 13:55:01 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 5 May 2017 03:54:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44HslND5177746
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 03:54:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44HsM2S001745
 for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2017 03:54:22 +1000
Subject: [PATCH 2/2] powerpc/fadump: avoid holes in boot memory area when
 fadump is registered
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Pingfan Liu <piliu@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 04 May 2017 23:24:05 +0530
In-Reply-To: <149392041651.10802.10097444663269312695.stgit@hbathini.in.ibm.com>
References: <149392041651.10802.10097444663269312695.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149392044508.10802.11008391107873058533.stgit@hbathini.in.ibm.com>
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
---
 arch/powerpc/include/asm/fadump.h               |    1 +
 arch/powerpc/kernel/fadump.c                    |   12 ++++++++++++
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 0031806..609fccc 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -198,6 +198,7 @@ struct fad_crash_memory_ranges {
 	unsigned long long	size;
 };
 
+extern int is_fadump_boot_memory_area(u64 addr, ulong size);
 extern int early_init_dt_scan_fw_dump(unsigned long node,
 		const char *uname, int depth, void *data);
 extern int fadump_reserve_mem(void);
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 03563c6..ea7dfdc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -114,6 +114,18 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
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
