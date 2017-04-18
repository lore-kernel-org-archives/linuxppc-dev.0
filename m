Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6ZkC025szDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 16:20:18 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/mm: Fix page table dump build on PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170418062013.954766E624@localhost.localdomain>
Date: Tue, 18 Apr 2017 08:20:13 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC32 (ex: mpc885_ads_defconfig), page table dump compilation
fails as follows. This is because the memory layout is slightly
different on PPC32. This patch adapts it.

  CC      arch/powerpc/mm/dump_linuxpagetables.o
arch/powerpc/mm/dump_linuxpagetables.c: In function 'walk_pagetables':
arch/powerpc/mm/dump_linuxpagetables.c:369:10: error: 'KERN_VIRT_START' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:369:10: note: each undeclared identifier is reported only once for each function it appears in
arch/powerpc/mm/dump_linuxpagetables.c: In function 'populate_markers':
arch/powerpc/mm/dump_linuxpagetables.c:383:37: error: 'ISA_IO_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:384:37: error: 'ISA_IO_END' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:385:37: error: 'PHB_IO_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:386:37: error: 'PHB_IO_END' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:387:37: error: 'IOREMAP_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:388:37: error: 'IOREMAP_END' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c:392:38: error: 'VMEMMAP_BASE' undeclared (first use in this function)
arch/powerpc/mm/dump_linuxpagetables.c: In function 'ptdump_show':
arch/powerpc/mm/dump_linuxpagetables.c:400:20: error: 'KERN_VIRT_START' undeclared (first use in this function)
make[1]: *** [arch/powerpc/mm/dump_linuxpagetables.o] Error 1
make: *** [arch/powerpc/mm] Error 2

Fixes: 8eb07b187000d ("powerpc/mm: Dump linux pagetables")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 For reviewers: the layout is taken from mem_init() in arch/powerpc/mm/mem.c

 v2: Added missing boundaries setup for fixmap area

 arch/powerpc/mm/dump_linuxpagetables.c | 59 +++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 4ac1a286824e..b1fb1cdee3cd 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -26,6 +26,10 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_PPC32
+#define KERN_VIRT_START	0
+#endif
+
 /*
  * To visualise what is happening,
  *
@@ -69,6 +73,7 @@ static struct addr_marker address_markers[] = {
 	{ 0,	"Start of kernel VM" },
 	{ 0,	"vmalloc() Area" },
 	{ 0,	"vmalloc() End" },
+#ifdef CONFIG_PPC64
 	{ 0,	"isa I/O start" },
 	{ 0,	"isa I/O end" },
 	{ 0,	"phb I/O start" },
@@ -76,6 +81,20 @@ static struct addr_marker address_markers[] = {
 	{ 0,	"I/O remap start" },
 	{ 0,	"I/O remap end" },
 	{ 0,	"vmemmap start" },
+#else
+	{ 0,	"Early I/O remap start" },
+	{ 0,	"Early I/O remap end" },
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	{ 0,	"Consistent mem start" },
+	{ 0,	"Consistent mem end" },
+#endif
+#ifdef CONFIG_HIGHMEM
+	{ 0,	"Highmem PTEs start" },
+	{ 0,	"Highmem PTEs end" },
+#endif
+	{ 0,	"Fixmap start" },
+	{ 0,	"Fixmap end" },
+#endif
 	{ -1,	NULL },
 };
 
@@ -390,20 +409,38 @@ static void walk_pagetables(struct pg_state *st)
 
 static void populate_markers(void)
 {
-	address_markers[0].start_address = PAGE_OFFSET;
-	address_markers[1].start_address = VMALLOC_START;
-	address_markers[2].start_address = VMALLOC_END;
-	address_markers[3].start_address = ISA_IO_BASE;
-	address_markers[4].start_address = ISA_IO_END;
-	address_markers[5].start_address = PHB_IO_BASE;
-	address_markers[6].start_address = PHB_IO_END;
-	address_markers[7].start_address = IOREMAP_BASE;
-	address_markers[8].start_address = IOREMAP_END;
+	int i = 0;
+
+	address_markers[i++].start_address = PAGE_OFFSET;
+	address_markers[i++].start_address = VMALLOC_START;
+	address_markers[i++].start_address = VMALLOC_END;
+#ifdef CONFIG_PPC64
+	address_markers[i++].start_address = ISA_IO_BASE;
+	address_markers[i++].start_address = ISA_IO_END;
+	address_markers[i++].start_address = PHB_IO_BASE;
+	address_markers[i++].start_address = PHB_IO_END;
+	address_markers[i++].start_address = IOREMAP_BASE;
+	address_markers[i++].start_address = IOREMAP_END;
 #ifdef CONFIG_PPC_STD_MMU_64
-	address_markers[9].start_address =  H_VMEMMAP_BASE;
+	address_markers[i++].start_address =  H_VMEMMAP_BASE;
 #else
-	address_markers[9].start_address =  VMEMMAP_BASE;
+	address_markers[i++].start_address =  VMEMMAP_BASE;
+#endif
+#else /* CONFIG_PPC64 */
+	address_markers[i++].start_address = ioremap_bot;
+	address_markers[i++].start_address = IOREMAP_TOP;
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	address_markers[i++].start_address = IOREMAP_TOP;
+	address_markers[i++].start_address = IOREMAP_TOP +
+					     CONFIG_CONSISTENT_SIZE;
+#endif
+#ifdef CONFIG_HIGHMEM
+	address_markers[i++].start_address = PKMAP_BASE;
+	address_markers[i++].start_address = PKMAP_ADDR(LAST_PKMAP);
 #endif
+	address_markers[i++].start_address = FIXADDR_START;
+	address_markers[i++].start_address = FIXADDR_TOP;
+#endif /* CONFIG_PPC64 */
 }
 
 static int ptdump_show(struct seq_file *m, void *v)
-- 
2.12.0
