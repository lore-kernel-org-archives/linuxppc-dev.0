Return-Path: <arnd@arndb.de>
Message-Id: <20060429233921.099214000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:19 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 07/13] powerpc: export symbols for page size selection
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need access to some symbols in powerpc memory management
from spufs in order to create proper SLB entries.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- linus-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/arch/powerpc/mm/hash_utils_64.c	2006-04-29 22:53:43.000000000 +0200
@@ -85,16 +85,26 @@
 #endif /* CONFIG_U3_DART */
 
 static unsigned long _SDR1;
-struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
 hpte_t *htab_address;
 unsigned long htab_size_bytes;
 unsigned long htab_hash_mask;
+
+struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+EXPORT_SYMBOL_GPL(mmu_psize_defs);
+
 int mmu_linear_psize = MMU_PAGE_4K;
+EXPORT_SYMBOL_GPL(mmu_linear_psize);
+
 int mmu_virtual_psize = MMU_PAGE_4K;
+EXPORT_SYMBOL_GPL(mmu_virtual_psize);
+
 #ifdef CONFIG_HUGETLB_PAGE
 int mmu_huge_psize = MMU_PAGE_16M;
+EXPORT_SYMBOL_GPL(mmu_huge_psize);
+
 unsigned int HPAGE_SHIFT;
+EXPORT_SYMBOL_GPL(HPAGE_SHIFT);
 #endif
 
 /* There are definitions of page sizes arrays to be used when none

--
