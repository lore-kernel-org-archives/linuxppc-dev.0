Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTrpH4yxPzDvyc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 20:00:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: rashmicy@gmail.com
Subject: [PATCH] powerpc/mm: Fix page table dump build on non-Book3S
Date: Thu,  1 Dec 2016 20:00:00 +1100
Message-Id: <1480582800-28597-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the recent commit 1515ab932156 ("powerpc/mm: Dump hash table") we
added code to dump the hage page table. Currently this can be selected
to build on any platform. However it breaks the build if we're building
for a non-Book3S platform, because none of the hash page table related
defines and so on exist. So restrict it to building only on Book3S.

Similarly in commit 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
we added code to dump the Linux page tables, which uses some constants
which are only defined on Book3S - so guard those with an #ifdef.

Fixes: 1515ab932156 ("powerpc/mm: Dump hash table")
Fixes: 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug             | 4 ++++
 arch/powerpc/mm/Makefile               | 4 ++--
 arch/powerpc/mm/dump_linuxpagetables.c | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 20cf770611ec..949258d412d0 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -366,4 +366,8 @@ config PPC_PTDUMP
 
 	  If you are unsure, say N.
 
+config PPC_HTDUMP
+	def_bool y
+	depends on PPC_PTDUMP && PPC_BOOK3S
+
 endmenu
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index f4ffe1f68ce9..5784682d7b63 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -42,5 +42,5 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
-obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o \
-				   dump_hashpagetable.o
+obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o
+obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index d242bc79ae64..49abaf4dc8e3 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -159,6 +159,7 @@ static const struct flag_info flag_array[] = {
 		.set	= "no cache",
 		.clear	= "        ",
 	}, {
+#ifdef CONFIG_PPC_BOOK3S_64
 		.mask	= H_PAGE_BUSY,
 		.val	= H_PAGE_BUSY,
 		.set	= "busy",
@@ -183,6 +184,7 @@ static const struct flag_info flag_array[] = {
 		.val	= H_PAGE_F_SECOND,
 		.set	= "f_second",
 	}, {
+#endif
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
 		.set	= "special",
-- 
2.7.4
