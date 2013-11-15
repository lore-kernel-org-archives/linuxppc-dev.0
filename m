Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B9FFB2C0097
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Nov 2013 04:31:49 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 16 Nov 2013 03:31:44 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D96D63578050
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Nov 2013 04:31:37 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAFHDsrC19791950
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Nov 2013 04:13:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAFHVYWg029001
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Nov 2013 04:31:35 +1100
Subject: [PATCH] PPC64: Adding symbols in vmcoreinfo to facilitate dump
 filtering
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 15 Nov 2013 23:01:32 +0530
Message-ID: <20131115173132.1121.61175.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_SPARSEMEM_VMEMMAP option is used in kernel, makedumpfile fails
to filter vmcore dump as it fails to do vmemmap translations. So far
dump filtering on ppc64 never had to deal with vmemmap addresses seperately
as vmemmap regions where mapped in zone normal. But with the inclusion of
CONFIG_SPARSEMEM_VMEMMAP config option in kernel, this vmemmap address
translation support becomes necessary for dump filtering. For vmemmap adress
translation, few kernel symbols are needed by dump filtering tool. This patch
adds those symbols to vmcoreinfo, which a dump filtering tool can use for
filtering the kernel dump. Tested this changes successfully with makedumpfile
tool that supports vmemmap to physical address translation outside zone normal.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h |    4 ++++
 arch/powerpc/kernel/machine_kexec.c   |   12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index f65e27b..33e507a 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -17,6 +17,10 @@ struct vmemmap_backing {
 	unsigned long virt_addr;
 };
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+extern struct vmemmap_backing *vmemmap_list;
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
+
 /*
  * Functions that deal with pagetables that could be at any level of
  * the table need to be passed an "index_size" so they know how to
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index e1ec57e..88a7fb4 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -18,6 +18,7 @@
 #include <linux/ftrace.h>
 
 #include <asm/machdep.h>
+#include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/sections.h>
 
@@ -75,6 +76,17 @@ void arch_crash_save_vmcoreinfo(void)
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
+#if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
+	VMCOREINFO_SYMBOL(vmemmap_list);
+	VMCOREINFO_SYMBOL(mmu_vmemmap_psize);
+	VMCOREINFO_SYMBOL(mmu_psize_defs);
+	VMCOREINFO_STRUCT_SIZE(vmemmap_backing);
+	VMCOREINFO_OFFSET(vmemmap_backing, list);
+	VMCOREINFO_OFFSET(vmemmap_backing, phys);
+	VMCOREINFO_OFFSET(vmemmap_backing, virt_addr);
+	VMCOREINFO_STRUCT_SIZE(mmu_psize_def);
+	VMCOREINFO_OFFSET(mmu_psize_def, shift);
+#endif
 }
 
 /*
