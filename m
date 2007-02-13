Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Feb 2007 11:46:07 +1100
Subject: [PATCH 2/3] powerpc: Remove SPU struct page's for PS3
In-Reply-To: <1171327564.314011.545768742379.qpush@grosgo>
Message-Id: <20070213004617.2C93BDDF19@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Struct page are no longer needed for SPUs, so let's not create them
on PS3 anymore.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/ps3/spu.c |   42 +--------------------------------------
 1 file changed, 2 insertions(+), 40 deletions(-)

Index: linux-cell/arch/powerpc/platforms/ps3/spu.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/ps3/spu.c	2007-02-13 11:34:38.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/ps3/spu.c	2007-02-13 11:37:07.000000000 +1100
@@ -170,31 +170,6 @@ static int __init construct_spu(struct s
 	return result;
 }
 
-static int __init add_spu_pages(unsigned long start_addr, unsigned long size)
-{
-	int result;
-	unsigned long start_pfn;
-	unsigned long nr_pages;
-	struct pglist_data *pgdata;
-	struct zone *zone;
-
-	BUG_ON(!mem_init_done);
-
-	start_pfn = start_addr >> PAGE_SHIFT;
-	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	pgdata = NODE_DATA(0);
-	zone = pgdata->node_zones;
-
-	result = __add_pages(zone, start_pfn, nr_pages);
-
-	if (result)
-		pr_debug("%s:%d: __add_pages failed: (%d)\n",
-			__func__, __LINE__, result);
-
-	return result;
-}
-
 static void spu_unmap(struct spu *spu)
 {
 	iounmap(spu->priv2);
@@ -206,19 +181,6 @@ static void spu_unmap(struct spu *spu)
 static int __init setup_areas(struct spu *spu)
 {
 	struct table {char* name; unsigned long addr; unsigned long size;};
-	int result;
-
-	/* setup pages */
-
-	result = add_spu_pages(spu->local_store_phys, LS_SIZE);
-	if (result)
-		goto fail_add;
-
-	result = add_spu_pages(spu->problem_phys, sizeof(struct spu_problem));
-	if (result)
-		goto fail_add;
-
-	/* ioremap */
 
 	spu_pdata(spu)->shadow = __ioremap(
 		spu_pdata(spu)->shadow_addr, sizeof(struct spe_shadow),
@@ -260,8 +222,8 @@ static int __init setup_areas(struct spu
 
 fail_ioremap:
 	spu_unmap(spu);
-fail_add:
-	return result;
+
+	return -ENOMEM;
 }
 
 static int __init setup_interrupts(struct spu *spu)
