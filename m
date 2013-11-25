Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5EBDD2C0098
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Nov 2013 17:56:34 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 25 Nov 2013 16:56:33 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4D7E32CE8053
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Nov 2013 17:56:26 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAP6cNmO23461944
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Nov 2013 17:38:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAP6uOat012940
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Nov 2013 17:56:24 +1100
Subject: [PATCH v2] PPC64: Adding symbols in vmcoreinfo to facilitate dump
 filtering
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 25 Nov 2013 12:26:20 +0530
Message-ID: <20131125065620.22242.54478.stgit@localhost.localdomain>
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

When CONFIG_SPARSEMEM_VMEMMAP option is set in kernel, makedumpfile
tool fails to filter vmcore dump as it fails to do translations for
vmemmap addresses that are mapped outside zone normal. For vmemmap
adress translation support in this scenario, few kernel symbols are
needed by dump filtering tool. This patch adds those symbols to
vmcoreinfo, which a dump filtering tool can use for filtering the
kernel dump. This changes are tested successfully with makedumpfile
tool that supports vmemmap to physical address translation outside
zone normal.

Changes from v1:
Updated patch decription and removed #ifdef around extern.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h |    2 ++
 arch/powerpc/kernel/machine_kexec.c   |   12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index f65e27b..3973e62 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -17,6 +17,8 @@ struct vmemmap_backing {
 	unsigned long virt_addr;
 };
 
+extern struct vmemmap_backing *vmemmap_list;
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
