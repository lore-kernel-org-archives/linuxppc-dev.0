Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC6AE1A0988
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Oct 2014 19:41:45 +1100 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 zhong@linux.vnet.ibm.com
Subject: [PATCH 3/3] powerpc/pseries: Use dump_stack instead of show_stack
Date: Mon, 13 Oct 2014 19:41:40 +1100
Message-Id: <1413189700-30322-3-git-send-email-anton@samba.org>
In-Reply-To: <1413189700-30322-1-git-send-email-anton@samba.org>
References: <1413189700-30322-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can use the simpler dump_stack() instead of
show_stack(current, __get_SP())

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index de1ec54..e32e009 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -30,7 +30,6 @@
 #include <linux/mm.h>
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
-#include <linux/sched.h>	/* for show_stack */
 #include <linux/string.h>
 #include <linux/pci.h>
 #include <linux/dma-mapping.h>
@@ -168,7 +167,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 			printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
 			printk("\ttcenum  = 0x%llx\n", (u64)tcenum);
 			printk("\ttce val = 0x%llx\n", tce );
-			show_stack(current, (unsigned long *)__get_SP());
+			dump_stack();
 		}
 
 		tcenum++;
@@ -257,7 +256,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
 		printk("\tnpages  = 0x%llx\n", (u64)npages);
 		printk("\ttce[0] val = 0x%llx\n", tcep[0]);
-		show_stack(current, (unsigned long *)__get_SP());
+		dump_stack();
 	}
 	return ret;
 }
@@ -273,7 +272,7 @@ static void tce_free_pSeriesLP(struct iommu_table *tbl, long tcenum, long npages
 			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
 			printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
 			printk("\ttcenum  = 0x%llx\n", (u64)tcenum);
-			show_stack(current, (unsigned long *)__get_SP());
+			dump_stack();
 		}
 
 		tcenum++;
@@ -292,7 +291,7 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
 		printk("\trc      = %lld\n", rc);
 		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
 		printk("\tnpages  = 0x%llx\n", (u64)npages);
-		show_stack(current, (unsigned long *)__get_SP());
+		dump_stack();
 	}
 }
 
@@ -307,7 +306,7 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
 		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%lld\n", rc);
 		printk("\tindex   = 0x%llx\n", (u64)tbl->it_index);
 		printk("\ttcenum  = 0x%llx\n", (u64)tcenum);
-		show_stack(current, (unsigned long *)__get_SP());
+		dump_stack();
 	}
 
 	return tce_ret;
-- 
1.9.1
