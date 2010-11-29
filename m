Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e4aea657faf920a0d207e582724ccd7ef08487f1.1291004790.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Record vma->phys_addr in ioremap()
Date: Mon, 29 Nov 2010 15:26:36 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The vmalloc code can track the physical address of a vma, when the
vma is used for ioremap, if set it is displayed in /proc/vmallocinfo.

Because get_vm_area_caller() doesn't know it's being called for
ioremap() it's up to the arch code to set the phys_addr. A bunch
of other arch's do this, I'm not sure why powerpc doesn't?

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/pgtable_32.c |    1 +
 arch/powerpc/mm/pgtable_64.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a87ead0..71932d0 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -230,6 +230,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 		area = get_vm_area_caller(size, VM_IOREMAP, caller);
 		if (area == 0)
 			return NULL;
+		area->phys_addr = p;
 		v = (unsigned long) area->addr;
 	} else {
 		v = (ioremap_bot -= size);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 21d6dfa..88927a0 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -223,6 +223,8 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 					    caller);
 		if (area == NULL)
 			return NULL;
+
+		area->phys_addr = paligned;
 		ret = __ioremap_at(paligned, area->addr, size, flags);
 		if (!ret)
 			vunmap(area->addr);
-- 
1.7.1
