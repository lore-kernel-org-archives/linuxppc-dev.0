Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC8EFB70CB
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 09:34:03 +1100 (EST)
Received: from mail6-am1 (localhost.localdomain [127.0.0.1])	by
	mail6-am1-R.bigfish.com (Postfix) with ESMTP id BF47F1B9028C	for
	<linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 22:33:58 +0000 (UTC)
Received: from AM1EHSMHS009.bigfish.com (unknown [10.3.201.253])	by
	mail6-am1.bigfish.com (Postfix) with ESMTP id 40FC76C804B	for
	<linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 22:33:00 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9IMWvjC009081	for <linuxppc-dev@ozlabs.org>;
	Mon, 18 Oct 2010 15:32:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9IMWvL7012329	for <linuxppc-dev@ozlabs.org>;
	Mon, 18 Oct 2010 17:32:57 -0500 (CDT)
Date: Mon, 18 Oct 2010 17:32:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH RFC] PPC: /dev/mem: All RAM is cacheable, not just the
	kernel's.
Message-ID: <20101018223256.GA30946@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If mem= is used on the kernel command line to create reserved regions
for userspace to map using /dev/mem, let it be mapped cacheable as long
as it is within the memory region described in the device tree.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This isn't just a performance issue, but it could also be a correctness
issue, if the reserved portion of RAM is mapped cacheable by e.g. a KVM
guest.  This patch does not address cases where such regions could show up
as something other than a standard memory node -- such as shared regions
in an AMP configuration.  Ideally there would be some means for a platform
to register cacheable regions, without having to completely replace the
entire phys_mem_access_prot function.

This patch assumes that there is no region between memstart and memend that
must be non-cacheable.  This is already the case with the "for now"
implementation of page_is_ram on 32-bit, but will this be a problem on
64-bit?

 arch/powerpc/kernel/pci-common.c |    5 ++++-
 arch/powerpc/kernel/prom.c       |    3 +++
 arch/powerpc/mm/mem.c            |    3 ++-
 arch/powerpc/mm/mmu_decl.h       |    1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 10a44e6..4298a56 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -39,6 +39,8 @@
 #include <asm/firmware.h>
 #include <asm/eeh.h>
 
+#include <mm/mmu_decl.h>
+
 static DEFINE_SPINLOCK(hose_spinlock);
 LIST_HEAD(hose_list);
 
@@ -398,7 +400,8 @@ pgprot_t pci_phys_mem_access_prot(struct file *file,
 	resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
 	int i;
 
-	if (page_is_ram(pfn))
+	if (pfn >= (memstart_addr >> PAGE_SHIFT) &&
+	    pfn <= (memend_addr >> PAGE_SHIFT))
 		return prot;
 
 	prot = pgprot_noncached(prot);
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fed9bf6..f8f5966 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -62,6 +62,8 @@
 #define DBG(fmt...)
 #endif
 
+phys_addr_t memend_addr;
+
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
@@ -504,6 +506,7 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 	memblock_add(base, size);
 
 	memstart_addr = min((u64)memstart_addr, base);
+	memend_addr = max((u64)memend_addr, base + size - 1);
 }
 
 u64 __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 1a84a8d..f947a39 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -104,7 +104,8 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	if (ppc_md.phys_mem_access_prot)
 		return ppc_md.phys_mem_access_prot(file, pfn, size, vma_prot);
 
-	if (!page_is_ram(pfn))
+	if (pfn < (memstart_addr >> PAGE_SHIFT) ||
+	    pfn > (memend_addr >> PAGE_SHIFT))
 		vma_prot = pgprot_noncached(vma_prot);
 
 	return vma_prot;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index dd0a258..05f1ac6 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -119,6 +119,7 @@ extern phys_addr_t __initial_memory_limit_addr;
 extern phys_addr_t total_memory;
 extern phys_addr_t total_lowmem;
 extern phys_addr_t memstart_addr;
+extern phys_addr_t memend_addr;
 extern phys_addr_t lowmem_end_addr;
 
 #ifdef CONFIG_WII
-- 
1.7.0.4
